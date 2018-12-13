Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84301C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:47:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1BC20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z0cl8tyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1BC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hREl23VIZ9AIXC+LFGdrktaBtX/GnsmiAgDiY6CArIs=; b=Z0cl8tySK/vc+c
	VQCS8HmELpuiQ2pXqov3jAMoGeAbnCPH/CsYJj3Uym8cmSvJI1ObPabv02YACbaDYEOjsfNYMEDtI
	3xGAxQmO2MhngFhKmHmWEuRKonejitLvg05MNlXxSJVQBSZKp0/xW9JRH4AbdCbey92jfZ6UAic84
	SA48aS1QDk/UZlU7QTgvDVtr1Wji+ngpNuFXteLKiJJBlJZuIxihqI5qIEyvvBiKq8dfav8D6hOz6
	y7/xDf4AUpGg1yHbe18IuheiAr5sc6LFnx81+XygHEF9J1Q+ekR/O8e8ieRi0iqvoIaDxECkRx1By
	JdqlIUqanKKoVUX+PMXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOWS-0002la-Uo; Thu, 13 Dec 2018 10:47:16 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOWK-0002ZD-EH
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:47:14 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXOW5-0000m9-Ln; Thu, 13 Dec 2018 11:46:53 +0100
Message-ID: <1544698012.3137.28.camel@pengutronix.de>
Subject: Re: [v3] PCI: imx: make msi work without pcieportbus
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <hongxing.zhu@nxp.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>,  "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>
Date: Thu, 13 Dec 2018 11:46:52 +0100
In-Reply-To: <1544696723-1673-1-git-send-email-hongxing.zhu@nxp.com>
References: <1544696723-1673-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_024708_844697_BADAFC7D 
X-CRM114-Status: GOOD (  15.87  )
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

QW0gRG9ubmVyc3RhZywgZGVuIDEzLjEyLjIwMTgsIDEwOjQzICswMDAwIHNjaHJpZWIgUmljaGFy
ZCBaaHU6Cj4gTVNJX0VOIG9mIGlNWCBQQ0llIFJDIHdvdWxkIGJlIGFzc2VydGVkIHdoZW4KPiBQ
Q0lFUE9SVEJVUyBkcml2ZXIgaXMgc2VsZWN0ZWQuCj4gVGh1cywgdGhlIE1TSSB3b3JrcyBmaW5l
IG9uIGlNWCBQQ0llIGJlZm9yZS4KPiBBc3NlcnQgaXQgdW5jb25kaXRpb25hbGx5IHdoZW4gTVNJ
IGlzIGVuYWJsZWQuCj4gT3RoZXJ3aXNlLCB0aGUgTVNJIHdvdWxkbid0IGJlIHRyaWdnZXJlZCBh
bHRob3VnaAo+IHRoZSBFUCBpcyBwcmVzZW50IGFuZCB0aGUgTVNJcyBhcmUgYXNzaWduZWQuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPgoKUmV2
aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKPiAtLS0KPiBD
aGFuZ2VzIHYxIC0+IHYyOgo+ICogQXNzZXJ0IHRoZSBNU0lfRU4gdW5jb25kaXRpb25hbGx5IHdo
ZW4gTVNJIGlzIHN1cHBvcnRlZC4KPiBDaGFuZ2VzIHYyIC0+IHYzOgo+ICogUmVtb3ZlIHRoZSBJ
U19FTkFCTEVEKENPTkZJR19QQ0lfTVNJKSBzaW5jZSB0aGUgZHJpdmVyCj4gZGVwZW5kcyBvbiBQ
Q0lfTVNJX0lSUV9ET01BSU4KPiAqIEV4dGVuZGVkIHdpdGggYSBjaGVjayBmb3IgcGNpX21zaV9l
bmFibGVkKCkgdG8gc2VlCj4gaWYgdGhlIHVzZXIgZXhwbGljaXRseSB3YW50IGxlZ2FjeSBJUlFz
Cj4gLS0tCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgOCArKysr
KysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYwo+IGluZGV4IDI2MDg3YjMuLjFjNTlhOTMgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKPiBAQCAtNzQsNiArNzQsNyBAQCBzdHJ1
Y3QgaW14Nl9wY2llIHsKPiA+IMKgI2RlZmluZSBQSFlfUExMX0xPQ0tfV0FJVF9VU0xFRVBfTUFY
CTIwMAo+IMKgCj4gwqAvKiBQQ0llIFJvb3QgQ29tcGxleCByZWdpc3RlcnMgKG1lbW9yeS1tYXBw
ZWQpICovCj4gPiArI2RlZmluZSBQQ0lfTVNJX0NBUAkJCQkweDUwCj4gPiDCoCNkZWZpbmUgUENJ
RV9SQ19MQ1IJCQkJMHg3Ywo+ID4gwqAjZGVmaW5lIFBDSUVfUkNfTENSX01BWF9MSU5LX1NQRUVE
U19HRU4xCTB4MQo+ID4gwqAjZGVmaW5lIFBDSUVfUkNfTENSX01BWF9MSU5LX1NQRUVEU19HRU4y
CTB4Mgo+IEBAIC05MjYsNiArOTI3LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgCXN0cnVjdCByZXNvdXJjZSAqZGJpX2Jh
c2U7Cj4gPiDCoAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7Cj4gPiDC
oAlpbnQgcmV0Owo+ID4gKwl1MTYgdmFsOwo+IMKgCj4gPiDCoAlpbXg2X3BjaWUgPSBkZXZtX2t6
YWxsb2MoZGV2LCBzaXplb2YoKmlteDZfcGNpZSksIEdGUF9LRVJORUwpOwo+ID4gwqAJaWYgKCFp
bXg2X3BjaWUpCj4gQEAgLTEwNzEsNiArMTA3MywxMiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gwqAJaWYgKHJldCA8IDApCj4g
PiDCoAkJcmV0dXJuIHJldDsKPiDCoAo+ID4gKwlpZiAocGNpX21zaV9lbmFibGVkKCkpIHsKPiA+
ICsJCXZhbCA9IGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwgUENJX01TSV9DQVAgKyBQQ0lfTVNJX0ZM
QUdTKTsKPiA+ICsJCXZhbCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsKPiA+ICsJCWR3X3BjaWVf
d3JpdGV3X2RiaShwY2ksIFBDSV9NU0lfQ0FQICsgUENJX01TSV9GTEFHUywgdmFsKTsKPiA+ICsJ
fQo+ICsKPiA+IMKgCXJldHVybiAwOwo+IMKgfQo+IMKgCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
