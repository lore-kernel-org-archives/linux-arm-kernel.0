Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9F4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:48:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1AD20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQtC9kRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1AD20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3cykw+u+phQBN5+yqwOxRwqBNi1rzNxAf6fPiXBPUds=; b=lQtC9kRU4M7Pgd
	4UR/kSyfnLfR3tGZUg4RcojELX7JHi4Zay/ZQx/bnWj2l+p5Xsp5LJScfGKaAtgl/Od27pElmYQ42
	vbUp3SJP6PxD1Ka7APhME2geV7ZdDXCadFVlfwFbohKykAATNnAJ5K0AluvvwD3LIYHnJ5TjlClCJ
	SCFJlPE5vKJAS95FklOBPhoJHjH/MwVxJoHg/lCsqBoFLRdJ+pvIHHX/tBGqibxwD3+GzVg7crxfP
	rC6BvV9mG2JKThs9FpGrNFfhM4HUkoWHbeVOZ8qfv4TGa4hzQOLCZD5I4h80eESpMqrpDa3omFgUw
	n1ibITd4mLeoGodqSi7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPp6-0008EM-Lw; Fri, 18 Jan 2019 08:48:20 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPp3-0008Dh-0V
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:48:18 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gkPoy-0007kL-2d; Fri, 18 Jan 2019 09:48:12 +0100
Message-ID: <1547801291.2626.3.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 18 Jan 2019 09:48:11 +0100
In-Reply-To: <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_004817_206647_DC661C07 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDE4LjAxLjIwMTksIDA3OjUzICswMDAwIHNjaHJpZWIgQWlzaGVuZyBE
b25nOgo+IE5vdCBhbGwgNjQgaW50ZXJydXB0cyBtYXkgYmUgdXNlZCBpbiBvbmUgZ3JvdXAuIGUu
Zy4gbW9zdCBpcnFzdGVlciBpbgo+IGlteDhxeHAgYW5kIGlteDhxbSBzdWJzeXN0ZW1zIHN1cHBv
cnRzIG9ubHkgMzIgaW50ZXJydXB0cy4KPiAKPiBBcyB0aGUgSVAgaW50ZWdyYXRpb24gcGFyYW1l
dGVycyBhcmUgQ2hhbm5lbCBudW1iZXIgYW5kIGludGVycnVwdHMgbnVtYmVyLAo+IGxldCdzIHVz
ZSBmc2wsaXJxcy1wZXItY2hhbiB0byByZXByZXNlbnRzIGhvdyBtYW55IGludGVycnVwdHMgc3Vw
cG9ydGVkCj4gYnkgdGhpcyBpcnFzdGVlciBjaGFubmVsLgoKU29ycnksIGJ1dCB0b3RhbCBOQUNL
LiBJJ3ZlIGdvdCB0byBncmVhdCBsZW5ndGhzIHdpdGggZHVtcGluZyB0aGUKYWN0dWFsbHkgaW1w
bGVtZW50ZWQgcmVnaXN0ZXIgbGF5b3V0IG9uIGkuTVg4TSBhbmQgQUZBSUNTIHRoZSBJUlFzIGFy
ZQphbHdheXMgbWFuYWdlZCBpbiBncm91cHMgb2YgNjQgSVJRcywgZXZlbiBpZiBsZXNzIHRoYW4g
dGhhdCBhcmUKY29ubmVjdGVkIGFzIGlucHV0IElSUXMuIFRoaXMgaXMgd2hhdCB0aGUgYWN0dWFs
bHkgcHJlc2VudCByZWdpc3RlciBzZXQKb24gaS5NWDhNIHRlbGxzIHVzLgoKUmVnYXJkcywKTHVj
YXMKCj4gQ2M6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+Cj4gPiBDYzogUm9i
IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4KPiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4KPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+
Cj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25n
IEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+IC0tLQo+IMKgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4dMKgwqDCoMKgwqDC
oMKgfCA2ICsrKy0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFzdGVlci50eHQgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4
dAo+IGluZGV4IDQ1NzkwY2UuLmVhYWJjZGEgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFzdGVlci50eHQK
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvZnNsLGlycXN0ZWVyLnR4dAo+IEBAIC0xNiw4ICsxNiw4IEBAIFJlcXVpcmVkIHByb3Bl
cnRpZXM6Cj4gwqAtICNpbnRlcnJ1cHQtY2VsbHM6IFNwZWNpZmllcyB0aGUgbnVtYmVyIG9mIGNl
bGxzIG5lZWRlZCB0byBlbmNvZGUgYW4KPiDCoMKgwqBpbnRlcnJ1cHQgc291cmNlLiBUaGUgdmFs
dWUgbXVzdCBiZSAxLgo+IMKgLSBmc2wsY2hhbm5lbDogVGhlIG91dHB1dCBjaGFubmVsIHRoYXQg
YWxsIGlucHV0IElSUXMgc2hvdWxkIGJlIHN0ZWVyZWQgaW50by4KPiAtLSBmc2wsaXJxLWdyb3Vw
czogTnVtYmVyIG9mIElSUSBncm91cHMgbWFuYWdlZCBieSB0aGlzIGNvbnRyb2xsZXIgaW5zdGFu
Y2UuCj4gLcKgwqBFYWNoIGdyb3VwIG1hbmFnZXMgNjQgaW5wdXQgaW50ZXJydXB0cy4KPiArLSBm
c2wsaXJxcy1wZXItY2hhbjogTnVtYmVyIG9mIGlucHV0IGludGVycnVwdHMgcGVyIGNoYW5uZWwu
IFNob3VsZCBiZSBtdWx0aXBsZSBvZiAzMgo+ICvCoMKgaW5wdXQgaW50ZXJydXB0cyBhbmQgdXAg
dG8gNTEyIGludGVycnVwdHMuCj4gwqAKPiDCoEV4YW1wbGU6Cj4gwqAKPiBAQCAtMjgsNyArMjgs
NyBAQCBFeGFtcGxlOgo+ID4gwqAJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfRElTUF9BUEJf
Uk9PVD47Cj4gPiDCoAkJY2xvY2stbmFtZXMgPSAiaXBnIjsKPiA+IMKgCQlmc2wsY2hhbm5lbCA9
IDwwPjsKPiA+IC0JCWZzbCxpcnEtZ3JvdXBzID0gPDE+Owo+ID4gKwkJZnNsLGlycXMtcGVyLWNo
YW49IDw2ND47Cj4gPiDCoAkJaW50ZXJydXB0LWNvbnRyb2xsZXI7Cj4gPiDCoAkJI2ludGVycnVw
dC1jZWxscyA9IDwxPjsKPiA+IMKgCX07CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
