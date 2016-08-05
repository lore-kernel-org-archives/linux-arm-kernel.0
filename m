From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Aug 2016 17:58:12 +0200
Subject: [PATCH 2/4] irqchip: irq-mvebu-pic: new driver for Marvell
 Armada 7K/8K PIC
In-Reply-To: <20160805153113.GW4541@io.lakedaemon.net>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160805153113.GW4541@io.lakedaemon.net>
Message-ID: <20160805175812.55162108@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks for the quick feedback!

On Fri, 5 Aug 2016 15:31:13 +0000, Jason Cooper wrote:

> > +config MVEBU_PIC
> > +	bool  
> 
> tri-state?  Is there anything else attached to the PIC besides the PMU?

tri-state would be fine I believe, it's indeed a secondary interrupt
controller, not essential for booting the platform.

But then I probably need to rework PATCH 3/4 and not have it
unconditionally selected by the platform Kconfig option, right?

Regarding what else is attached to the PIC, I have no idea, I don't
have this information.

> > +static const struct of_device_id mvebu_pic_of_match[] = {
> > +	{ .compatible = "marvell,armada-8k-pic", },  
> 
> You mention 7k in $subject, should you use that here as the youngest
> compatible SoC generation?

There isn't anything youngest or oldest between 7K and 8K, they both
got released at the same time. They are really the same family of SoCs,
the 7K having only one CP110, the 8K having two of them, which provides
more I/Os.

For several other IPs, we're using armada-8k as the compatible string:

 * marvell,armada8k-pcie
 * marvell,armada-8k-xhci

(Yes you will already notice how consistent we are in the naming of the
compatible string :-/).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
