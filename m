Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:26:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058F3214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZbDaTCQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u79/+PEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058F3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5hYcKR0n8Fdh9Ah4FEAvj7/AVR8yia3p6XOtid3taEo=; b=KZbDaTCQKIfYJz
	0cU2TOPSpWJpA6E14MOrpmyNwos7Yn0JmtVb2BF1Kh5n7i40u+M/KwEla9+uBBiKQzvBVVTmKOQWw
	a6CaNEoQ6c44Eh1KncV9Mks/aGojXclVx1P4bUYK3nnpBLmkmOd9wlH36XJtH98v87V8dyRSi7Sv3
	JW4lp9PibP+Bn1vqQc3clB9NOQyojBIYc5cYeuTA7ap9tEfpCsITAMM0g1V2LbArpoeXq+qk4NFDC
	SPj3MtLaQK9n9YkouxzyPXDIOW1b4EARbxmzbAtjxX6JWkyiy9u0wjmIx63A/0F/uAOLl3cxZThCn
	iczYwLf+bqWlods8WNZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9jf-0004tq-0X; Mon, 11 Feb 2019 11:26:51 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9jY-0004m9-4T
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:26:49 +0000
Received: by mail-wm1-x344.google.com with SMTP id f16so16716033wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SdxLDzej+W+1L6rlFXDCkuHteBsUA6aEHotwknsM1Pc=;
 b=u79/+PEHiaW/PQYFrNWlF+qtwewBG4Kd+DzV0sS1htWFpjEk79DrLkV2NqipaoRMip
 63NdEo6PvxHAJgVw3reYEOHFxAtZ1Hvo0DIbVWB1q6VuhE+tz506SUlfYZIUvuWW2dNA
 vek4sTHepeKNj283lkBr1Vi+H4feVHLUH2womu5TgtepCIHN24WHPTVFSXDebeEWv4jS
 wEZgjzkrsDe6CtEUxAP6Fwaj7u5Bb8AumN/80w1WT8EBwgBVF6h/q0yyMsdqOmATAirX
 +23lFiyEJOwx226uh8aUqmo128UZdCqfwwaKTHOv/OgGF6aKsjVk2vs8sVIaW85Qxr6x
 +Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdxLDzej+W+1L6rlFXDCkuHteBsUA6aEHotwknsM1Pc=;
 b=omJZhd6WeZ2ZEMOaqIHPydV3RTfUywFUWTFNQFDu5tOwpUGr/RW5huFIFw2QIru5g2
 m2FMjtI9b4ZfVUybkkxWFOKX3E3P74foC92OQotJHdTz+i3p1PsTw9wWeBUW0mQ+lDlE
 U2mJEPuS/UqRszkpw/JUYiz3cpUQMrDhEvcM2FZIeCWzpk9oCJcX5sG/9fkUYsvueolH
 38kwYS9whosOLxj7sNZkI1rOw84cy6S2uW/7M0P+majafG0VvfQREbrvKZU/I+mL+d+f
 priBtMvhdl06yGjJoVN39X9ypQ4U1kxikidyUHrLqNzFXFybcXdLGbif4zNJ94u1X5WQ
 q0vQ==
X-Gm-Message-State: AHQUAubCEMK4VvngL9m0QjiR80OwF6rP5NV78tWf9QgMufmXpjNR3ouH
 hbIuJ8DEjBcFOKFndamsTdP97UCdEl0=
X-Google-Smtp-Source: AHgI3IbCb39JWdzplKnsyzIPAKWeoqNaGjmVSOs1JcJl+4JLnJixri6NybAYNy4LI2p7Dwyydvz6KQ==
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr8553326wmn.108.1549884402218; 
 Mon, 11 Feb 2019 03:26:42 -0800 (PST)
Received: from [192.168.0.41] (13.50.92.92.rev.sfr.net. [92.92.50.13])
 by smtp.googlemail.com with ESMTPSA id s3sm11276430wmj.23.2019.02.11.03.26.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 03:26:41 -0800 (PST)
Subject: Re: [PATCH 12/17 v1] clocksource/drivers/ixp4xx: Add OF
 initialization support
To: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-13-linus.walleij@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4b9f4015-6d49-56a9-df05-12c6393621be@linaro.org>
Date: Mon, 11 Feb 2019 12:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190203214205.13594-13-linus.walleij@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_032644_454144_4F6E5BEA 
X-CRM114-Status: GOOD (  20.58  )
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
Cc: Olof Johansson <olof@lixom.net>, Tim Harvey <tharvey@gateworks.com>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDMvMDIvMjAxOSAyMjo0MiwgTGludXMgV2FsbGVpaiB3cm90ZToKPiBUaGlzIGFkZHMgc3Vw
cG9ydCBmb3Igc2V0dGluZyB1cCB0aGUgSVhQNHh4IHRpbWVyIGRyaXZlciBmcm9tCj4gZGV2aWNl
IHRyZWUuCj4gCj4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
Pgo+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiBTaWduZWQtb2Zm
LWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4gLS0tCj4gQ2xv
Y2tzb3VyY2UvdGltZXIgbWFpbnRhaW5lcnM6IEkgYW0gcmVxdWVzdGluZyBhbiBBQ0sgZm9yCj4g
dGhpcyBvbmNlIHlvdSdyZSBoYXBweSB3aXRoIHRoZSBkcml2ZXIsIGFzIEkgaW50ZW5kIHRvCj4g
bWVyZ2UgYWxsIG9mIHRoaXMgSVhQNHh4IHJld29yayB0aHJvdWdoIEFSTSBTb0MuCgpBY2tlZC1i
eTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+Cgo+IC0tLQo+ICBk
cml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWl4cDR4eC5jIHwgMzUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItaXhwNHh4LmMgYi9kcml2ZXJzL2Ns
b2Nrc291cmNlL3RpbWVyLWl4cDR4eC5jCj4gaW5kZXggZmE3OGY4MDc5MmRiLi40MDQ0NDViYzEx
ZWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1peHA0eHguYwo+ICsr
KyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItaXhwNHh4LmMKPiBAQCAtMTYsNiArMTYsOCBA
QAo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ICAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+
Cj4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgo+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVz
cy5oPgo+ICsjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+Cj4gIC8qIEdvZXMgYXdheSB3aXRoIE9G
IGNvbnZlcnNpb24gKi8KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RhdGEvdGltZXItaXhw
NHh4Lmg+Cj4gIAo+IEBAIC0yNDcsMyArMjQ5LDM2IEBAIHZvaWQgX19pbml0IGl4cDR4eF90aW1l
cl9zZXR1cChyZXNvdXJjZV9zaXplX3QgdGltZXJiYXNlLAo+ICAJaXhwNHh4X3RpbWVyX3JlZ2lz
dGVyKGJhc2UsIHRpbWVyX2lycSwgdGltZXJfZnJlcSk7Cj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9H
UEwoaXhwNHh4X3RpbWVyX3NldHVwKTsKPiArCj4gKyNpZmRlZiBDT05GSUdfT0YKPiArc3RhdGlj
IF9faW5pdCBpbnQgaXhwNHh4X29mX3RpbWVyX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpucCkK
PiArewo+ICsJdm9pZCBfX2lvbWVtICpiYXNlOwo+ICsJaW50IGlycTsKPiArCWludCByZXQ7Cj4g
Kwo+ICsJYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsKPiArCWlmICghYmFzZSkgewo+ICsJCXByX2Ny
aXQoIklYUDR4eDogY2FuJ3QgcmVtYXAgdGltZXJcbiIpOwo+ICsJCXJldHVybiAtRU5PREVWOwo+
ICsJfQo+ICsKPiArCWlycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKG5wLCAwKTsKPiArCWlmIChp
cnEgPD0gMCkgewo+ICsJCXByX2VycigiQ2FuJ3QgcGFyc2UgSVJRXG4iKTsKPiArCQlyZXQgPSAt
RUlOVkFMOwo+ICsJCWdvdG8gb3V0X3VubWFwOwo+ICsJfQo+ICsKPiArCS8qIFRPRE86IGdldCBz
b21lIGZpeGVkIGNsb2NrcyBpbnRvIHRoZSBkZXZpY2UgdHJlZSAqLwo+ICsJcmV0ID0gaXhwNHh4
X3RpbWVyX3JlZ2lzdGVyKGJhc2UsIGlycSwgNjY2NjYwMDApOwo+ICsJaWYgKHJldCkKPiArCQln
b3RvIG91dF91bm1hcDsKPiArCXJldHVybiAwOwo+ICsKPiArb3V0X3VubWFwOgo+ICsJaW91bm1h
cChiYXNlKTsKPiArCXJldHVybiByZXQ7Cj4gK30KPiArVElNRVJfT0ZfREVDTEFSRShpeHA0eHgs
ICJpbnRlbCxpeHA0eHgtdGltZXIiLCBpeHA0eHhfb2ZfdGltZXJfaW5pdCk7Cj4gKyNlbmRpZgo+
IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZh
Y2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8j
IS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9n
Lz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
