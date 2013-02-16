From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Sun, 17 Feb 2013 00:05:07 +0100
Subject: [PATCH v2 00/12] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <201302170005.08300.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 16. Februar 2013, 17:43:52 schrieb Tomasz Figa:
> This series is an attempt to make the samsung-time clocksource driver ready
> for multiplatform kernels. It moves the driver to drivers/clocksource,
> cleans it up from uses of static platform-specific definitions, simplifies
> timer interrupt handling and adds Device Tree support.
> 
> Tested on a Tiny6410 board (Mini6410-compatible) both with and without
> Devicee Tree (with my DT patches for S3C64xx). Compile tested for other
> related SoCs.
> 
> Changes since v1:
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16005)
>  - Addressed comments from Mark Rutland
>  - Documented struct samsung_timer_variant
>  - Dropped inactive mail addresses from CC
> 
> Tomasz Figa (12):
>   ARM: SAMSUNG: Move samsung-time to drivers/clocksource
>   clocksource: samsung-time: Set platform-specific parameters at runtime
>   clocksource: samsung-time: Drop useless defines from public header
>   ARM: SAMSUNG: Move samsung-time.h header to inlude/clocksource
>   clocksource: samsung-time: Use local register definitions
>   clocksource: samsung-time: Remove use of static register mapping
>   clocksource: samsung-time: Use clk_get_sys for getting clocks
>   ARM: SAMSUNG: devs: Drop unnecessary IRQ resources of timer devices
>   clocksource: samsung-time: Do not use static IRQ definition
>   clocksource: samsung-time: Move IRQ mask/ack handling to the driver
>   ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
>   clocksource: samsung-time: Add Device Tree support

on a non-dt s3c2416 based board
Tested-by: Heiko Stuebner <heiko@sntech.de>


once I've ported my s3c2416 dt patches to all the recent changes, I will also 
test the dt side.


Heiko
