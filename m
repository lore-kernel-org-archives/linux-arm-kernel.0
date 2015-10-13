From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 09:57:53 +0200
Subject: [PATCH] pxa: remove incorrect __init annotation on
 pxa27x_set_pwrmode
In-Reply-To: <87fv1f6bjj.fsf@belgarion.home>
References: <5287252.pkh9x0t1Y6@wuerfel> <5395757.goqVg4VzNo@wuerfel>
 <87fv1f6bjj.fsf@belgarion.home>
Message-ID: <6820669.agSbTbzqFV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 23:07:28 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

> > The z2 in particular never did, except in the powerdown handler. So if it
> > is unable to wake up reliably from DEEPSLEEP, that may be a reason to use
> > that flag only in the poweroff function but not during normal operation.
> My first thought was :
>         This flag's only use is for Suspend to RAM.  There might be special
>         wirings where the voltage to the RAM is provided out of SYS_EN pin
>         control, and therefore PWRMODE_DEEPSLEEP is possible. But the most
>         common pattern would be a PMIC, providing voltage to the DRAM through
>         Vcc_Mem.
> 
> But having a closer look, you're right, I have misunderstood the way z2 poweroff
> was designed. The setting of poweroff to PWRMODE_DEEPSLEEP +
> pxa27x_cpu_pm_enter() is a whole, it is the closest to a platform halt where no
> external chip handles the poweroff phase, and memory is shutdown in deep sleep.
> 
> Therefore I'll drop Thierry's patch (which would actually break suspend to RAM I
> think) and take yours.

Ok, sounds good. thanks!

	Arnd
