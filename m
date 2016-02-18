From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 18 Feb 2016 19:42:20 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <alpine.LFD.2.20.1602181327060.13632@knanqh.ubzr>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602181244490.13632@knanqh.ubzr>
 <HK2PR06MB0561377EABB3B4B8E94F22328AAF0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1602181327060.13632@knanqh.ubzr>
Message-ID: <HK2PR06MB0561C0EEA846C516645239338AAF0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Nicolas Pitre wrote:

> > Is there some way you can do a PLATFORM_COUNTER++ for each device that 
> > is selected, and then XIP_KERNEL would depend on PLATFORM_COUNTER == 1 
> > ?
>
> I don't know all the Kconfig possibilities.
>
> But would something like this work?
>
> config FOO
>	depends on !(XIP && CHOICE_MADE)
>	select CHOICE_MADE

I follow your logic and that might work: If you made multiple choices, it would just take the first one.

However...I just tried it and it crashes.

scripts/kconfig/mconf  Kconfig
make[2]: *** [menuconfig] Segmentation fault (core dumped)
make[1]: *** [menuconfig] Error 2


It looks like you can't depend on something not being set that you are going to set yourself. Basically..."do as I say, not as I do"


Chris
