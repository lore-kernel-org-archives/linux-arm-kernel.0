From: yong.wu@mediatek.com (Yong Wu)
Date: Sat, 12 Aug 2017 17:36:08 +0800
Subject: [PATCH 7/8] memory: mtk-smi: Rearrange some function position
 alphabetically
In-Reply-To: <34e9e7ec-ff9b-caf9-09ac-a0d9e9d85fa5@arm.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
 <1502445377-26936-8-git-send-email-yong.wu@mediatek.com>
 <34e9e7ec-ff9b-caf9-09ac-a0d9e9d85fa5@arm.com>
Message-ID: <1502530568.11148.55.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-11 at 19:09 +0100, Robin Murphy wrote:
> On 11/08/17 10:56, Yong Wu wrote:
> > Only adjust some code position in Soc numerical order, from mt2701,
> > mt2712 to mt8173.
> > 
> > Besides, 3 minor changes:
> > 1) fix a coding style issue:
> >     CHECK: Alignment should match open parenthesis
> >     +               writel(reg_val,
> >     +                       common->smi_ao_base
> > 2) change from readl to readl_relaxed in gen1_config_port.
> > 3) change the type "larbid" from "int" to "unsigned int" to meet
> >    the requirement of of_property_read_u32.
> 
> If moving existing code around is really necessary, do it as a
> preliminary patch *before* any material changes (and arguably separate
> even from the whitespace and comment updates) - those diffs are usually
> hard to review as-is, so being able to check you get binary-identical
> object files before and after is reassuring. A "cleanup" patch shouldn't
> need to touch code added in the same series, and it certainly shouldn't
> have significant things like the readl_relaxed() change hidden in it.

OK. This patch is really not easy to read.

This patch-set is mainly for supporting MT2712 IOMMU. thus, I will use a
patch "readl_relaxed replace readl" instead of this one.

About the cleanup patch, I can send it in future if necessary.

> 
> Robin.
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 105 +++++++++++++++++++++++------------------------
> >  1 file changed, 52 insertions(+), 53 deletions(-)
> > 
[...]
