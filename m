From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 13 May 2010 10:49:29 +0900
Subject: [PATCH 11/11] ARM: S5P6440: Remove redundant defines
In-Reply-To: <1273710481-14856-1-git-send-email-kgene.kim@samsung.com>
References: <1273710481-14856-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTimTm_Vxvb2xvJnVxTxUaYguFgGeaWGypzA1yjwM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 9:28 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> --- a/arch/arm/mach-s5p6440/clock.c
> +++ b/arch/arm/mach-s5p6440/clock.c
> @@ -357,121 +357,121 @@ static struct clk init_clocks_disable[] = {
> ? ? ? ? ? ? ? ?.id ? ? ? ? ? ? = -1,
> ? ? ? ? ? ? ? ?.parent ? ? ? ? = &clk_hclk.clk,
> ? ? ? ? ? ? ? ?.enable ? ? ? ? = s5p6440_mem_ctrl,
> - ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= S5P_CLKCON_MEM0_HCLK_NFCON,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 2),
Peculiar. I have never seen defines dropped in favor of magic numbers.
