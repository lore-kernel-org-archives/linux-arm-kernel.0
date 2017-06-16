From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Jun 2017 16:08:13 +0200
Subject: [RFT 2/2] pinctrl: samsung: Fix invalid register offset used
 for Exynos5433 external interrupts
In-Reply-To: <20170614131828.28683-2-krzk@kernel.org>
References: <20170614131828.28683-1-krzk@kernel.org>
 <CGME20170614131847epcas3p4755a0ad1e25550134ddfcf0db9aff06b@epcas3p4.samsung.com>
 <20170614131828.28683-2-krzk@kernel.org>
Message-ID: <0cfe358a-c050-aae0-5755-819c7b25ef28@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 03:18 PM, Krzysztof Kozlowski wrote:
> When setting the pin function for external interrupts, the driver used
> wrong IO memory address base.  The pin function register is always under
> pctl_base, not the eint_base.
> 
> By updating wrong register, the external interrupts for chosen GPIO
> would not work at all and some other GPIO might be configured to wrong
> value.
> 
> Platforms other than Exynos5433 should not be affected as eint_base
> equals pctl_base in such case.
> 
> Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank")
> Cc:<stable@vger.kernel.org>
> Reported-by: Tomasz Figa<tomasz.figa@gmail.com>
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

The patch looks good to me, I'll try to test it later today.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Thanks,
Sylwester
