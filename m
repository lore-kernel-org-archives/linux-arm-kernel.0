From: broonie@kernel.org (Mark Brown)
Date: Sat, 24 Sep 2016 19:10:42 +0100
Subject: [PATCH v2] ASoC: rk3399_gru_sound: fix recording pop at first
 attempt
In-Reply-To: <20160923212737.GA17658@rob-hp-laptop>
References: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
 <20160923212737.GA17658@rob-hp-laptop>
Message-ID: <20160924181042.7odqqbae2sixdeyx@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 04:27:37PM -0500, Rob Herring wrote:
> On Thu, Sep 22, 2016 at 09:50:06PM +0800, Xing Zheng wrote:
> > From: Wonjoon Lee <woojoo.lee@samsung.com>

> > Pop happens when mclk applied but dmic's own boot-time

> This statement doesn't make sense.

It is very clear if you're familiar with the problem domain - because a
DMIC is digital it's got an on/off state which means that when it
transitions from off and not outputting anything to outputting something
you get a sudden DC transition which manifests as a pop in the audio
output.

> > Specify dmic delay times in dt to make sure
> > clocks are ready earlier than dmic working

> I don't think this really belongs in DT. Seems like better control of 
> the init order is needed. Or why not just a fixed delay in the driver?

The changelog says this is due to the DMICs having a startup time of
their own so needing a delay after they've started.  That's going to be
a system dependent thing since it'll depend on the specific component
selected and DMICs are easily interchangable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160924/30b3993f/attachment.sig>
