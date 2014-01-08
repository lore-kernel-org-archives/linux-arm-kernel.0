From: sre@debian.org (Sebastian Reichel)
Date: Wed, 8 Jan 2014 11:52:44 +0100
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <52CD23E0.8030400@ti.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <1389161742-10533-2-git-send-email-rogerq@ti.com>
 <20140108090808.GB16313@earth.universe> <52CD23E0.8030400@ti.com>
Message-ID: <20140108105244.GA21607@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 08, 2014 at 03:39:36PM +0530, Roger Quadros wrote:
> > What about the other clocks acquired in drivers/mfd/omap-usb-host.c? Shouldn't
> > all of those be provided by via the DT phandle?
> 
> All those clocks are identically named across the OMAP SoCs and are unique for each
> SoC, so providing DT phandle for all of them is not required.
> 
> The init_60m_fclk was renamed to l3init_60m_fclk in OMAP5, and hence the need for
> this binding.

I understand the intention of this patch. I was just wondering if
all the clocks should be referenced from DT even if that is not
strictly needed at the moment. This would make clocks similar to
other resources like regulators, gpios, irqs, ...

Having the clocks referenced from DT looks cleaner to me. It means I
can check the DT file for any resources used by a driver. It also
creates some kind of consistency in the kernel.

> > Should the clk_get be changed to of_clk_get()/of_clk_get_by_name() in the
> > driver? This would potentially remove the need of the init_60m_fclk name.
> 
> If we use of_clk_xxx() then we'll need to update DT nodes for OMAP4 and OMAP3 as
> well to explicitly provide the clock phandle.

I'm aware of this.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/07c451ab/attachment-0001.sig>
