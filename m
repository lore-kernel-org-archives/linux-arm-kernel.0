From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 10:47:18 +0100
Subject: [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
Message-ID: <20130717094718.GE22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 09:40:39AM +0100, Mark Rutland wrote:
> On Wed, Jul 17, 2013 at 07:12:14AM +0100, Barry Song wrote:

> > this makes users be able to add a bt-sco node in dts instead of
> > hardcoding a platform device in mach.

> I'm slightly confused by this. The driver doesn't seem to pick up any
> information out of the dts, and the binding doesn't even describe any
> linkage to a piece of hardware. I'm not familiar with bluetooth or ASoC,
> could you give an explanation as to why this is needed?

> I don't think this should be in the dt as is. Could this not be
> registered based on the presence of a bluetooth controller that supports
> this?

Audio devices are linked together by a separate board binding which
specifies how all the different components in the audio subsystem on the
board are wired together.  Even where things have no meanignful software
control (as is the case here and for a lot of simple DACs or ADCs) the
rest of the system needs information on their capabilites and ideally
the ability to interchange them with more substantial devices.  If there
were meaningful control there'd be a control bus here.

There is likely to be a control interface for the BT device hanging off
a UART but it's not clear there's much more meaningful data for those
than there is here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/419fecfc/attachment.sig>
