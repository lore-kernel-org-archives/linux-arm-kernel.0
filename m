From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jul 2015 12:09:08 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <4099394.C7vEjTFs8V@diego>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <554BD33D.7050907@codeaurora.org> <20150508100247.GQ11057@lukather>
 <4099394.C7vEjTFs8V@diego>
Message-ID: <20150730100908.GI2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Mon, Jul 27, 2015 at 10:57:33AM +0200, Heiko St?bner wrote:
> > > Also we can try to see if critical clocks aren't being forced on by
> > > applying this patch and looking for clk_get() failures
> > 
> > And that shows that the CPU and DDR clocks are not protected, which
> > obviously is pretty mad.
> > 
> > I've mass converted all our probing code to use OF_CLK_DECLARE, and
> > make things work again.
> > 
> > http://code.bulix.org/5goa5j-88345?raw
> > 
> > Is this an acceptable solution?
> > 
> > We were already moving to this, I'm not really fond of doing this like
> > that, but I guess this whole debacle makes it necessary.
> 
> 
> did this lead anywhere meanwhile.
> 
> Last I remember the change to orphan handling made sunxi fail, but
> I'm still hoping to get this usable at some point :-)

To be honest, I don't know what the current status is. I haven't get
any news since that mail.

I started to move a significant portion of our clocks to
CLK_OF_DECLARE, but not all of them are (which probably make the
situation worse for the time being).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/6f3d5af2/attachment.sig>
