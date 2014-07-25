From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 25 Jul 2014 11:01:24 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <53D21B3F.7060006@aksignal.cz>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
 <53D10C50.50305@aksignal.cz> <20140724162645.4e19c26c@bbrezillon>
 <53D12103.3020103@aksignal.cz> <20140724175848.44f5da10@bbrezillon>
 <53D1F5D0.1080006@aksignal.cz> <20140725095319.16a8465c@bbrezillon>
 <53D214E1.4050105@aksignal.cz> <20140725104553.403921b1@bbrezillon>
 <53D21B3F.7060006@aksignal.cz>
Message-ID: <20140725110124.3f0dce6c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jul 2014 10:54:23 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

> Here it is:
> cat /sys/kernel/debug/gpio
> GPIOs 0-31, platform/fffff400.gpio, fffff400.gpio:
> [in20] GPIOfffff400.gpio3: [gpio] set
> [spi0.3] GPIOfffff400.gpio14: [gpio] set
> [in19] GPIOfffff400.gpio21: [gpio] set
> [spi0.1] GPIOfffff400.gpio22: [gpio] set
> [spi0.0] GPIOfffff400.gpio23: [gpio] set
> [in18] GPIOfffff400.gpio28: [gpio] set
> [out20] GPIOfffff400.gpio29: [gpio] clear
> [out18] GPIOfffff400.gpio30: [gpio] clear
> [out19] GPIOfffff400.gpio31: [gpio] clear
> 
> GPIOs 32-50, platform/fffff600.gpio, fffff600.gpio:
> [blue] GPIOfffff600.gpio12: [gpio] set
> [gsm_on] GPIOfffff600.gpio13: [gpio] clear
> [yellow] GPIOfffff600.gpio14: [gpio] clear
> [gsm_rst] GPIOfffff600.gpio15: [gpio] clear
> [green] GPIOfffff600.gpio16: [gpio] clear
> [red] GPIOfffff600.gpio18: [gpio] clear
> 
> GPIOs 64-95, platform/fffff800.gpio, fffff800.gpio:
> [in17] GPIOfffff800.gpio16: [gpio] set
> [in13] GPIOfffff800.gpio18: [gpio] set
> [in14] GPIOfffff800.gpio20: [gpio] set
> [por] GPIOfffff800.gpio25: [gpio] clear
> [out16] GPIOfffff800.gpio26: [gpio] clear
> [out15] GPIOfffff800.gpio28: [gpio] clear
> [spi0.2] GPIOfffff800.gpio29: [gpio] set
> [out17] GPIOfffff800.gpio30: [gpio] clear
> 
> GPIOs 96-117, platform/fffffa00.gpio, fffffa00.gpio:
> [nand_enable] GPIOfffffa00.gpio4: [gpio] set
> [nand_rdy] GPIOfffffa00.gpio5: [gpio] set
> [atmel_usba_udc] GPIOfffffa00.gpio21: [gpio] clear
> 

Every thing seems in place.
Could you enable CONFIG_DEBUG_PINCTRL and grep on "enable pin" ?

> 
> Dne 25.7.2014 v 10:45 Boris BREZILLON napsal(a):
> > On Fri, 25 Jul 2014 10:27:13 +0200
> > Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
> >
> > [...]
> >>
> >>
> >>> Could you also paste the content of /sys/kernel/debug/gpio ?
> >> The /sys/kernel/debug/ is empty.
> >
> > You have to enable CONFIG_DEBUG_FS in your config and then mount the
> > debug file system:
> >
> > #mount -t debugfs dbg /sys/kernel/debug
> >
> >
> >
> >



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
