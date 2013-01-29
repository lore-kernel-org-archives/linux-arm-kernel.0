From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 10:01:55 -0800
Subject: Section mismatch in drivers/mfd/vexpress-sysreg.c
In-Reply-To: <20130129131244.GU23505@n2100.arm.linux.org.uk>
References: <20130129115535.GH21504@S2101-09.ap.freescale.net>
 <1359464711.8090.19.camel@hornet>
 <20130129131244.GU23505@n2100.arm.linux.org.uk>
Message-ID: <20130129180155.GE17935@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 01:12:45PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 01:05:11PM +0000, Pawel Moll wrote:
> > On Tue, 2013-01-29 at 11:55 +0000, Shawn Guo wrote:
> > > I'm building v3.8-rc5 and seeing the following section mismatch warning
> > > in drivers/mfd/vexpress-sysreg.c.
> > > 
> > > WARNING: drivers/mfd/built-in.o(.text+0x3108): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
> > > The function vexpress_sysreg_probe() references
> > > the function __init vexpress_sysreg_setup().
> > > This is often because vexpress_sysreg_probe lacks a __init
> > > annotation or the annotation of vexpress_sysreg_setup is wrong.
> > 
> > Arnd's got a fix for this already:
> > 
> > https://patchwork.kernel.org/patch/2046991/
> 
> Adding arm-soc people...
> 
> Which wasn't in yesterday's arm-soc though, as highlighted by last night's
> autobuild (the build tree was created at 9:28am yesterday, which'll be
> just after my arm-soc pull).

Right. I checked it in as commit e065d3d417274bafed162b3dffd2e03a5128623c
yesterday, it's in 'fixes' as well as in for-next. It wasn't checked in until
3pm Pacific time though, so it missed your build.

Let me know if it isn't fixed by tonight's build.



-Olof
