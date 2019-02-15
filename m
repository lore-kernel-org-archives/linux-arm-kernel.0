Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F20C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:43:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834F52192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZSN1is8e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UV9ANtBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834F52192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eIW1ocRPWMD9FWCeJLqyPXVJAG/1ZVgrkCzo3RhmcHk=; b=ZSN1is8eT0wB+M
	fRG6mhGp+d00NCzMUvhxOBVWjP/l3xiwEAABBsD5gOEyWvWncfkSN98uRD0FD1qZOL/5vKRPfk5ys
	J9kFh6PuiosN19ytI6jAwAhIdDUAGXj2IqgPSJ1zZfYcVltY5KJGxFiBSQckHKcHE8hqW5k7kheqg
	WK9T93RASTXs3gAXyrG5P+c6vI35+/d09+eqwy5zWfodiuipLaeW61U3mmaiqqWsS4h0KP+5g0icY
	wEVTNThg35oo96PqbeAtldpoei4zHMY0+ZNM4xbihO+CQGQb1UyRqmuaV0uObjlJP0uX5pDDgrpk0
	d7Fe7SrH46IEr4vGd5zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufeF-0007Y6-Oi; Fri, 15 Feb 2019 15:43:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufeE-0007Xz-Hc
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 15:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5iavRaY0ej58OPVrhQnyVCnPHw93N0uwciAT+OOEzEk=; b=UV9ANtBiTGriDvM9TYS/XK6aoe
 h6v+Ch6C9/NgXVOvxY5jCk3gH5MGlBjIp+H1EzzzJirxW7A1ImWXLVsNcPWTXN35Ch5j4ucfDaiCD
 tGXnlId5FZDBwNNwfWEI0h3tjNhR92diM6qggyJEWA3onNWM3umRDc++sW8iVPb4OQlmY+WGh/ME+
 WdHj0mkjKj3MolVNCyLTfDXuMbRBvlUJOo38ooNn1J5W5fQCtXtdcTBBlwDIHR1d7y50wSGj4FaNs
 RuE8BWOWscl8pIRCOrN228gn4utzT/77hHQzRU0g5/arnrieskjX+oq21jC9KKKnzIPqusDwf0Qo/
 jUjhV2Ag==;
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufeA-0008HH-Js
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:43:28 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B599260008;
 Fri, 15 Feb 2019 15:42:55 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/5] iio:adc:lpc32xx Cleanup headers
In-Reply-To: <20190209171646.49c75afc@archlinux>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-5-gregory.clement@bootlin.com>
 <20190209171646.49c75afc@archlinux>
Date: Fri, 15 Feb 2019 16:42:55 +0100
Message-ID: <87r2c92h34.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_154326_681601_58B5F1F7 
X-CRM114-Status: GOOD (  22.03  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSm9uYXRoYW4sCiAKIE9uIHNhbS4sIGbDqXZyLiAwOSAyMDE5LCBKb25hdGhhbiBDYW1lcm9u
IDxqaWMyM0BrZXJuZWwub3JnPiB3cm90ZToKCj4gT24gRnJpLCAgOCBGZWIgMjAxOSAxNzowOTo0
MyArMDEwMAo+IEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPiB3
cm90ZToKPgo+PiBBIGZldyBoZWFkZXJzIHdhcyB1c2VsZXNzOiByZW1vdmUgdGhlbSwgYW5kIGFs
c28gc29ydCB0aGVtIGluIGFscGhhYmV0aWMKPj4gb3JkZXIuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5
OiBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290bGluLmNvbT4KPiBIbW0uIEdp
dmVuIHRoZSBoZWFkZXJzIGluIHF1ZXN0aW9uIGFyZSBtb3N0bHkgb25seSB1c2VsZXNzIChJIHRo
aW5rKQo+IGluIHRoZSBzZW5zZSB0aGV5IGFyZSBhbHdheXMgaW5jbHVkZWQgYnkgc29tZXRoaW5n
IGVsc2UsIEknbQo+IG5vdCBzdXJlIHRoaXMgcGF0Y2ggaXMgd29ydGggdGhlIGNodXJuLgo+Cj4g
SXQncyBhbHNvIHRyaWNreSB0byBzZWUgd2hpY2ggb25lcyB3ZXJlIGFjdHVhbGx5IHJlbW92ZWQK
PiBnaXZlbiB0aGUgY29tYmluYXRpb24gd2l0aCBzb3J0aW5nLgo+IEkgdGhpbmsgaXQncyBqdXN0
IGtlcm5lbC5oLCBkZXZpY2UuaCwgZXJyLmggYWxsIG9mIHdoaWNoCj4gYXJlIHVzZWQgaW4gdmFy
aW91cyB3YXlzIGFuZCBvZnRlbiBkaXJlY3RseSBpbmNsdWRlZC4KCkFjdHVhbGx5LCBhcyBJIG5l
ZWRlZCB0byBhZGQgYSBoZWFkZXIsIEkgd2FudGVkIHRvIHNvcnQgdGhlIGxpc3QgdG8gcHV0Cml0
IGluIHRoZSByaWdodCBwbGFjZSBhbmQgdGhlbiBzb21lIG9mIHRoZSBoZWFkZXIgbG9va2VkIHN1
cGVyZmx1b3VzCnRoYXQgd2h5IEkgcmVtb3ZlIHNvbWUgb2YgdGhlbS4gRm9yIGV4YW1wbGUgdGhl
cmUgd2FzIG5vIHJlYXNvbiB0byB1c2UKc2xhYi5oIG9yIG9mLmguCgo+Cj4gVGhlIG90aGVyIG9u
ZSBpcyB0aGUgaWlvL3N5c2ZzLmggZmlsZS4gIFRoYXQgb25lIHdlIGNvdWxkCj4gZG8gdG8gZXZl
bnR1YWxseSBraWxsIG9mZiBlbnRpcmVseSwgc28gaGFwcHkgdG8gc2VlIHRoYXQKPiBvbmUgYWxv
bmUgZ28uCgpJIGFtIG5pdCBzdXJlIHRvIGtub3cgd2hhdCBkbyB5b3Ugd2FudCB3aXRoIHRoaXMg
cGF0Y2guCgpHcmVnb3J5CgoKPgo+IEpvbmF0aGFuCj4KPj4gLS0tCj4+ICBkcml2ZXJzL2lpby9h
ZGMvbHBjMzJ4eF9hZGMuYyB8IDE1ICsrKystLS0tLS0tLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWRjL2xwYzMyeHhfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvbHBjMzJ4eF9hZGMu
Ywo+PiBpbmRleCBlMzYxYzE1MzJhNzUuLmYzOTFjMWUxMDEzNiAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9paW8vYWRjL2xwYzMyeHhfYWRjLmMKPj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2xwYzMy
eHhfYWRjLmMKPj4gQEAgLTcsMjAgKzcsMTMgQEAKPj4gICAqICBDb3B5cmlnaHQgKEMpIDIwMTEs
IDIwMTIgUm9sYW5kIFN0aWdnZSA8c3RpZ2dlQGFudGNvbS5kZT4KPj4gICAqLwo+PiAgCj4+IC0j
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4+IC0jaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+Cj4+IC0jaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4+IC0jaW5jbHVkZSA8bGlu
dXgvZGV2aWNlLmg+Cj4+IC0jaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4+IC0jaW5jbHVkZSA8
bGludXgvc2xhYi5oPgo+PiAtI2luY2x1ZGUgPGxpbnV4L2lvLmg+Cj4+ICAjaW5jbHVkZSA8bGlu
dXgvY2xrLmg+Cj4+IC0jaW5jbHVkZSA8bGludXgvZXJyLmg+Cj4+ICAjaW5jbHVkZSA8bGludXgv
Y29tcGxldGlvbi5oPgo+PiAtI2luY2x1ZGUgPGxpbnV4L29mLmg+Cj4+IC0KPj4gICNpbmNsdWRl
IDxsaW51eC9paW8vaWlvLmg+Cj4+IC0jaW5jbHVkZSA8bGludXgvaWlvL3N5c2ZzLmg+Cj4+ICsj
aW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4KPj4g
KyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4KPj4gIAo+PiAgLyoKPj4gICAqIExQQzMyWFggcmVnaXN0ZXJzIGRlZmluaXRpb25z
Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwKCi0tIApHcmVnb3J5IENsZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQg
TGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwOi8vYm9vdGxpbi5jb20KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
