From: tmn505@gmail.com (Tomasz Maciej Nowak)
Date: Wed, 21 Feb 2018 17:20:14 +0100
Subject: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
In-Reply-To: <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
References: <20180219201623.6987-1-tmn505@gmail.com>
 <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
Message-ID: <873b01dc-3ca5-3151-2654-a8272cb9dd88@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 20.02.2018 o?20:55, Stephen Warren pisze:
> On 02/19/2018 01:16 PM, Tomasz Maciej Nowak wrote:
>> Adds device nodes for two front panel LEDs.
> 
> Why do you need to change the pinmux settings? Configuring a pin as a 
> GPIO should override any pinmux special function selection and hence 
> make it irrelevant, so I don't think you should need to change the pinmux.

At first I did exactly that without changing the pinmux, but the LEDs 
didn't light up. After that I compared with CompuLab source tree [1]. 
The pinmux was specified as in my patch. With this change the LEDs are 
fully functional.

1. 
https://gitorious.org/trimslice-kernel/trimslice-kernel?p=trimslice-kernel:trimslice-kernel.git;a=blob;f=arch/arm/mach-tegra/board-trimslice-pinmux.c;h=cc6d5225d97eb9327c820bf1d5b2bc16ab8c6dda;hb=d25bf45d6314089489b30d218ed8a0d6d94417f9#l45

-- 
Tomek
