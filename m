From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 13 Apr 2013 15:00:37 -0400
Subject: [PATCH 0/5 v2] mv643xx_eth: device tree bindings
In-Reply-To: <20130413172126.6cca0809@skate>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <20130411165303.GI28693@titan.lakedaemon.net>
 <20130413172126.6cca0809@skate>
Message-ID: <20130413190037.GY28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 13, 2013 at 05:21:26PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Thu, 11 Apr 2013 12:53:03 -0400, Jason Cooper wrote:
> 
> > With this and Thomas' pci series, we will have Kirkwood fully
> > converted to devicetree, can begin removing board files, and finally
> > begin migrating everything over to mach-mvebu/.  This will lead to
> > the removal of five directories under arch/arm/ (plat-orion,
> > mach-kirkwood, mach-orion5x, mach-dove, and mach-mv78xx0).
> 
> No, we can't remove mach-orion5x and mach-mv78xx0 for now, they have
> not been converted at all in terms of gpio/pinmux support. I've started
> writing some pinmux code for orion5x but it's not ready.
> 
> I don't think we should rush in doing this merge into mach-mvebu. I'd
> prefer to have the following conditions be met before a platform gets
> merged into mach-mvebu:
> 
>  * The mach-<foo> directory no longer depends on anything in
>    plat-orion. For mach-kirkwood, things are OK (for the DT platforms)
>    for GPIO, MPP and PCIe, but some work remains for the IRQ controller
>    driver and the timer driver.
> 
>  * All boards have been converted to the Device Tree. For
>    mach-kirkwood, we're getting closer.
> 
> Once a given mach-<foo> platform meets these conditions, it will be a
> clean platform, and we can merge it into mach-mvebu without any
> problem.
> 
> So let's continue the cleanup work, conversion to DT, usage of drivers
> in drivers/, improvement of pinmux to support orion5x/mv78xx0, and do
> the move per-platform, once they are ready.
> 
> What do you think?

I agree completely.  I was simply restating the longview goal of the
work we are doing (above and beyond adding armadaXP/370).  I probably
should have given a time reference for "This will lead to..." :)

Also, I have a feeling that not all legacy boards will get converted
over.  If there is no interest or no way to test, certains boards may
get deprecated.

thx,

Jason.
