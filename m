Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:37:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB52218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HKxAuw9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB52218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PLI7gn0DhKv8Hk5AgPeB9f2VyUKrMnXS8cXLqHbebRs=; b=HKxAuw9X+z7/JG
	Gzfl6Ha1mAv5456Vv10JMYkbJYVs1bVNhHdWLdw15Ss6UZ1rdMGhxyKNK5eOxqYOi3NXzppID1yhj
	5XEnxGiDgKIj0x6tIWBbEWtNMl6kKj4k+8xegJeydoI51nN5hUuGJgv2aLUWwSBlD4yLDHfLoBxLO
	Fsr6480fAfxKvQdTPBbRw6SIP9XKQqYH1iWcsGYA92vL4BlMXv+FR80zs/oPYKJ5+WZnuRRXozfja
	rBIkb4jZpBDlUaLh92D9xYUa439Cu2Tl9ANLMA71QtMG86Og1/lUdB5bBPTw3gUs8UdgN0Gu9MvOe
	JvjAGExbZCuWCX4o8gBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUVY-0007s8-JQ; Tue, 12 Feb 2019 09:37:40 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUVT-0007rL-Rd; Tue, 12 Feb 2019 09:37:37 +0000
X-UUID: ffa62dec5ce74f39b644ea8f59be9c38-20190212
X-UUID: ffa62dec5ce74f39b644ea8f59be9c38-20190212
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 329086531; Tue, 12 Feb 2019 01:37:26 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 01:37:25 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 17:37:22 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 17:37:22 +0800
Message-ID: <1549964242.27207.11.camel@mtksdccf07>
Subject: Re: [RFC PATCH V0 1/7] [media] dt-bindings: mt8183: Add binding for
 DIP shared memory
From: Frederic Chen <frederic.chen@mediatek.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sakari Ailus
 <sakari.ailus@iki.fi>
Date: Tue, 12 Feb 2019 17:37:22 +0800
In-Reply-To: <20190209181705.GB4505@pendragon.ideasonboard.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
 <1549020091-42064-2-git-send-email-frederic.chen@mediatek.com>
 <20190209155907.rbgwbdablndcesid@valkosipuli.retiisi.org.uk>
 <20190209181705.GB4505@pendragon.ideasonboard.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 15DFA9F8853A480109641174D41DD23EE4B87532B6C53798FB2B77326F4856F52000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_013735_897921_F8C0C83E 
X-CRM114-Status: GOOD (  24.27  )
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
 holmes.chiou@mediatek.com, linux-mediatek@lists.infradead.org,
 Jerry-ch.Chen@mediatek.com, tfiga@chromium.org, jungo.lin@mediatek.com,
 sj.huang@mediatek.com, hans.verkuil@cisco.com, matthias.bgg@gmail.com,
 Sakari Ailus <sakari.ailus@iki.fi>, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RGVhciBMYXVyZW50IGFuZCBTYWthcmksCgpJIGFwcHJlY2lhdGUgeW91ciBtZXNzYWdlcy4KCk9u
IFNhdCwgMjAxOS0wMi0wOSBhdCAyMDoxNyArMDIwMCwgTGF1cmVudCBQaW5jaGFydCB3cm90ZToK
PiBPbiBTYXQsIEZlYiAwOSwgMjAxOSBhdCAwNTo1OTowN1BNICswMjAwLCBTYWthcmkgQWlsdXMg
d3JvdGU6Cj4gPiBIaSBGcmVkZXJpYywKPiA+IAo+ID4gQ291bGQgeW91IGNjIHRoZSBkZXZpY2V0
cmVlIGxpc3QsIHBsZWFzZT8KPiA+IAo+ID4gT24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDc6MjE6
MjVQTSArMDgwMCwgRnJlZGVyaWMgQ2hlbiB3cm90ZToKPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHRo
ZSBiaW5kaW5nIGZvciBkZXNjcmliaW5nIHRoZSBzaGFyZWQgbWVtb3J5Cj4gPiA+IHVzZWQgdG8g
ZXhjaGFuZ2UgY29uZmlndXJhdGlvbiBhbmQgdHVuaW5nIGRhdGEgYmV0d2VlbiB0aGUKPiA+ID4g
Y28tcHJvY2Vzc29yIGFuZCBEaWdpdGFsIEltYWdlIFByb2Nlc3NpbmcgKERJUCkgdW5pdCBvZiB0
aGUKPiA+ID4gY2FtZXJhIElTUCBzeXN0ZW0gb24gTWVkaWF0ZWsgU29Dcy4KPiA+ID4gCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEZyZWRlcmljIENoZW4gPGZyZWRlcmljLmNoZW5AbWVkaWF0ZWsuY29t
Pgo+ID4gPiAtLS0KPiA+ID4gIC4uLi9tZWRpYXRlayxyZXNlcnZlLW1lbW9yeS1kaXBfc21lbS50
eHQgICAgICAgICAgIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDQ1IGluc2VydGlvbnMoKykKPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXJ2ZWQtbWVtb3J5L21lZGlhdGVrLHJlc2Vy
dmUtbWVtb3J5LWRpcF9zbWVtLnR4dAo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkvbWVkaWF0ZWsscmVzZXJ2
ZS1tZW1vcnktZGlwX3NtZW0udHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Jlc2VydmVkLW1lbW9yeS9tZWRpYXRlayxyZXNlcnZlLW1lbW9yeS1kaXBfc21lbS50eHQKPiA+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gaW5kZXggMDAwMDAwMC4uMGRlZDQ3OAo+ID4g
PiAtLS0gL2Rldi9udWxsCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yZXNlcnZlZC1tZW1vcnkvbWVkaWF0ZWsscmVzZXJ2ZS1tZW1vcnktZGlwX3NtZW0udHh0
Cj4gPiA+IEBAIC0wLDAgKzEsNDUgQEAKPiA+ID4gK01lZGlhdGVrIERJUCBTaGFyZWQgTWVtb3J5
IGJpbmRpbmcKPiA+ID4gKwo+ID4gPiArVGhpcyBiaW5kaW5nIGRlc2NyaWJlcyB0aGUgc2hhcmVk
IG1lbW9yeSwgd2hpY2ggc2VydmVzIHRoZSBwdXJwb3NlIG9mCj4gPiA+ICtkZXNjcmliaW5nIHRo
ZSBzaGFyZWQgbWVtb3J5IHJlZ2lvbiB1c2VkIHRvIGV4Y2hhbmdlIGRhdGEgYmV0d2VlbiBEaWdp
dGFsCj4gPiA+ICtJbWFnZSBQcm9jZXNzaW5nIChESVApIGFuZCBjby1wcm9jZXNzb3IgaW4gTWVk
aWF0ZWsgU29Dcy4KPiA+ID4gKwo+ID4gPiArVGhlIGNvLXByb2Nlc3NvciBkb2Vzbid0IGhhdmUg
dGhlIGlvbW11IHNvIHdlIG5lZWQgdG8gdXNlIHRoZSBwaHlzaWNhbAo+ID4gPiArYWRkcmVzcyB0
byBhY2Nlc3MgdGhlIHNoYXJlZCBidWZmZXIgaW4gdGhlIGZpcm13YXJlLgo+ID4gPiArCj4gPiA+
ICtUaGUgRGlnaXRhbCBJbWFnZSBQcm9jZXNzaW5nIChESVApIGNhbiBhY2Nlc3MgbWVtb3J5IHRo
cm91Z2ggbXQ4MTgzIElPTU1VIHNvCj4gPiA+ICtpdCBjYW4gdXNlIGRtYSBhZGRyZXNzIHRvIGFj
Y2VzcyB0aGUgbWVtb3J5IHJlZ2lvbi4KPiA+ID4gKyhTZWUgaW9tbXUvbWVkaWF0ZWssaW9tbXUu
dHh0IGZvciB0aGUgZGV0YWlsZWQgZGVzY3JpcHRpb24gb2YgTWVkaWF0ZWsgSU9NTVUpCj4gPiAK
PiA+IFdoYXQga2luZCBvZiBwdXJwb3NlIGlzIHRoZSBtZW1vcnkgdXNlZCBmb3I/IEJ1ZmZlcnMg
Y29udGFpbmluZyB2aWRlbyBkYXRhLAo+ID4gb3Igc29tZXRoaW5nIGVsc2U/IENvdWxkIHRoZSBi
dWZmZXIgb2JqZWN0cyBiZSBtYXBwZWQgb24gdGhlIGRldmljZXMKPiA+IGJhc2VkIG9uIHRoZSBu
ZWVkIGluc3RlYWQ/CgpUaGUgbWVtb3J5IGJ1ZmZlcnMgY29udGFpbiBjYW1lcmEgM0EgdHVuaW5n
IGRhdGEsIHdoaWNoIGFyZSB1c2VkIGJ5IHRoZQpjby1wcm9jZXNzb3IgYW5kIERJUCBJUC4gQWJv
dXQgbWFwcGluZyB0aGUgYnVmZmVyIGJhc2VkIG9uIHRoZSBuZWVkCmluc3RlYWQsIEnigJltIG5v
dCBzdXJlIEkgdW5kZXJzdGFuZCB0aGlzIHBvaW50LiBEbyB5b3UgbWVhbiB0aGF0CmFsbG9jYXRp
bmcgYW5kIG1hcHBpbmcgdGhlIG1lbW9yeSBkeW5hbWljYWxseT8KCj4gCj4gQW5kIGNvdWxkIENN
QSBiZSB1c2VkIHdoZW4gcGh5c2ljYWxseSBjb250aWd1b3VzIG1lbW9yeSBpcyBuZWVkZWQgPwoK
RElQIGRyaXZlciBkb2VzIG5vdCB1c2UgQ01BIG5vdywgYmVjYXVzZSB0aGUgZmlyc3QgdmVyc2lv
biB3aWxsIGJlIHVzZWQKYnkgQ3JPUyBidXQgQ3JPUyB3b27igJl0IGVuYWJsZSBDTUEuCgo+IAo+
ID4gPiArCj4gPiA+ICsKPiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6Cj4gPiA+ICsKPiA+ID4g
Ky0gY29tcGF0aWJsZTogbXVzdCBiZSAibWVkaWF0ZWsscmVzZXJ2ZS1tZW1vcnktZGlwX3NtZW0i
Cj4gPiA+ICsKPiA+ID4gKy0gcmVnOiByZXF1aXJlZCBmb3Igc3RhdGljIGFsbG9jYXRpb24gKHNl
ZSByZXNlcnZlZC1tZW1vcnkudHh0IGZvcgo+ID4gPiArICB0aGUgZGV0YWlsZWQgdXNhZ2UpCj4g
PiA+ICsKPiA+ID4gKy0gYWxsb2MtcmFuZ2U6IHJlcXVpcmVkIGZvciBkeW5hbWljIGFsbG9jYXRp
b24uIFRoZSByYW5nZSBtdXN0Cj4gPiA+ICsgIGJldHdlZW4gMHgwMDAwMDQwMCBhbmQgMHgxMDAw
MDAwMDAgZHVlIHRvIHRoZSBjby1wcm9jZXNzZXIncwo+ID4gPiArICBhZGRyZXNzaW5nIGxpbWl0
YXRpb24KPiA+ID4gKwo+ID4gPiArLSBzaXplOiByZXF1aXJlZCBmb3IgZHluYW1pYyBhbGxvY2F0
aW9uLiBUaGUgdW5pdCBpcyBieXRlcy4KPiA+ID4gKyAgSWYgeW91IHdhbnQgdG8gZW5hYmxlIHRo
ZSBmdWxsIGZlYXR1cmUgb2YgRGlnaXRhbCBQcm9jZXNzaW5nIFVuaXQsCj4gPiA+ICsgIHlvdSBu
ZWVkIDIwIE1CIGF0IGxlYXN0Lgo+ID4gPiArCj4gPiA+ICsKPiA+ID4gK0V4YW1wbGU6Cj4gPiA+
ICsKPiA+ID4gK1RoZSBmb2xsb3dpbmcgZXhhbXBsZSBzaG93cyB0aGUgRElQIHNoYXJlZCBtZW1v
cnkgc2V0dXAgZm9yIE1UODE4My4KPiA+ID4gKwo+ID4gPiArCXJlc2VydmVkLW1lbW9yeSB7Cj4g
PiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDI+Owo+ID4gPiArCQkjc2l6ZS1jZWxscyA9IDwyPjsK
PiA+ID4gKwkJcmFuZ2VzOwo+ID4gPiArCQlyZXNlcnZlLW1lbW9yeS1pc3Bfc21lbSB7Cj4gPiA+
ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLHJlc2VydmUtbWVtb3J5LWRpcF9zbWVtIjsKPiA+
ID4gKwkJCXNpemUgPSA8MCAweDE0MDAwMDA+Owo+ID4gPiArCQkJYWxpZ25tZW50ID0gPDAgMHgx
MDAwPjsKPiA+ID4gKwkJCWFsbG9jLXJhbmdlcyA9IDwwIDB4NDAwMDAwMDAgMCAweDUwMDAwMDAw
PjsKPiA+ID4gKwkJfTsKPiA+ID4gKwl9Owo+IAoKU2luY2VyZWx5LAoKRnJlZGVyaWMgQ2hlbgoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
