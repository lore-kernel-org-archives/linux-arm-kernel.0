Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF83EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C2720645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S/CtKJG5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umJ51yCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C2720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+W0l3a/djYdXAJp6dlp7W3VxUMH0KhdQx6nMBe0fZo4=; b=S/CtKJG5asoJ14
	cIx5aPCXByV7mo/W9eBhbtnmAAv8M8VbtviK/N6zaUnq6Izq3hMktvKnfs+mPAUDI8f8wkUXptfmF
	i4uzChgJNgRSAvFaxIq5JM4mOSDpHcDOtAS+cAeJcZBPbXbz8vycQ4ROsWAvpHEo7obDjMAQ2IJvo
	8SOi3h+xHlPGJ5fjvB+ish534tqvXpr/q6tieeBr/7Itv3LvG+7tymuHVruPT3WuMHgSSdRwx7TB7
	cijaAk9Ead1ld0VPaFA69gJdNRypIKkk/sDBHEyQNk1DEFRvFuaBUk5j5KBarARiFC9bpp7YP6XnK
	N/KsKj40Gv+kaNX2DowQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyKTJ-0003LC-PD; Mon, 25 Feb 2019 17:55:21 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyKTC-0003KP-Ip
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:55:19 +0000
Received: by mail-pl1-x641.google.com with SMTP id bj4so4826356plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YN0OlnVQYJBntNqmwDAzD0fL0Qo/FWo9DZeANwyOEYY=;
 b=umJ51yCkHoVGcS5UNZdohDiLlGiioruKwcmo/gpz8JNCBvFLUNr1lCMkCDJe15Wbfl
 t+JXzuDCZCw/Ii3RGDnm0iCom1eg99rHWs9VjYvtnOsVKngRMwji9a4+5x1dy12SDGbb
 9zeeEh/HLVnIb6C7ijrr9VSi4D4PTVn0Y6DdXiPZFJ/jhWnNayCLLtZRkgQiCa6BHdd6
 m08rMFPsm06mBC/C3ePmoLZ8fhp00D6SBJa48JmFzzASeSBUO/UTKgJ1dX8qb1WGJy6E
 nB7gMJufigHYMNaRhCqNUQ6HSNBQ8zd4ocfkEKUqjDmYbpZI34HFdKkwcXfSarRmN8d+
 zWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YN0OlnVQYJBntNqmwDAzD0fL0Qo/FWo9DZeANwyOEYY=;
 b=mfXDICPoABkmIfh4pF8JBCk82m0DuDGlJoEIp/zvkKutKK3Ik2uutgOJnWJmeejYjV
 wBYh9mssyIp6U5CG+1EtL7C+P3hzaWzYNWRCpUTihcmzmBNVDBPaLrq9CcbL4oSZntku
 m3j0sdio4B5OLd+TvI/Q2pBgmDIgfGDZnmflCGH/GEoY7vYAAoR+k3Qi8iHllANIj4D5
 aPLCMuhf+kF9X5nkdKGW4GUlpPJwR44kYOwnuEwOBqqX+E99jOh9EjTSmwu7wols1BGU
 +es9TA3brsmL3bfWDRZA7e4C3NdgNIsUbt1NH9rJeQDU6/ntU7rU5kIDJ0lcOSHcw9y+
 6iQA==
X-Gm-Message-State: AHQUAuZSq/gsw9eIB2pw49l2Fs8nnrLFmdhPDjYPpNDeKLd/oob2N0oT
 M2J81867/D0IFePl/Ryj3WM=
X-Google-Smtp-Source: AHgI3IaR7jlSeYRjfhqiVbXGysPfM6w8rNSpq0ul/maepRX4Bet+UD4pSpOSmzEcnUTMMh7J7I8Dxw==
X-Received: by 2002:a17:902:24e7:: with SMTP id
 l36mr21770505plg.61.1551117313958; 
 Mon, 25 Feb 2019 09:55:13 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49]) by smtp.googlemail.com with ESMTPSA id
 h126sm7861299pfc.135.2019.02.25.09.55.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 09:55:13 -0800 (PST)
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
To: Robert Yang <decatf@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
 <20190225040232.GA2242@qmqm.qmqm.pl> <20190225082155.1163ed85@dimatab>
 <20190225165836.GA12933@r>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <684c1196-b2c3-f381-7cb0-0ffa3f071378@gmail.com>
Date: Mon, 25 Feb 2019 20:55:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225165836.GA12933@r>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_095518_144996_5DC11878 
X-CRM114-Status: GOOD (  15.74  )
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
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MjUuMDIuMjAxOSAxOTo1OCwgUm9iZXJ0IFlhbmcg0L/QuNGI0LXRgjoKPiBPbiBNb24sIEZlYiAy
NSwgMjAxOSBhdCAwODoyMTo1NUFNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+INCS
IE1vbiwgMjUgRmViIDIwMTkgMDU6MDI6MzMgKzAxMDAKPj4gTWljaGHFgiBNaXJvc8WCYXcgPG1p
cnEtbGludXhAcmVyZS5xbXFtLnBsPiDQv9C40YjQtdGCOgo+Pgo+Pj4gT24gRnJpLCBGZWIgMjIs
IDIwMTkgYXQgMTA6MzQ6MTlQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+IEhl
bGxvLAo+Pj4+Cj4+Pj4gVGhpcyBwYXRjaHNldCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBUcnVzdGVk
IEZvdW5kYXRpb25zIGZpcm13YXJlIG9uCj4+Pj4gTlZJRElBIFRlZ3JhMzAuIFByZXR0eSBtdWNo
IGFsbCBvZiBUZWdyYTMwIGNvbnN1bWVyIGRldmljZXMgaGF2ZQo+Pj4+IHRoYXQgZmlybXdhcmUg
YW5kIHVwc3RyZWFtIGtlcm5lbCBjYW4ndCBib290IG9uIHRob3NlIGRldmljZXMKPj4+PiB3aXRo
b3V0IHRoZSBmaXJtd2FyZSBzdXBwb3J0LiAgCj4+Pgo+Pj4gSGkgRG1pdHJ5Cj4+Pgo+Pj4gSSd2
ZSBhcHBsaWVkIGFuZCB0ZXN0ZWQgdGhpcyBwYXRjaHNldCBvbiBteSBURjMwMFQuIEJvb3RzIGFu
ZAo+Pj4gc3VzcGVuZHMvd2FrZXMgdXNpbmcgJ3J0Y3dha2UgLW0gbWVtIC1zIDEgLWQgL2Rldi9y
dGMxJyBhcyB0aGUgdGVzdC4KPj4+IGRtZXNnIGF0dGFjaGVkLgo+Pj4KPj4+IFRoZSBleGFjdCB0
cmVlIHVzZWQ6Cj4+PiAJZ2l0Oi8vcmVyZS5xbXFtLnBsL2xpbnV4IHRmMzAwdAo+Pj4KPj4+IEZl
ZWwgZnJlZSB0byBhZGQgbXkgVGVzdGVkLWJ5IGFuZCBTaWduZWQtb2ZmLWJ5IG9uIHRoZSBwYXRj
aGVzIHdoZXJlCj4+PiBhcHJvcHJpYXRlLCBhbmQgdGhhbmtzIGZvciB5b3VyIHdvcmshCj4+Cj4+
IEF3ZXNvbWUsIHRoYW5rIHlvdSB2ZXJ5IG11Y2ghCj4+Cj4+IFJvYmVydCwgY291bGQgeW91IHBs
ZWFzZSBjb25maXJtIHRoYXQgdjYgd29ya3MgZm9yIHlvdSB0b28/Cj4+Cj4gCj4gWWVzLCB2NiB3
b3JrcyBvbiBPdXlhLgo+IAo+IExQMS9MUDIgc3VzcGVuZCB0ZXN0ZWQgd2l0aCAncnRjd2FrZSAt
bSBtZW0gLXMgNScKPiBjcHVpZGxlIExQMiB0ZXN0ZWQgd2l0aCAnZWNobyAwIHwgdGVlIC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdVsxLTNdL29ubGluZScKPiBUZXN0ZWQgd2l0aCBDT05GSUdf
U01QIGRpc2FibGVkIHRvby4KPiAKPiBZb3UgY2FuIGFkZCBteSBUZXN0ZWQtYnkgdG8gdGhpcyBw
YXRjaCBzZXQuCgpHcmVhdCwgdGhhbmsgeW91IQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
