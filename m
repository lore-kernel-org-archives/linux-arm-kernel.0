From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Jan 2013 13:05:11 +0000
Subject: Section mismatch in drivers/mfd/vexpress-sysreg.c
In-Reply-To: <20130129115535.GH21504@S2101-09.ap.freescale.net>
References: <20130129115535.GH21504@S2101-09.ap.freescale.net>
Message-ID: <1359464711.8090.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 11:55 +0000, Shawn Guo wrote:
> I'm building v3.8-rc5 and seeing the following section mismatch warning
> in drivers/mfd/vexpress-sysreg.c.
> 
> WARNING: drivers/mfd/built-in.o(.text+0x3108): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
> The function vexpress_sysreg_probe() references
> the function __init vexpress_sysreg_setup().
> This is often because vexpress_sysreg_probe lacks a __init
> annotation or the annotation of vexpress_sysreg_setup is wrong.

Arnd's got a fix for this already:

https://patchwork.kernel.org/patch/2046991/

Thanks!

Pawel
