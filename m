From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 8 Jul 2015 16:49:54 +0800
Subject: [PATCH 0/2] Add MT8173 MMPLL change rate support
In-Reply-To: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436345394.3526.111.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The cover letter's title should be "[PATCH v2 0/2] ..."

changes since v1:
- Add a separated patch for mtk_pll_set_rate_regs().
- Use a structure array to describe a div_table.
- Limit max frequency to div_table[0].
- Minor changes such as static and comments.


Best regards,

James

On Wed, 2015-07-08 at 16:37 +0800, James Liao wrote:
> MT8173 MMPLL frequency settings are different from common PLLs.
> It needs different post divider settings for some ranges of frequency.
> This patch add support for MT8173 MMPLL frequency setting, includes:
> 
> 1. Add div-rate table for PLLs.
> 2. Increase the max ost divider setting from 3 (/8) to 4 (/16).
> 3. Write postdiv and pcw settings at the same time.
> 
> James Liao (2):
>   clk: mediatek: Fix PLL registers setting flow
>   clk: mediatek: Add MT8173 MMPLL change rate support
> 
>  drivers/clk/mediatek/clk-mt8173.c | 24 +++++++++++++++++++++---
>  drivers/clk/mediatek/clk-mtk.h    |  6 ++++++
>  drivers/clk/mediatek/clk-pll.c    | 39 +++++++++++++++++++++++++++------------
>  3 files changed, 54 insertions(+), 15 deletions(-)
> 
> --
> 1.8.1.1.dirty
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
