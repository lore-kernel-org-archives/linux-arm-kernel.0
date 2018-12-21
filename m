Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297FEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1B721906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bJ2AAgil";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgHnTFXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1B721906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sq+vAo02KjZE9IgBFP5V6GPEX8yEuQBZoWdESENi/2s=; b=bJ2AAgilpoA7D1
	HzL6Hsc1F4CCyMOt7c+1xNwCgMuBQ/MGKtyR9ZxxPDtsAWgl6w2QWUyv54Rxwvu1n/b5L8GHcxPYC
	OGlMNoQ5FBDpxNVJLeNUlklPI6DC8ZzH2jDcUYK/Aa9LIFu9fnQhsNtHR0wum+6LqbMIdjfzDi3Xx
	XyDxKSPVU1z6SeVxyDgGpJ0Ql/VU1EJilcO70iqRnEJCZtcY7PsG2jH3+kaLDjer908iemM7214Nl
	vo//KMcZYtERvGooej80opcKaJyIhMQ8zUemVXE2YZtHrfiHObMazUnhvOWaDlJGf37RaVeaWzY4B
	oIdN/cV5FHg3/oF6Werw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIJN-0003PC-5b; Fri, 21 Dec 2018 10:45:45 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIJF-0003Df-Gb
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:45:42 +0000
Received: by mail-lf1-x144.google.com with SMTP id i26so3600004lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wqUskNb2MAMNPRiADyLykBWdWKGKptjUyz9G6z+BYEQ=;
 b=dgHnTFXuMo+VWW5PWwhfgQjDd9n1TjWAqxa+ePVcAD/hfS8/MxPQX6frOam8jG1qRe
 ed3cnOBuiY0MgcuU5bkJ3iNmszOp+qFT7IRc4HKLm/gVNQx+Fd35h0XAoB0tU4aFprLH
 7xiY3cx+0k/itlm5eTshVS5G64/hxZFfTjEko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wqUskNb2MAMNPRiADyLykBWdWKGKptjUyz9G6z+BYEQ=;
 b=cuaApXgyHKKs2eh1LU5F9mVgTlcWjjl72f5GpDXZoy37/FX1WuGa3gFzcbP4gZQCe6
 4gRq8LzeYeckUX29hSnJh8Bh6rWbOHqYhiF6T3APcLcPA1csYUBIgBHO21iE5T27p4Hh
 m6stPJb68bfQ7o6aUSONKdCHUl3eT6wiAUZQh03l5E9ChWzPa6HHxJ9gMqdTLLQy2bKf
 0M72V3CGMgltH+uG3BGYpl5JALJR78tew+PJCDZvUaFiO7bbLeKlQxacXVkazeplSBfB
 e1FCEsWwZg5l2l/3Y6uuSIE5x60MrO6KkU/8j/tdsfwTX+o6fl33YLUhsrBRu0e0+EK8
 mwzQ==
X-Gm-Message-State: AA+aEWZ3bHy6hFIy70VcYjSwYM0vhQtMTkJZht0kAo0R6t9xNZWhU4iX
 9Pf8nnLLCxT3B74EgkN9LkUoh2W5sRqPoCjredxqnA==
X-Google-Smtp-Source: AFSGD/VZPxPTSXnB++FDKqwAjxqc0aqFpGMxkT9G1jmmDnD+Eydzj5O0HPAMuPjUI4afaTLjhltS3VH1cTLwsTyEJys=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1149591lfa.32.1545389125588; 
 Fri, 21 Dec 2018 02:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20181218155744.19409-1-zajec5@gmail.com>
In-Reply-To: <20181218155744.19409-1-zajec5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:45:13 +0100
Message-ID: <CACRpkdYoZtZci3BJ=-2AGr4vz7-OVJ9UwppYviMAiotBn2EU6Q@mail.gmail.com>
Subject: Re: [PATCH fixes 4.20] dt-bindings: pinctrl: bcm4708-pinmux: rework
 binding to use syscon
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_024537_550149_ACDB19F0 
X-CRM114-Status: GOOD (  19.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMTgsIDIwMTggYXQgNDo1OCBQTSBSYWZhxYIgTWnFgmVja2kgPHphamVjNUBn
bWFpbC5jb20+IHdyb3RlOgoKPiBGcm9tOiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2ku
cGw+Cj4KPiBBcyBwb2ludGVkIGJ5IFJvYiwgQ1JVIGlzIGEga2luZCBvZiBibG9jayB0aGF0IGNh
bid0IGJlIGd1YXJhbnRlZWQgdG8KPiBoYXZlIGV2ZXJ5dGhpbmcgZXhwb3NlZCBhcyBzdWJub2Rl
cy4gSXQncyBhIHNldCBvZiB2YXJpb3VzIHJlZ2lzdGVycwo+IHRoYXQgYXJlbid0IHRpZWQgdG8g
YW55IHNpbmdsZSBkZXZpY2UuIEl0IGNvdWxkIGJlIGRlc2NyaWJlZCBtdWNoIG1vcmUKPiBhY2N1
cmF0ZWx5IGFzIE1GRCAoTXVsdGktRnVuY3Rpb24gRGV2aWNlKS4KPgo+IFNvbWUgaGFyZHdhcmUg
YmxvY2tzIG1heSBpbmRlZWQgd2FudCB0byBhY2Nlc3MgYSByZWdpc3RlciBvciB0d28gb2YgdGhl
Cj4gQ1JVIHdoaWNoIHJlcXVpcmVzIGRlc2NyaWJpbmcgaXQgYXMgdGhlICJzeXNjb24iLgo+Cj4g
V2hpbGUgYXQgaXQgcmVwbGFjZSBleG1wbGUgbm9kZSBuYW1lIHdpdGggdGhlIHN0YW5kYXJkICJw
aW5jdHJsIiAoYWxzbwo+IHBvaW50ZWQgb3V0IGJ5IFJvYikuCj4KPiBTaWduZWQtb2ZmLWJ5OiBS
YWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2kucGw+Cj4gLS0tCj4gSGkgTGludXMsCj4KPiBB
ZnRlciBiZWluZyBwaW5nZWQgYWJvdXQgdGhlIHBpbmN0cmwgZHJpdmVyIEkgcmVhbGl6ZWQgSSBu
ZXZlciBhZGRyZXNzZWQKPiBSb2IncyBjb21tZW50cyBmcm9tIHRoZSBlLW1haWwgdGhyZWFkOgo+
Cj4gW1BBVENIXSBkdC1iaW5kaW5nczogcGluY3RybDogYmNtNDcwOC1waW5tdXg6IGltcHJvdmUg
ZXhhbXBsZSBiaW5kaW5nCj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5l
bC9tc2c2ODI4MzguaHRtbAo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvOTg0
MDI0Lwo+Cj4gUm9iIGhhcyBwb2ludGVkIGNvcnJlY3RseSAoYXMgYWx3YXlzKSB0aGF0IGRlc2Ny
aWJpbmcgQ1JVIHVzaW5nCj4gInNpbXBsZS1idXMiIGhhcyBpdHMgaW1wbGljYXRpb25zIGFuZCBt
YXkgaHVudCB1cyBiYWNrIGlmIHdlIGV2ZXIKPiByZWFsaXplIHdlIHdpbGwgd2FudCB0byByZWZl
cmVuY2UgaXQgYXMgInN5c2NvbiIuIFRoYXQgaXMgcHJldHR5IGxpa2VseQo+IGFjdHVhbGx5Lgo+
Cj4gVG8gZml4IHRoYXQgd2hpbGUgc3RpbGwgcG9zc2libGUgKGJlZm9yZSBoYXZpbmcgdGhhdCBE
b2N1bWVudGF0aW9uIGluCj4gYW55IHN0YWJsZSByZWxlYXNlKSBJJ2QgbGlrZSB5b3UgdG8gY29u
c2lkZXIgdGFraW5nIHRoaXMgcGF0Y2ggZm9yIHRoZQo+IDQuMjAgcmVsZWFzZSBpZiB5b3UgZmlu
ZCBpdCBwb3NzaWJsZS4KPgo+IEknbSB3ZWxsIGF3YXJlIGl0J3MgZGFtbiBsYXRlLiBJJ20gYXdh
cmUgSSd2ZSBzY3Jld2VkIHVwLiBJJ20gc29ycnkuCj4KPiBJJ20gYWZyYWlkIEkgY2Fubm90IGZp
eCBpdCBhbnlob3cuIEp1c3QgdGFrZSBhIGxvb2sgYXQgdGhhdCBwYXRjaCBhbmQKPiBmZWVsIGZy
ZWUgdG8gc2F5IEknbSBjcmF6eSBjb21pbmcgd2l0aCBpdCBzbyBsYXRlLgoKSSBqdXN0IGFwcGxp
ZWQgaXQuIEl0J3Mgbm90IGxpa2UgaXQncyBldGNoZWQgaW4gc3RvbmUgdGhvdWdoIHNvbWUKcGVv
cGxlIG1heSBoYXZlIHRoYXQgbWVudGFsIG1vZGVsLgoKSWYgdGhlIERUIG1haW50YWluZXJzIGhh
dmUgZnVydGhlciBjb25jZXJucyB3ZSBjYW4gcGF0Y2ggaXQKYWdhaW4uCgpSb3VnaCBjb25zZW5z
dXMgYW5kIHJ1bm5pbmcgY29kZS4KCllvdXJzLApMaW51cyBXYWxsZWlqCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
