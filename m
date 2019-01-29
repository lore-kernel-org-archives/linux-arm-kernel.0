Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68168C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:13:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F132087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVNxPmOE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z93tr4N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F132087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EYQeHhnrlqXMU9MNi4u/YNRLwsbk45y9apiyP0uM8z4=; b=QVNxPmOEGtJc5S
	xCAxwu4lmbXNq9+ao/gyDby04LTmKogeuW8tAZnv+5ovtVeTCTWrre7V0usvrEU9HmimP7C2k1fdo
	Gv+L1tcJZ8OtVqSC9d991za8Vaa2HtVjnvBOj2MspTVTzDfsiULMLy8w+pODjydHZnefxjLqvl7gR
	aM3aw0LCI2/Sbnk55cMAxum/mUCyrzcPrPDwzzOUfjQwvLdIIx/K17TvsITexf9dDJk8k2PBJeO6i
	SFwkelcsOZQR1NzodnwgX1RLNeiWwh89QO8IiDh22dKWSwpWb/FX/G9OXfji9dOJFCopBLF872jkd
	ebWTQ7P/sPEhqYfe8aPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZl0-000075-Do; Tue, 29 Jan 2019 20:13:18 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZkz-00006q-1z
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 20:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zhwXPVsznSEuCuxWlv0DJnw/CFqDR6NFM2eupBOk3oQ=; b=Z93tr4N6Z0vYK9LkrdPZQ01e8
 VRihRCAIICnLUnGdTE6NPQxRUA1nA7BEnY7qWhSI5OoVf1iYu8nNXku1e0dRz7yCfpRYwoGJVCyh6
 zjvIuApuVTwred0c/YRZNi3zz7V3vBiTzcjIhFuFeA7teXb1lJ3FQ1pmKzqevQZD7x6q18VXGcHyk
 a8UgQ2SQcFr6lG1vktl0LdKMPTStJZyyTVoztY2qudvwoxsKZbshmyx4ddElbBogc3OzD04ZJ21KU
 RdzR7meaKLYYd0l1fEGhFsU2BhFNS1wqY9IhC5vurExcvf4Pf1paETEjXT9YReKdh/dOnvd70SHND
 oO/MMqJdg==;
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZku-0006pM-Or
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:13:13 +0000
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr
 [86.202.150.119])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 516E91C0005;
 Tue, 29 Jan 2019 20:12:38 +0000 (UTC)
Date: Tue, 29 Jan 2019 21:12:39 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
Message-ID: <20190129201239.GC19959@piout.net>
References: <20190129164950.31052-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129164950.31052-1-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_151312_942261_EB3559FE 
X-CRM114-Status: GOOD (  16.77  )
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
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 29/01/2019 17:49:12+0100, Nicolas Ferre wrote:
> This patch adds support for 8-bit buswidth.
> Relevant SDCR value modified.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 47189f9ed4e2..735aa5871358 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	case MMC_BUS_WIDTH_4:
>  		slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
>  		break;
> +	case MMC_BUS_WIDTH_8:
> +		slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
> +		break;
>  	}
>  
>  	if (ios->clock) {
> @@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
>  	 * use only one bit for data to prevent fifo underruns and overruns
>  	 * which will corrupt data.
>  	 */
> -	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
> +	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		if (slot_data->bus_width >= 8)
> +			mmc->caps |= MMC_CAP_8_BIT_DATA;
> +	}
>  
>  	if (atmci_get_version(host) < 0x200) {
>  		mmc->max_segs = 256;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
