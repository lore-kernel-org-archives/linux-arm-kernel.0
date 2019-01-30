Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B97C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506372184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LV5eh2vA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hTsBX6nZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506372184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u4oKxPsilC+cPPMlHLJHpAIj4AlwI7G4ZL7ImIqxoVo=; b=LV5eh2vACU7xvF
	0l+8FNfSwo/53QAUfAktnp++fTc0J7FbrjJ4dgmeGNDPA68VWj3djoY8aBGCq75bLsDeZAzbhr9w/
	/3u5UHOwDjdkai0msArMRAGLlac3HflGBKGVHKNGtDBjLmbRadXzWhxjqoz/+fL7SpzUKeGcvSkXt
	Vtoj7OTcZfsKtkfg7gg1BT+gbDCAe3UaS1dxqG3qsIV/HAZqYxdmxrioUMsdblRS0CYfsEPMPZVqh
	WltoMf3aABDb+VJIpGlITOWVS05wD7wny+NP4xXpzr52g0o8ggefthHkDlrScTC3favwTWRdEnb1C
	T+jBJKzx9Woe/zQ+W5dA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gov2W-0002Ku-J2; Wed, 30 Jan 2019 18:56:48 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gov28-00023u-GD
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:56:26 +0000
Received: by mail-lf1-x144.google.com with SMTP id c16so435340lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ncM9ihRYoY9Br1fhJmYOdQ+HKk2h3TZyaw64RU6uDOw=;
 b=hTsBX6nZyMVwIEswxD/WcNLQml5CzOjZ/eIFeenhQo2k9utHzPfOKU6pXzOiqGfI3v
 FCIgXw7/im16Zgta/ZoxDvMysKaz+zFEGf4fXxAS0C8exFQuokKRynieGyP/ZQfKZLlO
 IPk57E1LMea0CIZ8XUDH7fJYup0061Bx3vKBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ncM9ihRYoY9Br1fhJmYOdQ+HKk2h3TZyaw64RU6uDOw=;
 b=Sfz0uzpgNlPXitw7kMKamrEq4wXwH+bzu/lSzI3s3X6IcTo7hrXlO73+Tpn3WlGT8j
 NgqBmHNGtHM4OkTjCSIpGH8IborWAgioOIRScqvRBLmm+JlGjDJ+6J95Wmw93zAsO00/
 CuS4LUzkxjXXYt1Pssg3H4dIrcVX/BDyxXLs2xAX76uN7yW7G5hvVLcoxEqTHMKD/O3U
 6eSZ6TD1GVSHcQl/RWllzvMJJtD6d+oQ3mv/9bS37V8eqiE0KugLMoJV9cwFLBLC5n2+
 u2xe9SogQQPBEfZ5R/KDH4cKsJS9cIOH8qkwf9kQooK80d9ug7j8COaoTZvn46ANkPT+
 MBTw==
X-Gm-Message-State: AJcUukdHofRbeBIpSjHXvl9zCnNnRTmzGO4DlxDPaUFD4Lmo6cD8HI1P
 eDOyX1zfRo/hDkC7bTBPIjIuiS3CJrE=
X-Google-Smtp-Source: ALg8bN6eBWpioLA7rGjRnokPQB/Yxi0rbVwsNrxNLoFUuoO8LPclz1xSS7K2KpmkLDIioi9ehS+T5Q==
X-Received: by 2002:a19:6a13:: with SMTP id u19mr25840164lfu.46.1548874582655; 
 Wed, 30 Jan 2019 10:56:22 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id y131sm416166lfc.43.2019.01.30.10.56.22
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:56:22 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id s5-v6so457819ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:56:22 -0800 (PST)
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr24571224ljb.126.1548874581917; 
 Wed, 30 Jan 2019 10:56:21 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:55:45 -0800
X-Gmail-Original-Message-ID: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
Message-ID: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
Subject: Re: [PATCH v5 14/20] iommu/mediatek: Add mmu1 support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_105624_542809_961A1444 
X-CRM114-Status: GOOD (  19.66  )
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
> Normally the M4U HW connect EMI with smi. the diagram is like below:
>               EMI
>                |
>               M4U
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> Actually there are 2 mmu cells in the M4U HW, like this diagram:
>
>               EMI
>            ---------
>             |     |
>            mmu0  mmu1     <- M4U
>             |     |
>            ---------
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> This patch add support for mmu1. In order to get better performance,
> we could adjust some larbs go to mmu1 while the others still go to
> mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
>
> mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> value of that register is 0 which means all the larbs go to mmu0
> defaultly.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 66e3615..7fcef19 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -70,27 +70,32 @@
>  #define F_MISS_FIFO_ERR_INT_EN                 BIT(6)
>  #define F_INT_CLR_BIT                          BIT(12)
>
> -#define REG_MMU_INT_MAIN_CONTROL               0x124
> -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* mmu0 | mmu1 */

The comment being on that line is kind of weird, since the comment
really applies to the lines below it. Maybe the comment should be on
its own line, or on the TRANSLATION_FAULT line.

Other than that,
Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
