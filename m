From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 20 Feb 2012 08:03:13 +0800
Subject: [PATCH 1/2] ALSA: Remove __devinit annotation for
 pxa2xx_ac97_hw_probe to fix section mismatch warning
In-Reply-To: <20120219182005.GA16078@opensource.wolfsonmicro.com>
References: <1329637158.4818.4.camel@phoenix>
 <20120219182005.GA16078@opensource.wolfsonmicro.com>
Message-ID: <CAF+7xWkEb1UYFF79gnft9tCX1=9fHLpVGvieg5L4qAEytdQBeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, Feb 19, 2012 at 03:39:18PM +0800, Axel Lin wrote:
>> This fixes below build warning:
>> WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
>> The function pxa2xx_ac97_probe() references
>> the function __devinit pxa2xx_ac97_hw_probe().
>> This is often because pxa2xx_ac97_probe lacks a __devinit
>> annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.
>
> This seems like the wrong fix - shouldn't we be adding annotations
> rather than removing them here?
I'll send a new patch to fix it. Thanks.
The change now is in sound/soc/pxa/pxa2xx-ac97.c, so I change the subject to:
[PATCH] ASoC: Add __devinit annotation for pxa2xx_ac97_probe

Axel
