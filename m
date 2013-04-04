From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 4 Apr 2013 10:11:46 +0200
Subject: [PATCH] rtc: rtc-at91sam9.c add DT support
In-Reply-To: <515CF985.6050009@interlog.com>
References: <515CF985.6050009@interlog.com>
Message-ID: <515D35C2.7050405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 05:54 AM, Douglas Gilbert :
> Some members of the at91 SoCs use the Real Time Timer (RTT)
> and the General Purpose Backup Registers (GPBR) to implement
> a real time clock (RTC). The AT91SAM9G20 is one example.
> 
> Attached is a patch to add DT support to rtc-at91sam9.c .
> The patch is against lk 3.9.0-rc5 .
> 
> Below is a snippet of DT code for the 'G20 that was observed
> to work with this patch:
> 
> ahb {
>     apb {
> 
>         rtc {
>             compatible = "atmel,at91sam9-rtc";

The compatible string has to be formed by the name of the first SoC
compatible with this IP. It turns to be the at91sam9260.
The second part of the string should be a name that reflects the nature
of the peripheral. For this binding, I would like to mention the "RTT"
in the compatibility string (because other drivers can use other RTT
with other uses).

What do you think about:
"atmel,at91sam9260-rtt-as-rtc"? or something shorter?

>                          /* RTTC followed by GPBR (backup registers) */
>                          reg = <0xfffffd20 0x10>, <0xfffffd50 0x10>;
>                          interrupts = <1 4 7>;
>                          status = "okay";

Last, but not least, when we add a DT binding, it is a requirement to
add the corresponding documentation in the
Documentation/devicetree/bindings/rtc/ directory.

>         };
>     }
> };
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks, best regards,
-- 
Nicolas Ferre
