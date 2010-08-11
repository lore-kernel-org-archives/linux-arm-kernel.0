From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 11 Aug 2010 10:42:52 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
Message-ID: <201008111042.52631.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 11. srpna 2010 09:43:30 Yuri Ludkevich napsal(a):
> Hi Marek
> 
> I am working on colibri PXA320 so-dimm module and toradex orchid board. I
> flash it with OBM2 and U-boot - this work just fine. Ather that i compile
> 2.6.35 kernel and fount what touchscreen do not work =(. I turn on UCB1400
> support in MFD kernel section and UCB1400 touchscreen support in input
> device/touchscreen section. While booting ALSA founded UCB1400 sound device
> and input subsystem found UCB1400 touchscreen interface according to boot
> log:
> 
> [   28.336798] UCB1400: found IRQ
> 0
> [   28.356179] UCB1400: x/y =
> 601/735
> [   28.363892] input: UCB1400 touchscreen interface as
> /class/input/input0
> [   28.379487] ALSA device
> list:
> [   28.386389]   #0: pxa2xx-ac97 (Philips UCB1400)
> 
> but tapping touchscreen gets no samples from /dev/input/event0. And no
> interrupts in /proc/interrupts:
>   0:          0          SC  UCB1400
>   3:          1          SC  ohci_hcd:usb1
>  11:          0          SC  pxa27x_udc
>  14:        460          SC  AC97
>  17:          1          SC  LCD
>  21:         19          SC  BTUART
>  22:         71          SC  FFUART
>  23:      97011          SC  pxa2xx-mci
>  25:          0          SC  DMA
>  26:       9218          SC  ost0
> 124:          0        GPIO  MMC card detect
> 132:        107        GPIO  eth0
> Err:          0
> 
> Can you please point me to right way - i do not know where to dig =(.

Hi, it looks like the IRQ was misdetected probably. Check the following two 
patches (and possibly the vpac270 source file, the "Audio and Touchscreen" 
section will give you an idea how to force IRQ line to the driver).

http://git.kernel.org/?p=linux/kernel/git/marex/pxa-
linux-2.6.git;a=commitdiff;h=417eb54b3aba8f9aa1707fa1dae606ccaeb94599;hp=94616fcb8d6e5e51391f34463afafaad3bd20da6

http://git.kernel.org/?p=linux/kernel/git/marex/pxa-
linux-2.6.git;a=commitdiff;h=ced7f2ca8e8d99ec35ff34841c6e6a307a115fa0;hp=417eb54b3aba8f9aa1707fa1dae606ccaeb94599

Hope this helps you.
> 
> ps: sorry for my poor English.

It's actually quite ok :)
> 
> Thanks anyway.

Cheers
