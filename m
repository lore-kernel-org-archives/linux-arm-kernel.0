Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7855C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83482177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fvT3c7sR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83482177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ks5SkJfwzEcrgm0+E130ZK9uV0r/jojeG2CogmvvPWE=; b=fvT3c7sRusCEqg
	pgLFOh8/YSnpe5aRuSeBcCl9loyU1YxzsH4/llwVQ8eoYE190Enetb8Bh/hISSLF7wDy1JdCOskrq
	5zVC6+h2TRgDzOfIEuMKXrwkqLbqGwut4y1f+uizko2Ww0skBeYJ6+xYG5X3DALv6YSvQ7P1zVwWU
	lgcSLtXGcoJeKGEG+cbe5N4D0EnfIAo/UmiMsI8slQ8bHXRqWeGwsdRquQDbv8X6NpnKJ+KMvNLfa
	IDnfF1txMX/iIbcogSSFhkO3oPJQW61Dz//lqdzomRK0o05zQeFuhtPeq+lfHntvsVtYz6FTS6a4Y
	o5T20bwPmajfId+RnBjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqeB-0006Mt-Du; Mon, 18 Feb 2019 21:40:19 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqe8-0006LX-0V; Mon, 18 Feb 2019 21:40:18 +0000
Received: from oxbaltgw06.schlund.de ([172.19.246.12]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPoTl-1ghuQL42l9-00Mx23; Mon, 18 Feb 2019 22:40:10 +0100
Date: Mon, 18 Feb 2019 22:40:09 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
Message-ID: <2132367523.587775.1550526009519@email.ionos.de>
In-Reply-To: <d5b6ffaf-cf7a-22af-f2fc-c085897ef95f@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
 <2003821439.343814.1550437552156@email.ionos.de>
 <d5b6ffaf-cf7a-22af-f2fc-c085897ef95f@davidjohnsummers.uk>
Subject: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:f5h8Ym19bitzcERUIzspFW2xIoI06SyjlISYSzNyuElpPw9s/yg
 NfVCLp0K5wFbCYDu32VnCAQ5LYqDYU+xgGMbici7VVAkIVHn6Y6qvUjnwARsEtMSN706Ec1
 LP5WgjMCG1JAxXN4p0dZttCucuPqLXV7w0TFUufgPLb/nIokE1DqZjBajivcLwHeT9TX/Im
 vcILd1Zz+Fv5wE9jyY+3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LvwPnkPfUAE=:xqfdixVntCszdSIzm4IqpI
 ywDtLA2sh7ZNo+QESbLdKhmR3NllAwfizFQMccCCX+ExaRoTi3FpCC9wfpyIyP06pJJNgXH/t
 hX9kpp655ldpFVKKUuGMjkjIvkLPei8dCUKBa3pacaRrg/mFbFiFZc6sYkOUxVOjOe3Mtru9E
 jlRIB8d0FRT90PQaRQSi64JeTirF+MGsWfn9DITz5tlLkSD9UTVWqMUP/0sQjuDa4dO5R5hH0
 9qhT4MndgotizLSnwuY7PmdNxo/Mspw0WRSEpm6+/7e3O6ApdFrau+A4S00C4ZoY8onoJNNX/
 WsRDrKtC7rAG3R8F+fqbXk1XwTz/UjmW4DYl618SjtkB/UOKgKTeuYV+Rz2pUw+cJBirxXaD2
 O1GchDA7OrERrBk8BEYgVr2C8IJEpvuYIP085oRvmhpiaUMpuuGPEFBnrkrQjNDK0pKW3/K/k
 hbsVi2G5xYRIGmUCzmSWG85WficU6zi7qoPtdtVQgxtNrR1iG64oFeAnhfB3RqYGNPAasfhAs
 r9x8o++Hef7xaQH3zPNbNO7zzaoB6sOM13+9Jpvi6BNPJZyicA1b6b8/eqxmaX+fuPSTHz2Au
 c+X5GG4KuHmgqrGmtwlQXHwlXIfaHCycspyQWAI/iHjAJaS7Px6IjrqeGAgonsDtcjQ/jX7DN
 ENACvfuynstZ0M7AO/yKOb2mFsb14SKGCktLK5EqGig+wjSuQjrMtigZzwL0j6it4gO1uqgAf
 9pgvhSc23PUk0cFcOFnNgQkPnvX0Iik9Rv936X18w2NHRE950B293eCXEvE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_134016_357077_0085B6AC 
X-CRM114-Status: GOOD (  20.09  )
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
Cc: linux-rockchip@lists.infradead.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRGF2aWQsCgo+IERhdmlkIFN1bW1lcnMgPGJlYWdsZWJvYXJkQGRhdmlkam9obnN1bW1lcnMu
dWs+IGhhdCBhbSAxOC4gRmVicnVhciAyMDE5IHVtIDIxOjQ3IGdlc2NocmllYmVuOgo+IAo+IAo+
IE9uIDE3LzAyLzIwMTkgMjE6MDUsIFN0ZWZhbiBXYWhyZW4gd3JvdGU6Cj4gPiBIaSBEYXZpZCwK
PiA+Cj4gPj4gRGF2aWQgU3VtbWVycyA8YmVhZ2xlYm9hcmRAZGF2aWRqb2huc3VtbWVycy51az4g
aGF0IGFtIDE3LiBGZWJydWFyIDIwMTkgdW0gMTM6MTUgZ2VzY2hyaWViZW46Cj4gPj4KPiA+PiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9yazMyODgtdGlua2VyLmR0c2kKPiA+PiBAQCAtNDgxLDYg
KzQ4MSwxNyBAQAo+ID4+ICAgCj4gPj4gICAmdWFydDAgewo+ID4+ICAgCXN0YXR1cyA9ICJva2F5
IjsKPiA+PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gPj4gKwlwaW5jdHJsLTAgPSA8
JnVhcnQwX3hmZXI+LCA8JnVhcnQwX2N0cz4sIDwmdWFydDBfcnRzPjsKPiA+PiArCj4gPj4gKwli
bHVldG9vdGggewo+ID4+ICsJCWNsb2NrcyA9IDwmcms4MDggUks4MDhfQ0xLT1VUMT47Cj4gPiBB
cyB3ZSBhbHJlYWR5IGxpbmtlZCB0aGUgUks4MDggY2xvY2sgaW4gdGhlIHNkaW8gcHdyc2VxLCB3
ZSBzaG91bGRuJ3QgZG8gdGhpcyBoZXJlIGFnYWluLgo+ID4KPiA+PiArCQlyZXNldC1ncGlvcyA9
IDwmZ3BpbzQgUktfUEQ1IEdQSU9fQUNUSVZFX0xPVz47Cj4gPiByZXNldC1ncGlvcyBpc24ndCBj
b21wYXRpYmxlIHRvIGhjaV9oNSwgcGxlYXNlIHVzZSBteSBwcmVsaW1pbmFyeSBkdC1iaW5kaW5n
Cj4gPgo+ID4+ICsJCWRldmljZS13YWtlLWdwaW9zID0gPCZncGlvNCBSS19QRDIgR1BJT19BQ1RJ
VkVfSElHSD47Cj4gPj4gKwkJaG9zdC13YWtlLWdwaW9zID0gPCZncGlvNCBSS19QRDcgR1BJT19B
Q1RJVkVfSElHSD47Cj4gPiBBRkFJSyBoY2lfaDUgZG9lc24ndCBzdXBwb3J0IGhvc3Qtd2FrZSB5
ZXQuIFNvIGlmIHlvdSB3YW50IHRvIGtlZXAgZm9yIHRoZSBmdXR1cmUgd2Ugc2hvdWxkIG1ha2Ug
YSBjb21tZW50Lgo+ID4KPiA+PiArCQl2Y2MtMTgtc3VwcGx5ID0gPCZ2Y2NfMTg+Owo+ID4+ICsJ
CXZjYy1pby1zdXBwbHkgPSA8JnZjY19pbz47Cj4gPiBQbGVhc2UgZHJvcCB0aGVzZSBhcyB0aGUg
ZHJpdmVyIGRvZXNuJ3QgdXNlIGl0IGFuZCBpdCdzIGFscmVhZHkgbGlua2VkIGluIHRoZSBzZGlv
IHB3cnNlcS4KPiA+Cj4gPiBUaGFua3MgU3RlZmFuCj4gPgo+ID4+ICsJfTsKPiA+IFsxXSAtIGh0
dHBzOi8vZ2lzdC5naXRodWIuY29tL2xhdGVnb29kYnllLzc5YmFjOTlkNGYxMTU4YTcxOWE0OGVh
M2M0NWViN2YxI2ZpbGUtMDAwMi1kdC1iaW5kaW5ncy1hZGQtc3VwcG9ydC1mb3ItcmVhbHRlay1i
bHVldG9vdGgtc2VyaWFsLXBhdGNoCj4gCj4gU29ycnkgSSBkaXNhZ3JlZSBoZXJlLgo+IAo+IExh
c3QgdGltZSBJIHBvc3RlZCBhbiBleGFtcGxlIHBhdGNoIGxpa2UgdGhpcyByb2JoIHNhaWQgY2xl
YXJseSB0aGF0IAo+IHRoZXNlIHNob3VsZCBnaXZlIGNsb2NrcywgcG93ZXIsIGV0YzoKPiAKPiBo
dHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1ibHVldG9vdGgvbXNnNzg1NDUuaHRt
bAo+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWJsdWV0b290aC9tc2c3ODU4
NS5odG1sIAo+IDxodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1ibHVldG9vdGgv
bXNnNzg1ODUuaHRtbD4KPiAKPiBhbmQgYXMgaGUgaXMgbWFpbnRhaW5lciBoZSB3aW5zLgo+IAo+
IEkgY2FuIHVuZGVyc3RhbmQgUm9icyBwb3NpdGlvbiwgZGV2aWNlIHRyZWUgYXJlIGZvciBkZXNj
cmliaW5nIGhhcmR3YXJlLCAKPiB0aGV5IGFyZW4ndCBwcmltYXJpbHkgZm9yIGhlbHBpbmcgY29k
ZSB0byBsb2FkLiBZZXMgdGhhdCBpcyBhIHNlY29uZCAKPiBlZmZlY3QsIGl0cyBzbyBpdCBrbm93
cyB3aGF0IGlzIGluwqAgdGhlIGhhcmR3YXJlLiBJbiB0aGlzIGNhc2Ugd2hhdCBpZiAKPiBzb21l
b25lIHdhbnRlZCBCbHVldG9vdGgsIGJ1dCBub3QgV2lGaSAtIHRoZW4gdGhlIEJsdWV0b290aCBz
aG91bGQga25vdyAKPiB3aGF0IHBvd2VyIGFuZCBjbG9ja3MgYXJlIG5lZWRlZC4gTm93IHRoYXQg
dGhlIGRyaXZlciBkb2Vzbid0IHVuZGVyc3RhbmQgCj4gdGhlc2UgdGhpbmdzIGlzIHNlY29uZGFy
eS4gTWF5YmUgdGhhdCB3aWxsIGJlIGN1cmVkIGluIGZ1dHVyZT8KPgoKeW91IG5lZWQgdG8gY29u
c2lkZXIgdG8gY29udGV4dCBvZiB0aGUgZGlzY3Vzc2lvbi4gVGhlIGxpbmsgcG9pbnRlZCB0byBh
IGRpc2N1c3Npb24gYWJvdXQgdGhlIGR0LWJpbmRpbmcuIEEgYmluZGluZyBzaG91bGQgZGVzY3Jp
YmUgYWxsIHBhcnRzIChldmVuIG9wdGlvbmFsKSBvZiB0aGUgaGFyZHdhcmUgYW5kIHRoYXQgaXMg
dGhlIHJlYXNvbiB3aHkgaSBleHBsYWluZWQgaW4gQXJjaCBib2FyZCB0aGF0IHdlIG5lZWQgMyBw
YXJ0cyBmb3IgYmx1ZXRvb3RoIChkdC1iaW5kaW5nLCBkcml2ZXIgY2hhbmdlIGFuZCBmaW5hbGx5
IHRoZSBkdHMgY2hhbmdlKS4gU2luY2UgeW91IGF2b2lkIHRoYXQgYW5kIHNlbmQgb25seSB0aGUg
bGFzdCBwYXJ0IHdpdGhvdXQgY29tcGF0aWJsZXMgY2F1c2VzIGNvbmZ1c2lvbi4KCldlIHVzdWFs
bHkgZG9uJ3QgY2hhbmdlIERUUyBwcm9wZXJ0aWVzIGJlY2F1c2UgaXQncyBjb25zaWRlcmVkIGFz
IGFuIEFCSSwgd2hpY2ggbWVhbnMgd2Ugc2hvdWxkIGRvIGl0IHByb3Blcmx5IGluIHRoZSBmaXJz
dCBydW4uIFNvIGxldHMgbWFrZSB0aGUgc3RlcCBvbmUgKHRlc3QgYmx1ZXRvb3RoKSBhbmQgbm90
IHN0ZXAgZm91ciAuLi4KClJlZ2FyZHMKU3RlZmFuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
