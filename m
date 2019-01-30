Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232EDC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:11:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E923D20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFmnps6P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwWx8N2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E923D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tNcXhuJZZ2SKsG1HATIHerqDUHky6rwZL84Lc/w9pS8=; b=hFmnps6P0WikxK
	qc7fYrG8A+StuP/ZpylPlA/xn0cm3V0dRrYdmFYleYql0DVjM2AA/sQF56rIjUTf/1VZw7rfZzsIR
	AbiuWVVNcfc2pYMfPr7hLimJh9fZiHmYKs3I+pEC38xZ9L93rwXwoSrD4s1U2y5i5GEPHuF5Z0zDt
	eAu5NcfvA1pa0b+1bH9DFAJBw7m7IU81QECuaHRz7t9eKHKOWqwM2+aBDj1UL1rUVUp+iakVRPLFD
	xhY/e8OiiPTcV/LOhnxmFNVVs0pXbK1DGS9DxAP9vYNHkD0ASgroHcsTyJlID1KjUBkW/fBqXJRIJ
	g3cdGon/abhVAk3shHGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govGH-00009s-W6; Wed, 30 Jan 2019 19:11:02 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govGE-00009W-4A
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:10:59 +0000
Received: by mail-lf1-x141.google.com with SMTP id a8so484166lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ynAO8iDI7f1xWNXGggBNd8fyyz0/WqPhtdZq74Lk9Kk=;
 b=XwWx8N2iqXBW8tR4GiISRfUVRyqQl1/XsIGA6Llvmg35sX/xq36kgBGdg6UieKvBNU
 +FeVWdSuDV6Gy5mmG5o0RafiNBlihZPGVO52Lu3dE7Y5m+rJk+4uSkiK4Ok+gYDuC091
 5gfsbYG6j8OibgG5BnZzI2uTzqCco6dkc2tuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ynAO8iDI7f1xWNXGggBNd8fyyz0/WqPhtdZq74Lk9Kk=;
 b=WL/sXN9TV3NhtXck5FdiRITKM1mIv675BAxmpYU8bFG4FdmeBqAN+j8UwVqF0cIowH
 kv8+Fi5PL8c4E6f2hNBKtxVTowypVW266I0fuE2TqTEIF/ER2295576VwIdE7Io3qvt0
 9U8T3EoOla5cQvyd38kzbfPQeizvObXsIf++WhmUtsFqnClvDByALKVDJcPyOCaYM9ZF
 PHw7yaQQAtpirBRYkPmMUcSntfpr2JeaVB/UFUd0iepY2tcpNL6qucMgnKAuY1QssjCa
 Rnj737OA1YzPU5dshC8nzLb413Xe8Rz+FYwN0+pIBm/m/EzLRXgm9lWp5kDXzOn0jYSO
 6s/A==
X-Gm-Message-State: AJcUukfO51Me04gSHgJ7lYy9cLnuDPJF+8OY2P8ykXlmMKD8BL+oEwu/
 tGjpNc5ojeaBXR35+xQTCokShb/6MRI=
X-Google-Smtp-Source: ALg8bN5NeUyoUIAaa9fP/Ybqv7kOroV1wH3rpvBPOJ0jvzYcvHKYMrfSmtkV05wadCktYv1xquzDEQ==
X-Received: by 2002:ac2:554b:: with SMTP id l11mr24437292lfk.92.1548875456134; 
 Wed, 30 Jan 2019 11:10:56 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id 85-v6sm421573lja.16.2019.01.30.11.10.55
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:10:56 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a8so484149lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:10:55 -0800 (PST)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr25062787lfc.47.1548875140072; 
 Wed, 30 Jan 2019 11:05:40 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 11:05:03 -0800
X-Gmail-Original-Message-ID: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
Message-ID: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] memory: mtk-smi: Invoke pm runtime_callback to
 enable clocks
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_111058_199564_A389BDF5 
X-CRM114-Status: GOOD (  27.62  )
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
> This patch only move the clk_prepare_enable and config_port into the
> runtime suspend/resume callback. It doesn't change the code content
> and sequence.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> (SMI_BUS_SEL need to be restored after smi-common resume every time.)
> Also it gives a chance to get rid of mtk_smi_larb_get/put which could
> be a next topic.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I believe this refactoring is a no-op as described, because the order is still:
1) mtk_smi_clk_enable(common)
2) mtk_smi_clk_enable(larb)
3) larb_gen->config_port()

And teardown still happens in the opposite order, except for
config_port, which they seem not to do in suspend.
So, looks good to me.

Reviewed-by: Evan Green <evgreen@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index a430721..9790801 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
>         u32                             *mmu;
>  };
>
> -static int mtk_smi_enable(const struct mtk_smi *smi)
> +static int mtk_smi_clk_enable(const struct mtk_smi *smi)
>  {
>         int ret;
>
> -       ret = pm_runtime_get_sync(smi->dev);
> -       if (ret < 0)
> -               return ret;
> -
>         ret = clk_prepare_enable(smi->clk_apb);
>         if (ret)
> -               goto err_put_pm;
> +               return ret;
>
>         ret = clk_prepare_enable(smi->clk_smi);
>         if (ret)
> @@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>         clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>         clk_disable_unprepare(smi->clk_apb);
> -err_put_pm:
> -       pm_runtime_put_sync(smi->dev);
>         return ret;
>  }
>
> -static void mtk_smi_disable(const struct mtk_smi *smi)
> +static void mtk_smi_clk_disable(const struct mtk_smi *smi)
>  {
>         clk_disable_unprepare(smi->clk_gals1);
>         clk_disable_unprepare(smi->clk_gals0);
>         clk_disable_unprepare(smi->clk_smi);
>         clk_disable_unprepare(smi->clk_apb);
> -       pm_runtime_put_sync(smi->dev);
>  }
>
>  int mtk_smi_larb_get(struct device *larbdev)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> -       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> -       int ret;
> +       int ret = pm_runtime_get_sync(larbdev);
>
> -       /* Enable the smi-common's power and clocks */
> -       ret = mtk_smi_enable(common);
> -       if (ret)
> -               return ret;
> -
> -       /* Enable the larb's power and clocks */
> -       ret = mtk_smi_enable(&larb->smi);
> -       if (ret) {
> -               mtk_smi_disable(common);
> -               return ret;
> -       }
> -
> -       /* Configure the iommu info for this larb */
> -       larb_gen->config_port(larbdev);
> -
> -       return 0;
> +       return (ret < 0) ? ret : 0;
>  }
>  EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
>
>  void mtk_smi_larb_put(struct device *larbdev)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> -
> -       /*
> -        * Don't de-configure the iommu info for this larb since there may be
> -        * several modules in this larb.
> -        * The iommu info will be reset after power off.
> -        */
> -
> -       mtk_smi_disable(&larb->smi);
> -       mtk_smi_disable(common);
> +       pm_runtime_put_sync(larbdev);
>  }
>  EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
>
> @@ -385,12 +350,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> +       int ret;
> +
> +       /* Power on smi-common. */
> +       ret = pm_runtime_get_sync(larb->smi_common_dev);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
> +               return ret;
> +       }
> +
> +       ret = mtk_smi_clk_enable(&larb->smi);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to enable clock(%d).\n", ret);
> +               pm_runtime_put_sync(larb->smi_common_dev);
> +               return ret;
> +       }
> +
> +       /* Configure the basic setting for this larb */
> +       larb_gen->config_port(dev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +
> +       mtk_smi_clk_disable(&larb->smi);
> +       pm_runtime_put_sync(larb->smi_common_dev);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops smi_larb_pm_ops = {
> +       SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
> +};
> +
>  static struct platform_driver mtk_smi_larb_driver = {
>         .probe  = mtk_smi_larb_probe,
>         .remove = mtk_smi_larb_remove,
>         .driver = {
>                 .name = "mtk-smi-larb",
>                 .of_match_table = mtk_smi_larb_of_ids,
> +               .pm             = &smi_larb_pm_ops,
>         }
>  };
>
> @@ -489,12 +494,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> +{
> +       struct mtk_smi *common = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = mtk_smi_clk_enable(common);
> +       if (ret) {
> +               dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
> +{
> +       struct mtk_smi *common = dev_get_drvdata(dev);
> +
> +       mtk_smi_clk_disable(common);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops smi_common_pm_ops = {
> +       SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
> +};
> +
>  static struct platform_driver mtk_smi_common_driver = {
>         .probe  = mtk_smi_common_probe,
>         .remove = mtk_smi_common_remove,
>         .driver = {
>                 .name = "mtk-smi-common",
>                 .of_match_table = mtk_smi_common_of_ids,
> +               .pm             = &smi_common_pm_ops,
>         }
>  };
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
