Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225AB20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gb33/XJO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z86GZnHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225AB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=btAeKPiDH/A+P+6PTwxMITtP9qfnmYeeCbJmWMPZS50=; b=gb33/XJObNYBkp
	2Ml3ugynNDycUThqeYk9cjwzNFcq2HeCv3VB+mL+xNoi/hv2O7O/k79FpdsJb4qUCR2d6AuBf4mAg
	Gox4pNjMsjAYd/llhpNGsTaQYzBc7MrvtQYNP35iYhydKwXp/S4edZsLANRd8MfKs0FFY1aW4kMK6
	GilQrcw8oprvQ0Dh/11X7nkm4beo3PlCFFnCWeZqJnDIGwMtSmo11saUmydbnQZ0aXRQfZv38oDmR
	0zX3pdVLagcbFOKE8uEq5QY2560x4jo2QcZcKJzLLyT6gyKkMZWIHtJ9jpZDjXZDRpP3OYw26este
	kqHt7AI5pNV/iVSEbPfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtg7-0006yh-NS; Thu, 06 Dec 2018 13:26:55 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtg2-0006wR-S4
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:26:52 +0000
Received: by mail-wm1-x344.google.com with SMTP id y1so968163wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version:content-transfer-encoding;
 bh=r0L/uUj4FgBzt1qunpYhx4A32a5D1WS8nwyo/Y3U+N0=;
 b=z86GZnHc2rTqolSRqaHY0Kt4WpDIN2SZOp5HSMAEDV+6rJJyItBYiqTh4cQzd/CLDe
 qxHMyXdnjpda7+xj7ue1u+k7gtUIG8UQSk4cZ1N74/CUkHqhA1c1LmhG9AcyZDWMg+nu
 wwTe/ZMEi/Zupz/9SqS172dlvOEPAI6CgJV1TPMAGWz0EOFi2Q+YVKsfDMooPkM+m29S
 6JJ4y9DLDcN4wlmX6aYva/u1mN2ylm4FePdzGJTdLznXX9QBcBGCwdGEBRCA99wNj3y9
 cV1RfEyAt+aG2Cde/VxMn0dzOAS6tFBOHq6wT4UWmiQkz8vpqi+qMSvqmIvYeyBK8iYC
 eWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=r0L/uUj4FgBzt1qunpYhx4A32a5D1WS8nwyo/Y3U+N0=;
 b=L/iCWdAvMr+KhSTosYjvQVpLovIq7PWmXahXewg+avexkbM/MOaepeXB5TKOlgB7lV
 pVul4BZq2aodnH4HkpKLmiR/TPEH3JddaAaMu9sNH1j8WwiHUqbaM+0SD4qf9sodVnyy
 jljIbyxSsd+bVJVtdvfBbxl9L9+4+wr69t1+q5ciHR+tL0gG9PUiwajbA/TfLRE1Thi4
 WA0dOtkmRK9XB8V8KJaqn+YregrnjpC1Igo/j0DqmhheURnj8MzcrAfmZn2UF64zLmgh
 BgY7lzPDvD2Xj14NVzuM7+bzgAXXpNx4EzWZLNvGlbyltGq3FwfARLX0Qx554AS0f7VY
 5nAg==
X-Gm-Message-State: AA+aEWY1vOX0CXNuibQiPBdzaRcXAMg8b/xQVfhNTJIAN5wz3fEvT9qU
 uENJmSsU77dwXpFzNT3dqt3SSQ==
X-Google-Smtp-Source: AFSGD/WxeZSpyLIuHbYYXY7DHqpOny+BIOawEFp3/GW0pJQwugGqQq9hE/74NOHgrXHemRn6nKludQ==
X-Received: by 2002:a1c:bd82:: with SMTP id
 n124mr19134487wmf.105.1544102804068; 
 Thu, 06 Dec 2018 05:26:44 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 i192sm1138979wmg.7.2018.12.06.05.26.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:26:43 -0800 (PST)
Message-ID: <b0b8a45b1c7189c3820064fee9e137a8d7cacf29.camel@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
From: Jerome Brunet <jbrunet@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, khilman@baylibre.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 martin.blumenstingl@googlemail.com
Date: Thu, 06 Dec 2018 14:26:41 +0100
In-Reply-To: <20181204160447.27869-1-ccaione@baylibre.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052650_907370_52CBA547 
X-CRM114-Status: GOOD (  12.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-04 at 16:04 +0000, Carlo Caione wrote:
> The wrong IRQ trigger type for the macirq was causing the connection
> speed to drop after a few hours when stress testing the DUT. The fix
> seems also to fix another long standing issue with EEE.
> 
> The fixes are tested on a AXG board but we think that the same fix is
> valid also for all the others Amlogic SoC families.
> 
> Carlo Caione (2):
>   arm64: dts: meson: Fix IRQ trigger type for macirq
>   arm64: dts: meson: Remove eee-broken-1000t quirk
> 
>  arch/arm/boot/dts/meson.dtsi                        | 2 +-
>  arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
>  7 files changed, 3 insertions(+), 7 deletions(-)
> 

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

on the S905 odroid-c2 and A113 s400
Tested-by: Jerome Brunet <jbrunet@baylibre.com>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
