Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F786C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:02:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C982222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WYfF7wAB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="og9vZugm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C982222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NjIZqm2KtPveQSG8Gju8jDOqRrZVTR+NQzycyvphSmA=; b=WYfF7wABjfu1Dt
	9i3D/vIWcSugEtdTTnrvgSMacKxogV5n8m6m6FWY6yROE4m5TwOB++zqoJ1DhiLNBxhEIZjG5OFHz
	U/tj6Y6+bl+CMI0EZC0P3uD+RheOMn2zZpg6vSoZ7MTG8KjKcAS0s2FUeMuFm2pROMi68Fy0ixGdS
	vqKV1Jy2Qawh3lxt6Z7e2vg4QvG7a2zg2BDIPno3n6XcsY3IHY02e65q47y7pL9B9vh3QcoW7Wzg8
	0hV37ltT0B8tGCNC70bAqN1ebQ1ULPC0/+4mThIz2XoI4Uxc+vqx8M/JE1W/VA12O0dSeAaHnBW5e
	KzylbaJtdQPEssywhyCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gumUf-0007Ng-2I; Fri, 15 Feb 2019 23:02:05 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gumUb-0007N3-9S
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 23:02:03 +0000
Received: by mail-pf1-x441.google.com with SMTP id s22so5528046pfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=LskzHuROK1h+gyPGnPZqzE5FllwThTsMmeq6vc0//LQ=;
 b=og9vZugmjhrYTK70TlkPkVuAQYa5h3LX7Fq+EcnKu35gWDHfCHkZ/aojkvDTshNZEA
 9K8M+vIhtH8jFWmx0u61pht9F0HtpIV8LPm/diPraRFSGI5PhXr3ZLKUonbfwLJqN8dw
 216lx67v2bZ4ggR7MYRE8OMFHO7pOrrNZmIy7FXac1bfvPXTtSv3OQAEMJE1cjCPOvPg
 gDasXpfkQefbfelmizxxjBdPMsx+sHBtu2Ady9fs8tHn6vT5D/RHm4ha0Nz9ZCnbux8S
 6R0xwcYwzJGGw6ra9GeA3aGs/VL+jXxfIND74bOarHE9z59vLQpQByUkMOCvMkFUMtxJ
 sCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=LskzHuROK1h+gyPGnPZqzE5FllwThTsMmeq6vc0//LQ=;
 b=b81bCRdGPLJUgb6/fETT3z9HLOHZF+CuFxMs3e/QrkJ3O65qPTACk3ckvwZCB8Jxt7
 yHjTvQFNLmMbER+7J/dgOPCN+cm9rx2xDN2IfbA2hI77Qulrj0foogsvcunz5qC3oege
 GsfcCYINvkvyw+GjNOhH9Df/kTrWBcEw0XaI72/wEhK0hBaroUq9fawc7bf+W5TGEkdD
 TDbkG+JB1vxx9+yVSxJ9VMm7jvnvz6emvUV/pgyc7RE4QjSZC50bGkjRcom9BlkizQ0I
 +KklCVbzPFRxzpVEhHbm49s/Ajuql9Q/wOwHIXqaDOaGhJWyJVSvfMmEbg8WQ7Qm+EXc
 VebQ==
X-Gm-Message-State: AHQUAuYfriloTaj8j68OeWuWIm+T14iFFi4rIh6XMZ81NcshN7FjQmu2
 pi5YmAJirakA94/yPHvbgVWT+A==
X-Google-Smtp-Source: AHgI3IYBoKhPT2cQE3BGmTJ89853tcuDcm+y323TWsBUgTye1X15PrrRNZ/bvAePCEWZIkAgyqx9ag==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr11375134pgk.241.1550271719930; 
 Fri, 15 Feb 2019 15:01:59 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:100f:5904:cb2b:8631])
 by smtp.googlemail.com with ESMTPSA id f13sm9093713pfa.132.2019.02.15.15.01.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 15:01:59 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/2] ARM: dts: add the clock measurer on Meson8/Meson8b
In-Reply-To: <20190209002641.9105-1-martin.blumenstingl@googlemail.com>
References: <20190209002641.9105-1-martin.blumenstingl@googlemail.com>
Date: Fri, 15 Feb 2019 15:01:58 -0800
Message-ID: <7h4l94k655.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_150201_370420_8FFDB70A 
X-CRM114-Status: UNSURE (   8.28  )
X-CRM114-Notice: Please train this message.
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The 32-bit Amlogic Meson SoCs also have a "clock measurer", just like
> the newer 64-bit ones.
>
> Add the node of the clock measurer to meson8.dtsi and meson8b.dtsi
> so we can see the measured clock frequencies in:
> /sys/kernel/debug/meson-clk-msr/

Queued up, probably for v5.2, unless I get one more late PR in
(unlikely.)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
