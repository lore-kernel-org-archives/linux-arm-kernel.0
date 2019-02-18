Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D2C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94451217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tw4SSeQq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dgk6Skko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94451217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Ph4LGEwzJh/XjLel2X7nc9tsjRBPmcegFRuX/aPDddU=; b=Tw4SSeQqVyvjjSOCNOmSM1z/aG
	iOqpIB8PmaEeEOUj2EwFljb+I6pR9lgLm2SLsQZsaP7GY7NaoDiI8uvDt83yWoa4DwHfLXhYwhZ+w
	OwEJcBW7lC0RCX1A9TsNsmAxufOByhdgD43wSxEA9LjKUDYHFXD3HLMPr1MnwvOe5twv5sX9tzpHJ
	NRhEYW2EbddlzFmjKXvk249Wn2sWcd4UpniU2Edts73UKDqvBrDnj2xdbJkUn1TEJFeOX9fNxTD/X
	wetm0sO9jbAnUYaFgjzYxw41FJxrcMuKYomwCC5Y3vM4HvTA7K4zhpYOJmt8g8RRwm4VAwDbnb4WK
	0BaZ1TJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgVh-0001a1-JC; Mon, 18 Feb 2019 10:50:53 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgVe-0001Ze-3j
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:50:51 +0000
Received: by mail-wr1-x444.google.com with SMTP id w2so3186804wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=aS3pn+FwO9e/L96l1q5GR2QSJA56tlCPGB22Banj6Dw=;
 b=Dgk6Skko9GsFD0mcudXrG04MKcVYNkihFXasB2fqsiLvRxuck2gewPVRDdiUHIpdLA
 mnXLXsSYIHPVrIrrDz7DRwZ+lAf9H9iB5zxHfxN11xxbmz9GKOIrwpqa61ajzGmLA0qh
 68DhjobONdawx1wEOZCycF2BbTRwTejckluNO8LPXiJatoIIFhYB1bReoL5/h2nuE/f7
 INmxzTaSnScZKBquhV+G59Lsit9TvqgwzIlPshpksZzMnQ00MCfrHJ5UK2FT6uy12JL4
 poRMKi529e951w/tvsoI06AVrhWvMQawO6pEazE1fAwQQAaKuP+VG60040ZPDNHLs2R9
 Vbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aS3pn+FwO9e/L96l1q5GR2QSJA56tlCPGB22Banj6Dw=;
 b=NybAQL5dkZFtESexhXVRbgG0n7w4FiaitpmkPTikvPlDMS1Cdg9gbz0lh64HTFyUfD
 DxOq1opTiy5234p9UzJy4DO4hOGR0JIWmFgL3vhSWIl9aaPu2n7XtOrkg900vjLLYwbm
 ZI2MWGoq54gHAwd/znFscv70LW0mk0yX5pdbXRPk8TW3z9ckMk2AX8iwiEZsCejW/buX
 SK6x1RbPvEa0cbr/fvDhhzBLzVs3oNhIRY8Mo0Ljcujmbuy7oR5j7nqCXZlVZNYT0aRE
 +TJ33bRxMbj6S0/vu3jMsTY1afgqV2uvEbVhcDZgM274MmRlqWIjMhrjgOUifQOkJh8n
 RnFg==
X-Gm-Message-State: AHQUAuZMjsftKjmFV2JAau/Hxi4HgOxoWfMZoeD251c/IyQ9tZTgP1vt
 DNeZJs7OZmOMEopP1eSM7hDr8g==
X-Google-Smtp-Source: AHgI3IYNs/h8krv9CzyRnk7cIkNdzuI64vf9d1Ac/qGJhfux3UPLXK2iHgWB4zvH421oHoPAElIzZw==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr10493701wrv.73.1550487048409; 
 Mon, 18 Feb 2019 02:50:48 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id b8sm2310542wmj.35.2019.02.18.02.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 02:50:47 -0800 (PST)
Subject: Re: [PATCH] clocksource: exynos_mct: Remove unused header includes
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <1550484598-1952-1-git-send-email-krzk@kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d6a2fd0-60e1-cf36-e9fe-23de07e76019@linaro.org>
Date: Mon, 18 Feb 2019 11:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550484598-1952-1-git-send-email-krzk@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_025050_158020_A5C35D33 
X-CRM114-Status: GOOD (  11.65  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAxMTowOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPiBUaGUgZHJp
dmVyIGRvZXMgbm90IHVzZSBzY2hlZC5oIGFuZCBwbGF0Zm9ybV9kZXZpY2UuaC4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4gLS0tCgpB
cHBsaWVkIGZvciA1LjEKClRoYW5rcwoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExp
bmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExp
bmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwK
PGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5s
aW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
