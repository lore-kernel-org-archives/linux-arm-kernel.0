From: mturquette@ti.com (Mike Turquette)
Date: Mon, 18 Jun 2012 18:38:12 -0700
Subject: [PATCH 09/29] ARM: omap: clk: Nuke plat/clock.c & reuse struct
 clk as clk_hw_omap
In-Reply-To: <1339678038-23082-10-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-10-git-send-email-rnayak@ti.com>
Message-ID: <20120619013812.GC4402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120614-18:16, Rajendra Nayak wrote:
> plat/clock.c which has most of usecounting/locking infrastructure will
> be used only for OMAP1 until that is moved to use COMMON clk.
> 
> reuse most of what plat/clock.h has while we move to common clk, and
> move most of what 'struct clk' was as 'struct clk_hw_omap' which
> will then be used to define platform specific parameters.
> All usecounting/locking related variables from 'struct clk' are
> dropped as they will not be used with 'struct clk_hw_omap'.
> 
> Based on the original changes from Mike Turquette.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Looks good to me Rajendra.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> +unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
> +		unsigned long parent_rate);

Would be nice to get rid of this.  I think only iva1_mpu_int_ifck from
OMAP2 uses it.  If so it would be nice to convert that clock over to the
fixed factor type (if possible) and drop this bit of glue code.
Probably something for the future though, no reason to block this patch
on it.

Regards,
Mike
