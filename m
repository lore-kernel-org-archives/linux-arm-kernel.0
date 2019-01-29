Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE28C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BF62184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qux1PNdJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="N2QHYwHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BF62184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+426An30aLPz8LfQ7syIEChJWwvcWpMKjk/Ixz62j9k=; b=qux1PNdJ9sBSGTNCOQ/xNN1ev
	Iewysm3BGXiIpezP184IeQZluhSlmVOQMQrZZEQcs2xD/SVIbPHa3s8pstntEv1zyYQBljJPleyly
	XdIYC8mxHCEwroNhnfORhG/cTfLSxgst3lv1jHdyVuoFHsih0TCcWyCMjgvwFRsGv5jm8ILuODZZv
	OokH5H54oh/tnvlv0+rlwsaePMKaJb+RoVfgo8pUN79xOtSqtKpPVu8ut+zXMt7nwqFn25YO3zqah
	XrOEt++KMRPowiUSVnR6U0cE5DwBOxH/r8Sx/OXZ7cIkghEWA49xxnBJqaenh2c9r4ywsN0Ars+xu
	TMEGyYffw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUoZ-0000rO-OX; Tue, 29 Jan 2019 14:56:39 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUoV-0000qz-Md
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:56:37 +0000
Received: by mail-lf1-x144.google.com with SMTP id u18so14816459lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YtmDmx4hF7yUv9PZ4nol91PQCpWWisMGSSBsX/os2+8=;
 b=N2QHYwHjj9U1Wh04zqHIe3EW9H8HfQwmSullR+DHw7bbzKnhuK2K+0s8dzkEOUd2ma
 S7eFATRyL7g3Yau1HPrm11eF3rdnEITmYq+4Qa0ke9ygGpMF/eR2jXA4ERwHZ70DCCFv
 VWyECTjPnXoUzXELtmpE283atZP0yEG19z2tZ4kmCFs0/gzw1dCzehHi0MWd+QbGjvvV
 dgcmyHJLCntRGKyuEinerpyR9nYswRt3H9YBg/M1eEWCHJUiLc1fwISZmI3RCMGkVAaF
 tC+VOLwPtjNuEdUrdQsQxpC+keYzY/3fXRMg1SNucde/MIk6vy/CARgRBD9xSgNmWNHQ
 JDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YtmDmx4hF7yUv9PZ4nol91PQCpWWisMGSSBsX/os2+8=;
 b=riuwCwz5SY76SnVm6pFynXQU+v8U+JFJtAhGt+QnG2up583GF/0NN4w/09iWVwk/k5
 1E42lyLi8z/FrTDOb31Rb/SW0l9ZOc/glL2FO6S8i3ZZbnPvyO75dB0sOGCwG7DPPq1G
 R37fpCs++uXvoPiLiQ3nbKe3aESfAzFyuQnXa+TRLonvqI6evU5YK7/+5XyhKbURLawR
 dSebnHhCuGMsJD8dfPsk0F2hU7uUpUtrfJ3Qw5wvdVfZ0HBZk2NHA2O2qzWhRMx+9OKk
 Vy4xVJQdaoXoF1EEk4mcuN9rFv2azmoiuYTqhrASXh1XnxH6naav8PvG+A9iOd5oL/G0
 INiw==
X-Gm-Message-State: AJcUukeW4uwVgoSZhZlUroISCKJWabhX/iG1MLaZDJDORByWIIf4dHXi
 TwKSMRiOcyd2EBe4Z0IP8afQ5Q==
X-Google-Smtp-Source: ALg8bN6oDCwGX67Kvm6xb9k3EUdbs+5+I74YZEN+oGHSzrNQIKdeJUC6TUDTR2Yyz+H5jaob8t5DqQ==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr20236759lfa.32.1548773793484; 
 Tue, 29 Jan 2019 06:56:33 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id
 m10-v6sm3553378ljj.34.2019.01.29.06.56.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 06:56:32 -0800 (PST)
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
To: Nicolas.Ferre@microchip.com, linux-kernel@vger.kernel.org
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
 <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
From: Jonas Bonn <jonas@norrbonn.se>
Message-ID: <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
Date: Tue, 29 Jan 2019 15:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_065635_882662_3471E0D5 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com,
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 29/01/2019 15:27, Nicolas.Ferre@microchip.com wrote:
> On 29/01/2019 at 09:38, Jonas Bonn wrote:
>> 
>> +	/* DLYBCT adds delays between words.  This is useful for slow devices
>> +	 * that need a bit of time to setup the next transfer.
>> +	 */
>> +	if (spi->word_delay_us) {
> 
> Well...
> 
>> +		csr |= SPI_BF(DLYBCT,
>> +			clamp_t(u8,
>> +				(as->spi_clk/1000000*spi->word_delay_us)>>5,
>> +				1, 255));
> 
> ... why not simplifying to:
> +				0, 255));
> and remove the test altogether, after all?

Hmm... that seemed too easy!  This started out as something else and 
looking at it now I think even the clamp_t() is unnecessary.  The value 
is already 0-255 and the way SPI_BF works any overflow is already 
truncated...  I'll rework this and resubmit once I get some feedback on 
the word_delay_us bits.

Thanks,
/Jonas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
