From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 11:45:23 +0100
Subject: [PATCH 15/32] dmaengine: ste_dma40: Separate Logical Global
 Interrupt Mask (GIM) unmasking
In-Reply-To: <1366279934-30761-16-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-16-git-send-email-lee.jones@linaro.org>
Message-ID: <20130418104523.GN14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 11:11:57AM +0100, Lee Jones wrote:
> +void d40_log_gim_unmask(u32 *src_cfg, u32 *dst_cfg) {
> +
> +	*src_cfg |= 1 << D40_SREG_CFG_LOG_GIM_POS;
> +	*dst_cfg |= 1 << D40_SREG_CFG_LOG_GIM_POS;

So, in patch 3, you started using the BIT() macro.  But here it's fine
not to because... ?

Use one notation or the other, don't mix them together.
