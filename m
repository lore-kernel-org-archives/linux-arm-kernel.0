From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Oct 2015 09:51:35 -0500
Subject: [PATCH v13 2/5] uart: pl011: Introduce register accessor
In-Reply-To: <5630DA2A.4050803@hurleysoftware.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-3-git-send-email-jun.nie@linaro.org>
 <55FBECCD.2080906@arm.com>
 <CAOZdJXUZDTzEn4f4FGhmKfq7HeEFKPKp4BAbR6_=wXGVw5_0GQ@mail.gmail.com>
 <5630DA2A.4050803@hurleysoftware.com>
Message-ID: <5630E0F7.9080705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 09:22 AM, Peter Hurley wrote:
> EARLYCON_DECLARE(zte, zte_early_console_setup);
> OF_EARLYCON_DECLARE(zte, ".......", zte_early_console_setup);
> EARLYCON_DECLARE(sbsa32, sbsa32_early_console_setup);
> OF_EARLYCON_DECLARE(sbsa32, "arm,sbsa-uart", sbsa32_early_console_setup);
>
> The above assumes that the sbsa32 maintains the equivalence of
> earlycon and console; ie., that
>
> / {
> 	chosen {
> 		stdout-path = &uart0;
> 	};
>
> 	soc {
> 		uart0: serial at xxxxxx {
> 			compatible = "arm,sbsa-uart";
> 		};
> 	};
> };
>
>
> will start a sbsa32 earlycon and later replace that with
> sbsa console.

I never really understood the device tree support for SBSA.  The "S" 
stands for Server, and ARM Server systems are supposed to use ACPI. 
It's easy to add special cases via device tree, because of its 
flexibility.  ACPI is much more difficult, and that's why I used the 
command-line approach.

Anyway, I found this alternate patch from Lief Lindholm that implements 
this idea better, although it needs work:

https://patches.linaro.org/53265/




-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
