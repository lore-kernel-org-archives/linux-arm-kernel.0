From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 13:12:45 +0000
Subject: Section mismatch in drivers/mfd/vexpress-sysreg.c
In-Reply-To: <1359464711.8090.19.camel@hornet>
References: <20130129115535.GH21504@S2101-09.ap.freescale.net>
 <1359464711.8090.19.camel@hornet>
Message-ID: <20130129131244.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 01:05:11PM +0000, Pawel Moll wrote:
> On Tue, 2013-01-29 at 11:55 +0000, Shawn Guo wrote:
> > I'm building v3.8-rc5 and seeing the following section mismatch warning
> > in drivers/mfd/vexpress-sysreg.c.
> > 
> > WARNING: drivers/mfd/built-in.o(.text+0x3108): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
> > The function vexpress_sysreg_probe() references
> > the function __init vexpress_sysreg_setup().
> > This is often because vexpress_sysreg_probe lacks a __init
> > annotation or the annotation of vexpress_sysreg_setup is wrong.
> 
> Arnd's got a fix for this already:
> 
> https://patchwork.kernel.org/patch/2046991/

Adding arm-soc people...

Which wasn't in yesterday's arm-soc though, as highlighted by last night's
autobuild (the build tree was created at 9:28am yesterday, which'll be
just after my arm-soc pull).
