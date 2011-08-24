From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 20:13:44 +0900
Subject: [PATCH 3/4] ARM: SAMSUNG: Add support for handling of cpu revision
In-Reply-To: <1313816759-14564-4-git-send-email-kgene.kim@samsung.com>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
	<1313816759-14564-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <06f301cc624e$e38dbd70$aaa93850$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> This patch adds plat-samsung/cpu.c for detecting of cpu id and
> silicon revision.
> 
> This patch was originally from Changhwan Youn <chaos.youn@samsung.com>
> 
> Acked-by: Changhwan Youn <chaos.youn@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---

(snip)

> +void __init s5p_init_cpu(void __iomem *cpuid_addr)
> +{
> +	samsung_cpu_id = __raw_readl(cpuid_addr);
> +	samsung_cpu_rev = samsung_cpu_id & 0xF;

Oops, should be 0xFF not 0xF.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
