Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFFA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hvk+2F+a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C4RzEXp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFFA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZBOsUAFbiVkD5c1BoNwmnAWv+11nbYPPYbkfxCHCXNY=; b=Hvk+2F+adurM/GWR6jINL0gNfm
	5p3aRF5jkvNQOs7ZL5SqU+mEi0X9i/7eIJp9qL4aIrNc5EdQ3l5l5cjukfv+6v1F1TZtDvq7hRXj1
	kLXpbChHg/w7L5o8ECc8GpkY7JsjnQq2BRRfpagB4qCfZd3A0sGX/j8h7y5lZBXRH+TGlG1H5d1YC
	VDFIOhp1QKyb+GQ53XULHDjotGgL80l8L6dvfdnqLstpa4TBno9roHN0LnT4mikCZNLQP/uQNZ0l6
	BotWD/m5Dt4r7A2QalPD90tgE7Mnay6ibeCcDXW8LJ5ZqtUKzGVgqKOCeflcbwAKRPKOM/vwTYVS8
	TTJ5YEwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkHn-0005Xg-7E; Fri, 14 Dec 2018 10:01:35 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXkHj-0005XI-1r
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:01:33 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so4820272wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MH1KlBpppvAWqa/LXWFxWv9R+0gBCDP8HMIHHY0SRfU=;
 b=C4RzEXp+xVqFYy2Jy+Sme0c3EbMVGpbUWSQpbGz5qtNTkUKVDO0aOPybiVri8JsN76
 REW1cD+/2TSlz2FEEt6ngfiNALE27Y1NTyx+rsRauZtC9254TiezDy/rNp/o/+N7mYu8
 FDI+AVaJSp20NDmVU/v8n1dXgFmogzC5MxEIKjXJnfor8ihsVnWVIP8ZTKxny8r5b3Fh
 7PPaokfRoZG2v0SDjm24rnIyHAsMrMW5DJEifsh86vlCUSNPjguWwr7NYdhrXUy13jjr
 SGTItbkYfLkreiY2UEqadyfFjJzjPNOpzUqevOLOvRyyxTXcHDlWpwbT8Jtf0BP4KkWL
 GDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MH1KlBpppvAWqa/LXWFxWv9R+0gBCDP8HMIHHY0SRfU=;
 b=iuxesxuCz3b/ZRuu7MIFrdKdN4GiSaikUbEJ7e6yjdZzbbK8f2WqjwH/SKfxdPbPF2
 DnD9bC/9gTVAyjYpk8b4WqwoEdNuCKIV8A9uedMnAF3915mSnZaTr+KK5XsJRyplFsm/
 zfbcyN7Uh6eQAuYNXGx5U3a2s7yDlk84fgGV6v+9XaUNTW4ZEw8cZ84jyV/3HIGGfGr0
 umnTxaDanDh8y8ITyu5NmLznc7ngl/wA4TlyuOuNML4i68aRbArzofrtTR2Uiu88Fe77
 gQ9YLaZBoJanNDeIJMZ5scf/cJT4SUmaF2QUdFKoJ8x+GpUXg2Z5qDgBjZaMns9EqAfq
 vOwA==
X-Gm-Message-State: AA+aEWajG74RvC+PakKensn8hjr3hv7tSLzl+oVxXxJPHVhKl5p4Thmz
 n1prPzMoJ1CWbcb9BTKcmix8+zrpHn74gQ==
X-Google-Smtp-Source: AFSGD/VJXXYfSryJEpSFQzMzxxwJLPBqksZ/qhAnJnIKG8OZcG+dMOg0i5K8WEFh7Ze0hohmjUpt/g==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr1972195wrr.201.1544781678413; 
 Fri, 14 Dec 2018 02:01:18 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id y13sm4505932wrn.73.2018.12.14.02.01.17
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 02:01:17 -0800 (PST)
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
To: linux-arm-kernel@lists.infradead.org
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
 <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
 <35518e71-027c-749e-1075-19ddc0410b19@amlogic.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0c6e5df3-c404-e997-04c2-ee1137857f85@baylibre.com>
Date: Fri, 14 Dec 2018 11:01:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <35518e71-027c-749e-1075-19ddc0410b19@amlogic.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_020131_232281_A5B35880 
X-CRM114-Status: GOOD (  14.48  )
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

T24gMTMvMTIvMjAxOCAxNDoyNSwgU3VubnkgTHVvIHdyb3RlOgo+IEhpIE5laWwsCj4gCj4gT24g
MjAxOC8xMi8xMyAxNjo1NSwgTmVpbCBBcm1zdHJvbmcgd3JvdGU6Cj4+IEhpIFN1bm55LAo+Pgo+
PiBPbiAxMy8xMi8yMDE4IDA5OjM5LCBTdW5ueSBMdW8gd3JvdGU6Cj4+PiBUaGUgU1BJQ0MgY29u
dHJvbGxlciBpbiBNZXNvbi1BWEcgU29DIGlzIGNhcGFibGUgb2YgdXNpbmcKPj4+IGEgbGluZWFy
IGNsb2NrIGRpdmlkZXIgdG8gcmVhY2ggYSBtdWNoIGZpbmUgdHVuZWQgcmFuZ2Ugb2YgY2xvY2tz
LAo+Pj4gd2hpbGUgdGhlIG9sZCBjb250cm9sbGVyIG9ubHkgdXNlIGEgcG93ZXIgb2YgdHdvIGNs
b2NrIGRpdmlkZXIsCj4+PiByZXN1bHQgYXQgYSBtb3JlIGNvYXJzZSBjbG9jayByYW5nZS4KPj4K
Pj4gVGhpcyBwYXRjaCBzaG91bGQgZGVmaW5pdGVseSBnbyBiZWZvcmUgcGF0Y2ggMS4KPiBXb3Vs
ZCB5b3UgcGxlYXNlIHNob3cgdGhlIHJlYXNvbj8KCkJlY2F1c2UgeW91IGFsbG93IDgwTWh6IGZv
ciBBWEcgaW4gcGF0Y2ggMSBldmVuIGlmIHRoZSBjb2RlIGlzIG5vdCBjYXBhYmxlCmFzIGluIHBh
dGNoIDEsIHNvIHBsZWFzZSBpbnRyb2R1Y2UgdGhlIG5ldyBlbmhhbmNlZCBkaXZpZGVyICp0aGVu
KiBhbGxvdwp0aGUgODBNSHogZnJlcSBmb3IgQVhHLgoKTmVpbAoKPj4KPj4+IMKgCj4+PiArwqDC
oMKgIC8qIFNldCBtYXN0ZXIgbW9kZSBhbmQgZW5hYmxlIGNvbnRyb2xsZXIgKi8KPj4+ICvCoMKg
wqAgd3JpdGVsX3JlbGF4ZWQoU1BJQ0NfRU5BQkxFIHwgU1BJQ0NfTU9ERV9NQVNURVIsCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGljYy0+YmFzZSArIFNQSUNDX0NPTlJFRyk7
Cj4+Cj4+IFBsZWFzZSByZW1vdmUgaXQgZnJvbSBtZXNvbl9zcGljY19wcmVwYXJlX21lc3NhZ2Uo
KSBub3cuCj4+Cj4gWWVzLCBJIG1vdmVkIGl0IGhlcmUgYW5kIGZvcmdvdCByZW1vdmUgaXQgYXQg
cHJlcGFyZV9tZXNzYWdlKCkuCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
