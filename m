From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 11 Oct 2012 16:33:58 +0530
Subject: [PATCH v2 01/13] clk: davinci - add Main PLL clock driver
In-Reply-To: <1348683037-9705-2-git-send-email-m-karicheri2@ti.com>
References: <1348683037-9705-1-git-send-email-m-karicheri2@ti.com>
 <1348683037-9705-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <5076A79E.80502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/26/2012 11:40 PM, Murali Karicheri wrote:

> +struct clk_davinci_pll_data {
> +	/* physical addresses set by platform code */
> +	u32 phy_pllm;
> +	/* if PLL has a prediv register this should be non zero */
> +	u32 phy_prediv;
> +	/* if PLL has a postdiv register this should be non zero */
> +	u32 phy_postdiv;

"phys" is typically used for physical addresses. I couldn't immediately
related this to physical address when I looked at this variable outside
of this file.

Also, physical addresses should be of type phys_addr_t.

> +	/* mapped addresses. should be initialized by  */
> +	void __iomem *pllm;
> +	void __iomem *prediv;
> +	void __iomem *postdiv;
> +	u32 pllm_mask;
> +	u32 prediv_mask;
> +	u32 postdiv_mask;
> +	u32 num;

Wondering what num is for? May be it will be clear once you document the
complete structure as Linus suggested.

> +	/* framework flags */
> +	u32 flags;
> +	/* pll flags */
> +	u32 pll_flags;
> +       /* use this value for prediv */
> +	u32 fixed_prediv;

Why is this called "fixed". Isn't this the pre-divider value that user
can configure? Also, shouldn't there be a post-divider value that you
need as well.

> +	/* multiply PLLM by this factor. By default most SOC set this to zero
> +	 * that translates to a multiplier of 1 and incrementer of 1.
> +	 * To override default, set this factor
> +	 */
> +	u32 pllm_multiplier;

'm' in pllm stands for multiplier. So, instead of calling it
"pllm_multiplier", call it "pllm_val" instead?

Sorry about late comments on this, looks like I missed looking at this
structure altogether yesterday and had to go back to this only when I
tried understanding whats going on in 4/13

Thanks,
Sekhar
