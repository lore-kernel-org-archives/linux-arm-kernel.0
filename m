Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8691FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF1B2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qtza8o06";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAMal645"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF1B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kJm+gZSqIikYDPoo1oCBwshS7kjZ0KXmfcd+0Y1pzAQ=; b=qtza8o068Wa+DG
	7lHfH/7dfE3ZZfsskd7X2sU/cO/0WVAJepxNj6/0IDdqEuBq2y6ByB0IADkIGtD+8dLZd6G7ml55g
	EUsH38mxgPdpTyL9vYhU/FymyTQe6ZgNEmZucJfjCBsZeukBJiubRlU9jGHNmGytDbxhh169xYoDs
	GrQduEMTNXUZZLuxXNw0+hqeh0OBS5hDcy569mHHkeqK7GtofiXR3+fafxC5O5mqJ8np3skrjU5iR
	R/m4u0FCAmNfjkJz/68qpAu9SymXl+lH2swZ7PZuTxxvz2eTqdSA6F/kkEph4oXYKU0XkMfqwsHOu
	eP3wfR9QkDWatlcaeGEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govDL-0006Ps-2d; Wed, 30 Jan 2019 19:07:59 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govDH-0006OO-43
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:07:57 +0000
Received: by mail-lf1-x142.google.com with SMTP id u18so447513lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u2kvNL8hyI8LvEhJp8PwSq49BVsqDIa5rehdFSpt/WA=;
 b=LAMal645UtppVgxvUM0liVNBkXQhEeuOZbWAMkeKgNRLnJo9l1bO+ClwBIOB7IOvD5
 KdRp2Los/M2vb5x2Ks1C8WtQuxKnYKu8FOYwSO0y4YGta86aMqHFMjkQkZDJ/buQ9zZS
 rnSNQrlDmEkMtcQ5MgWcxQhIHtN6GN+LpdmuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u2kvNL8hyI8LvEhJp8PwSq49BVsqDIa5rehdFSpt/WA=;
 b=OmQeB34agFNTRrQu2Ca/AFWeYl/7ZaIt0yvzluT3xaSZUew6jWkezSARXuyb2FNnIu
 OP6oCTSZdPTjWp6BxDQm/q+/dOAtjLS8SzQcviPjKhKXr/HIBQLnJ5MVY1Hugf698A8o
 /ka1GDBtCOBB9RrC6V/R1hjj7nVWhYPUhUiemungDGKukGdtYPevu1Pui8sDynsIUsvB
 jQXC3JW4zeD6NtL0NY4I2fOS05RCcm9ZGJj+rvUL/++TOI0MEW88rpHLaqgpF1v896Ig
 7yr+oBt8VxtyW7KNPFw3hSZVdI1rlgpTgPtH5GoN2Zj8dUOu4J+QnNHoEUwtc8VCc1aj
 KOIg==
X-Gm-Message-State: AJcUukdhvJ11CL36UIrGuF9VDPFVIPRoJ+CGMr1yYafGobukgnz5mn0X
 El07CayvMv1yeJgxjLeDsoKDCvVFx4s=
X-Google-Smtp-Source: ALg8bN5xzirFnek+ogFpOHbQfQqga3eFdh728KuF10IAjFnN8jamITd47OaAmgHi7mJKzo0IoNjYOw==
X-Received: by 2002:a19:f89:: with SMTP id 9mr24469436lfp.10.1548875273065;
 Wed, 30 Jan 2019 11:07:53 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id e97-v6sm416404lji.51.2019.01.30.11.07.50
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:07:51 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id c19-v6so548198lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:07:50 -0800 (PST)
X-Received: by 2002:a2e:9715:: with SMTP id
 r21-v6mr26090126lji.30.1548875269976; 
 Wed, 30 Jan 2019 11:07:49 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 11:07:13 -0800
X-Gmail-Original-Message-ID: <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Message-ID: <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Subject: Re: [PATCH v5 16/20] memory: mtk-smi: Add bus_sel for mt8183
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_110755_162504_8494DA2E 
X-CRM114-Status: GOOD (  20.07  )
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

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 9790801..08cf40d 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -49,6 +49,12 @@
>  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
>  #define F_MMU_EN               BIT(0)
>
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> +
>  enum mtk_smi_gen {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -57,6 +63,7 @@ enum mtk_smi_gen {
>  struct mtk_smi_common_plat {
>         enum mtk_smi_gen gen;
>         bool             has_gals;
> +       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -72,8 +79,8 @@ struct mtk_smi {
>         struct clk                      *clk_apb, *clk_smi;
>         struct clk                      *clk_gals0, *clk_gals1;
>         struct clk                      *clk_async; /*only needed by mt2701*/
> -       void __iomem                    *smi_ao_base;
> -
> +       void __iomem                    *smi_ao_base; /* only for gen1 */
> +       void __iomem                    *base;        /* only for gen2 */
>         const struct mtk_smi_common_plat *plat;
>  };
>
> @@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>         .gen      = MTK_SMI_GEN2,
>         .has_gals = true,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> +                   F_MMU1_LARB(7),
>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> @@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 ret = clk_prepare_enable(common->clk_async);
>                 if (ret)
>                         return ret;
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               common->base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(common->base))
> +                       return PTR_ERR(common->base);

So you split base and smi_ao_base because they're completely different
register regions, or because ->base is no longer "always on"? It's
tempting to recombine them because they appear to be mutually
exclusive, but if they're truly different register regions then I
understand.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
