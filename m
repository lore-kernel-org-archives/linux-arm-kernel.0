Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C01C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D87217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MKiblm0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D87217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9t9R/4sKK99G4VrvuuMOYxMGoaVkByNYAbWgWeXcsfc=; b=MKiblm0qp58V0t
	wdmK5qrAczyEw6k4BjXNhTB46iWdub6kiNxnCP3uWwDuRMP/NISbxeMcg5+IFwC1cKjmHScCXmLIu
	ISeQowDcbc4c2D0ACw87SNbGAukRvemBO+G6YwL6v2JoPUxKWL4AYXK4hI7O+vcg7G2FNRU77VQvf
	LEkFAsfmwRcsyQiLjdBxbOJj0OikghbI8arMmlPYKo+ZYvHWSHBVZjd3nSxDIHGUqJCbpZ381IwfY
	18abzMFCT1Cn07P44kmvBcxEFJbWAhK26YUEJdoiVOUhf9Cpz1Xs7fYopgUl6WCDO3fd4VNd3bikC
	qSoPqMdhJHeSDnpHRLUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3H4-0005fn-6b; Mon, 28 Jan 2019 09:32:14 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3H1-0005fT-57
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:32:12 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1go3Gw-0007wX-09; Mon, 28 Jan 2019 10:32:06 +0100
Message-ID: <85151aee51eca63d4a664b38837930c53cf8e7c1.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible
 parts
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Mon, 28 Jan 2019 10:32:04 +0100
In-Reply-To: <20190128060840.31695-3-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
 <20190128060840.31695-3-angus@akkea.ca>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_013211_354140_D3C22764 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Sonntag, den 27.01.2019, 23:08 -0700 schrieb Angus Ainslie (Purism):
> This is identical to the imx7d.

So it can be dropped and the i.MX8M DT should just specify the
"fsl,imx7d-sdma" as a fallback compatible for the SDMA codes.

If both the imx8m and imx7d compatible are present in the DT, we can
introduce a more specific matchic when we actually need it. No need to
pollute the code with this from the start.

Regards,
Lucas

> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/dma/imx-sdma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 757fad2fbfae..c4db4fe6bcc9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -578,6 +578,9 @@ static const struct platform_device_id
> sdma_devtypes[] = {
>  	}, {
>  		.name = "imx7d-sdma",
>  		.driver_data = (unsigned long)&sdma_imx7d,
> +	}, {
> +		.name = "imx8mq-sdma",
> +		.driver_data = (unsigned long)&sdma_imx7d,
>  	}, {
>  		/* sentinel */
>  	}
> @@ -592,6 +595,7 @@ static const struct of_device_id sdma_dt_ids[] =
> {
>  	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
>  	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
>  	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
> +	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx7d, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdma_dt_ids);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
