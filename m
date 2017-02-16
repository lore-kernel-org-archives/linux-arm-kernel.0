From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 16:06:19 +0000
Subject: [PATCH v3 1/3] ARM: l2c: allow CA9 optimizations to be disabled
In-Reply-To: <20170216153726.22919-2-chris.brandt@renesas.com>
References: <20170216153726.22919-1-chris.brandt@renesas.com>
 <20170216153726.22919-2-chris.brandt@renesas.com>
Message-ID: <20170216160619.GQ27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 10:37:24AM -0500, Chris Brandt wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 2290be3..486cc6d 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -57,6 +57,9 @@ static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
>  
>  struct l2x0_regs l2x0_saved_regs;
>  
> +static bool l2x0_bresp_dis;
> +static bool l2x0_flz_dis;

Please use full "disable" here.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
