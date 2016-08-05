From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 5 Aug 2016 16:27:03 +0000
Subject: [PATCH 2/4] irqchip: irq-mvebu-pic: new driver for Marvell
 Armada 7K/8K PIC
In-Reply-To: <20160805175812.55162108@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160805153113.GW4541@io.lakedaemon.net>
 <20160805175812.55162108@free-electrons.com>
Message-ID: <20160805162703.GZ4541@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Aug 05, 2016 at 05:58:12PM +0200, Thomas Petazzoni wrote:
> On Fri, 5 Aug 2016 15:31:13 +0000, Jason Cooper wrote:
> 
> > > +config MVEBU_PIC
> > > +	bool  
> > 
> > tri-state?  Is there anything else attached to the PIC besides the PMU?
> 
> tri-state would be fine I believe, it's indeed a secondary interrupt
> controller, not essential for booting the platform.
> 
> But then I probably need to rework PATCH 3/4 and not have it
> unconditionally selected by the platform Kconfig option, right?

meh.  I have no preference either way.  It's what works best for your
platform.  I've just seen one or two people on a tear lately regarding
module.h/MODULE_* and being boolean.  I figured I'd address it while I
was here. :-)

> Regarding what else is attached to the PIC, I have no idea, I don't
> have this information.

Ok, then which ever way you go is fine by me.

> > > +static const struct of_device_id mvebu_pic_of_match[] = {
> > > +	{ .compatible = "marvell,armada-8k-pic", },  
> > 
> > You mention 7k in $subject, should you use that here as the youngest
> > compatible SoC generation?
> 
> There isn't anything youngest or oldest between 7K and 8K, they both
> got released at the same time. They are really the same family of SoCs,
> the 7K having only one CP110, the 8K having two of them, which provides
> more I/Os.
> 
> For several other IPs, we're using armada-8k as the compatible string:
> 
>  * marvell,armada8k-pcie
>  * marvell,armada-8k-xhci

Ok, sure.  That was just a nit.  I know human nature, despite logic,
will assume 8k is newer that 7k, like SSLv3 being better than TLS v1.x
because the number is bigger. :-/

Consistency is better at this point.

The rest of it looks fine.

thx,

Jason.
