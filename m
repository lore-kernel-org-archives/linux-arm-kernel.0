From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Oct 2017 17:23:24 -0700
Subject: [PATCH 1/8] SOC: brcmstb: add memory API
In-Reply-To: <1508868949-16652-2-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-2-git-send-email-jim2101024@gmail.com>
Message-ID: <a83617d0-8506-7fe4-2870-d9dbd9ffdb3f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jim,

On 10/24/2017 11:15 AM, Jim Quinlan wrote:
> +#elif defined(CONFIG_MIPS)
> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
> +{
> +	/* The logic here is fairly simple and hardcoded: if pa <= 0x5000_0000,
> +	 * then this is MEMC0, else MEMC1.
> +	 *
> +	 * For systems with 2GB on MEMC0, MEMC1 starts at 9000_0000, with 1GB
> +	 * on MEMC0, MEMC1 starts at 6000_0000.
> +	 */
> +	if (pa >= 0x50000000ULL)
> +		return 1;
> +	else
> +		return 0;
> +}
> +#endif

We may be missing an EXPORT_SYMBOL_GPL(brcmstb_memory_phys_to_addr_memc)
here?

Thanks!
-- 
Florian
