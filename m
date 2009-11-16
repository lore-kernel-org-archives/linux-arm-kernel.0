From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 Nov 2009 00:37:15 +0800
Subject: [PATCH] hx4700: fix hx4700 touchscreen pressure values
In-Reply-To: <E1N9Lt7-0007mK-2t@relay07.plus.net>
References: <E1N9Lt7-0007mK-2t@relay07.plus.net>
Message-ID: <f17812d70911160837k5ef5008as442fa1d2357cc93d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 15, 2009 at 12:54 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> hx4700 touchscreen events were being dropped in ads7846_rx() because their pressure values consistently exceeded the platform maximum of 512; a sample of 256 pressure values were in the range 531 to 815. Doubling the platform maximum to 1024 allows hx4700 touchscreen events to pass the test.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>

Applied to 'fix', thanks.

> ---
> --- linux-2.6.32-rc7/arch/arm/mach-pxa/hx4700.c.orig ? ?2009-11-14 15:19:59.294682971 +0000
> +++ linux-2.6.32-rc7/arch/arm/mach-pxa/hx4700.c 2009-11-14 15:20:14.677951232 +0000
> @@ -604,7 +604,7 @@ static struct platform_device gpio_vbus
> ?static const struct ads7846_platform_data tsc2046_info = {
> ? ? ? ?.model ? ? ? ? ? ?= 7846,
> ? ? ? ?.vref_delay_usecs = 100,
> - ? ? ? .pressure_max ? ? = 512,
> + ? ? ? .pressure_max ? ? = 1024,
> ? ? ? ?.debounce_max ? ? = 10,
> ? ? ? ?.debounce_tol ? ? = 3,
> ? ? ? ?.debounce_rep ? ? = 1,
>
>
