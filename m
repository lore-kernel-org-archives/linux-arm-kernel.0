From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 19 Mar 2015 14:19:48 +0100
Subject: [PATCH v2] clocksource: atmel-st: select MFD_SYSCON
In-Reply-To: <1426771068-9657-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426771068-9657-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150319141948.016c2d66@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015 14:17:48 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Enforce MFD_SYSCON selection as the driver needs it. Else, it will still
> compile with some warning about X1, x2 or sr being used uninitialized.
> 
> Reported-by: fengguang.wu at intel.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

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
> index 168035883afa..55aef6f89074 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -146,6 +146,7 @@ config ATMEL_PIT
>  config ATMEL_ST
>  	bool
>  	select CLKSRC_OF
> +	select MFD_SYSCON
>  
>  config CLKSRC_METAG_GENERIC
>  	def_bool y if METAG



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
