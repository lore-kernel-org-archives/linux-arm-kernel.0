Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44700C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:32:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018A620645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jCP6YKaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018A620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRWSSXiJAew/r6y1kU/Drkog2m6n0lWbWrXu/sPYCXQ=; b=jCP6YKaYNzBcn3
	Nv6lQxh8e0kO3Ku9S5sZknht8GrxOyxfMp+TX8aomS6qClN+6zX0iEH6yRS3fVSCidz2INe2FeUDr
	Ap913EpLg4N6UMWTxpU/mvg7i7eAQf5rPiAG5i/wNUyOYjzFu4A197nkuTD7OacU8B0rJTRlqjRjk
	AIPACSBQZw3gqP6ruyIFmPe7VFv/bc1iAMIaW4DzUVbeO7YwnEBkpwDxyAWsZiBAEuVGyi9T4o3Ej
	T2cw5jzSUUlXKHVGA6go9FBnAnbjXaNpLkHS085Hv4AqRT4/ABFUOOJ56awY6nPLaP4N94xS3/Xdc
	S5WYHCcgP9/CHZl9mxNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXh1i-0006h0-S5; Fri, 14 Dec 2018 06:32:46 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXh1e-0006ez-3y; Fri, 14 Dec 2018 06:32:44 +0000
X-UUID: 04ba7c9394e94bc79d2980f6c84ff657-20181214
X-UUID: 04ba7c9394e94bc79d2980f6c84ff657-20181214
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <biao.huang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 39259241; Fri, 14 Dec 2018 14:32:18 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 14 Dec 2018 14:32:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 14:32:16 +0800
Message-ID: <1544769136.24219.175.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
From: biao huang <biao.huang@mediatek.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 14 Dec 2018 14:32:16 +0800
In-Reply-To: <f3427cac-88b2-1464-8f92-4692a7125674@gmail.com>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
 <20181213123346.GF1605@lunn.ch> <1544756477.24219.164.camel@mhfsdcap03>
 <f3427cac-88b2-1464-8f92-4692a7125674@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_223242_591813_E1E0A956 
X-CRM114-Status: GOOD (  23.24  )
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
Cc: mark.rutland@arm.com, Andrew Lunn <andrew@lunn.ch>,
 nelson.chang@mediatek.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 liguo.zhang@mediatek.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 yt.shen@mediatek.com, joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, matthias.bgg@gmail.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RGVhciBGbG9yaWFuLAoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLgoKT24gVGh1LCAyMDE4LTEy
LTEzIGF0IDIxOjExIC0wODAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+IExlIDEyLzEzLzE4
IMOgIDc6MDEgUE0sIGJpYW8gaHVhbmcgYSDDqWNyaXQgOgo+ID4gRGVhciBBbmRyZXcsCj4gPiAJ
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLgo+ID4gCj4gPiBPbiBUaHUsIDIwMTgtMTItMTMgYXQg
MTM6MzMgKzAxMDAsIEFuZHJldyBMdW5uIHdyb3RlOgo+ID4+IEhpIEJpYW8KPiA+Pgo+ID4+PiAr
CWNhc2UgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJOgo+ID4+PiArCQkvKiB0aGUgUEhZIGlzIG5v
dCByZXNwb25zaWJsZSBmb3IgaW5zZXJ0aW5nIGFueSBpbnRlcm5hbAo+ID4+PiArCQkgKiBkZWxh
eSBieSBpdHNlbGYgaW4gUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJIGNhc2UsCj4gPj4+ICsJCSAq
IHNvIEV0aGVybmV0IE1BQyB3aWxsIGluc2VydCBkZWxheXMgZm9yIGJvdGggdHJhbnNtaXQKPiA+
Pj4gKwkJICogYW5kIHJlY2VpdmUgcGF0aCBoZXJlLgo+ID4+PiArCQkgKi8KPiA+Pgo+ID4+IFdo
YXQgaWYgdGhlIFBDQiBkZXNpZ25lZCBoYXMgZGVjaWRlZCB0byBkbyBhIGtpbmsgaW4gdGhlIGNs
b2NrIHRvIGFkZAo+ID4+IHRoZSBkZWxheXM/IEkgZG9uJ3QgdGhpbmsgYW55IG9mIHRoZXNlIGRl
bGF5cyBzaG91bGQgZGVwZW5kIG9uIHRoZSBQSFkKPiA+PiBpbnRlcmZhY2UgbW9kZS4gSXQgaXMg
dXAgdG8gdGhlIGRldmljZSB0cmVlIHdyaXRlciB0byBzZXQgYm90aCB0aGUgUEhZCj4gPj4gZGVs
YXkgYW5kIHRoZSBNQUMgZGVsYXksIGJhc2VkIG9uIGtub3dsZWRnZSBvZiB0aGUgYm9hcmQsIGlu
Y2x1ZGluZwo+ID4+IGFueSBraWNrcyBpbiB0aGUgdHJhY2tzLiBUaGUgZHJpdmVyIHNob3VsZCB0
aGVuIGRvIHdoYXQgaXQgaXMgdG9sZC4KPiA+Pgo+ID4gT3JpZ2luYWxseSwgd2UgcmVjb21tZW5k
IGVxdWFsIHRyYWNlIGxlbmd0aCBvbiBQQ0IsIHdoaWNoIG1lYW5zIHRoYXQKPiA+IFJHTUlJIGRl
bGF5IGJ5IFBDQiB0cmFjZXMgaXMgbm90IHJlY29tbWVuZGVkLiBzbyBvbmx5IFBIWS9NQUMgZGVs
YXkgaXMKPiA+IHRha2VuIGludG8gYWNjb3VudCBpbiB0aGUgdHJhbnNtaXQvcmVjZWl2ZSBwYXRo
Lgo+ID4gCj4gPiBhcyB5b3UgZGVzY3JpYmVkIGFib3ZlLCBtYXliZSB0aGUgZXF1YWwgUENCIHRy
YWNlIGxlbmd0aCBhc3N1bXB0aW9uIGlzCj4gPiBub3QgcmVhc29uYWJsZSwgYW5kIHdlJ2xsIG9u
bHkgaGFuZGxlIE1BQyBkZWxheS1wcyBpbiBvdXIgZHJpdmVyIGJhc2VkCj4gPiBvbiB0aGUgZGV2
aWNlIHRyZWUgaW5mb3JtYXRpb24gbm8gbWF0dGVyIHdoaWNoIHJnbWlpIGlzIHNlbGVjdGVkLgo+
IAo+IEV4cGVjdGluZyBpZGVudGljYWwgUENCIHRyYWNlcyBpcyBzb21ldGhpbmcgdGhhdCBpcyBo
YXJkIHRvIGVuZm9yY2Ugd2l0aAo+IGV4dGVybmFsIGN1c3RvbWVycywgZm9yIGludGVybmFsIHJl
ZmVyZW5jZSBib2FyZHMsIGFic29sdXRlbHkgdGhleQo+IHNob3VsZCBoYXZlIHRob3NlIHRyYWNl
cyBvZiBlcXVhbCBsZW5ndGguCj4gCnllcywgd2UnbGwgc2V0IHRoZSBjb3JyZXNwb25kaW5nIHJl
Z2lzdGVyIGJhc2VkIG9uIHRoZQp0eC1kZWxheS1wcy9yeC1kZWxheS1wcyBpbiBkZXZpY2UgdHJl
ZSBmb3IgcmdtaWkgaW50ZXJmYWNlLgp0aGUgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJLy1SWElE
Ly1UWElELy1JRCBzaGFyZSB0aGUgc2FtZSBmbG93IGluCkV0aGVybmV0IGRyaXZlci4KCkEgbmV3
IHBhdGNoIHdpbGwgYmUgc2VudCB0byBmaXggdGhpcyBpc3N1ZS4KPiA+IAo+ID4gU2luY2UgRGF2
aWQgYWxyZWFkeSBhcHBsaWVkIHRoaXMgcGF0Y2gsIEknbGwgc2VuZCBhbm90aGVyIHBhdGNoIHRv
IGZpeAo+ID4gdGhpcyBpc3N1ZS4KPiA+Pj4gKwlpZiAoIW9mX3Byb3BlcnR5X3JlYWRfdTMyKHBs
YXQtPm5wLCAibWVkaWF0ZWssdHgtZGVsYXktcHMiLCAmdHhfZGVsYXlfcHMpKSB7Cj4gPj4+ICsJ
CWlmICh0eF9kZWxheV9wcyA8IHBsYXQtPnZhcmlhbnQtPnR4X2RlbGF5X21heCkgewo+ID4+PiAr
CQkJbWFjX2RlbGF5LT50eF9kZWxheSA9IHR4X2RlbGF5X3BzOwo+ID4+PiArCQl9IGVsc2Ugewo+
ID4+PiArCQkJZGV2X2VycihwbGF0LT5kZXYsICJJbnZhbGlkIFRYIGNsb2NrIGRlbGF5OiAlZHBz
XG4iLCB0eF9kZWxheV9wcyk7Cj4gPj4+ICsJCQlyZXR1cm4gLUVJTlZBTDsKPiA+Pj4gKwkJfQo+
ID4+PiArCX0KPiA+Pj4gKwo+ID4+PiArCWlmICghb2ZfcHJvcGVydHlfcmVhZF91MzIocGxhdC0+
bnAsICJtZWRpYXRlayxyeC1kZWxheS1wcyIsICZyeF9kZWxheV9wcykpIHsKPiA+Pj4gKwkJaWYg
KHJ4X2RlbGF5X3BzIDwgcGxhdC0+dmFyaWFudC0+cnhfZGVsYXlfbWF4KSB7Cj4gPj4+ICsJCQlt
YWNfZGVsYXktPnJ4X2RlbGF5ID0gcnhfZGVsYXlfcHM7Cj4gPj4+ICsJCX0gZWxzZSB7Cj4gPj4+
ICsJCQlkZXZfZXJyKHBsYXQtPmRldiwgIkludmFsaWQgUlggY2xvY2sgZGVsYXk6ICVkcHNcbiIs
IHJ4X2RlbGF5X3BzKTsKPiA+Pj4gKwkJCXJldHVybiAtRUlOVkFMOwo+ID4+PiArCQl9Cj4gPj4+
ICsJfQo+ID4+PiArCj4gPj4+ICsJbWFjX2RlbGF5LT50eF9pbnYgPSBvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2wocGxhdC0+bnAsICJtZWRpYXRlayx0eGMtaW52ZXJzZSIpOwo+ID4+PiArCW1hY19kZWxh
eS0+cnhfaW52ID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKHBsYXQtPm5wLCAibWVkaWF0ZWsscnhj
LWludmVyc2UiKTsKPiA+Pj4gKwltYWNfZGVsYXktPmZpbmVfdHVuZSA9IG9mX3Byb3BlcnR5X3Jl
YWRfYm9vbChwbGF0LT5ucCwgIm1lZGlhdGVrLGZpbmUtdHVuZSIpOwo+ID4+Cj4gPj4gV2h5IGlz
IGZpbmUgdHVuZSBuZWVkZWQ/IElmIHRoZSByZXF1ZXN0ZWQgZGVsYXkgY2FuIGJlIGRvbmUgdXNp
bmcgZmluZQo+ID4+IHR1bmUsIGl0IHNob3VsZCB1c2UgZmluZSB0dW5lLiBJZiBub3QsIGl0IHNo
b3VsZCB1c2Ugcm91Z2ggdHVuZS4gVGhlCj4gPj4gZHJpdmVyIGNhbiB3b3JrIHRoaXMgb3V0IGl0
c2VsZi4KPiA+IAo+ID4gZmluZCB0dW5lIGhlcmUgcmVwcmVzZW50cyBhIG1vcmUgYWNjdXJhdGUg
ZGVsYXkgY2lyY3VpdCB0aGFuIGNvYXJzZQo+ID4gdHVuZSwgYW5kIGl0J3MgYSBwYXJhbGxlbCBj
aXJjdWl0IG9mIGNvYXJzZSB0dW5lLgo+ID4gRm9yIG1vc3QgZGVsYXksIGJvdGggZmluZSBhbmQg
Y29hcnNlIHR1bmUgY2FuIG1lZXQgdGhlIHJlcXVpcmVtZW50Lgo+ID4gSXQncyB1cCB0byB0aGUg
dXNlciB0byBzZWxlY3Qgd2hpY2ggb25lLgo+ID4gCj4gPiBCdXQgb25seSBvbmUgb2YgdGhlbSBj
YW4gd29yayBhdCB0aGUgc2FtZSB0aW1lLCBzbyB3ZSBuZWVkIGEgc3dpdGNoCj4gPiBmbGFnKGZp
bmVfdHVuZSBoZXJlKSB0byBpbmRpY2F0ZSB3aGljaCBvbmUgaXMgdmFsaWQuCj4gPiBEcml2ZXIg
Y2FuIGhhcmRseSB3b3JrIG91dCB3aGljaCBvbmUgaXMgd29ya2luZyBhY2NvcmRpbmcgdG8gZGVs
YXktcHMuCj4gPiAKPiA+IFBsZWFzZSBjb3JyZWN0IG1lIGlmIGFueSBtaXN1bmRlcnN0YW5kaW5n
Lgo+IAo+IFlvdSBhcmUgZ2l2aW5nIGEgbG90IG9mIG9wdGlvbnMgZm9yIHVzZXJzIG9mIHRoaXMg
RXRoZXJuZXQgY29udHJvbGxlciB0bwo+IHNob290IHRoZW1zZWx2ZXMgaW4gdGhlIGZlZXQgYW5k
IHNwZW5kIGEgZ29vZCBhbW91bnQgb2YgdGltZSBkZWJ1Z2dpbmcKPiB3aHkgdGhlaXIgUkdNSUkg
Y29ubmVjdGlvbiBpcyBub3QgcmVsaWFibGUgb3IgaGF2ZSB0aW1pbmcgdmlvbGF0aW9ucy4KeWVz
LCBzaW5jZSBmaW5lIHR1bmUgaXMgbW9yZSBhY2N1cmF0ZSwgYW5kIGNhbiBtZWV0IGN1c3RvbWVy
J3MKcmVxdWlyZW1lbnQsIHdlJ2xsIHJlbW92ZSB0aGUgJ2ZpbmUtdHVuZScgcHJvcGVydHkgaW4g
ZGV2aWNlIHRyZWUsCmVuYWJsZSBmaW5lLXR1bmUgY2lyY3VpdCBieSBkZWZhdWx0IGluIEV0aGVy
bmV0IGRyaXZlciwgYW5kIGFiYW5kb24gdGhlCmNvYXJzZSBkZWxheSBtZWNoYW5pc20uIHNvIGN1
c3RvbWVyIHdpbGwgbm90IGJlIGNvbmZ1c2VkIGJ5IHRoZSBvcHRpb25zLgoKSSdsbCBzZW5kIGEg
bmV3IHBhdGNoIHRvIGZpeCB0aGlzIGlzc3VlLgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
