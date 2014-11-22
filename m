From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 22 Nov 2014 09:42:43 +0900
Subject: [PATCH v4 1/2] i2c: s3c2410: Handle i2c sys_cfg register in i2c
 driver
In-Reply-To: <546F1140.4050709@samsung.com>
References: <1414656270-8048-1-git-send-email-pankaj.dubey@samsung.com>
 <1414656270-8048-2-git-send-email-pankaj.dubey@samsung.com>
 <20141121072545.GG1480@katana> <546F1140.4050709@samsung.com>
Message-ID: <018d01d005ed$3a777640$af6662c0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dubey wrote:
> 
> On Friday 21 November 2014 12:55 PM, Wolfram Sang wrote:
> > On Thu, Oct 30, 2014 at 01:34:29PM +0530, Pankaj Dubey wrote:
> >> Let's handle i2c interrupt re-configuration in i2c driver. This will
> >> help us in removing some soc specific checks from machine files and
> >> will help in removing static iomapping of SYS register in exynos.c
> >>
> >> Since only Exynos5250, and Exynos5420 has i2c nodes in DT, added syscon
> >> based phandle to i2c device nodes of respective SoC DT files.
> >>
Well...actually there are 4ch i2c in exynos5410 and exynos5800 as well, i2c
nodes are not added in dt files though.

> >> Also handle saving and restoring of SYS_I2C_CFG register during
> >> suspend and resume of i2c driver.
> >>
> >> CC: Rob Herring <robh+dt@kernel.org>
> >> CC: Randy Dunlap <rdunlap@infradead.org>
> >> CC: Wolfram Sang <wsa@the-dreams.de>
> >> CC: Russell King <linux@arm.linux.org.uk>
> >> CC: devicetree at vger.kernel.org
> >> CC: linux-doc at vger.kernel.org
> >> CC: linux-i2c at vger.kernel.org
> >> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >> ---
> >>   .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    1 +
> >>   arch/arm/boot/dts/exynos5250.dtsi                  |    4 +++
> >>   arch/arm/boot/dts/exynos5420.dtsi                  |    4 +++
> >
> > I usually don't take DTS patches. They should go via arm-soc. Please say
> > so if there are reasons I should take them.
> 
> I CC'ed to you because same patch contains changes in i2c driver.
> I am not very sure via which tree this should go. May be I can ask
> samsung SoC maintainer Kukjin to look into this, as patch 2/2 has
> changes in mach-exynos which should go via Kukjin's tree.
> 
I'll reply on other email.

Thanks,
Kukjin
