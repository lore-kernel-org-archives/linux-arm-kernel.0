Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A06C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C09021904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAE3bCkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C09021904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vv4ObEk3ZeL/BUchfvmFFEOKbtZxu6mxw5bavcQGgYc=; b=LAE3bCkC7R3s3U
	LOqO6KCyyfBg4NgMVe/bejVMQLMdC3lJK5x8VfRTcF7scNHKqKENQM1tHRB0YIEj8d1tLk2pbTxjw
	m16y3JERhZepoZbzz8m+4dcbd1PCpVnef042imCjtnH2rLMxEZQ7QZ632lGviHvWR6T41ic1wl2Sc
	ViEwu2xzgtmLV6IPYadrnD1pQ1vs3yAdSZSLByT6ZdDdXnPtpuWA1kWqHx77VnIxzH5U7cUThc8XC
	mvb3QbTtk7K6C+73IsikSj8g1GkD392EyxhHRS5sn56luNrbs41SsBMtgdGKyLK7khzk53UKWl4QZ
	lbwXOpepwiGt4QbMPRaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grh8K-000159-2J; Thu, 07 Feb 2019 10:42:16 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grh7r-0000Wn-1m
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 10:41:52 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1grh7n-00089p-2H; Thu, 07 Feb 2019 11:41:43 +0100
Message-ID: <1549536102.4557.10.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] reset: hisilicon: Add HiSilicon HI3670 reset support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 xuwei5@hisilicon.com, robh+dt@kernel.org
Date: Thu, 07 Feb 2019 11:41:42 +0100
In-Reply-To: <20190201153841.21903-4-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
 <20190201153841.21903-4-manivannan.sadhasivam@linaro.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_024147_969912_82D9AAE6 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-01 at 21:08 +0530, Manivannan Sadhasivam wrote:
> HI3670 SoC is architecturally same as the HI3660 SoC. Hence, add the
> HI3670 compatible to HI3660 reset driver in order to reuse it.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/reset/hisilicon/reset-hi3660.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
> index 17d8bb128e6e..1c22f3457ba7 100644
> --- a/drivers/reset/hisilicon/reset-hi3660.c
> +++ b/drivers/reset/hisilicon/reset-hi3660.c
> @@ -103,6 +103,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id hi3660_reset_match[] = {
>  	{ .compatible = "hisilicon,hi3660-reset", },
> +	{ .compatible = "hisilicon,hi3670-reset", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, hi3660_reset_match);

If the HI3670 device tree contained the hisilicon,hi3660-reset
compatible as well, this change would not be necessary.

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
