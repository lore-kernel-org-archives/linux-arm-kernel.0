Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A0DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:58:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2DF20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CNAN6sYR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="daZ4DhO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2DF20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ncentric.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZBVpZGoxDbhspsokJBAWke9PrZmTl+Yc3Kx+gSBXvhs=; b=CNAN6sYR+1ftdW65gX5iibkwN
	9bZt6GJ/fFqU5dVc1Dt9d5KpOxyUSHIalnmH5SAzTDDJ9jzJ/PYPEAta7MeMHE4i/OobgN8bgqiyR
	40uhm9uMAFp1FhMh07tr2CrJpHdHk5QtqB1Uxe6IR7RirQ2eSxrDT6PE1sAtCvhzLrEJ5O/iuomah
	aRSZU3rv1jSWlqNNK0TMxwrLZRU+h6gEfAyG9a5jjIcm0hnOVzJ03oL39lRVGYrCkbYxX4aN2D4jq
	L+nD+wdkbLsc1N1FPz54WDgvGbiC0TdbjaG/U9R3/4I0HwLtiFzouSlXv+h31Fs+TOv/jcdpVhvI6
	ru9CaHvCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggQkG-0002GY-CI; Mon, 07 Jan 2019 08:58:52 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggQkC-0002Fq-9i
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 08:58:50 +0000
Received: by mail-ed1-x544.google.com with SMTP id b14so99109edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncentric-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Th9BvYaGibqs1kjLWZxxqSN1OnYLVs5YECXoMK3YXAo=;
 b=daZ4DhO+/5bDdu5p7qhrqEXNtvI9ZKHfB3jF6h/qjLLErgObp1YpshaLOQyKBEJk0y
 EaMs5XEBPyP0j2PagC2Y/e+OVpxwOc41mG/QEjZHvMoA8V38qlUgbGXejJafSrWMeXFR
 2dPKjQ5Dwd4eawxiV305PkqQSIMbwcWKbpsoEsvZgSr0MmQgRgeoEWkb05oRZL0NIyY5
 ksQw+CLQcCRKbPYKFvbD3M3sHyY9QVMC1F7fOsMC8mEk2Dy4TXaOTW/blFWu3xBKniRn
 Be4EaxB4L9xvU/JB2hoVvmL0U+Y4wv1P/FCt+nw6BmEHptbs1R9XqjoUs2lSfWRFF38N
 fSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Th9BvYaGibqs1kjLWZxxqSN1OnYLVs5YECXoMK3YXAo=;
 b=EBBCUvYJfaUrnaIiq0M9nXrkXtqS7KTB1VgaTv6FfS8gNce/5dlP32ubTrMeNbuhZI
 TRRuHxUm2DEVzJ6Om9LXuWeFFfj4hPRaZwnEAlKuc15sEbPLsXxmhu7JoM2Qe4362txm
 YuquQEDhu/489Vx5cmV8aIXURXT5cRurB4aQHu32ypZGmCPtnMYvQNkQgGXbMh16LKXn
 TbbZbtkmKVwJ7EajRqrFg9oYBqCKBBoZNmksMRqISffTf0HFS5XjyU/+btuvZh9YR/Gb
 h7lpIgI7AKS1e8Y0DKo6fPKdO5TNrbm/tPwSdjQXjMBmqH/cvcUiCa0/x07lG3qNi5RT
 BWAg==
X-Gm-Message-State: AA+aEWamWjiw1Y7evsr7sJMnF0EjdwzwNxfDNRcWhbzA5WVkeNeKvcjK
 ivCQqhtLyLqcTOEceARllZ9P6OnDSVM=
X-Google-Smtp-Source: AFSGD/Xajdc1Emkq7ZUOTJLFg+NCU+rqoFnhNUYJSh2h/RrQtKk7phnzQX1R6ZYlBYhtxN+U5b17kg==
X-Received: by 2002:a50:c31a:: with SMTP id a26mr56117105edb.160.1546851525970; 
 Mon, 07 Jan 2019 00:58:45 -0800 (PST)
Received: from [192.168.3.176] ([91.179.126.85])
 by smtp.gmail.com with ESMTPSA id dc5-v6sm17874417ejb.53.2019.01.07.00.58.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 00:58:45 -0800 (PST)
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
To: Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Krzysztof_Ha=c5=82asa?=
 <khalasa@piap.pl>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com> <m336qegfzv.fsf@t19.piap.pl>
 <20181231152918.GE159477@google.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <a7531ef2-d6d0-0a48-1558-23474c97b838@ncentric.com>
Date: Mon, 7 Jan 2019 09:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181231152918.GE159477@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_005848_399394_12964244 
X-CRM114-Status: GOOD (  23.72  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDMxLjEyLjE4IDE2OjI5LCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+IE9uIE1vbiwgRGVjIDMx
LCAyMDE4IGF0IDExOjE0OjI4QU0gKzAxMDAsIEtyenlzenRvZiBIYcWCYXNhIHdyb3RlOgo+PiBC
am9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyaXRlczoKPj4KPj4+IDgwMmI3YzA2
YWRjNyByZXBsYWNlZCBjbnMzeHh4X3BjaV93cml0ZV9jb25maWcoKSwgd2hpY2ggYWx3YXlzIHVz
ZWQKPj4+IF9fcmF3X3dyaXRlbCgpIHNvIGl0IG9ubHkgZGlkIDMyLWJpdCBhY2Nlc3Nlcywgd2l0
aAo+Pj4gcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRlKCksIHdoaWNoIHVzZXMgd3JpdGViL3dyaXRl
dy93cml0ZWwoKQo+Pj4gZGVwZW5kaW5nIG9uIHRoZSBzaXplLgo+Pj4KPj4+IDgwMmI3YzA2YWRj
NyBhbHNvIGNvbnZlcnRlZCBjbnMzeHh4X3BjaV9yZWFkX2NvbmZpZygpIGZyb20gYWx3YXlzCj4+
PiB1c2luZyBfX3Jhd19yZWFkbCgpIChhIDMyLWJpdCBhY2Nlc3MpIHRvIHVzaW5nCj4+PiBwY2lf
Z2VuZXJpY19jb25maWdfcmVhZDMyKCksIHdoaWNoIGFsc28gYWx3YXlzIGRvZXMgYSAzMi1iaXQg
YWNjZXNzLgo+Pj4KPj4+IFRoaXMgbWFrZXMgbWUgdGhpbmsgdGhlIGNueDN4eHggaGFyZHdhcmUg
aXMgb25seSBjYXBhYmxlIG9mIDMyLWJpdAo+Pj4gYWNjZXNzZXMsIGFuZCB0aGlzIHBhdGNoIHNo
b3VsZCBjaGFuZ2UgdGhlIGRyaXZlciB0byB1c2UKPj4+IHBjaV9nZW5lcmljX2NvbmZpZ193cml0
ZTMyKCkgaW5zdGVhZCBvZiBwY2lfZ2VuZXJpY19jb25maWdfd3JpdGUoKSBpbgo+Pj4gYWRkaXRp
b24gdG8gdGhlIG1hcHBpbmcgZml4IGFib3ZlLgo+PiBIYXNuJ3QgaXQgYWxyZWFkeSBiZWVuIHZl
cmlmaWVkIHRoYXQgdGhlIENOUzN4eHggY2FuIGRvIDgtYml0IGFjY2Vzc2VzCj4+IChhbmQgcHJv
YmFibHkgMTYtYml0IG9uZXMgYXMgd2VsbCksIGFuZCB0aGF0IHRoZSBkb2NzIGRvbid0IG1lbnRp
b24gYW55Cj4+IHN1Y2ggbGltaXRhdGlvbj8KPiBRdWl0ZSBwb3NzaWJseS4gIEknbSBub3QgZmFt
aWxpYXIgd2l0aCB0aGUgaGFyZHdhcmUgb3IgZG9jcyBzbyBjYW4ndAo+IGNvbW1lbnQgcGVyc29u
YWxseS4KPgo+IDgwMmI3YzA2YWRjNyByZWltcGxlbWVudGVkIGNuczN4eHhfcGNpX3JlYWRfY29u
ZmlnKCkgdXNpbmcKPiBwY2lfZ2VuZXJpY19jb25maWdfcmVhZDMyKCksIHdoaWNoIHByZXNlcnZl
ZCB0aGUgcHJvcGVydHkgb2Ygb25seQo+IGRvaW5nIDMyLWJpdCByZWFkcy4gIEl0IHJlcGxhY2Vk
IGNuczN4eHhfcGNpX3dyaXRlX2NvbmZpZygpIHdpdGgKPiBwY2lfZ2VuZXJpY19jb25maWdfd3Jp
dGUoKSwgc28gaXQgY2hhbmdlZCB3cml0ZXMgZnJvbSBhbHdheXMgYmVpbmcgMzIKPiBiaXRzIHRv
IGJlaW5nIHRoZSBhY3R1YWwgc2l6ZS4gIEkgdGhpbmsgdGhpcyB3YXMgYW4gZXJyb3IgaW4gdGhl
Cj4gb3JpZ2luYWwgY29tbWl0LCBzaW5jZSB0aGUgY2hhbmdlbG9nIGRvZXNuJ3QgbWVudGlvbiB0
aGlzIGNoYW5nZTsgaW4KPiBmYWN0LCB0aGUgY2hhbmdlbG9nIHNheXMgaXQgY2hhbmdlcyBfX3Jh
d193cml0ZWwgdG8gd3JpdGVsLgo+Cj4gVGhlIGNoYW5nZSBmcm9tIDMyLWJpdCB0byBhY3R1YWwg
c2l6ZSBhY2Nlc3NlcyB3b3VsZCBsb2dpY2FsbHkgYmUgYQo+IHNlcGFyYXRlIGNvbW1pdCBmcm9t
IGNoYW5naW5nIHRvIHVzZSB0aGUgZ2VuZXJpYyBhY2Nlc3NvcnMuCj4KPiBBc3N1bWluZyB0aGUg
aGFyZHdhcmUgZG9lcyBzdXBwb3J0IHNtYWxsZXIgYWNjZXNzZXMsIEknZCBwcm9wb3NlIHR3bwo+
IHBhdGNoZXM6CgpCam9ybiwKClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIHRvIGxvb2sgaW50byB0
aGlzLgoKPiAgICAxKSBUaGUgY3VycmVudCBvbmUgdGhhdCBjb3JyZWN0cyB0aGUgYWRkcmVzcyBh
bGlnbm1lbnQgZXJyb3IsIGFuZApJcyBpdCByZXF1aXJlZCB0byByZXNlbmQgdGhpcyBzcGVjaWZp
YyBwYXRjaD8KPiAgICAyKSBBIG5ldyBvbmUgdGhhdCBjb252ZXJ0cyBjbnMzeHh4X3BjaV9yZWFk
X2NvbmZpZygpIHRvIHVzZQo+ICAgICAgIHBjaV9nZW5lcmljX2NvbmZpZ19yZWFkKCkgaW5zdGVh
ZCBvZiBwY2lfZ2VuZXJpY19jb25maWdfcmVhZDMyKCkuCkknbGwgZmlyc3QgZXh0ZW5zaXZlbHkg
dGVzdCBub24tMzJiIHJlYWRzIGxhdGVyIHRvZGF5IGFuZCB3aWxsIHNlbmQgYSAKcGF0Y2ggZm9y
IGl0Cj4gSWRlYWxseSB0aGUgY2hhbmdlbG9nIGZvciB0aGUgc2Vjb25kIHBhdGNoIHdvdWxkIHJl
ZmVyIHRvIHRoZQo+IHZlcmlmaWNhdGlvbiB0aGF0IHRoZSBoYXJkd2FyZSBpcyBjYXBhYmxlIG9m
IDgtIGFuZCAxNi1iaXQgYWNjZXNzZXMuCj4KPiBCam9ybgpLb2VuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
