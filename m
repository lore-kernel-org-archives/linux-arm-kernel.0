Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:53:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E3620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hsUg6hSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bLEQBJ44mKGzT2xg2IAhFeGRkLI/8YBRCCeN56o9Ljk=; b=hsUg6hSI6MXqOi
	LvHO62Sz1BPZyCDb+dtsfDalUzJCNcBAcc90Qx6ox6/in7cv+saoTeidqMk4z7/aaalQ8T8h1LJvo
	or1g7hnV2CxoCnJNqYOF3w0NhxBa5kRu7BgrAzNsOmNX0vmLPphbYUPaJ2fEGRSKfNiDUQNIJ5nXP
	wZE61R09NodiqsZLI2jlB+E06lCSdvhuOr/Xid2+eENnh6NslA1a8Im53GtdDBBzyE4OIN40rLp8Z
	4y5L+q/IjLb7fEaWG2UjZoGLTmT3zC34wwQN+9Jrbs4fNq0HOuN58R0d+15eDnU4arjF390SRcTAe
	u4dJDgL3bZOzlcj7Ur+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfTl-0006EF-U3; Fri, 30 Nov 2018 09:52:57 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfTi-0006DG-9d
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:52:56 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gSfTT-0008Rj-3G; Fri, 30 Nov 2018 10:52:39 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gSfTS-0008Jo-Fn; Fri, 30 Nov 2018 10:52:38 +0100
Date: Fri, 30 Nov 2018 10:52:38 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v3 1/1] i2c: imx: refactor error handling on
 i2c_imx_dma_request()
Message-ID: <20181130095238.z736hvdeibouqu2b@pengutronix.de>
References: <20181130094418.17700-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130094418.17700-1-o.rempel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_015254_508408_28F8C12B 
X-CRM114-Status: GOOD (  20.17  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 10:44:18AM +0100, Oleksij Rempel wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> =

> Current implementation will print error if system is not configured
> with DMA for I2C core. At least on i.MX5x variants is DMA event for I2C
> muxed with SDHC. So it is project specific configuration and not an error.
> =

> This patch will also affect probe, since it will forward all error except
> of missing DMA.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> [ore: make it actually compile, fix a corner case]
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes:
> 20181130 v3:
>  - reword commit message =

> 20181112 v2:
>  - drop "[PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and
>    later" and rebase without this patch.
>  - Set proper initial author
> =

>  drivers/i2c/busses/i2c-imx.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> =

> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index c406700789e1..3c12b174bbb1 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -273,7 +273,7 @@ static inline unsigned char imx_i2c_read_reg(struct i=
mx_i2c_struct *i2c_imx,
>  }
>  =

>  /* Functions for DMA support */
> -static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>  						dma_addr_t phy_addr)

If you touch the line above, maybe also realign the followup line to
start at the opening parenthesis.

>  {
>  	struct imx_i2c_dma *dma;
> @@ -283,11 +283,13 @@ static void i2c_imx_dma_request(struct imx_i2c_stru=
ct *i2c_imx,
>  =

>  	dma =3D devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
> -		return;
> +		return -ENOMEM;
>  =

> -	dma->chan_tx =3D dma_request_slave_channel(dev, "tx");
> +	dma->chan_tx =3D dma_request_chan(dev, "tx");

Maybe this is worth a separate change?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
