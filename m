From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 12:20:08 +0000
Subject: Section mismatch in drivers/mfd/vexpress-sysreg.c
In-Reply-To: <20130129115535.GH21504@S2101-09.ap.freescale.net>
References: <20130129115535.GH21504@S2101-09.ap.freescale.net>
Message-ID: <20130129122008.GT23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 07:55:37PM +0800, Shawn Guo wrote:
> Pawel,
> 
> I'm building v3.8-rc5 and seeing the following section mismatch warning
> in drivers/mfd/vexpress-sysreg.c.
> 
> WARNING: drivers/mfd/built-in.o(.text+0x3108): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
> The function vexpress_sysreg_probe() references
> the function __init vexpress_sysreg_setup().
> This is often because vexpress_sysreg_probe lacks a __init
> annotation or the annotation of vexpress_sysreg_setup is wrong.

I've already reported this - it's been around for a while now.
