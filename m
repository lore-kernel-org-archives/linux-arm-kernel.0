Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:22:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAB62081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwCpooIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAB62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LTANkB3SQVVTzjx6vqDkgeM63o8G69vXbJEQ2rI6QSo=; b=gwCpooIYR17N8c
	OOv6Hrg0dfuj5yM4+b4l3E4Qcd4qCiDKGmYZq5x4wrANIO+0vwDZWTBe9+rvIoEpSj9dC0nSI6AfT
	KzaFNgyMoNNuX6waUS5QbK9OG41WujmQmMBvYjAIpHIJ6p6zxVKa4sg9f+VHKSwioiuJPIsHzfMrl
	qw18zt+bvFSvt3uccJte8Pir/hj7DCz5CVWXsFcYyJFiqgZM4Fq1D7HvDFLcVqEaPfuEwn9IhrV1/
	m4z47vDLRnwGdTaU/uyPdvsAvdJkZStjd6JHWOBl9l4U5At4A3E7ZsP4cE7CgXpLwBtyW2o4N69rD
	1kgA2rZ51gjyiDMlkQMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULtd-00060O-Mp; Wed, 05 Dec 2018 01:22:37 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULtZ-0005z8-Ph
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:22:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A2938B609;
 Wed,  5 Dec 2018 01:22:19 +0000 (UTC)
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>
References: <20181204183649.GA5716@bogus>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
Date: Wed, 5 Dec 2018 02:22:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204183649.GA5716@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_172234_249818_21BA2249 
X-CRM114-Status: GOOD (  20.93  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Alexander Graf <agraf@suse.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm@kernel.org, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 linux-arm-kernel@lists.infradead.org, Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Um9iLAoKQW0gMDQuMTIuMTggdW0gMTk6MzYgc2NocmllYiBSb2IgSGVycmluZzoKPiBJJ3ZlIHB1
dCB0b2dldGhlciBhIHNjcmlwdCB0byBtb3ZlIHRoZSBkdHMgZmlsZXMgYW5kIHVwZGF0ZSB0aGUg
Cj4gbWFrZWZpbGVzLiBJdCBkb2Vzbid0IGhhbmRsZSBmaWxlcyBub3QgZm9sbG93aW5nIGEgY29t
bW9uIHByZWZpeCB3aGljaCAKPiBpc24ndCBtYW55IGFuZCBzb21lIGluY2x1ZGVzIHdpdGhpbiB0
aGUgZHRzIGZpbGVzIHdpbGwgbmVlZCBzb21lIGZpeHVwcyAKPiBieSBoYW5kLgo+IAo+IE1BSU5U
QUlORVJTIHdpbGwgYWxzbyBuZWVkIHVwZGF0aW5nLgo+IAo+IEEgZmV3IHF1ZXN0aW9uczoKPiAK
PiBEbyB3ZSB3YW50IHRvIG1vdmUgYWJzb2x1dGVseSBldmVyeXRoaW5nIHRvIHN1YmRpcnM/CgpU
aGlzIHJlZmFjdG9yaW5nIGlzIGEgdGVycmlibGUgaWRlYSEKCldoaWxlIGl0IHdvdWxkJ3ZlIGJl
ZW4gbmljZSB0byBoYXZlIG1vcmUgc3RydWN0dXJlIGZyb20gdGhlIHN0YXJ0LApib290bG9hZGVy
cyBsaWtlIFUtQm9vdCBleHBlY3QgYSBmbGF0IHN0cnVjdHVyZSBmb3IgYXJtIC5kdGIgZmlsZXMg
bm93LgpJZiB5b3Ugc3RhcnQgaW5zdGFsbGluZyB0aGVtIGludG8gc3ViZGlycyBpbnN0ZWFkLCB0
aGV5IHdvbid0IGZpbmQgdGhlCmZpbGVzIGFueW1vcmUgdW5kZXIgdGhlIGhhcmRjb2RlZCBuYW1l
LgoKRG9pbmcgdGhpcyBvbmx5IGZvciBuZXcgcGxhdGZvcm1zIHdvdWxkIGJlIG11Y2ggbGVzcyBp
bnZhc2l2ZSBhbmQgYWxsb3cKdG8gcHJlcGFyZSBib290bG9hZGVycyBhY2NvcmRpbmdseS4gQWx0
ZXJuYXRpdmVseSwgd2hpdGUtbGlzdCB3aGljaCBvbmVzCmFyZSBzYWZlIHRvIG1vdmUgYXJvdW5k
LiBCdXQgZG9uJ3QganVzdCBzY3JpcHQgYSByZWZhY3RvcmluZyBiZWNhdXNlIGl0Cmxvb2tzIG5p
Y2VyIGluIHRoZSBzb3VyY2UgdHJlZSwgd2l0aG91dCB0ZXN0aW5nIHdoYXQgc2lkZSBlZmZlY3Rz
IHRoaXMKY2FuIGhhdmUgZm9yIGJvYXJkL2Rpc3RybyB1c2VycyBvZiB0aGUgY29tcGlsZWQgZmls
ZXMgaW4gcHJhY3RpY2UuCldlIGFscmVhZHkgaGFkIHRoYXQgZGlzY3Vzc2lvbiBmb3IgYXJtNjQg
YmVjYXVzZSBEZWJpYW4gY2hvc2UgdG8gaWdub3JlCnRoZSBrZXJuZWwtaW5zdGFsbGVkIHN1YmRp
cmVjdG9yaWVzIGFuZCBpbnN0YWxsZWQgLmR0YiBmaWxlcyBpbnRvIGEgZmxhdApkaXJlY3Rvcnks
IHdoaWNoIGNvbGxpZGVkIHdpdGggb3BlblNVU0Ugc3RpY2tpbmcgdG8gdGhlIGtlcm5lbCBjaG9p
Y2UuCgpUaGlzIHRvcGljIGJlY29tZXMgZXZlbiBtb3JlIGltcG9ydGFudCB3aXRoIEVCQlI6IFRo
ZXJlIGlzIG5laXRoZXIgYQptZWNoYW5pc20gaW4gcGxhY2UgdG8gc3luYyAuZHRzIGZpbGVzIGlu
dG8gVS1Cb290IG9yIEVESzIgc291cmNlIHRyZWVzLApub3IgYXJlIGNhcHN1bGUgdXBkYXRlcyBp
bXBsZW1lbnRlZCBpbiBVLUJvb3QgZm9yIGVhc2lseSBkZXBsb3lpbmcgc3VjaApib290bG9hZGVy
cyB3aXRoIG5ldyAuZHRzIHNvdXJjZXMgb3IgcGF0aHMgeWV0LiBBbmQgSSBjYW4gYXNzdXJlIHlv
dQp0aGF0IGp1c3QgZ2V0dGluZyB1c2VycyB0byBkZCB0aGUgcmlnaHQgYm9vdGxvYWRlciBjYW4g
YmUgZGlmZmljdWx0Li4uClNpbmNlIERUIGZvcndhcmQgYW5kIGJhY2t3YXJkIGNvbXBhdGliaWxp
dHkgaXMgb2Z0ZW4gYmVpbmcgbmVnbGVjdGVkLApmb3IgZXhhbXBsZSB3aXRoIG9wdGlvbmFsIHBy
b3BlcnRpZXMgb3IgcmVuYW1lZCBjb21wYXRpYmxlcyB0aGF0IGJyZWFrCmJvb3Rpbmcgd2l0aCBw
cmV2aW91cyBkcml2ZXJzLCBuZXcga2VybmVsIHZlcnNpb25zIG9mdGVuIG5lZWQgdXBkYXRlZApE
ZXZpY2UgVHJlZXMgdG8gbWFrZSB1c2Ugb2YgbmV3L2VuaGFuY2VkIGRyaXZlcnMuIFRoZXJlZm9y
ZSBpdCBpcwp1bmZvcnR1bmF0ZWx5IG9mdGVuIGVub3VnaCBhIG5lY2Vzc2l0eSB0byBsb2FkIG5l
d2VyIGtlcm5lbC1iYXNlZCAuZHRiCmZpbGVzIG1hdGNoaW5nIHRoZSBrZXJuZWwgKGFzIG9wcG9z
ZWQgdG8gdGhlIGRyZWFtIG9mIGtlcm5lbC1pbmRlcGVuZGVudApoYXJkd2FyZSBkZXNjcmlwdGlv
bnMpIHdoZW4gd29ya2luZyB3aXRoIHRoZSBsYXRlc3QgLXJjIG9yIC1uZXh0IGtlcm5lbHMKYXQg
bGVhc3QuIEZvciBleGFtcGxlcyBvZiBEVHMgbmVlZGluZyB1cGRhdGVzLCBsb29rIG5vIGZ1cnRo
ZXIgdGhhbgpMaW5hcm8ncyA5NmJvYXJkcyAtIGluIGNhc2Ugb2YgaGlrZXk5NjAvRURLMiBHUlVC
IGlzIGFub3RoZXIgbGF5ZXIgd2hlcmUKLmR0YiBwYXRocyBtYXkgYmUgaGFyZGNvZGVkLCBkaXR0
byBmb3IgYXJtOyBhbmQgQXJtYWRhIHdhcyBhbiBleGFtcGxlCndoZXJlIHRoZSB1cHN0cmVhbSBi
aW5kaW5ncyBmb3IgdGhlIG5ldHdvcmsgSVAgY2hhbmdlZCBpbmNvbXBhdGlibHkuCgpEVCBvdmVy
bGF5cyBhcmUgYW5vdGhlciB0b3BpYyB0aGF0IGlzIG5vdCBtYWtpbmcgYW55IHByb2dyZXNzIHVw
c3RyZWFtCmFjY29yZGluZyB0byB0aGUgRUxDRSBCb0YsIHNvIGJleW9uZCB0aGUgUmFzcGJlcnJ5
IFBpIHRoZSBvbmx5IGtub3duCndvcmtpbmcgd2F5IHRvIGFwcGx5IHRoZW0gaXMgdG8gd3JpdGUg
YSBVLUJvb3QgYm9vdC5zY3Igc2NyaXB0LCB3aGljaApjYW4gZWl0aGVyIHJldXNlICRmZHRjb250
cm9sYWRkciBEVCBvciB1c2UgdGhlIGZpbGVuYW1lICRmZHRmaWxlIG9yCmhhcmRjb2RlIG9uZSwg
dGhlIGxhdHRlciB0d28gb2Ygd2hpY2ggd291bGQgYnJlYWsgd2l0aCB5b3VyIHJlbmFtaW5nLgoK
U28gZXhwZWN0IHBlb3BsZSB0byBiZSB1c2luZyAuZHRiIGZpbGVzLCBleHBlY3QgdGhlbSB0byBi
ZSBhZmZlY3RlZCBieQpmaWxlIG1vdmVtZW50cyB0byBzdWJkaXJlY3RvcmllcyBoZXJlLCBhbmQg
ZG9uJ3QgZXhwZWN0IGVhY2ggdXNlciB0bwp1bmRlcnN0YW5kIG9yIGJlIGFibGUgdG8gZml4IHRo
aW5ncyB0aGVtc2VsdmVzIGlmIHRoZXkgZmFsbCBhcGFydCBhcwpyZXN1bHQgb2YgeW91ciBjaGFu
Z2VzIGFuZCB0aGV5IHN1ZGRlbmx5IG5vIGxvbmdlciBoYXZlIEV0aGVybmV0L1dpZmkuCgpSZWdh
cmRzLApBbmRyZWFzCgotLSAKU1VTRSBMaW51eCBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcsIEdlcm1hbnkKR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwg
R3JhaGFtIE5vcnRvbgpIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
