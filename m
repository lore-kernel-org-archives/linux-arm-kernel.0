From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 25 Jul 2014 11:31:10 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <53D21FCF.7010402@aksignal.cz>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
 <53D10C50.50305@aksignal.cz> <20140724162645.4e19c26c@bbrezillon>
 <53D12103.3020103@aksignal.cz> <20140724175848.44f5da10@bbrezillon>
 <53D1F5D0.1080006@aksignal.cz> <20140725095319.16a8465c@bbrezillon>
 <53D214E1.4050105@aksignal.cz> <20140725104553.403921b1@bbrezillon>
 <53D21B3F.7060006@aksignal.cz> <20140725110124.3f0dce6c@bbrezillon>
 <53D21FCF.7010402@aksignal.cz>
Message-ID: <20140725113110.70c4aa41@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jul 2014 11:13:51 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:


> >
> > Every thing seems in place.
> > Could you enable CONFIG_DEBUG_PINCTRL and grep on "enable pin" ?
> / # dmesg | grep "enable pin"
> [    0.968750] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 101 as GPIO
> [    0.968750] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 101 as PIOD5 0x20
> [    0.968750] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 100 as GPIO
> [    0.968750] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 100 as PIOD4 0x10
> [    1.238281] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 23 as GPIO
> [    1.238281] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 23 as PIOA23 0x800000
> [    1.238281] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 22 as GPIO
> [    1.238281] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 22 as PIOA22 0x400000
> [    1.242187] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 93 as GPIO
> [    1.242187] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 93 as PIOC29 0x20000000
> [    1.246093] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 14 as GPIO
> [    1.246093] pinctrl-at91 ahb:apb:pinctrl at fffff400: enable pin 14 as PIOA14 0x4000


Okay, this cleary shows that PA14 pin is muxed as a GPIO (or at least
the driver think it is).


Could you launch these commands (you'll need the devmem tool) and
paste the results ?

#devmem 0xfffff408
#devmem 0xfffff418
#devmem 0xfffff438
#devmem 0xfffff43c
#devmem 0xfffff458
#devmem 0xfffff468
#devmem 0xfffff470
#devmem 0xfffff474
#devmem 0xfffff498

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
