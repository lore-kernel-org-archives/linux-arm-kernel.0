Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4291CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:28:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C8F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IT9bQfHv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEpkBLfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C8F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mH7gjJSR+veVc/UjgA34je9o70JZaiAiS7YUgaonNPc=; b=IT9bQfHvMaJnLG
	Zc4+5bkLiTsdu3P4HcT1qFVGNa/EynUS4PTUBsMkuFUTgKSAREUjcTlPzoiFCOGMvb9TYPM6OLC8h
	71ZJDPin+6by2el5K/EKU+Ef27PDXrttd239WLgdASpaGLih7i2myFtHsXPX0QiLM2S2Dp1ld1uo6
	7idzj72vxQTHvWIZQyrIRGMmn9ZfNZ9m9k4pUgHMIZBDWbNPaEc3mC7HMK9OuqllqJfNQmQOzIMMB
	IYm3vv2sDjtumoKIBHfPIZx8SgFnWK7aTayPsug572I0JTVGmXbfk6bxFY6dyEqqIMhiY+QqGuftO
	uutgOoJFHmTNX7TyhPqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXR2K-0003kS-LH; Thu, 13 Dec 2018 13:28:20 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXR2H-0003jc-HF
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:28:19 +0000
Received: by mail-wr1-x444.google.com with SMTP id 96so2024371wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=++tRpRVFmyDdNBbWnm7w53xwo4Ppov3K25bE9jo+hkY=;
 b=bEpkBLfYKcwnFAJHZFxNN2ELYIerXSau8LGF5JLhFbI2FBdY1k267N2cWpHTDXSJnS
 wYa+hZZIHmpf67DMeiM46kS/0SDJh9TFIjPTDzzOkXNXbGuJDCZOcN8n5qPVTdsbw/yZ
 5lhi22uLeQ4j6+uJXT5icbdMT0CptBpmTFx9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=++tRpRVFmyDdNBbWnm7w53xwo4Ppov3K25bE9jo+hkY=;
 b=dDH3q5hIxy5GOzWCeDgbkE50tt+wogUxQmBYhU/RbFsOJM7uMrsndJMkYPPmSmm6kv
 GPrgMRwWMnrixNMa9DwVwhW0GVME4I6aIsk112Epa3DReM5An+pxUgB7BHjEgCTmkGWl
 ji/mLVHouNxR6QvaunoTTyGAooH42faFLo0NSywj0k3/86O0QnqI2+i+pfkjmMDLJVGZ
 EpQjKV7JTR6JbFFgGhw7RbbyrNpzmUEAVOT1a3KeIQVveyPCkMnsDWKp8/93nJaw/1cz
 AWMPcE5NPbf947PhGLcpIDLxN9iT3QWwFYejo6gwmzg+4VxS2M7HGDkPiJ0Gzsul9sxu
 99zw==
X-Gm-Message-State: AA+aEWbHouEKgeahT35o5tR27vTKEgIlOOr/VHoaabDOQCe0VbNqU/zP
 GMFmSfO22XtE2COD9RH0InHBaw==
X-Google-Smtp-Source: AFSGD/UBBBTchFxEtrQ7Zc3RJYAZQX7ZpjFwSYd+W7XF8bmzCAvldJL3PiB4hQIeSJirpFpmYjVwpw==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr1609250wro.261.1544707685182; 
 Thu, 13 Dec 2018 05:28:05 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id z12sm2432990wrh.35.2018.12.13.05.28.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 05:28:04 -0800 (PST)
Date: Thu, 13 Dec 2018 13:28:02 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181213132802.GQ4497@dell>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
 <20181213115506.GD10669@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213115506.GD10669@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_052817_576802_612A8A70 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Priit Laes <plaes@plaes.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAxMyBEZWMgMjAxOCwgTWFyayBCcm93biB3cm90ZToKCj4gT24gTW9uLCBEZWMgMTAs
IDIwMTggYXQgMDg6NDI6MTJQTSArMDIwMCwgUHJpaXQgTGFlcyB3cm90ZToKPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IE9sbGl2ZXIgU2NoaW5hZ2wgPG9saXZlckBzY2hpbmFnbC5ubD4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFByaWl0IExhZXMgPHBsYWVzQHBsYWVzLm9yZz4KPiA+IEFja2VkLWZvci1NRkQt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gCj4gV2hhdCdzIGdvaW5nIG9u
IHdpdGggdGhpcyBwYXRjaD8gIFdpbGwgeW91IGJlIGFwcGx5aW5nIGl0IG9yIGlzIHRoaXMgYW4K
PiBhY2sgZm9yIGl0IHRvIGJlIGFwcGxpZWQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzPwoK
SSBkb24ndCBoYXZlIGFueXRoaW5nIGVsc2UgcXVldWVkIGZvciBpbmNsdWRlL2xpbnV4L21mZC9h
eHAyMHguaCwgc28KeW91IGNhbiB0YWtlIGl0IGlmIHlvdSB3YW50LiAgSnVzdCBtYWtlIHN1cmUg
eW91ICdzLy1mb3ItTUZELy8nLiAKCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNl
cnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
