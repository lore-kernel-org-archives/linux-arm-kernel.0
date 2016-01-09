From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 09 Jan 2016 21:56:39 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <4332640.jBKM55TPAo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 January 2016 09:25:54 kernel at martin.sperl.org wrote:
> --- a/include/dt-bindings/clock/bcm2835.h
> +++ b/include/dt-bindings/clock/bcm2835.h
> @@ -44,5 +44,6 @@
>  #define BCM2835_CLOCK_EMMC             28
>  #define BCM2835_CLOCK_PERI_IMAGE       29
>  #define BCM2835_CLOCK_PWM              30
> +#define BCM2835_CLOCK_PCM              31
>  
> -#define BCM2835_CLOCK_COUNT            31
> +#define BCM2835_CLOCK_COUNT            32

The last line contains an incompatible change, please don't do that.
If you have to add another clock, do that after the BCM2835_CLOCK_COUNT
definition to avoid changing dts files that use that number.

	Arnd
