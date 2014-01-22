From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 12:26:53 +0000
Subject: Kconfig errors
In-Reply-To: <CA+V-a8uy6wM8nS993VeezJGOaoqM5GRsJE7FrKe7=bhD6nZhXw@mail.gmail.com>
References: <CA+V-a8vcvTRpP-cE6SKd1KgWgzSbOXvSNW+5Jh8wqOfr1za4SQ@mail.gmail.com>
 <CA+V-a8uy6wM8nS993VeezJGOaoqM5GRsJE7FrKe7=bhD6nZhXw@mail.gmail.com>
Message-ID: <20140122122653.GA15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 05:54:29PM +0530, Prabhakar Lad wrote:
> Hi Russell,
> 
> On Fri, Jan 17, 2014 at 1:07 PM, Prabhakar Lad
> <prabhakar.csengg@gmail.com> wrote:
> > Hi,
> >
> > On Linux-next branch I see following errors for davinci_all_defconfig
> > & da8xx_omapl_defconfig configs,
> >
> > arch/arm/Kconfig:1966:error: recursive dependency detected!
> > arch/arm/Kconfig:1966:    symbol ZBOOT_ROM depends on AUTO_ZRELADDR
> > arch/arm/Kconfig:2154:    symbol AUTO_ZRELADDR is selected by ZBOOT_ROM
> > #
> > # configuration written to .config
> > #
> >
> I am seeing this errors on linux-next, with your recent patch,
> "[PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM"
> and strangely I see that AUTO_ZRELADDR doesnt select ZBOOT_ROM
> but still an error.
> 
> Note: For the davinci configs CONFIG_AUTO_ZRELADDR is not set and
> CONFIG_ZBOOT_ROM_TEXT=0x0, CONFIG_ZBOOT_ROM_BSS=0x0

I've killed off the "select AUTO_ZRELADDR if !ZBOOT_ROM" in the IMX
Kconfig now, so when linux-next picks up my tree, that should be gone.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
