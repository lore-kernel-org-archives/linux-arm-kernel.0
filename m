Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:19:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C345A20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hMAQkbdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C345A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jCCJJLbrG3uKAsdEacFtn/TDv7tQRyvd92D2xOykjrQ=; b=hMAQkbdzdPrx4u
	Y2yhvg5w43UKER18qGHjKJ1Kber8RrRy7qx5+ky6yE3cfG23jBYt5bMIEBuJRVWVUtdOmqQJ8fwfA
	s3d0YQN01JcYB9NJg1aU0I97RJHk801QOwC2sLbMzPIau/6IgLcVW1JRYOY1Gca5fmK0ZZ4zI/Ckt
	4htMTA8/rG389csnIQTNwnud2eshUsI9Ep+eiQ1eHw7dyz0LZ3sXQvHhyknW1fLNjqHuSYREnj4kA
	bC9ubQDaT2MFwi4x3aYomvVHl2dnjjBOKSZC9MhZG7SNARPYe8FDmG/UVACHeJTo2I1zZkK7tqqHn
	YKeEguFjw+laWUT6WTrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXN9n-0002gq-2m; Thu, 13 Dec 2018 09:19:47 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXN9j-0001v5-Ej
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:19:45 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXN9U-0005cg-Pk; Thu, 13 Dec 2018 10:19:28 +0100
Message-ID: <1544692768.3137.25.camel@pengutronix.de>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <hongxing.zhu@nxp.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>,  "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>
Date: Thu, 13 Dec 2018 10:19:28 +0100
In-Reply-To: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_011943_653125_B75DF148 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUmljaGFyZCwKCkFtIERvbm5lcnN0YWcsIGRlbiAxMy4xMi4yMDE4LCAwODowMiArMDAwMCBz
Y2hyaWViIFJpY2hhcmQgWmh1Ogo+IE1TSV9FTiBvZiBpTVggUENJZSBSQyB3b3VsZCBiZSBhc3Nl
cnRlZCB3aGVuCj4gUENJRVBPUlRCVVMgZHJpdmVyIGlzIHNlbGVjdGVkLgo+IFRodXMsIHRoZSBN
U0kgd29ya3MgZmluZSBvbiBpTVggUENJZSBiZWZvcmUuCj4gQXNzZXJ0IGl0IHVuY29uZGl0aW9u
YWxseSB3aGVuIE1TSSBpcyBzdXBwb3J0ZWQuCj4gT3RoZXJ3aXNlLCB0aGUgTVNJIHdvdWxkbid0
IGJlIHRyaWdnZXJlZCBhbHRob3VnaAo+IHRoZSBFUCBpcyBwcmVzZW50IGFuZCB0aGUgTVNJcyBh
cmUgYXNzaWduZWQuCgpUaGFua3MgZm9yIGRpZ2dpbmcgaW50byB0aGlzIGlzc3VlLiBUaGlzIHNl
ZW1zIGxpa2UgdGhlIHJpZ2h0IHdheQpmb3J3YXJkLiBIb3dldmVyLCBkaWQgeW91IHRlc3QgdGhp
cyB3aXRoIGRldmljZXMgdXNpbmcgbGVnYWN5IElSUXM/IApJLmUuIGJvb3Rpbmcgd2l0aCAibm9t
c2kiIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHNlZSBpZiBsZWdhY3kKSVJRcyBzdGls
bCB3b3JrIGlmIHRoaXMgYml0IGlzIHNldCwgb3IgaWYgd2UgbmVlZCB0byBhdm9pZCBzZXR0aW5n
IHRoaXMKd2hlbiB0aGUgdXNlciBleHBsaWNpdGx5IHJlcXVlc3RzIHRvIGRpc2FibGUgTVNJcz8K
ClJlZ2FyZHMsCkx1Y2FzCgo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMgfCA3ICsrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKPiBpbmRleCAyNjA4N2IzLi5kM2U0Mjk2
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4gQEAgLTc0LDYgKzc0
LDcgQEAgc3RydWN0IGlteDZfcGNpZSB7Cj4gPiDCoCNkZWZpbmUgUEhZX1BMTF9MT0NLX1dBSVRf
VVNMRUVQX01BWAkyMDAKPiDCoAo+IMKgLyogUENJZSBSb290IENvbXBsZXggcmVnaXN0ZXJzICht
ZW1vcnktbWFwcGVkKSAqLwo+ID4gKyNkZWZpbmUgUENJX01TSV9DQVAJCQkJMHg1MAo+ID4gwqAj
ZGVmaW5lIFBDSUVfUkNfTENSCQkJCTB4N2MKPiA+IMKgI2RlZmluZSBQQ0lFX1JDX0xDUl9NQVhf
TElOS19TUEVFRFNfR0VOMQkweDEKPiA+IMKgI2RlZmluZSBQQ0lFX1JDX0xDUl9NQVhfTElOS19T
UEVFRFNfR0VOMgkweDIKPiBAQCAtOTI2LDYgKzkyNyw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2ll
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiDCoAlzdHJ1Y3QgcmVzb3Vy
Y2UgKmRiaV9iYXNlOwo+ID4gwqAJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9u
b2RlOwo+ID4gwqAJaW50IHJldDsKPiA+ICsJdTE2IHZhbDsKPiDCoAo+ID4gwqAJaW14Nl9wY2ll
ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCppbXg2X3BjaWUpLCBHRlBfS0VSTkVMKTsKPiA+
IMKgCWlmICghaW14Nl9wY2llKQo+IEBAIC0xMDcwLDYgKzEwNzIsMTEgQEAgc3RhdGljIGludCBp
bXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgCXJldCA9
IGlteDZfYWRkX3BjaWVfcG9ydChpbXg2X3BjaWUsIHBkZXYpOwo+ID4gwqAJaWYgKHJldCA8IDAp
Cj4gPiDCoAkJcmV0dXJuIHJldDsKPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kp
KSB7Cj4gPiArCQl2YWwgPSBkd19wY2llX3JlYWR3X2RiaShwY2ksIFBDSV9NU0lfQ0FQICsgUENJ
X01TSV9GTEFHUyk7Cj4gPiArCQl2YWwgfD0gUENJX01TSV9GTEFHU19FTkFCTEU7Cj4gPiArCQlk
d19wY2llX3dyaXRld19kYmkocGNpLCBQQ0lfTVNJX0NBUCArIFBDSV9NU0lfRkxBR1MsIHZhbCk7
Cj4gPiArCX0KPiDCoAo+ID4gwqAJcmV0dXJuIDA7Cj4gwqB9CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
