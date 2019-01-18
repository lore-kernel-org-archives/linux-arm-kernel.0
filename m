Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B8C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3361A20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZL5yQ8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3361A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DYV5lbJpe7u8f0+XbwMnyDLNFeq7ytsKeYApYitCnV8=; b=VZL5yQ8jhW11sV
	zkNlnIAX00vR7WLSVzYMrGjZnR0oXOwDlSu8tLxWWpJRsI/kTVxjh3qwWveRERrl+Vbc1Xm5gFiJP
	jhe/NLzSD1P/NJe4wOBMVAUszGYoGDFr5PP4g31qxsnUmfEvaIw5z535pX0jm85LOvy46uUcdFgvg
	X8moIsQTjagyT9bttKjtJ5gt0mcOeeA98/kLUZ6n3Mr+5oXX5w2tsk1qyh6SNQ2YBd0eQ3yLixwfr
	kdlFF2L8Hicho0ZKiz/EvRFqctsa9OJv04Q+KEecGs5hBqcMwuuyNZvt2gU0Z2hK4OTj5x3JwUC+W
	pD3wThA9JXnGTzyXCuEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQxm-0003fN-E0; Fri, 18 Jan 2019 10:01:22 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQxi-0003eW-B3; Fri, 18 Jan 2019 10:01:19 +0000
X-UUID: 126f558424a544fd99f650cd4f066d80-20190118
X-UUID: 126f558424a544fd99f650cd4f066d80-20190118
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1638672212; Fri, 18 Jan 2019 02:01:13 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 02:01:12 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 18:01:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 18:01:09 +0800
Message-ID: <1547805669.8969.4.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From: Ryder Lee <ryder.lee@mediatek.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 18 Jan 2019 18:01:09 +0800
In-Reply-To: <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <20190118075925.noilab6glzm3cig6@pengutronix.de>
 <1547804574.8124.6.camel@mtkswgap22>
 <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_020118_385869_BA7AD405 
X-CRM114-Status: GOOD (  21.24  )
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
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE5LTAxLTE4IGF0IDEwOjUzICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToKPiBIZWxsbyBSeWRlciwKPiAKPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAwNTo0Mjo1NFBN
ICswODAwLCBSeWRlciBMZWUgd3JvdGU6Cj4gPiBPbiBGcmksIDIwMTktMDEtMTggYXQgMDg6NTkg
KzAxMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+ID4gPiBIZWxsbywKPiA+ID4gCj4gPiA+
IE9uIEZyaSwgSmFuIDE4LCAyMDE5IGF0IDExOjI0OjQxQU0gKzA4MDAsIFJ5ZGVyIExlZSB3cm90
ZToKPiA+ID4gPiBUaGlzIGFkZHMgYSBwcm9wZXJ0eSAibWVkaWF0ZWssbnVtLXB3bXMiIHRvIGF2
b2lkIGhhdmluZyBhbiBlbmRsZXNzCj4gPiA+ID4gbGlzdCBvZiBjb21wYXRpYmxlcyB3aXRoIG5v
IGRpZmZlcmVuY2VzIGZvciB0aGUgc2FtZSBkcml2ZXIuCj4gPiA+ID4gCj4gPiA+ID4gVGh1cywg
dGhlIGRyaXZlciBzaG91bGQgaGF2ZSBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB0byBvbGRlciBE
VHMuCj4gPiA+IAo+ID4gPiBJIHN0aWxsIHRoaW5rIFRoaWVycnkgc2hvdWxkIGJsZXNzICJudW0t
cHdtcyIgd2l0aG91dCB2ZW5kb3IgcHJlZml4Lgo+ID4gCj4gPiBPa2F5Lgo+ID4gCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPgo+ID4gPiA+
IC0tLQo+ID4gPiA+IENoYW5nZXMgc2luY2UgdjE6IGFkZCBzb21lIGNoZWNrcyBmb3IgYmFja3dh
cmRzIGNvbXBhdGliaWxpdHkuCj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvcHdtL3B3bS1t
ZWRpYXRlay5jIHwgMjcgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4gPiA+IAo+ID4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYyBiL2RyaXZlcnMvcHdt
L3B3bS1tZWRpYXRlay5jCj4gPiA+ID4gaW5kZXggZWI2Njc0Yy4uODFiN2U1ZSAxMDA2NDQKPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYwo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvcHdtL3B3bS1tZWRpYXRlay5jCj4gPiA+ID4gQEAgLTU1LDcgKzU1LDcgQEAgZW51bSB7Cj4g
PiA+ID4gIH07Cj4gPiA+ID4gIAo+ID4gPiA+ICBzdHJ1Y3QgbXRrX3B3bV9wbGF0Zm9ybV9kYXRh
IHsKPiA+ID4gCj4gPiA+IFVucmVsYXRlZCB0byB0aGlzIHBhdGNoOiBUaGlzIG5hbWUgaXMgYmFk
LiBUaGlzIHN0cnVjdCBpcyBub3QgdXNlZCBhcwo+ID4gPiBwbGF0Zm9ybV9kYXRhIGFuZCBzbyBz
aG91bGQgYmV0dGVyIGJlIG5hbWVkIG10a19wd21fb2ZfZGF0YS4gV2hpbGUgYXQKPiA+ID4gY3Jp
dGljaXppbmcgZXhpc3Rpbmcgc3R1ZmY6IEknZCBwcmVmZXIgcHdtX21lZGlhdGVrIGFzIGNvbW1v
biBwcmVmaXggdG8KPiA+ID4gbWF0Y2ggdGhlIGZpbGVuYW1lLgo+ID4gCj4gPiBJIHRoaW5rIHdl
IGNhbiB0YWtlIGNhcmUgYWJvdXQgdGhhdCBpbiBhbm90aGVyIHBhdGNoLgo+IAo+IFRoYXQncyB3
aGF0IEkgd2FudGVkIHRvIHNheSwgcmlnaHQuIERvIHlvdSBmb2xsb3cgdXA/CgpZZXMsIEkgd2ls
bCBkbyB0aGF0LgoKPiA+ID4gPiAtCXVuc2lnbmVkIGludCBudW1fcHdtczsKPiA+ID4gPiArCXVu
c2lnbmVkIGludCBudW1fcHdtczsJLyogaXQgc2hvdWxkIG5vdCBiZSB1c2VkIGluIHRoZSBmdXR1
cmUgU29DcyAqLwo+ID4gPiAKPiA+ID4gSSdkIGRyb3AgdGhpcyBjb21tZW50IGluIGZhdm91ciBv
ZiBhIHJ1bnRpbWUgd2FybmluZy4KPiA+IAo+ID4gU29ycnksIEkgY2FuJ3QgZ2V0IHlvdSBoZXJl
Lgo+IAo+IEknZCBkbyBhCj4gCj4gCWRldl93YXJuKGRldiwgImR0IGRpZG4ndCBzcGVjaWZ5IG51
bWJlciBvZiBQV01zLCBmYWxsaW5nIGJhY2sgdG8gJWRcbiIsIHBjLT5zb2MtPm51bV9wd21zKTsK
PiAKPiB0byBtYWtlIHBlb3BsZSBhd2FyZSB0aGF0IHVwZGF0aW5nIHRoZSBkdCB3b3VsZCBiZSBu
aWNlLgoKT2theSEKClRoYW5rcwpSeWRlcgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
