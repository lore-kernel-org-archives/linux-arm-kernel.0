Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811D921871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cmCRAJ4r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHWprtkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811D921871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DJDHMVgAVS07M5VxqmRVb596xjnfMmnuPOEbIl0O1Qs=; b=cmCRAJ4rgtxUkD
	zh6e/s0nbHlv/OgrvLvJXTxHBfyxfzIGld3/QAS5Qfr/JA7/ewQlQa5XwqvEKrAv9s8/BBIh/PoKM
	/+tM7pZcPDoribNJ6yAT+BqDzez8RfZxlO0ALXiQLok03pC1ILGl2Dk2L9YLRaQDQKg9+KjaeQF1/
	o7ckN8GnMTtouCbExhidCZ0j1ZwaxKe/enF1U/sAtMZRgGr7YzOBsiBxv+NgT+i1aXTtwojXuUlFo
	pbp5FH9OoTg4JovthzTpfhOttTg0SwrUCmUZUseTTqH27dQ6It9Iq8c1lkVIiA/vhOSRallRgtvHk
	DMXIEni5FLMu0t8RHJhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQ5i-0001dE-81; Mon, 25 Feb 2019 23:55:22 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQ5R-0000JQ-F9
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:55:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id z25so9087565ljk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v4zKbHDhMsN+Mg7u0glRIUId4HtPnOzdJXLjXBeHdzg=;
 b=OHWprtkORMqk3kKdabHOVWP/Y3RhmlW9snAjiZJfKfl2rYVcSsU1z+ZiO0XpIGJ7p7
 rAbQl+Wz97fdWOmXL2ZHPI0o1G4vZ9X6yozpLEHUy6h4GmN62k4NgA/+Wo0dci4/8Gr2
 qrDCwCrbOy+JLyMuJXexQR8LZ2/ijBPYnyPkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v4zKbHDhMsN+Mg7u0glRIUId4HtPnOzdJXLjXBeHdzg=;
 b=Y23RBqxs+NFLiM8rK1gxzXJcpEufPUvIGmKQqvPZt/bEK+HB+svNdR7+gxR6N1JRiF
 XRIvz8tJpBNVoQAz0G5l0P7HvdFJnIl2YAlaIyQeemKF2rC096GylDXp5T6nPoiwIbLz
 yVdEkKKSwUB1oFCFxshNyLcsCCSMxuu10QykR60X69PXhx3yaFNRRvVaQw3tuBvaj9Xj
 5p2vQ18KJt9S9GkapaBmgGTxZkymLX5ztLYpd3yrOV2GXOd1Y85d3Nr5MdXNlm4IJnc1
 R8IMi88NrYHSBvFfZpJdjbPgdOq9jtTzctSIXrGhZzPpGTXCj9DRy9sa2rg6eRlPaBT5
 gStQ==
X-Gm-Message-State: AHQUAuYQZa0lprqm3UbDe2M7nzbUi1AUst1ELGOx21bklPyHRXKXK7r1
 vxbL9zhhXkGobdF+29S0JNPBEnz401g=
X-Google-Smtp-Source: AHgI3IaqMIcBF/EB7n3lcTnl5GVuxFMba+11XY4JhXhzIEDnqrlsI7KfNHZKg0/GFn1wvzPYcGeu3A==
X-Received: by 2002:a2e:9001:: with SMTP id h1mr11593111ljg.5.1551138903088;
 Mon, 25 Feb 2019 15:55:03 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id 2sm2547061ljh.41.2019.02.25.15.55.01
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 15:55:02 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id g2so8236233lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:55:01 -0800 (PST)
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr12318394lfc.104.1551138901438; 
 Mon, 25 Feb 2019 15:55:01 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:54:25 -0800
X-Gmail-Original-Message-ID: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Message-ID: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_155506_128275_DCD6898A 
X-CRM114-Status: GOOD (  24.69  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU don't have its power-domain. all the consumer connect
> with smi-larb, then connect with smi-common.
>
>         M4U
>          |
>     smi-common
>          |
>   -------------
>   |         |    ...
>   |         |
> larb1     larb2
>   |         |
> vdec       venc
>
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
>
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
>
> This patch adds device_link between the consumer and the larbs.
>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
>  drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 202e41b..735ae8d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>         struct mtk_smi_larb_iommu    *larb_mmu;
>         unsigned int                 larbid, portid;
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +       struct device_link *link;
>         int i;
>
>         for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>                 dev_dbg(dev, "%s iommu port: %d\n",
>                         enable ? "enable" : "disable", portid);
>
> -               if (enable)
> +               if (enable) {
>                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -               else
> +                       /* Link the consumer with the larb device(supplier) */
> +                       link = device_link_add(dev, larb_mmu->dev,
> +                                              DL_FLAG_PM_RUNTIME |
> +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> +                       if (!link) {
> +                               dev_err(dev, "Unable to link %s\n",
> +                                       dev_name(larb_mmu->dev));
> +                               return;

The return is a little odd here, given that you don't return an error
and this function doesn't do anything else. If it's non-fatal that
this link didn't get set up, then remove the return. If it is fatal,
then return an error code.

> +                       }
> +               } else {
>                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +               }
>         }
>  }
>
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 9386aee..022bad9 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>         struct mtk_smi_larb_iommu    *larb_mmu;
>         unsigned int                 larbid, portid;
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +       struct device_link *link;
>         int i;
>
>         for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>                 dev_dbg(dev, "%s iommu port: %d\n",
>                         enable ? "enable" : "disable", portid);
>
> -               if (enable)
> +               if (enable) {
>                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -               else
> +                       link = device_link_add(dev, larb_mmu->dev,
> +                                              DL_FLAG_PM_RUNTIME |
> +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> +                       if (!link) {
> +                               dev_err(dev, "Unable to link %s\n",
> +                                       dev_name(larb_mmu->dev));
> +                               return;

Same for this one.

> +                       }
> +               } else {
>                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +               }
>         }
>  }
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
