Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:22:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F902086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPJGgWBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F902086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A7Wr6d4U/THGqSnaWh74OqSQ/6pHCXYnIfGMfAOAWiw=; b=lPJGgWBbgwlnAV
	wS28lxiIcq/AykU5XCH3qkh26b9SPkHq31FYNYYStnDbrdC3Z3Sj7FVRnFdj5d4DP9dpAy+0RxmZy
	iU1MYK7iMyK6FVJtx6XOFmuzXgcfflG0N13eUh2WhCwFkEgOZcFOjKx5A5umLUkdTOR/T+C8vNHBz
	tdna1F8BKIwVtZxzkoEvNfgk3PB23e7iOgmuOFb5DOO+dEctCWSepN2zGBPX+yXJG6paPXBWWpVoa
	WwUxLblkrXvD9zu5OFa4UFOOFdckwPj9HJc80HKnW/QOYVUtxEcyEuIQZK0f2EscNJ71dIDnhKp2R
	GYdwYizZEItony083REQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwThs-00068m-AT; Wed, 20 Feb 2019 15:22:44 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwThp-000681-0T
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:22:42 +0000
Received: by mail-ed1-f68.google.com with SMTP id j89so10784326edb.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/poT5zSDQYR4xkvE6W+qkDPTxMHyI95yC8gl7wywdao=;
 b=nr55GpxElnkNRkCUyacrWES39K0IVb2KdtnuNE4zqZbJy7IeXtESGvtrO1LKxKhTOg
 +jOBuaalRhCKxF+41nhF9hAJ85oP4fuhUbwogxaindzi1P2PxD8WaQMWEwc1WcvV+dDu
 QoGexwn2JHAXOuJqznUFio5BD3RRk4fCineo20xfPrw6HkwPEbbsnHNbzz8j03NAdyol
 QK20C3RMl3RfIeu2KX1i759mJYwK4PhBTlG5mPDgfD7Y3rtcHKfp4FIqIDu2Oer7sqjP
 oDJtYiqT1tq+q7IXhdaAO79v+K3e6EOtxzNHGkmB3xnnkfnwdmQp1qnKie2rBK5kDD6B
 Kv/A==
X-Gm-Message-State: AHQUAuYI3pc6Mxbmdfqx8yCYkYvJk49uR+ew/3sCFBLvx/7ernpRXY/i
 /0adMNiUUePHQu2htZdCxJAUcX6Uyg0=
X-Google-Smtp-Source: AHgI3IYCPyQKN0dzUxM4yp85wnfNw+nrEMkpz6hzDxNQ2LtMREEauNUgNgNIcqzwk+GLGffHnCsFug==
X-Received: by 2002:a05:6402:158e:: with SMTP id
 c14mr13255569edv.218.1550676159062; 
 Wed, 20 Feb 2019 07:22:39 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41])
 by smtp.gmail.com with ESMTPSA id h44sm3941228edh.34.2019.02.20.07.22.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 07:22:38 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id y185so4965399wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:22:38 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr7366092wmc.116.1550676158191; 
 Wed, 20 Feb 2019 07:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20190216182132.12895-1-mans@mansr.com>
 <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
 <20190220090617.aprfndnidcamwcvy@flea> <yw1x36oiybbl.fsf@mansr.com>
In-Reply-To: <yw1x36oiybbl.fsf@mansr.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 20 Feb 2019 23:22:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v669BXTtL=u2_yn3K_9zpdGBxGzA+UfrDgpu+zi99P=77g@mail.gmail.com>
Message-ID: <CAGb2v669BXTtL=u2_yn3K_9zpdGBxGzA+UfrDgpu+zi99P=77g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072241_048748_39A35D26 
X-CRM114-Status: GOOD (  20.61  )
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
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgNzowMCBQTSBNw6VucyBSdWxsZ8OlcmQgPG1hbnNAbWFu
c3IuY29tPiB3cm90ZToKPgo+IE1heGltZSBSaXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5j
b20+IHdyaXRlczoKPgo+ID4gT24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgMDQ6NTg6NDlQTSArMDgw
MCwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgo+ID4+IE9uIFN1biwgRmViIDE3LCAyMDE5IGF0IDI6MjEg
QU0gTWFucyBSdWxsZ2FyZCA8bWFuc0BtYW5zci5jb20+IHdyb3RlOgo+ID4+ID4KPiA+PiA+IFRo
aXMgYWRkcyBwaW5jdHJsIHNldHRpbmdzIGZvciB2YXJpb3VzIG1pc3NpbmcgdWFydCBvcHRpb25z
Lgo+ID4+ID4KPiA+PiA+IFNpZ25lZC1vZmYtYnk6IE1hbnMgUnVsbGdhcmQgPG1hbnNAbWFuc3Iu
Y29tPgo+ID4+ID4gLS0tCj4gPj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLmR0c2kg
fCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0NSBpbnNlcnRpb25zKCspCj4gPj4gPgo+ID4+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL3N1bjdpLWEyMC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLmR0
c2kKPiA+PiA+IGluZGV4IGFmNWIwNjdhNWY4My4uMjI5NWZmNWFkZjQ4IDEwMDY0NAo+ID4+ID4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLmR0c2kKPiA+PiA+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL3N1bjdpLWEyMC5kdHNpCj4gPj4gPiBAQCAtOTQ0LDYgKzk0NCwzMSBAQAo+
ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJ1YXJ0MCI7
Cj4gPj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9Owo+ID4+ID4KPiA+PiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHVhcnQwX3BmX3BpbnM6IHVhcnQwLXBmLXBpbnMgewo+ID4+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5zID0gIlBGMiIsICJQRjQiOwo+ID4+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJ1YXJ0MCI7Cj4gPj4g
PiArICAgICAgICAgICAgICAgICAgICAgICB9Owo+ID4+Cj4gPj4gV2UndmUgaGFkIHRoZSBwb2xp
Y3kgb2Ygbm90IGFkZGluZyBwaW5jdHJsIG5vZGVzIHRoYXQgYXJlbid0IHVzZWQgaW4tdHJlZSwK
PiA+PiB0byBhdm9pZCBibG9hdGluZyB1cCB0aGUgYmxvYiBzaXplLiBIb3dldmVyIERUQyAxLjQu
NyBpbnRyb2R1Y2VkIHRoZSBuZXcKPiA+PiAvb21pdC1pZi1uby1yZWYvIGRpcmVjdGl2ZSwgd2hp
Y2ggd291bGQgbWFrZSB0aGUgY29tcGlsZXIgZGlzY2FyZCBtYXJrZWQKPiA+PiBub2RlcyBpZiB0
aGV5IGFyZW4ndCByZWZlcmVuY2VkLgo+ID4+Cj4gPj4gU28gcGxlYXNlIGFkZCB0aGlzIHRvIGFs
bCB0aGUgbmV3IG5vZGVzLiBJdCBzZWVtcyB0byB3b3JrIHJlZ2FyZGxlc3Mgd2hldGhlcgo+ID4+
IHlvdSBhZGQgaXQgYmVmb3JlIG9yIGFmdGVyIHRoZSBsYWJlbCwgdGhvdWdoIGhhdmluZyBpdCBh
ZnRlciB0aGUgbGFiZWwgc2VlbXMKPiA+PiB0byBtYWtlIHZpbSBzeW50YXggaGlnaGxpZ2h0aW5n
IGhhcHBpZXIuCj4KPiBTaG91bGQgd2UgYWxzbyBhZGQgdGhpcyB0byBleGlzdGluZyBub2Rlcz8K
Pgo+IEJUVywgSSByZWFsbHkgZG8gbmVlZCBhbGwgdGhvc2UgdWFydCBwaW4gb3B0aW9ucy4KCk5v
dGUgdGhhdCAvb21pdC1pZi1uby1yZWYvIGRvZXMgbm90IHdvcmsgd2l0aCBkdGMgLUAsCmFzIGlu
IHRoZSBub2RlIHdpbGwgYmUgcmVtb3ZlZCBpZiBubyByZWZlcmVuY2VzIHRvIGl0CmFyZSBmb3Vu
ZCB3aXRoaW4gdGhlIHNhbWUgZmlsZS4gSXQgd2lsbCBub3QgcmVzdWx0IGluCmEgc3ltYm9sIGJl
aW5nIGNyZWF0ZWQuCgpJIGhhdmUgYSBwYXRjaCBmb3IgdGhhdCBidXQgaGF2ZW4ndCBzZW50IGl0
IG91dCB5ZXQuCgpDaGVuWXUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
