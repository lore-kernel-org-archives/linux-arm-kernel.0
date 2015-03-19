From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 19 Mar 2015 09:02:16 +0100
Subject: [PATCH] clocksource: atmel-st: select REGMAP_MMIO
In-Reply-To: <1426676795-29333-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426676795-29333-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150319090216.634797ef@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, 18 Mar 2015 12:06:35 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Enforce REGMAP_MMIO selection as the driver needs it. Else, it will still
> compile with some warning about X1, x2 or sr being used uninitialized.
> 
> Reported-by: fengguang.wu at intel.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Daniel,
> 
> I think this should go through the at91 tree as the patch introducing that issue
> went there.
> 
>  drivers/clocksource/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 168035883afa..3cc97b217019 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -146,6 +146,7 @@ config ATMEL_PIT
>  config ATMEL_ST
>  	bool
>  	select CLKSRC_OF
> +	select REGMAP_MMIO

Shouldn't we select MFD_SYSCON instead.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
