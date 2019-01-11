Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:13:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700A52146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rxSv5QXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700A52146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UBHNBm8h01kSj2PGOsiDSgwLV0zLjd1BqoeqAwVqFtA=; b=rxSv5QXT0j8+0u
	yKOuV2hDcctr37OIEJ3XLMdPq2HYOgy3Q1ktNIYBWJrteXuWuAiU/X50JIO6GDxknK8Z1oPnHY2Db
	OY51ZcyPiHlbegOEMLAisqJlT+Nlg2e8VdBYtdk8JSaDqKolT9TbYJfZKBZMm59Sd7qFKvidRfsec
	MpWB5lhwM6tjgBjGlbbRAvBzb3P6t932qvbq+bcmYC1HgDcWJcKUptfgWFR3KpjLHvsxBYTSZgDKB
	ptfCvjCPs2JmA5qJzVogC30FyASadCsPt7lUz6TwAp+ONQVddSxYHRvEk9QV3Sf7rinA0bC7b1PNm
	/gUlUF4nWnqZG6cjabFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtp4-0001e4-Uc; Fri, 11 Jan 2019 10:13:54 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtp0-0001cp-Jp; Fri, 11 Jan 2019 10:13:52 +0000
Received: by mail-wr1-f66.google.com with SMTP id r10so14529292wrs.10;
 Fri, 11 Jan 2019 02:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=OePOV6n/Kmg9WhJzcGlyqkLo6gzzRwfvOj4eo4aEWm8=;
 b=IXYVbP5KXjC5zVFnAfX6iR4KarLGC6w7FlZo2v6tygZ0HMTQUE8N7J67Gj9eyyk24F
 g/SHIwi9FlPMndF/KYEe/NgzqgiZCI1CXFjDhU9SC30xpYjWxLbj1vSG0fMcMiAXHFqo
 xVKPBPedEBQnBIjEREWFsolr94csLdJ1pjX4c45nsg6Uruvbq1X1HqbfPfRiXWR7CSEN
 V60QoAOOczjfU3sCNZ6P2v7d9SaZEjNstMIrgEvwtwd4zUARFsdd1eBaao/B4FkbHRyh
 26aDMZ1h26amJtAcmUIbB3bIkd6HVLEmO9Z+xs9cyJK6kIJAxFKkLM2Z7870hmUjJ6o2
 gyVg==
X-Gm-Message-State: AJcUukdSmP2HvPRmGwunJR5LYOGmmivRkm3wbojiOTdNI7ZQkyBEWVz+
 rFDy0cQc8GG1BfIsdWxoFWA=
X-Google-Smtp-Source: ALg8bN5ruiul8+7DhD+ryOEoZYxY+0P9U33hOFuaJ9izgVtdXQqfmyZi7/dE+8IjveQ9cx8sCm/FmA==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr13264491wrs.272.1547201628803; 
 Fri, 11 Jan 2019 02:13:48 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id b7sm55299188wrs.47.2019.01.11.02.13.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 02:13:48 -0800 (PST)
Date: Fri, 11 Jan 2019 11:13:46 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 2/2] ARM: dts: meson8b: fix the Ethernet data line
 signals in eth_rgmii_pins
Message-ID: <20190111101315.GA2461@ingrassia.epigenesys.com>
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-3-martin.blumenstingl@googlemail.com>
 <7hwoncov8k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hwoncov8k.fsf@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_021350_655958_26840354 
X-CRM114-Status: GOOD (  17.74  )
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
Cc: linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKYW4gMTAsIDIwMTkgYXQgMDU6MDk6NDdQTSAtMDgwMCwgS2V2aW4gSGlsbWFuIHdy
b3RlOgo+IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFp
bC5jb20+IHdyaXRlczoKPgo+ID4gQWNjb3JkaW5nIHRvIHRoZSBPZHJvaWQtQzErIHNjaGVtYXRp
Y3MgdGhlIEV0aGVybmV0IFRYRDEgc2lnbmFsIGlzCj4gPiByb3V0ZWQgdG8gR1BJT0hfNSBhbmQg
dGhlIFRYRDAgc2lnbmFsIGlzIHJvdXRlZCB0byBHUElPSF82Lgo+ID4gVGhlIHB1YmxpYyBTODA1
IGRhdGFzaGVldCBzaG93cyB0aGF0IFRYRDAgY2FuIGJlIHJvdXRlZCB0byBESUZfMl9QIGFuZAo+
ID4gVFhEMSBjYW4gYmUgcm91dGVkIHRvIERJRl8yX04gaW5zdGVhZC4KPiA+Cj4gPiBUaGUgcGlu
IGdyb3VwcyBldGhfdHhkMF8wIChHUElPSF82KSBhbmQgZXRoX3R4ZDBfMSAoRElGXzJfUCkgYXJl
IGJvdGgKPiA+IGNvbmZpZ3VyZWQgYXMgRXRoZXJuZXQgVFhEMCBhbmQgVFhEMSBkYXRhIGxpbmVz
IGluIG1lc29uOGIuZHRzaS4gQXQgdGhlCj4gPiBzYW1lIHRpbWUgZXRoX3R4ZDFfMCAoR1BJT0hf
NSkgYW5kIGV0aF90eGQxXzEgKERJRl8yX04pIGFyZSBjb25maWd1cmVkCj4gPiBhcyBUWEQwIGFu
ZCBUWEQxIGRhdGEgbGluZXMgYXMgd2VsbC4KPiA+IFRoaXMgcmVzdWx0cyBpbiBhIGJhZCBFdGhl
cm5ldCByZWNlaXZlIHBlcmZvcm1hbmNlLiBQcmVzdW1hYmx5IHRoaXMgaXMKPiA+IGR1ZSB0byB0
aGUgZXRoX3R4ZDAgYW5kIGV0aF90eGQxIHNpZ25hbCBiZWluZyByb3V0ZWQgdG8gdGhlIHdyb25n
IHBpbnMuCj4gPiBBcyBhIHJlc3VsdCBvZiB0aGF0IGRhdGEgY2FuIG9ubHkgYmUgdHJhbnNtaXR0
ZWQgb24gZXRoX3R4ZDIgYW5kCj4gPiBldGhfdHhkMy4gSG93ZXZlciwgSSBoYXZlIG5vIHNjb3Bl
IHRvIGZ1bGx5IGNvbmZpcm0gdGhpcyBhc3N1bXB0aW9uLgo+ID4KPiA+IFRoZSB2ZW5kb3IgdS1i
b290IHNvdXJjZXMgZm9yIE9kcm9pZC1DMSB1c2UgdGhlIGZvbGxvd2luZyBFdGhlcm5ldAo+ID4g
cGlubXV4IGNvbmZpZ3VyYXRpb246Cj4gPiAgIFNFVF9DQlVTX1JFR19NQVNLKFBFUklQSFNfUElO
X01VWF82LCAweDNmNGYpOwo+ID4gICBTRVRfQ0JVU19SRUdfTUFTSyhQRVJJUEhTX1BJTl9NVVhf
NywgMHhmMDAwMDApOwo+ID4gVGhpcyB0cmFuc2xhdGVzIHRvIHRoZSBmb2xsb3dpbmcgcGluIGdy
b3VwcyBpbiB0aGUgbWFpbmxpbmUga2VybmVsOgo+ID4gLSByZWdpc3RlciA2IGJpdCAgMDogZXRo
X3J4ZDEgKERJRl8wX1ApCj4gPiAtIHJlZ2lzdGVyIDYgYml0ICAxOiBldGhfcnhkMCAoRElGXzBf
TikKPiA+IC0gcmVnaXN0ZXIgNiBiaXQgIDI6IGV0aF9yeF9kdiAoRElGXzFfUCkKPiA+IC0gcmVn
aXN0ZXIgNiBiaXQgIDM6IGV0aF9yeF9jbGsgKERJRl8xX04pCj4gPiAtIHJlZ2lzdGVyIDYgYml0
ICA2OiBldGhfdHhfZW4gKERJRl8zX1ApCj4gPiAtIHJlZ2lzdGVyIDYgYml0ICA4OiBldGhfcmVm
X2NsayAoRElGXzNfTikKPiA+IC0gcmVnaXN0ZXIgNiBiaXQgIDk6IGV0aF9tZGMgKERJRl80X1Ap
Cj4gPiAtIHJlZ2lzdGVyIDYgYml0IDEwOiBldGhfbWRpb19lbiAoRElGXzRfTikKPiA+IC0gcmVn
aXN0ZXIgNiBiaXQgMTE6IGV0aF90eF9jbGsgKEdQSU9IXzkpCj4gPiAtIHJlZ2lzdGVyIDYgYml0
IDEyOiBldGhfdHhkMiAoR1BJT0hfOCkKPiA+IC0gcmVnaXN0ZXIgNiBiaXQgMTM6IGV0aF90eGQz
IChHUElPSF83KQo+ID4gLSByZWdpc3RlciA3IGJpdCAyMDogZXRoX3R4ZDBfMCAoR1BJT0hfNikK
PiA+IC0gcmVnaXN0ZXIgNyBiaXQgMjE6IGV0aF90eGQxXzAgKEdQSU9IXzUpCj4gPiAtIHJlZ2lz
dGVyIDcgYml0IDIyOiBldGhfcnhkMyAoRElGXzJfUCkKPiA+IC0gcmVnaXN0ZXIgNyBiaXQgMjM6
IGV0aF9yeGQyIChESUZfMl9OKQo+ID4KPiA+IERyb3AgdGhlIGV0aF90eGQwXzEgYW5kIGV0aF90
eGQxXzEgZ3JvdXBzIGZyb20gZXRoX3JnbWlpX3BpbnMgdG8gZml4IHRoZQo+ID4gRXRoZXJuZXQg
dHJhbnNtaXQgcGVyZm9ybWFuY2Ugb24gT2Ryb2lkLUMxLiBBbHNvIGFkZCB0aGUgZXRoX3J4ZDIg
YW5kCj4gPiBldGhfcnhkMyBncm91cHMgc28gd2UgZG9uJ3QgcmVseSBvbiB0aGUgYm9vdGxvYWRl
ciB0byBzZXQgdGhlbSB1cC4KPiA+Cj4gPiBpcGVyZjMgc3RhdGlzdGljcyBiZWZvcmUgdGhpcyBj
aGFuZ2U6Cj4gPiAtIHRyYW5zbWl0dGluZyBmcm9tIE9kcm9pZC1DMTogNzQxIE1iaXRzL3NlYyAo
MCByZXRyaWVzKQo+ID4gLSByZWNlaXZpbmcgb24gT2Ryb2lkLUMxOiAxOTkgTWJpdHMvc2VjICgx
NzEzIHJldHJpZXMpCj4gPgo+ID4gaXBlcmYzIHN0YXRpc3RpY3MgYWZ0ZXIgdGhpcyBjaGFuZ2U6
Cj4gPiAtIHRyYW5zbWl0dGluZyBmcm9tIE9kcm9pZC1DMTogNjY3IE1iaXRzL3NlYyAoMCByZXRy
aWVzKQo+ID4gLSByZWNlaXZpbmcgb24gT2Ryb2lkLUMxOiA3NTAgTWJpdHMvc2VjICgwIHJldHJp
ZXMpCj4gPgo+ID4gRml4ZXM6IGI5NjQ0NjU0MWQ4MzkwICgiQVJNOiBkdHM6IG1lc29uOGI6IGV4
dGVuZCBldGhlcm5ldCBjb250cm9sbGVyIGRlc2NyaXB0aW9uIikKPiA+IFNpZ25lZC1vZmYtYnk6
IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+
Cj4gPiBDYzogRW1pbGlhbm8gSW5ncmFzc2lhIDxpbmdyYXNzaWFAZXBpZ2VuZXN5cy5jb20+Cj4g
PiBDYzogTGludXMgTMO8c3NpbmcgPGxpbnVzLmx1ZXNzaW5nQGMwZDMuYmx1ZT4KPgo+IFF1ZXVl
ZCBmb3IgdjUuMSAoYnJhbmNoOiB2NS4xL2R0KQo+Cj4gS2V2aW4KClRlc3RlZC1ieTogRW1pbGlh
bm8gSW5ncmFzc2lhIDxpbmdyYXNzaWFAZXBpZ2VuZXN5cy5jb20+ClJldmlld2VkLWJ5OiBFbWls
aWFubyBJbmdyYXNzaWEgPGluZ3Jhc3NpYUBlcGlnZW5lc3lzLmNvbT4KCkVtaWxpYW5vCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
