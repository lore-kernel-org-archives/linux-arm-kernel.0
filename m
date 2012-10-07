From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Oct 2012 12:47:53 -0700
Subject: [PATCH 0/6] ARM: Add support for Broadcom BCM476x SoCs
In-Reply-To: <20121007015300.828366635@gmail.com>
References: <20121007015300.828366635@gmail.com>
Message-ID: <20121007194753.GA15034@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 03:53:00AM +0200, Domenico Andreoli wrote:
> Howdy,
> 
>   this patchset adds (minimal) support for the Broadcom BCM476x ARM based
> SoCs to the kernel, not to be confused with the already supported MIPS
> based BCM47xx SoC and other BCM47xx WiFi and GPS produced by Broadcom.
> 
> This BCM476x is a DT-only multi-platform ARM platform and, at this spin,
> minimal in the features (boots nicely into initrd/busybox only) but also
> in the new code required, thanks to the existing drivers (and sweet DT)
> easily hooked up with the rest.
> 
> Additional support is being worked on. Pinctrl, clocks and gpios are
> almost ready for review. DMA (PL080) and/or sdhci have issues. Regulators
> (BCM59040) are minimal and usb (DWC OTG) only attemped reusing s3c-hsotg.
> Other fancy stuff (not too much) later and not all.
> 
> All this is my code, originating by me. The reference code I used is
> published by TomTom (my employer, who is aware but not involved at all)
> as part of the GPL compliance program but I don't plan to re-publish
> or maintain any part of it.
> 
> It's based on a random pre v3.7-rc1 commit (eb0ad9c) with mainlined
> multi-platform support and Stephen's patch to add DEBUG_LL to it.
> 
> Special thanks go to Stephen Warren who, with the recently mainlined
> BCM2835, showed how to do things cleanly since the beginning and
> involuntarily spurred me to act.
> 
> Any feedback is welcome.

Nice and clean. I wonder if it even warrants its own mach directory at this
point, or over time if more of them can share. But that's a restructuring that
can happen later.

For the series:

Acked-by: Olof Johansson <olof@lixom.net>

It's up to you if you want to send the driver patches through the respective
maintainers, or if you want to collect their Acked-by's and merge it in one set
of patches through arm-soc, let us know.


Thanks!

-Olof
