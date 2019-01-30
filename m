Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54617C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5E120869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UlgBVdq7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGUZF20T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5E120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+mp7/YtDX4IlUVJfqhkFbL2MUzXw38Tx9LiFLW5G++o=; b=UlgBVdq7LWNak9
	ICWabUeP0/saT40uqxabrCs+Ixuk884IxLKz9cAvx1kvDyk9SKlS0StAuHm04VS9DQNe1vjyHvhpc
	HvP8pQF2/N44Q6HBJDggOFhQjKAPHgapGR1g3dVPNWlkTVwoVQddTocPZ1k4LAjS/sqxMR97hdCmW
	0LWB2KNgMRw882LyUuw5THir8KzN4t+ls1QjRJsF3qT5H0nk68XXnbx0EEfhw3K0wpBNoV4LTlteL
	tQN2nHyh6VdNjyCVpEdF0WEDccYgrUt75Lxe1dUSB02D7ndCdAD6QVP0srQQeyerPvA5fXPE6mRu1
	d7k09TgbeLzr2nJkS88Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goujg-0000rb-Lo; Wed, 30 Jan 2019 18:37:20 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goujA-0000Or-L7
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:36:57 +0000
Received: by mail-lf1-x143.google.com with SMTP id c16so391793lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E6oIusMF+iFLQKqeXCK/18P8bJ9F9HsbW/9Ihvp1RMY=;
 b=SGUZF20Tb1xKiJC2QZUA+j8QUBKvC5yQg65xBn31Dy2xE2in2dCL6hqUZQOxdpLG0P
 cPJ1VJxs2EIh9jacIMGYv+gI0RC+TM4jx/MqphWM0IfV/+efzWVawzweyj3ELA5XmfoK
 Bj4PR68aPpg6FEajxTcsHsq7W7OCLDRfbQOrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E6oIusMF+iFLQKqeXCK/18P8bJ9F9HsbW/9Ihvp1RMY=;
 b=Bo/DcRWM09AjAJGCGJ4dYiBY+ZbRe81X2L+k9C0b0PJOB4AuKSZlPHyi94wroN/6vk
 BDnxMM0gxDBFBIerffslaFeLYgQxhBXCDYGPWNaJiclc9wnHfTwYcBnYbayKmDvrntTd
 ND9VpB+GdzS/Q2fL4GqOiNuL7IkS0D9tuJ9GZd+HRVcJYrLwPR/RL9i/tnwau7vZXZkL
 FcqrrlhR1attGhk19dGxj0/8RPWbOskaZc0CPBXkhWuADe3ZCim6YcGU9L4sAl4750nw
 7T/9tpj2slG/P3aIGcrKr6+sC228tFJdjt+i+WE03NiSS8GX3+SdqwNZ+tSzPqgh0Jx9
 AR8w==
X-Gm-Message-State: AJcUukdp3j8ZBNUEKuQcTNHrvGgPteO8FzBm8ajEbmFdhow9wlNT/U63
 d8lwXPkyFyHAX/eS9Q5mU073FxIVHu0=
X-Google-Smtp-Source: ALg8bN6ISfEf9DmwCgXTZmNdsDWsOApZRf7orkWp1HtTXR6KdfxSZfNfl4w0swMk2IYAkk7lachZWw==
X-Received: by 2002:a19:d619:: with SMTP id n25mr22609644lfg.91.1548873406496; 
 Wed, 30 Jan 2019 10:36:46 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id o14-v6sm396384lji.70.2019.01.30.10.36.46
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:36:46 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q2-v6so425957lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:46 -0800 (PST)
X-Received: by 2002:a2e:9715:: with SMTP id
 r21-v6mr25985526lji.30.1548872964434; 
 Wed, 30 Jan 2019 10:29:24 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-7-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-7-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:28:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
Message-ID: <CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_103649_409770_A7B731AE 
X-CRM114-Status: GOOD (  35.19  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek extend the arm v7s descriptor to support the dram over 4GB.
>
> In the mt2712 and mt8173, it's called "4GB mode", the physical address
> is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> bit32 is always enabled. thus, in the M4U, we always enable the bit9
> for all PTEs which means to enable bit32 of physical address.

I got a little lost here. I get that you're trying to explain why you
always used to set bit32 of the physical address. But I don't totally
get the part about physical addresses being from 0x4000_0000 -
0x1_3fff_ffff, but also from 0x1_0000_0000-0x1_ffff_ffff. Are you
saying that the physical addresses from the iommu's perspective were
always >0x1_0000_0000? But then from whose perspective is it
0x4000_0000? ... oh, or you're saying there was some sort of remapping
facility that moved the physical addresses around?

>
> but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> 32bits.
>
> In order to unify code, in the "4GB mode", we add the bit32 for the
> physical address manually in our driver.
>
> Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> has to been moved into v7s.
>
> Regarding whether the pagetable address could be over 4GB, the mt8183
> support it while the previous mt8173 don't. thus keep it as is.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
>  drivers/iommu/io-pgtable.h         |  7 +++----
>  drivers/iommu/mtk_iommu.c          | 14 ++++++++------
>  drivers/iommu/mtk_iommu.h          |  1 +
>  4 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 11d8505..8803a35 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -124,7 +124,9 @@
>  #define ARM_V7S_TEX_MASK               0x7
>  #define ARM_V7S_ATTR_TEX(val)          (((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>
> -#define ARM_V7S_ATTR_MTK_4GB           BIT(9) /* MTK extend it for 4GB mode */
> +/* MediaTek extend the two bits below for over 4GB mode */
> +#define ARM_V7S_ATTR_MTK_PA_BIT32      BIT(9)
> +#define ARM_V7S_ATTR_MTK_PA_BIT33      BIT(4)

If other vendors start doing stuff like this we'll need a more generic
way to handle this... but I guess until we see a pattern this is okay.

>
>  /* *well, except for TEX on level 2 large pages, of course :( */
>  #define ARM_V7S_CONT_PAGE_TEX_SHIFT    6
> @@ -183,13 +185,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
>  static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>                                     struct io_pgtable_cfg *cfg)
>  {
> -       return paddr & ARM_V7S_LVL_MASK(lvl);
> +       arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> +
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> +               if (paddr & BIT_ULL(32))
> +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> +               if (paddr & BIT_ULL(33))
> +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> +       }
> +       return pte;
>  }
>
>  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>                                   struct io_pgtable_cfg *cfg)
>  {
>         arm_v7s_iopte mask;
> +       phys_addr_t paddr;
>
>         if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
>                 mask = ARM_V7S_TABLE_MASK;
> @@ -198,7 +209,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>         else
>                 mask = ARM_V7S_LVL_MASK(lvl);
>
> -       return pte & mask;
> +       paddr = pte & mask;
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> +                       paddr |= BIT_ULL(32);
> +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> +                       paddr |= BIT_ULL(33);
> +       }
> +       return paddr;
>  }
>
>  static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> @@ -315,9 +333,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
>         if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
>                 pte |= ARM_V7S_ATTR_NS_SECTION;
>
> -       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
> -               pte |= ARM_V7S_ATTR_MTK_4GB;
> -

So despite getting lost in the details, I guess the reason it's okay
that this goes from unconditional to conditional on bit32 is that
before, with the older chips, all physical addresses were above 4GB,
so we'll always see PA's above 4GB?

>         return pte;
>  }
>
> @@ -504,7 +519,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
>         if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>                 return 0;
>
> -       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> +       if (WARN_ON(upper_32_bits(iova)) ||
> +           WARN_ON(upper_32_bits(paddr) &&
> +                   !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
>                 return -ERANGE;
>
>         ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 47d5ae5..69db115 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -62,10 +62,9 @@ struct io_pgtable_cfg {
>          *      (unmapped) entries but the hardware might do so anyway, perform
>          *      TLB maintenance when mapping as well as when unmapping.
>          *
> -        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
> -        *      PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
> -        *      when the SoC is in "4GB mode" and they can only access the high
> -        *      remap of DRAM (0x1_00000000 to 0x1_ffffffff).
> +        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) MediaTek IOMMUs extend
> +        *      to support up to 34 bits PA where the bit32 and bit33 are
> +        *      encoded in the bit9 and bit4 of the PTE respectively.
>          *
>          * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
>          *      be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 189d1b5..ae1aa5a 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -367,12 +367,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
>                          phys_addr_t paddr, size_t size, int prot)
>  {
>         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>         unsigned long flags;
>         int ret;
>
> +       /* The "4GB mode" M4U physically can not use the lower remap of Dram. */
> +       if (data->plat_data->has_4gb_mode && data->enable_4GB)
> +               paddr |= BIT_ULL(32);
> +

Ok here's where I get lost. How is this okay? Is the same physical RAM
accessible at multiple locations in the physical address space? Won't
this map an iova to a different pa than the one requested?

Also, you could have rolled the has_4gb_mode check into whether or not
you set enable_4GB. Then you're doing the check for has_4gb_mode once,
rather than on every map call.
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
