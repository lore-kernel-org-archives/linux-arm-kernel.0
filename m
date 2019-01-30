Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:22:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151A420882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FqQuESSL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mA1F8WiA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc5tXPHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151A420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z92rhVxQtrQQTAagYwSlMAvcWzGttVeZgpjPRetNTDM=; b=FqQuESSL+jnMFq
	zZdc846J05ucF/eBX+oqgK8sgFuxUAplGmrM4Eh/iWPQRGIMtdeyhVv4ff6IXIUWOCUtzxzw2mHoz
	BvF8xuG+gWrMmDomBLzEk4eFRxBKZp39Upv2eWScve7i++MIyaklirM9ncwd3anv/++uQo0eTMclC
	yMZo85HKacHD2t3S9Krb++1m0g3KVgfrV0mnAUOPLzM+DqO/YwTdG7wKOA6nrFrdkqUFS2IKKNQra
	MfOUXw4nwsNirQQyIEHtET2Pf83bk8nMo3K6DrodX0z0CrU5MmJNU0dWMRw4WifHlpFvdYFk1gRWV
	SYDZjyfKkwmOe+o+aX1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom4K-0000hP-VZ; Wed, 30 Jan 2019 09:22:04 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom3a-0000Dg-9G
 for linux-arm-kernel@bombadil.infradead.org; Wed, 30 Jan 2019 09:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5q2By4zDCEQ19WGtdM+IRxh5BPqAQYmO+RXSEca+nD0=; b=mA1F8WiAuECQF8VhQPeK0kfs+
 2AHgZ94GY7pJf9uGrpKoXGNfih/w670YR/FTwn4TRP1B/Lwyy4aorTM/Kq/+QeQR93fMV0iPCl1Ez
 7wKB2rmHP5wJjNmZcKXncUNWkt4V7N8kFwSZKGPI6nKVYblJ7K2hdO0v/CMP97TA1R8djr9zBmADY
 5uaa9uIMpwVmAg6tGr1WXdUbTC5KK/o+EQ+bp1V30Fuew+KCvp67urN5TY0rTP1qRf6Ggq39LLgN+
 qKVOcZjfv6l05iPWfFAeUTUJ2VOT+pheoTioAheRf9Mp2V5Ei2TQh4CdXcRJISLvej0kIUbIxf3mb
 vYaxK1Rlg==;
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom3X-0007HX-9q
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:21:16 +0000
Received: by mail-vs1-xe42.google.com with SMTP id p74so13845808vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5q2By4zDCEQ19WGtdM+IRxh5BPqAQYmO+RXSEca+nD0=;
 b=Cc5tXPHaEjkJ8is4qaHQKQUIRsJLCXh7Vuzsuo17FzSAc65cHiEdJyNHFX9xlMK0y+
 UxffHHHvcWa0H+J0Uze+vh0tUvUX5JW7uqcQnKRpR26W3z+DqpNJLBJD8pvHH7z0TTcN
 a3CrewZcStgSUt+ra0iBH/gPjPyTMbXmMhtYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5q2By4zDCEQ19WGtdM+IRxh5BPqAQYmO+RXSEca+nD0=;
 b=eufN8iibL/eUHI9IDwRQKmJV5jFq5vHCeNgLl39I8BtQzkilOFB/aLcAoxjmo05sPf
 C66VXmE0pqSQlSXnp7Lo16sflRtk45lF0P7gywUtgb96Q7j5UYWKPPAxdTnG8z4ZtdHm
 TGGGb8c0ACqbeSbQ08k7dEf4Br73brfcZWq3m9INb9bNVzyq4BZlpZhn55jJs0I0G5PX
 38juaaA9wLTbHl5o1nC3rPAIDwryun2igX/QFEGKtabTBqBnb8ZPDxp6JZUm8NkpFQTZ
 Ga+my9xc3vCcA9W7+bnOUX7qzD+hOEPyFRe1QcowwBWpHx2V5b5p4Z0aQafr/WLQi04Z
 FGIQ==
X-Gm-Message-State: AJcUukdrl3E3HKMvTJ3Cn6LyC7WD6S0Rv4LQXNLdXz0v/2hYv0vK4EFc
 eLRgVLETJoLxN09xYRdiJXaW7Tz0eusf/8P42VrE3w==
X-Google-Smtp-Source: ALg8bN4J35Hii93cBd4NWmhlx9nwks5erLZ56doFhQC1g6SVvZp2XJ5FjNpR5RqJGsuQYhdlbgbr1ncfdjFMy6/2Kyo=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr8785047vsc.34.1548840070176; 
 Wed, 30 Jan 2019 01:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129164950.31052-1-nicolas.ferre@microchip.com>
In-Reply-To: <20190129164950.31052-1-nicolas.ferre@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Jan 2019 10:20:34 +0100
Message-ID: <CAPDyKFrknwcbTDKQsGTSo9oZWX3B=fq39Ea=YkoFt_8LoEj5AQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
To: Nicolas Ferre <nicolas.ferre@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_042115_384118_FC4DF045 
X-CRM114-Status: GOOD (  17.46  )
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
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 at 17:50, Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
>
> This patch adds support for 8-bit buswidth.
> Relevant SDCR value modified.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 47189f9ed4e2..735aa5871358 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_BUS_WIDTH_4:
>                 slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
>                 break;
> +       case MMC_BUS_WIDTH_8:
> +               slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
> +               break;
>         }
>
>         if (ios->clock) {
> @@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
>          * use only one bit for data to prevent fifo underruns and overruns
>          * which will corrupt data.
>          */
> -       if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
> +       if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
> +               if (slot_data->bus_width >= 8)
> +                       mmc->caps |= MMC_CAP_8_BIT_DATA;
> +       }
>
>         if (atmci_get_version(host) < 0x200) {
>                 mmc->max_segs = 256;
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
