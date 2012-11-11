From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 11 Nov 2012 14:40:47 -0700
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <CAA-5wcDo2OJSD9O4YfJkxYDukCSMJo46at2NR9e41fZbAhh7wA@mail.gmail.com>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
 <12188358.5I1Xcz160E@bender>
 <CAA-5wcDo2OJSD9O4YfJkxYDukCSMJo46at2NR9e41fZbAhh7wA@mail.gmail.com>
Message-ID: <50A01B5F.6040404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 10:32 AM, Christian Daudt wrote:
> 
> 
> On Sun, Nov 11, 2012 at 7:53 AM, Florian Fainelli <florian@openwrt.org
> <mailto:florian@openwrt.org>> wrote:
> 
>     Hi Christian,
> 
>     On Sunday 11 November 2012 06:57:14 Christian Daudt wrote:
>     > In order to start upstreaming Broadcom SoC support, create
>     > a starting hierarchy, arch and dts files.
>     > The first support SoC family that is planned is the
>     > BCM281XX (BCM28145/28150/28155/28160) family of dual A9 mobile SoC
>     cores
>     > This code is just the skeleton code for get the machine upstreamed. It
>     > has been made MULTIPLATFORM compatible.
>     > Next steps
>     > ----------
>     > Upstream a basic set of drivers - sufficient for a console boot to
>     > ramdisk. These will includer timer, gpio, i2c drivers.
>     > After this basic set, we will proceed with a more comprehensive set
>     > of drivers for the 281XX SoC family.
> 
>     Would not it make more sense to use mach-bcm281xx as a directory
>     name instead
>     of mach-bcm which sounds a tad too generic? This would also make it
>     consistent
>     with Domenico's mach-bcm47xx and the existing bcm47xx and bcm63xx
>     MIPS-based
>     SoC support.
> 
> 
> I'm following the other mobile ARM SoCs which all have a single mach-
> directory for various families of chips (mach-tegra, mach-omap2,
> etc...). Plus the intent is to have a single set of mach files that
> works across bcm SoCs, so it is preferable to keep it in a single mach-bcm.

It's quite possible to create one directory now, e.g. mach-bcm281xx, and
then when consolidation with other mach-bcm* happens, merge all those
directories into a single mach-bcm. I would tend to prefer (but only
lightly) using mach-bcm281xx now and then renaming later, unless you
plan on expanding the SoC support in the pretty near future.
