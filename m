Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9BC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:52:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAEC20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fx+Q8WsH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0ZUR9a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAEC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7/7H0RTDm9e3W9DO4+m2z09tNj6HOj2/8aZ8aNzHbyI=; b=Fx+Q8WsHdIChyy
	YmLFbh7/mpJkGDfKDmJREAoATbT0v6NIsOnIi5oIMK9h90bbDbSunNPlUe9e95QLcNKBH96PLzrNI
	icQKa9RkwG1TU8Nhk8/z/ummyji8CBMbKpdtXo2VpZW9J9sd9TZBH4N2Lmc44UIQoquZ1O54GlhhJ
	0njkDKJ4CXkHSnQjZPgUCGqGNXvQxHujwjovModEeojcJvOLJF6kjFk7BLjXY4Og4kD3CTk6kYWhu
	FNz/Dyl+v9/dGPmeSRhj0kB1FVm6JDHBhAZMZOHEItnxdKmKHOx3yPcPaH3jcKRzncgftGsv8wwcN
	rtRCs3UTrYbCZHfg8hzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwIv-0005q9-C3; Fri, 11 Jan 2019 12:52:53 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwIs-0005pE-0l
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:52:51 +0000
Received: by mail-lf1-x144.google.com with SMTP id p6so10749825lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 04:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dTLAXasfoxk1TY4BjzZ++ji6QYNcJ+ZLibT+Dom9UCk=;
 b=c0ZUR9a26++F1F0VMtvdMmEYePRIQp2Wv7Jsm8QX86vXo/en5auP8DCNDw9vdG7nCH
 OxnSY3XcZSiSh9YDF+v1Myoqtd1NA3q9k2ItTqGtZl/TnqoK8jakJcLz3tb4CO/PLEpT
 CwBvYN73X/SqvZzYOjZJiRNi3FfvjpwbQ+x4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dTLAXasfoxk1TY4BjzZ++ji6QYNcJ+ZLibT+Dom9UCk=;
 b=nDHmJkMlY17UOMGHqPDsICp7nQtBOpDsO1ehYyIPid3hFWsghXERaGptmf6g8vppWg
 wsvFH/19qZSO/JiPOInuE8gbfwSNKsWRAmmPJzHhumYbZG0aL3r/er7YJ8kWtJc72lXh
 jwO03oGae287jPlqR95fNc3lk51lZtrdS/R9/OeQw9xsv5vYIj6dqWVsArobZzapdyeW
 f/lRJEeQDOtSUMBGEfcXWllUS2Ru0K2Ll31BAXPUPlaLeC6T7ktRxkQLzi3Gd5hi2AI1
 VyXilU9hlti6gJNoq3AGfIW8o3K7vRwec7l6EbFmyILXf2E3s2XERpKGzdbh8zcu5LcN
 qNcA==
X-Gm-Message-State: AJcUuked9U0zOinH1SHSnfSlnQD0s8+3c6G6mSR0aq26zxz7r8P/eyzN
 93IXo/qTEJim5WKYY/TI3LoWW3nhoOABF+ZYKCrUS9Furrg=
X-Google-Smtp-Source: ALg8bN6jyPxbQ0k/G8BO2m4H8pnsHhh2XJ9b2isrdSmthXqRALVHysnQxOjT5D7c2pOhC0ENJgqt456XC2o8BdsnrGQ=
X-Received: by 2002:a19:789:: with SMTP id 131mr8581944lfh.11.1547211168039;
 Fri, 11 Jan 2019 04:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20190107194523.2772-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190107194523.2772-1-u.kleine-koenig@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 13:52:36 +0100
Message-ID: <CACRpkdbYizVLtQxh8_ZXWC-d6+E-k0T6Zq67qRJ7ascFGWTXig@mail.gmail.com>
Subject: Re: [PATCH] bus: ts-nbus: remove bus driver without user
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_045250_113788_3E4EA52A 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Sascha Hauer <kernel@pengutronix.de>, kernel <kernel@savoirfairelinux.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?SsOpcsO0bWUgT1VGRUxMQQ==?= <jerome.oufella@savoirfairelinux.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBKYW4gNywgMjAxOSBhdCA4OjQ2IFBNIFV3ZSBLbGVpbmUtS8O2bmlnCjx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgoKPiBTaW5jZSB0aGUgdHMtbmJ1cyBkcml2
ZXIgd2FzIGludHJvZHVjZWQgaW4gMjAxNyBpdCBvbmx5IHNhdyBzb21lIHJld29ya2luZwo+IGNo
YW5nZXMuIFRoZXJlIGlzIG5vIHVzZXIgaW4gdGhlIHRyZWUsIG5laXRoZXIgYSBtYWNoaW5lIHRo
YXQgaGFzIHRoaXMKPiBidXMgbm9yIGEgZHJpdmVyIGZvciBhIGRldmljZSBvbiB0aGF0IGJ1cy4g
QWxzbyB0aGUgZW1haWwgYWRkcmVzcyBvZiB0aGUKPiBhdXRob3IgZG9lc24ndCBleGlzdCBhbnkg
bW9yZS4KPgo+IFNvIHJlbW92ZSB0aGlzIGJ1cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+CgpTZWJhc3RpZW4gYWRk
ZWQgdGhpcyBidXMgYW5kIEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgaGUgd2FzCnVz
aW5nIGl0LCBldmVuIGlmIG5vIGNvbmZpZyBvciBEVFMgaW4gdGhlIGtlcm5lbCBzZWVtcyB0byBi
ZSB1c2luZyBpdC4KCklJUkMgaXQgc2hvdWxkIGxhbmQgaW4gdGhpcyBvbmU6CmFyY2gvYXJtL2Jv
b3QvZHRzL2lteDI4LXRzNDYwMC5kdHMKClRoaXMgd2FzIGFkZGVkIG92ZXIgYSB5ZWFyIGFnbyBh
bmQgbm90IG11Y2ggaGFwcGVuZWQgc2luY2UuCgpTZWJhc3RpZW4gd2hhdCBoYXBwZW5lZCB3aXRo
IHRoaXM/CihJIGhvcGUgaGlzIG1haWwgaXMgbm90IGJvdW5jaW5nLi4uKQoKVGhpcyBpbnRlcmVz
dGluZ2x5IGJyaW5ncyB1cCB0aGUgZm9sbG93aW5nIHF1ZXN0aW9uOiB3ZSB1c2VkIHRvIGp1c3QK
Z3JlcCB0aGUga2VybmVsIGZvciB1c2VycyBvZiBhIGNlcnRhaW4gZHJpdmVyLCB3aGljaCB3aWxs
IGZpbmQgZS5nLiBib2FyZApmaWxlcyBldmVuIGlmIHRoZXJlIGlzIGN1cnJlbnRseSBubyBkZWZj
b25maWcgZm9yIHRoZSBzeXN0ZW0uCldpdGggZGV2aWNlIHRyZWUgZHJpdmVycyB0aGVzZSBEVFMg
ZmlsZXMgZGVmaW5pbmcgdGhlIHVzZSBvZiB0aGUKZHJpdmVyIGNhbiBiZSBvdXQtb2YtdHJlZSwg
c29tZXRpbWVzIChTdW5PUz8pIGluIHRoZSBST00gb2YgYQptYWNoaW5lLCBhbmQgbm90IHBvc3Np
YmxlIHRvIGNoZWNrIHVzaW5nIGdyZXAuCgpXZSBuZWVkIHNvbWUgcG9saWN5IHRoZXJlLCBsaWtl
IHByZWZlcmFibHkgbWVyZ2UgZGV2aWNlIHRyZWVzCnVwc3RyZWFtIGFuZCBhZGQgZGVmY29uZmln
cyBzbyB3ZSBoYXZlIHNvbWUgaW5kaWNhdGlvbiB0aGF0CnRoZSBkcml2ZXIgaXMgdXNlZCBhbmQg
YWxzbyBnZXQgY29tcGlsZWQgaW4gdGVzdHMuCgpZb3VycywKTGludXMgV2FsbGVpagoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
