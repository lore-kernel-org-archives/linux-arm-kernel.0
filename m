Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:53:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865E2218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqDYDd/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865E2218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lf/+y44LFceGz1v4LuJrsw2q6hRCm6WRbbfIgi/H/rI=; b=hqDYDd/KsmRacr
	O1J5zkCL2/DO1xKeGcTvTI6B48UdPvoEbeo5gz9GFFvgK1n0X15WqwU4l6Jai9JpgMfsXOKhI20Pt
	hSpUzwxWefOi7HmmlV32vkB4STrqxK47KruDaCuRBz65uhaIMZmlEdTWgLvlcMf2VxPrzLgEh6XaI
	i71cXXgn3ZrUbsD6AWw7ye3Q7JgTeY+sZm+TIWEN5s/1xk9ChItbgO4TU/iR35T/lQX/VSYMExJiY
	0tF96oZAMlRdOL6YfzXJy8V7euKcxZlAYY8EBPA3NJLx+nfR0KKNcQ/R4zkLSAcp1QFaw93aLl1d6
	wmYbnWYg9J+U/Z2wshsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2qo-00074u-6X; Fri, 25 Jan 2019 14:52:58 +0000
Received: from protonic.xs4all.nl ([83.163.252.89] helo=protonic.nl)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2qj-00074S-UC
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:52:55 +0000
Received: from erd987 (unknown [192.168.2.69])
 by sparta (Postfix) with ESMTP id EA1F844A004C;
 Fri, 25 Jan 2019 15:54:01 +0100 (CET)
Date: Fri, 25 Jan 2019 15:52:48 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Introduce regulator support
Message-ID: <20190125155248.23937600@erd987>
In-Reply-To: <20190125113449.10128-1-martink@posteo.de>
References: <20190125113449.10128-1-martink@posteo.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_065254_132841_C231787C 
X-CRM114-Status: GOOD (  21.06  )
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
Cc: ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Fri, 25 Jan 2019 12:34:49 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds support for explicitly switching the mmc's power on and off.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> This is not my patch. It's taken from https://patchwork.kernel.org/patch/4365751/
> rebased and minimally changed; but we use this.
> 
> Are there any objections to this?
> 
> Robin, can I still add your Signed-off-by to this? Also, should I set you
> as the author?

It's old, but thanks for keeping me in the loop :)

> 
> thanks,
> 
>                                 martin
> 
>  drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70195ea..e3c19fabb723 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -517,6 +517,26 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		host->bus_width = 0;
>  
> +	if (ios->power_mode != host->power_mode) {
> +		switch (ios->power_mode) {
> +		case MMC_POWER_OFF:
> +			if ((host->vmmc) && regulator_disable(host->vmmc)) {
> +				dev_err(mmc_dev(host->mmc),
> +					"Failed to disable vmmc regulator\n");
> +			}
> +			break;
> +		case MMC_POWER_UP:
> +			if ((host->vmmc) && regulator_enable(host->vmmc)) {
> +				dev_err(mmc_dev(host->mmc),
> +					"Failed to enable vmmc regulator\n");
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +		host->power_mode = ios->power_mode;
> +	}
> +

A single check in the root contitional for the availability of vmmc
should suffice, so:

if (host->vmmc && ios->power_mode != host->power_mode) {
	...
	case MMC_POWER_XX:
		if (regulator_xx(host->vmmc))
			dev_err;
	...


>  	if (ios->clock)
>  		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
>  }
> @@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  
>  	host->mmc = mmc;
>  	host->sdio_irq_en = 0;
> +	host->power_mode = MMC_POWER_OFF;

My patch added 'power_mode' and 'vmmc' to the drivers private struct
(which are missing in this email?)

>  
>  	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> -	if (!IS_ERR(reg_vmmc)) {
> -		ret = regulator_enable(reg_vmmc);
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to enable vmmc regulator: %d\n", ret);
> -			goto out_mmc_free;
> -		}
> -	}
> +	if (!IS_ERR(reg_vmmc))
> +		host->vmmc = reg_vmmc;

what about mmc_regulator_get_supply(mmc)?

If we use that the vmmc will be made available under mmv->supply->vmmc
if probe was successfull instead of storing it in the drivers private
struct.

>  
>  	ssp->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(ssp->clk)) {

Robin van der Gracht

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
