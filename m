Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5716C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B6721738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PnUtEibn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6IXIxs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B6721738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EHZKIH7th13WZUTkpfdNBhnVj9t7GX/u5+MDM/egTQU=; b=PnUtEibntZK76Z
	T3PydffIGXL62qs9uG9+fam0T7elwY+V6m2LgUQONJ5q03mQdG5Lzj36ktxAyWISWLBWMhhMMS48Y
	M7LTXh0AuuGoZxgRNgnprtLAwNlGF5C5fJdpUGwBRRjXMr/2dqGmoKRcVkQAB/ONRfPBVSdUDtIlt
	djkieAj9yGnG0qJILndoHozvBfV6q1LLcEiAVI/vrOCKNgRLa+YFvnzn4vF3BWcXbp6kWMAnoHoGP
	7Sk75hIeeMyS5iH2P7y0nZ9idZtOnCDZfgOxYiRF81ptTUfn1kM/3PUALiYuTXkpSne1AgtHgs7Ag
	sDwv0Ake46x5USC4j5qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5At-0007rm-TO; Mon, 28 Jan 2019 11:33:59 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5Aq-0007rF-Lw
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:33:58 +0000
Received: by mail-ua1-x944.google.com with SMTP id d19so5457290uaq.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 03:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eBDrm1PCVZfCKpICeTE3MM436tQNH63XHBlLwrxqY+g=;
 b=B6IXIxs2rNeEKlGAAyr/j/89sOBRoDvDGz30BOTojHr8W10ibuNDOTAsBty5zduvPU
 FzfhlMVVXPMFBQcnNaaSYFTtUxvMS/YIseTjEiBVaInwBAkaq87rGGbcj6mADRC8g7TA
 nC/Jz92sM0ZtvA57OmmS2d8tee4SHU8gjB4pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eBDrm1PCVZfCKpICeTE3MM436tQNH63XHBlLwrxqY+g=;
 b=IcAturKarCLKjqyiB7JFn47ittZgItNXk5PTvdcS1yy8q4r9utiodwT+pF+ZIfRFjj
 Pt6k3QbEaFI0jT+Ompe2kUYqzj+ERVgrUd1l5g2RavP2WdDF+SmnHHvqow42CQlW/nYz
 RBIWPbsol99CQdBJKCPbz8Y84o/6mhNDlsSt1d+UT5BWuS+pS5bVgBFY3vkd+ZTImF/A
 XCN7uU/JZN1MivJFawZauy+u20Slhxpe2MOM2WKoGU5QfhUxtc8gaOjhG8OGa0zsnDc/
 o2HR6TN/BO5RGui/zDQIepr1x7QobfWxUp+QBlUNjRxqKv1gtqAfsu2lkP/EpeQ0pA0k
 WdFw==
X-Gm-Message-State: AJcUukf2GC/PvCpJbcIAJlIjwGpQT+/FmkR/2nt4eRn5qGEHuhcqkQEo
 Tuw49jPJ7yjvdykSNDYUtd8xQsMCt+JncQhXzit1Cw==
X-Google-Smtp-Source: ALg8bN57wjlohKgYoWs9ZtVJVIMImSWEBQiDpa4XjMYAm0eWCz22/JoMHaV1RiUvGEbuQ7srVhMnAfC18N/1AK2fW64=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr8899547uar.39.1548675234990;
 Mon, 28 Jan 2019 03:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20190128102022.1880-1-martink@posteo.de>
In-Reply-To: <20190128102022.1880-1-martink@posteo.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Jan 2019 12:33:19 +0100
Message-ID: <CAPDyKFpbSMpfdpEd_CkcMzfDU1nwG3A8dnZ8HR30mM+WF22kZw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
To: Martin Kepplinger <martink@posteo.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_033356_734232_3801F7FF 
X-CRM114-Status: GOOD (  22.48  )
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
Cc: Robin van der Gracht <robin@protonic.nl>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 at 11:20, Martin Kepplinger <martink@posteo.de> wrote:
>
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
> doesn't turn off the VMMC regulator which leads to hangs when loading firmware.

Isn't there a GPIO that needs to be toggled and separate clk for the
WiFi chip that needs to be enabled as well?

>
> Tested on i.MX28.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>
> again, this isn't new. it's (rebased and simplified)
> https://patchwork.kernel.org/patch/4365751/
>
> Thanks Robin for your input!
>
> revision history
> ----------------
> v1: was just a question why this hasn't gone in earlier.
>
>
>  drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70195ea..fdaca0fcec99 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -66,11 +66,13 @@ struct mxs_mmc_host {
>         struct mmc_request              *mrq;
>         struct mmc_command              *cmd;
>         struct mmc_data                 *data;
> +       struct regulator                *vmmc;

You don't need this here as this is already part of the generic struct
mmc_host (via the struct mmc_supply).

>
>         unsigned char                   bus_width;
>         spinlock_t                      lock;
>         int                             sdio_irq_en;
>         bool                            broken_cd;
> +       unsigned char                   power_mode;

Ditto.

>  };
>
>  static int mxs_mmc_get_cd(struct mmc_host *mmc)
> @@ -517,6 +519,24 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 host->bus_width = 0;
>
> +       if (host->vmmc && ios->power_mode != host->power_mode) {
> +               switch (ios->power_mode) {
> +               case MMC_POWER_OFF:
> +                       if (regulator_disable(host->vmmc))
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "Failed to disable vmmc regulator\n");

You should use mmc_regulator_set_ocr() instead.

> +                       break;
> +               case MMC_POWER_UP:
> +                       if (regulator_enable(host->vmmc))

Ditto.

> +                               dev_err(mmc_dev(host->mmc),
> +                                       "Failed to enable vmmc regulator\n");
> +                       break;
> +               default:
> +                       break;
> +               }
> +               host->power_mode = ios->power_mode;
> +       }
> +
>         if (ios->clock)
>                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
>  }
> @@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>
>         host->mmc = mmc;
>         host->sdio_irq_en = 0;
> +       host->power_mode = MMC_POWER_OFF;

This isn't needed. The state is already controlled by the mmc core.

>
>         reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");

You should use mmc_regulator_get_supply() instead.

> -       if (!IS_ERR(reg_vmmc)) {
> -               ret = regulator_enable(reg_vmmc);
> -               if (ret) {
> -                       dev_err(&pdev->dev,
> -                               "Failed to enable vmmc regulator: %d\n", ret);
> -                       goto out_mmc_free;
> -               }
> -       }
> +       if (!IS_ERR(reg_vmmc))
> +               host->vmmc = reg_vmmc;
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(ssp->clk)) {
> --
> 2.20.1
>

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
