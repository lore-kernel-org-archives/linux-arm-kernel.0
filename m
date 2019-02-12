Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A7FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7378E2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oGt3Ww0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7378E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pk1l6rQzlObS0GdGtDDR7xjsa50eVuZ5/+4vn/EtAYI=; b=oGt3Ww0rZiWgvX
	Dt+40ug08OG3av+JRdRCAYlszYbGb19y8OgLD9PBxLmED6R11MJav3/LfhDXMcwJV6MjKy5IPwE4g
	CiQJLuLJUSptdDDcZDEoVBIaYpriAIFWdzfPXln7jjH4WjeLeBctjvbo4R/htAdnDq3ZBttTOEJ5b
	cdcMu448wL1B3cobcpcDtQtlkGJpq4kRUYOPRYTCosuhe6i9wO9aptz6vtbrPHzUjzwpnbqXC5aJe
	J0iCHaeaGpDGsI9UyaBm+hKHRlhyqxu3oM89yO/tJIADJM7LNRpV88VbSI5F0HIehI3mFxO04kQcu
	IKd+/EZoMaXC62KE69YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUhr-0006JD-Pq; Tue, 12 Feb 2019 09:50:23 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUhn-0006I1-I0; Tue, 12 Feb 2019 09:50:21 +0000
X-UUID: 19f53d49de9441868bd34b84aee59644-20190212
X-UUID: 19f53d49de9441868bd34b84aee59644-20190212
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 136427946; Tue, 12 Feb 2019 01:50:10 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 01:50:08 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 17:50:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 17:50:00 +0800
Message-ID: <1549965000.29488.4.camel@mtksdccf07>
Subject: Re: [RFC PATCH V0 3/7] [media] dt-bindings: mt8183: Added DIP-SMEM
 dt-bindings
From: Frederic Chen <frederic.chen@mediatek.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sakari Ailus
 <sakari.ailus@iki.fi>
Date: Tue, 12 Feb 2019 17:50:00 +0800
In-Reply-To: <20190209182034.GC4505@pendragon.ideasonboard.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
 <1549020091-42064-4-git-send-email-frederic.chen@mediatek.com>
 <20190209155935.afrrtf3twjmj23sm@valkosipuli.retiisi.org.uk>
 <20190209182034.GC4505@pendragon.ideasonboard.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_015019_601352_D806526B 
X-CRM114-Status: GOOD (  23.34  )
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
Cc: devicetree@vger.kernel.org, Sean.Cheng@mediatek.com,
 laurent.pinchart+renesas@ideasonboard.com, Rynn.Wu@mediatek.com,
 christie.yu@mediatek.com, srv_heupstream@mediatek.com,
 holmes.chiou@mediatek.com, Jerry-ch.Chen@mediatek.com, tfiga@chromium.org,
 jungo.lin@mediatek.com, sj.huang@mediatek.com, hans.verkuil@cisco.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RGVhciBMYXVyZW50IGFuZCBTYWthcmksCgoKT24gU2F0LCAyMDE5LTAyLTA5IGF0IDIwOjIwICsw
MjAwLCBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOgo+IEhlbGxvIEZyZWRlcmljLAo+IAo+IE9uIFNh
dCwgRmViIDA5LCAyMDE5IGF0IDA1OjU5OjM1UE0gKzAyMDAsIFNha2FyaSBBaWx1cyB3cm90ZToK
PiA+IEhpIEZyZWRlcmljLAo+ID4gCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaHNldC4KPiA+IAo+
ID4gQ291bGQgeW91IGFsc28gY2MgdGhlIGRldmljZXRyZWUgbGlzdCwgcGxlYXNlPwo+ID4gCj4g
PiBPbiBGcmksIEZlYiAwMSwgMjAxOSBhdCAwNzoyMToyN1BNICswODAwLCBGcmVkZXJpYyBDaGVu
IHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlv
biBmb3IgdGhlIHNoYXJlZCBtZW1vcnkKPiA+ID4gYmV0d2VlbiBESVAgKERpZ2l0YWwgSW1hZ2Ug
UHJvY2Vzc2luZykgdW5pdCBvZiB0aGUgY2FtZXJhIElTUCBzeXN0ZW0KPiA+ID4gYW5kIHRoZSBj
by1wcm9jZXNzb3IgaW4gTWVkaWF0ZWsgU29Dcy4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IEZyZWRlcmljIENoZW4gPGZyZWRlcmljLmNoZW5AbWVkaWF0ZWsuY29tPgo+ID4gPiAtLS0KPiA+
ID4gIC4uLi9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxkaXBfc21lbS50eHQgICAgICAgICAgIHwg
MjkgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2Vy
dGlvbnMoKykKPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssZGlwX3NtZW0udHh0Cj4gPiA+IAo+ID4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVr
LGRpcF9zbWVtLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9t
ZWRpYXRlayxkaXBfc21lbS50eHQKPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gaW5k
ZXggMDAwMDAwMC4uNTUzMzcyMQo+ID4gPiAtLS0gL2Rldi9udWxsCj4gPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxkaXBfc21lbS50eHQK
PiA+ID4gQEAgLTAsMCArMSwyOSBAQAo+ID4gPiArTWVkaWF0ZWsgSVNQIFNoYXJlZCBNZW1vcnkg
RGV2aWNlCj4gPiA+ICsKPiA+ID4gK01lZGlhdGVrIElTUCBTaGFyZWQgTWVtb3J5IERldmljZSBp
cyB1c2VkIHRvIG1hbmFnZSBzaGFyZWQgbWVtb3J5Cj4gPiA+ICthbW9uZyBDUFUsIElTUCBJUHMg
YW5kIGNvcHJvY2Vzc29yLiBJdCBpcyBhc3NvY2lhdGVkIHdpdGggYSByZXNlcnZlZAo+ID4gPiAr
bWVtb3J5IHJlZ2lvbiAoUGxlYXNlIHNlZSBEb2N1bWVudGF0aW9uXGRldmljZXRyZWVcYmluZGlu
Z3NcCj4gPiA+ICtyZXNlcnZlZC1tZW1vcnlcbWVkaWF0ZWsscmVzZXJ2ZS1tZW1vcnktaXNwX3Nt
ZW0udHh0KSBhbmQKPiA+IAo+ID4gcy9cXC9cLy9nOwo+ID4gCj4gPiA+ICthbmQgcHJvdmlkZSB0
aGUgY29udGV4dCB0byBhbGxvY2F0ZSBtZW1vcnkgd2l0aCBkbWEgYWRkcmVzc2VzLgo+IAo+IERv
ZXMgdGhpcyByZXByZXNlbnQgYSByZWFsIGRldmljZSAoYXMgaW4gSVAgY29yZSkgaW4gdGhlIFNv
QyA/IFRoZXJlCj4gc2VlbXMgdG8gYmUgbm8gZHJpdmVyIGFzc29jaWF0ZWQgd2l0aCB0aGUgY29t
cGF0aWJsZSBzdHJpbmcgZGVmaW5lZAo+IGhlcmVpbiBpbiB0aGlzIHBhdGNoIHNlcmllcywgd2hh
dCBpcyB0aGlzIG5vZGUgdXNlZCBmb3IgPwoKSXQgZG9lcyBub3QgcmVwcmVzZW50IGEgcmVhbCBk
ZXZpY2UuIEl0IGlzIHVzZWQgZm9yIGNyZWF0aW5nIHRoZQpESVAtc3BlY2lmaWMgdmIyIGJ1ZmZl
ciBhbGxvY2F0aW9uIGNvbnRleHQgKGltcGxlbWVudGVkCmluIC9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL210ay1pc3AvaXNwXzUwL2RpcC9tdGtfZGlwLXNtZW0tZHJ2LmMpLgpUaGUgY29tcGF0aWJs
ZSBzdHJpbmcgaGFzIGJlZW4gcmVuYW1lZCBhcyDigJxtZWRpYXRlayxkaXBfc21lbeKAnSBpbiB0
aGlzCnBhdGNoIHNlcmllcyBhbmQgSSB3aWxsIGNvcnJlY3QgaXQgaW4gdGhpcyBiaW5kaW5nIGRv
Y3VtZW50LgoKPiAKPiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6Cj4gPiA+ICstIGNvbXBhdGli
bGU6IFNob3VsZCBiZSAibWVkaWF0ZWssaXNwX3NtZW0iCj4gPiAKPiA+IHMvU2hvdWxkL1NoYWxs
Lwo+ID4gCj4gPiA+ICsKPiA+ID4gKy0gaW9tbXVzOiBzaG91bGQgcG9pbnQgdG8gdGhlIHJlc3Bl
Y3RpdmUgSU9NTVUgYmxvY2sgd2l0aCBtYXN0ZXIgcG9ydAo+ID4gCj4gPiBzL3Nob3VsZC9zaGFs
bC8KPiA+IAo+ID4gPiArICBhcyBhcmd1bWVudC4gUGxlYXNlIHNldCB0aGUgcG9ydHMgd2hpY2gg
bWF5IGJlIGFjY2Vzc2VkCj4gPiA+ICsgIHRocm91Z2ggdGhlIGNvbW1vbiBwYXRoLiBZb3UgY2Fu
IHNlZQo+ID4gPiArICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvbWVk
aWF0ZWssaW9tbXUudHh0Cj4gPiA+ICsgIGZvciB0aGUgZGV0YWlsLgo+ID4gPiArCj4gPiA+ICst
IG1lZGlhdGVrLGxhcmI6IG11c3QgY29udGFpbiB0aGUgbG9jYWwgYXJiaXRlcnMgaW4gdGhlIGN1
cnJlbnQgU29jcy4KPiA+IAo+ID4gUGVyaGFwcyAiU29DcyI/Cj4gPiAKPiA+ID4gKyAgUGxlYXNl
IHNldCB0aGUgbGFyYiBvZiBjYW1zeXMgZm9yIFBhc3MgMSBhbmQgaW1nc3lzIGZvciBESVAsIG9y
IGJvdGgKPiA+ID4gKyAgaWYgeW91IGFyZSB1c2luZyBhbGwgdGhlIGNhbWVyYSBmdW5jdGlvbi4g
WW91IGNhbiBzZWUKPiA+ID4gKyAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
bW9yeS1jb250cm9sbGVycy8KPiA+ID4gKyAgbWVkaWF0ZWssc21pLWxhcmIudHh0IGZvciB0aGUg
ZGV0YWlsLgo+ID4gPiArCj4gPiA+ICtFeGFtcGxlOgo+ID4gPiArCWlzcF9zbWVtOiBpc3Bfc21l
bSB7Cj4gPiA+ICsJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssaXNwX3NtZW0iOwo+ID4gPiArCQlt
ZWRpYXRlayxsYXJiID0gPCZsYXJiNT47Cj4gPiA+ICsJCWlvbW11cyA9IDwmaW9tbXUgTTRVX1BP
UlRfQ0FNX0lNR0k+Owo+ID4gPiArCX07Cj4gCgoKU2luY2VyZWx5LAoKRnJlZGVyaWMgQ2hlbgoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
