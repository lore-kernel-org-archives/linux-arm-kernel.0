Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2864C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31BF20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VRrGuVJe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qm0rzkPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31BF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o8KV7jFEIIjq8XKBOI1Hdf+ws2Z5KF4NuynU9ItiJdA=; b=VRrGuVJeSZUZEo
	/ob5ReHkIjRLNhwztksouUx4e7N8hr5GmlAqEwzMXNdHzCzkdU/nX+kVuLx87Srf9HG6qMp9tuCLD
	V63CLatBPrpmZlbjowtJmRYC4xiMZZVQwbHtPhC+lb+PYtxZ1yJCf6z7ugifj4j6zS1J+83ohFVJd
	KwDk9HJiUr2BY3rx5RHr4ho20so6msJ8S4gGodZtDNSs1ldOsuEGxx16W5TvjrjWiQ7HMYUS22RJG
	typKTIda1Oiaea93wpmf8Y4DMp8n8ncK3d5IWs2hcg1Gd00WleE9KPOrqPKX3YaNtyJPtWn8d+h2R
	qOuVArZpDD/VLYaFrs0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqnT-0004pw-1H; Tue, 22 Jan 2019 07:48:35 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqnQ-0004oz-Al
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:48:33 +0000
Received: by mail-vs1-xe44.google.com with SMTP id v205so14157566vsc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 23:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vGe7Xk+fJDYSgGFrjAjlOQ1FrcZ5N8Eq8Pc3qdaUrm4=;
 b=Qm0rzkPmO8YRvajeixkKxSH4n+9lPVcDOZLS3DZ2FZuEDFg4pDK3h/EkKCzaVc/Hue
 j5Q0R6zX7IRzd+D7rjnPafKyvZNDEcQ2KTRhB0vT4jihF+Cf0BMjPz6VcQwb20Sliwvs
 4PrW15ZNkyYpGejFGS2grCB38lppBS0px0NBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vGe7Xk+fJDYSgGFrjAjlOQ1FrcZ5N8Eq8Pc3qdaUrm4=;
 b=nTFiiBBTeDhnAcpYAv1tAda9jMoLdP5oiX4PA03Dh9U+ihnpSk0hTy5W2Oqmjusc1J
 vNRdoWirxNLarr3ZseFtRuLC+QeZkT/epYMQeqIiHRYUEcANrBrEOTSpCWrPdsciQCi6
 hjXsuJB8dlJu4Vh3Mv/u8UAehb+p+aUuVH4tq23Ed3Eusu5QMq6eEe5VRJYGq2eOPfod
 eOfxlQfG/SlT8/HAQQKzY5YLiWqADrztph3VnRRPbF6NZXp0n75/BwbYbh0moptrTI42
 ohrR5Ut+6quDyPgAYTmwkMBQP9ODnxa7n5IVLAQzXLHaPthdQtu83HQx56zZ0oaEnXcM
 pQQg==
X-Gm-Message-State: AJcUukfktLSsrSUQC0Y4LrcsrR9xw8Kx1RFckSWAn69UU3s9H0B6aB9W
 rUeiK059cBS0aWTRvEXLeXGllsS25AHyzkTAH167Aw==
X-Google-Smtp-Source: ALg8bN6r3X8Jxoq0sQeFVH8aEbdazteyIuBjEavTztYBNTKw7PRU0RJxAlrchw2ve9ElgNixpFOdAVdG0IU+nxAU2uE=
X-Received: by 2002:a67:1a84:: with SMTP id
 a126mr13591563vsa.165.1548143310679; 
 Mon, 21 Jan 2019 23:48:30 -0800 (PST)
MIME-Version: 1.0
References: <1547617491-60322-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1547617491-60322-1-git-send-email-weiyongjun1@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Jan 2019 08:47:54 +0100
Message-ID: <CAPDyKFo3rj3MbZfUUSwj64Gg-jdkJND0ERDjW-ELUVrjR2Go5w@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-esdhc-imx: fix return value check in
 sdhci_esdhc_imx_probe()
To: Wei Yongjun <weiyongjun1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_234832_369689_93ECA0DE 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: kernel-janitors@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, BOUGH CHEN <haibo.chen@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 06:38, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function devm_kzalloc() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
>
> Fixes: fadac7488064 ("mmc: sdhci-esdhc-imx: add CMDQ support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 75ad824..fad6007 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1500,8 +1500,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (imx_data->socdata->flags & ESDHC_FLAG_CQHCI) {
>                 host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>                 cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
> -               if (IS_ERR(cq_host)) {
> -                       err = PTR_ERR(cq_host);
> +               if (!cq_host) {
> +                       err = -ENOMEM;
>                         goto disable_ahb_clk;
>                 }
>
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
