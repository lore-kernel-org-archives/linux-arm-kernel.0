From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 15:11:23 +0200
Subject: [PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and dw-apb-timer-sp
 to just dw-apb-timer
In-Reply-To: <1371514129-22801-2-git-send-email-dinguyen@altera.com>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
 <1371514129-22801-2-git-send-email-dinguyen@altera.com>
Message-ID: <201306181511.24004.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, dinguyen at altera.com wrote:
> @@ -476,27 +476,31 @@
>                 };
>  
>                 timer0: timer0 at ffc08000 {
> -                       compatible = "snps,dw-apb-timer-sp";
> +                       compatible = "snps,dw-apb-timer";
>                         interrupts = <0 167 4>;
>                         reg = <0xffc08000 0x1000>;
> +                       clocks = <&osc>;
>                 };
>  
>                 timer1: timer1 at ffc09000 {
> -                       compatible = "snps,dw-apb-timer-sp";
> +                       compatible = "snps,dw-apb-timer";
>                         interrupts = <0 168 4>;
>                         reg = <0xffc09000 0x1000>;
> +                       clocks = <&osc>;
>                 };

I think it would make sense to fix the device name as well, they should
all be named "timer", not "timer0", so I would add


-                 timer0: timer0 at ffc08000 {
+                 timer0: timer at ffc08000 {

for all the timers in the dts file here.

	Arnd
