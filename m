Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B42C20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AzhHRrij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B42C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A6duUAUcJxf4wxX0qfx0zYRsxMKp15ZSXMekl+pKp5g=; b=AzhHRrij9IZYX/
	1jqJwndvZXIjMpW+Y7h8g9vrXBXl9LpYvAuHtVdsNpw7BgJeTtWm1EUYde0y1zKLtS7LSNjPwMecx
	xtEhthLw3PGzl/C6jLTyW3r+N1PhRYO5LqtvLBotdtkOm9B4+yAIZZySVkN1BrdblM7NRTTsPMu2V
	MzZJvbz+H0U/uIYnBlSBZzspe5U9SaGPbso6I+zSaV3CfJypqvWrqc1S9enYeKEBybzDAzEynhniL
	g9XDemmA8aBapDFS83gCm7ST7IJo5oqD9LMhXLyNh8Qn6RRqk1X2AaAyvLdMFlxes+5m6loBZz9eB
	cbnCo/h9A2zfCvYGQIxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqrZ-0006oS-BQ; Mon, 03 Dec 2018 16:14:25 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqrW-0006ne-0V
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:14:23 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3F01613F8D2;
 Mon,  3 Dec 2018 17:13:53 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
To: Jeffrey Hugo <jhugo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
 <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
 <8b697e3b-6cb5-41ea-cd56-94c54082c58b@free.fr>
 <e1b8ed92-c310-97ed-c1bd-5b90af76b3a0@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <0dd4dfa9-5c54-702a-c830-a9f4eba2bcc9@free.fr>
Date: Mon, 3 Dec 2018 17:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e1b8ed92-c310-97ed-c1bd-5b90af76b3a0@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_081422_228731_BFF3ED8D 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDMvMTIvMjAxOCAxNzowMywgSmVmZnJleSBIdWdvIHdyb3RlOgoKPiBPbiAxMi8zLzIwMTgg
ODo1MyBBTSwgTWFyYyBHb256YWxleiB3cm90ZToKPgo+PiBPbiAwMy8xMi8yMDE4IDE2OjQ3LCBK
ZWZmcmV5IEh1Z28gd3JvdGU6Cj4+Cj4+PiBPbiAxMi8zLzIwMTggODoyNyBBTSwgSmVmZnJleSBI
dWdvIHdyb3RlOgo+Pj4KPj4+PiBPbiAxMi8zLzIwMTggODoxOCBBTSwgTWFyYyBHb256YWxleiB3
cm90ZToKPj4+Pgo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdWZzcGh5OiBwaHlAMWRhNzAwMCB7Cj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAicWNvbSxzZG04NDUtcW1w
LXVmcy1waHkiOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxZGE3MDAw
IDB4MThjPjsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDE+Owo+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5nZXM7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNsb2NrLW5hbWVzID0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAicmVmX2Nsa19zcmMiLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJy
ZWZfY2xrIiwKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicmVmX2F1eF9j
bGsiOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPQo+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmcnBtY2MgMD4sCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgPCZnY2MgR0NDX1VGU19DTEtSRUZfQ0xLPiwKPj4+Cj4+PiBBbHNv
LCAiR0NDX1VGU19DTEtSRUZfQ0xLIiBpcyBub3QgZGVmaW5lZCBpbgo+Pj4gaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9xY29tLGdjYy1tc204OTk4Lmggd2hpY2ggaXMgcHJvYmFibHkgdGhlIGNh
dXNlCj4+PiBvZiB5b3VyIC0yIGVycm9yIGxpc3RlZCBhYm92ZS4KPj4KPj4gSWYgaXQgd2VyZSB1
bmRlZmluZWQsIGR0YyB3b3VsZCBoYXZlIGtpY2tlZCBtZSBpbiB0aGUgbmFkcyA6LSkKPj4KPj4g
JCBnaXQgZ3JlcCBHQ0NfVUZTX0NMS1JFRl9DTEsgaW5jbHVkZQo+PiBpbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL3Fjb20sZ2NjLW1zbTg5OTYuaDojZGVmaW5lIEdDQ19VRlNfQ0xLUkVGX0NMSyAg
ICAgICAgMjE1Cj4+IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svcWNvbSxnY2MtbXNtODk5OC5o
OiNkZWZpbmUgR0NDX1VGU19DTEtSRUZfQ0xLICAgICAgICAxNjgKPiAKPiBOb3QgcHJlc2VudCBp
biB2NC4yMC1yYzUgbm9yIGxpbnV4LW5leHQuICBEaWQgeW91IGFkZCB0aGlzIHlvdXJzZWxmPyAg
SWYgCj4gc28sIGRpZCB5b3UgYWxzbyB1cGRhdGUgdGhlIGRyaXZlcj8KCllvdSdyZSByaWdodC4g
SSBhcHBsaWVkIEJqb3JuJ3MgcGF0Y2ggc2VyaWVzLgpbUEFUQ0ggMC8zXSBjbGs6IHFjb206IGdj
Yy1tc204OTk4OiBGaXhlcyBhbmQgY2xrcmVmIGNsb2NrcwoKUmVnYXJkcy4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
