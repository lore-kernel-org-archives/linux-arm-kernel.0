Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F4C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DCC218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UIsU2NZI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="yKYWZX9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DCC218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j/CdSv0icZthszhupODysGocCYVu9WS9VeQDqQC66fY=; b=UIsU2NZI/blFItfvDctTYk7ST
	GWBEl3iOyk2Qz+pe+7yn6EDWraakFYxWY+G6yZrsU0L8IxNhcsN1KlSn7wU83JotdOyj0vu4gEvgf
	1jShEge49kD+7kmd79vDICY2P2JQTmHrH9cveFeslc5ZZagS98McWIDr5wQJdb+kM4yUill4i66+D
	ZCbhdbXksMn+86LpZTQl81Avcwp5uxqBfEYxRfDNBWXgXzeCA2s0xtyNXUfVesKhKhvAhfIg1phpR
	m3wCV+OluhM+YLWmT26+xOIlxNwS45qXtCu1fQfXK3M0m+43oh89oUVJDIwxSRtBk1iaHQ13FAp8H
	o+5uBCDJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzxC-00016C-VY; Fri, 25 Jan 2019 11:47:22 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzx9-00015r-SS
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:47:21 +0000
Received: by mail-lj1-x244.google.com with SMTP id u89-v6so8165026lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C31nlWpUsUu8j1iiazgCD439xBD7EbLuX36kiR/KNSI=;
 b=yKYWZX9oCKoMT2Fi/l3X1JV0wUphRDT2IxMzR7Wai8+fciGvOYKSaHLAVLUOkf9i8k
 +IOenP2MM0HMxoDWO1eyDwfybr44T5xVoWm9gczZDqyEoIIP1CnhylynJ4XKtnCrUpiB
 qdl7gQMAJCjBaSpDeZPn6gzZIonSYqworKlmxx7KZmKsCeByGwFFs/mVfWgMuiVjxnb/
 UbbfZEX9yPx+2g5paDNDpQE1MtSWi26oMYcZd70vXS6MNBXzNXAB9W+C+DEeXgXdywg7
 AEwH2VrWjT++EIY1hVl84fHsJmnAcyPP4+ecljFz0dQ3XMfSWVObLt5Q/4lUV6bnDj0X
 aMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C31nlWpUsUu8j1iiazgCD439xBD7EbLuX36kiR/KNSI=;
 b=cE6hlFXvTfu5b22BxZQkCv0+TFY9TMx2Dmh4lKCJBiCUsNT6szi5lUIDmWxDSe5FVx
 6RtmxJDc3XsNFxDYdSfuskV+1Cjdg5qn4sUgHGcI8bStTdA1cSVGRec/RPiFlx1LTYSE
 9UItNpBbfDb9vgk8otwXO2DeYb9co7v8stu0s2CTVMArgDVcYddh0bbTf4nMabCJ37xa
 SkW+HUN4egfsa5c0j69JL3MoHQEHNNI/xF2uGcrZsgR2BPix232E9I8i5jiVESKbtIDw
 VHN6Pf/01itCXPq3oTo3GZp/+VdnZdGOJVlmF647zJIM//NF1AJbUQy6gUX302X3aMi4
 Iaow==
X-Gm-Message-State: AJcUukdtAUvhCKN+FDfmrftDwgF5qvtkBNLGtWykXntm9soTq+1/BCpl
 GPCeCS9cXSSRGiW1ujYNoQLvmIfZdXE=
X-Google-Smtp-Source: ALg8bN57MEamk9wYy/GwFOX0tGuq2r4wbYBsROXpUqSD+7w1rimZDMdBR2dqSjH9QFH/sO/BXcq4xw==
X-Received: by 2002:a2e:58b:: with SMTP id
 133-v6mr8263289ljf.127.1548416837534; 
 Fri, 25 Jan 2019 03:47:17 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id
 15-v6sm1611419lje.18.2019.01.25.03.47.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 03:47:17 -0800 (PST)
Subject: Re: [PATCH 2/2] spi-atmel: support inter-word delay
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-3-jonas@norrbonn.se>
From: Jonas Bonn <jonas@norrbonn.se>
Message-ID: <296f8326-a33d-8db1-ca71-c6aba21b1302@norrbonn.se>
Date: Fri, 25 Jan 2019 12:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125114429.20066-3-jonas@norrbonn.se>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_034719_923138_8BB14065 
X-CRM114-Status: GOOD (  19.06  )
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
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 25/01/2019 12:44, Jonas Bonn wrote:
> If the SPI slave requires an inter-word delay, configure the DLYBCT
> register accordingly.
> 
> Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
> board).
> 
> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
> CC: Ludovic Desroches <ludovic.desroches@microchip.com>
> CC: linux-spi@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/spi/spi-atmel.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 74fddcd3282b..88ff3fef56e9 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1209,13 +1209,14 @@ static int atmel_spi_setup(struct spi_device *spi)
>   		csr |= SPI_BIT(CSAAT);
>   
>   	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
> -	 *
> -	 * DLYBCT would add delays between words, slowing down transfers.
> -	 * It could potentially be useful to cope with DMA bottlenecks, but
> -	 * in those cases it's probably best to just use a lower bitrate.
>   	 */
>   	csr |= SPI_BF(DLYBS, 0);
> -	csr |= SPI_BF(DLYBCT, 0);
> +
> +	/* DLYBCT adds delays between words.  This is useful for slow devices
> +	 * that need a bit of time to setup the next transfer.
> +	 */
> +	csr |= SPI_BF(DLYBCT,
> +		clamp_t(u8, (as->spi_clk/1000000*spi->word_delay)>>5, 1, 255));

Ah... this is stupid.  The clamping here _always_ introduces a delay, 
which is not what we want...  will resubmit this.

/Jonas

>   
>   	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>   	npcs_pin = (unsigned long)spi->controller_data;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
