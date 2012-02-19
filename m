From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 19 Feb 2012 18:20:08 +0000
Subject: [PATCH 1/2] ALSA: Remove __devinit annotation for
 pxa2xx_ac97_hw_probe to fix section mismatch warning
In-Reply-To: <1329637158.4818.4.camel@phoenix>
References: <1329637158.4818.4.camel@phoenix>
Message-ID: <20120219182005.GA16078@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2012 at 03:39:18PM +0800, Axel Lin wrote:
> This fixes below build warning:
> WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
> The function pxa2xx_ac97_probe() references
> the function __devinit pxa2xx_ac97_hw_probe().
> This is often because pxa2xx_ac97_probe lacks a __devinit
> annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

This seems like the wrong fix - shouldn't we be adding annotations
rather than removing them here?
