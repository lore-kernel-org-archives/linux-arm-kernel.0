Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198C621479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A9N7umTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198C621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cX3A4F62pefOvvh93qSmDN5F76y8YeW8KK+PlncmRyc=; b=A9N7umTDCQlynL
	ANZ2vCznyS/nn/acblc7RnpgInV5ExiLSqta8B/mTXTXcsXohqssWSyhhlpeZN0fSolxAdASMafJK
	SIzvFB6pgpJb1iloa5SwDyLldAFJweEed6TeIZVArfs+bwHruTcSWSqOiD4rxH8EpAWvwRTNSdmEp
	fEi1A5VSPQWkvD3EY9JjvPnBOwfN7bdXp5RRtmSvY0KyrayGl51zgoNfvtcKCT35b+LbFs4GuWhBZ
	GKYGVM+a+/7ciUcDz//NPi0BNWNddnDciPcevNABh5us4wRIog5dZYhXLT0aOuv4aoCYXu8PkAPKy
	ZuCwFhkAoFbNGU+j0LHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfC0G-00019x-OG; Thu, 03 Jan 2019 23:02:16 +0000
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfC0C-00018w-D8; Thu, 03 Jan 2019 23:02:13 +0000
Received: by mail-it1-f196.google.com with SMTP id w18so47609483ite.1;
 Thu, 03 Jan 2019 15:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+yAuDYqw26SUmzh667+nR4C2OZufSpiblcwZrq/i1zA=;
 b=NRXQ97nDhgEOBh6g86Voqk47QZwh+JNkDkEwm0LMC4BIYUodbl2v5fnvtOTI7CqjQ5
 DRi7FBzakZuvzdnVhzMFcZ068q24l8wup6UecfVzA/vO6DTqc6yEXO2cvD158XRkIH/P
 Pi74Fq+l+6jf18O8w5VObFM913pnSfpQd5gkIg5MnjTZhdrw02gZXJpwqPLrcGMMkPdt
 VYzpxzgrI3VSATSdQdGwpc462r8lRBIAI12qJV7Mt85O3TQGgnciyHBCiFAHlgsSfrHr
 DE46kqjcJbE/qro6PFfdhBU+f6PANdflVgTazK/6OhUKGZXtg4doswLpKhH3fzp48eH+
 hArg==
X-Gm-Message-State: AJcUukctuC1wiV4yjud9wQg0ZETS8v87oJdyQquw9YTA+/Vhf70g18y8
 CQ6gWdDmjy6usVhc40Wt5w==
X-Google-Smtp-Source: ALg8bN5Ij/GIIondPWfkSo9lM06JUFqag+j9dPGudwxneaKXEAKPgiAfTIBMWYgwJkNtMpTdCbUQdA==
X-Received: by 2002:a24:6115:: with SMTP id s21mr31253483itc.62.1546556531148; 
 Thu, 03 Jan 2019 15:02:11 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id e10sm24924755ioa.65.2019.01.03.15.02.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 15:02:10 -0800 (PST)
Date: Thu, 3 Jan 2019 17:02:09 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: meson-saradc: update
 temperature sensor support
Message-ID: <20190103230209.GA21801@bogus>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
 <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_150212_480391_EA590CF5 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, balbes-150@yandex.ru,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 27 Dec 2018 22:50:19 +0100, Martin Blumenstingl wrote:
> Meson8b and Meson8m2 use a 5-bit wide TSC (temperature sensor
> coefficient). The SAR ADC registers however can only store (the lower)
> 4 bits. The fifth (upper-most) bit is stored inside the
> MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.
> This adds a syscon property to the HHI register area so a driver can
> fetch the HHI register map and store the fifth TSC bit in there.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt      | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
