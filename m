Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF79EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:35:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7955721855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I4Vm2s28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7955721855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rBD/5gSiW+PyGmpyDhjIzatgK5EaConJIEVkSweNhzI=; b=I4Vm2s28/Tc6Dt
	wTvol1JYzfSswXx3/FnP9Mj7CG6ji/v9ggmmBtObN7H0s2WdRBoHqWLkXV2JTfvyBKWUDw4vTYzVM
	mk3mBD3cyabq4JttzZ6biGHix4gQn9txXqGR2L06t5dq0rsP4dt/iW4WN4fImLd14TYecCsAvsBsV
	PgpjgFATlvizCHKxpmUwEWatkW14ranvqRBcf5cstaOORwSitYJwSnPFS6WGXig3W1WUCxQQ2GsRX
	uJquDvCmANHhK46mZA9Zw9yXZ8hL1oz+djWEjNVgBQo9EAqRX9wkRSb3U/yIqnLubcST9jL6lKI5C
	NYRCgG2tfEi7ESfuxW2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxt6-000271-Sq; Fri, 25 Jan 2019 09:35:00 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxt2-00026G-EG
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:34:57 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmxst-0001Sj-1b; Fri, 25 Jan 2019 10:34:47 +0100
Message-ID: <1548408884.28802.33.camel@pengutronix.de>
Subject: Re: [PATCH v4 4/5] dma: imx-sdma: add a test for imx8mq multi sdma
 devices
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Fri, 25 Jan 2019 10:34:44 +0100
In-Reply-To: <20190125025528.15645-5-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
 <20190125025528.15645-5-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013456_634595_EA0DE200 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDI0LjAxLjIwMTksIDE5OjU1IC0wNzAwIHNjaHJpZWIgQW5ndXMg
QWluc2xpZSAoUHVyaXNtKToKPiBPbiBpLm14OG1xLCB0aGVyZSBhcmUgdHdvIHNkbWEgaW5zdGFu
Y2VzLCBhbmQgdGhlIGNvbW1vbiBkbWEgZnJhbWV3b3JrCj4gd2lsbCBnZXQgYSBjaGFubmVsIGR5
bmFtaWNhbGx5IGZyb20gYW55IGF2YWlsYWJsZSBzZG1hIGluc3RhbmNlIHdoZXRoZXIKPiBpdCdz
IHRoZSBmaXJzdCBzZG1hIGRldmljZSBvciB0aGUgc2Vjb25kIHNkbWEgZGV2aWNlLiBTb21lIElQ
cyBsaWtlCj4gU0FJIG9ubHkgd29yayB3aXRoIHNkbWEyIG5vdCBzZG1hMS4gVG8gbWFrZSBzdXJl
IHRoZSBzZG1hIGNoYW5uZWwgaXMgZnJvbQo+IHRoZSBjb3JyZWN0IHNkbWEgZGV2aWNlLCB1c2Ug
dGhlIHBoYW5kbGUgdG8gbWF0Y2guCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBBaW5zbGll
IChQdXJpc20pIDxhbmd1c0Bha2tlYS5jYT4KPiAtLS0KPiDCoGRyaXZlcnMvZG1hL2lteC1zZG1h
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgOCArKysrKysrKwo+IMKgaW5jbHVk
ZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXguaCB8IDEgKwo+IMKgMiBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEu
YyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPiBpbmRleCBlYzZmYjQ4ZjM4N2EuLjg4ZTExMmE0
YWFiZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jCj4gKysrIGIvZHJpdmVy
cy9kbWEvaW14LXNkbWEuYwo+IEBAIC0xOTI3LDExICsxOTI3LDE3IEBAIHN0YXRpYyBpbnQgc2Rt
YV9pbml0KHN0cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSkKPiDCoHN0YXRpYyBib29sIHNkbWFfZmls
dGVyX2ZuKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgdm9pZCAqZm5fcGFyYW0pCj4gwqB7Cj4gPiDC
oAlzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsKPiA+ICsJ
c3RydWN0IHNkbWFfZW5naW5lICpzZG1hID0gc2RtYWMtPnNkbWE7Cj4gPiDCoAlzdHJ1Y3QgaW14
X2RtYV9kYXRhICpkYXRhID0gZm5fcGFyYW07Cj4gwqAKPiA+IMKgCWlmICghaW14X2RtYV9pc19n
ZW5lcmFsX3B1cnBvc2UoY2hhbikpCj4gPiDCoAkJcmV0dXJuIGZhbHNlOwo+IMKgCj4gPiArCS8q
IHJldHVybiBmYWxzZSBpZiBpdCdzIG5vdCB0aGUgcmlnaHQgZGV2aWNlICovCj4gKwlpZiAoKHNk
bWFjLT5zZG1hLT5kcnZkYXRhID09ICZzZG1hX2lteDhtcSkKCldoeSBkbyB0aGlzIGNoZWNrIG9u
bHkgb24gaS5NWDhNPyBUaGlzIGlzIGNvbXBsZXRlbHkgZ2VuZXJpYyBhbmQgY2FuCmFuZCBzaG91
bGTCoGJlIGRvbmUgZm9yIGV2ZXJ5IFNETUEgZW5naW5lIHdpdGggYSBPRiBub2RlLgoKQWxzbyB3
aHkgdXNlIHRoZSBwaGFuZGxlIHRvIG1hdGNoIHRoaXMgaW5zdGVhZCBvZiB0aGUgb2Zfbm9kZSBw
b2ludGVyCmRpcmVjdGx5PwoKUmVnYXJkcywKTHVjYXMKCj4gKwkJJiYgKHNkbWEtPmRldi0+b2Zf
bm9kZS0+cGhhbmRsZSAhPSBkYXRhLT5waGFuZGxlKSkKPiA+ICsJCXJldHVybiBmYWxzZTsKPiAr
Cj4gPiDCoAlzZG1hYy0+ZGF0YSA9ICpkYXRhOwo+ID4gwqAJY2hhbi0+cHJpdmF0ZSA9ICZzZG1h
Yy0+ZGF0YTsKPiDCoAo+IEBAIC0xOTQyLDYgKzE5NDgsNyBAQCBzdGF0aWMgc3RydWN0IGRtYV9j
aGFuICpzZG1hX3hsYXRlKHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmRtYV9zcGVjLAo+ID4gwqAJ
CQkJwqDCoMKgc3RydWN0IG9mX2RtYSAqb2ZkbWEpCj4gwqB7Cj4gPiDCoAlzdHJ1Y3Qgc2RtYV9l
bmdpbmUgKnNkbWEgPSBvZmRtYS0+b2ZfZG1hX2RhdGE7Cj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnAgPSBvZmRtYS0+b2Zfbm9kZTsKPiA+IMKgCWRtYV9jYXBfbWFza190IG1hc2sgPSBzZG1h
LT5kbWFfZGV2aWNlLmNhcF9tYXNrOwo+ID4gwqAJc3RydWN0IGlteF9kbWFfZGF0YSBkYXRhOwo+
IMKgCj4gQEAgLTE5NTksNiArMTk2Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2NoYW4gKnNkbWFf
eGxhdGUoc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqZG1hX3NwZWMsCj4gPiDCoAnCoCogYmUgc2V0
IHRvIHNkbWFjLT5ldmVudF9pZDEuCj4gPiDCoAnCoCovCj4gPiDCoAlkYXRhLmRtYV9yZXF1ZXN0
MiA9IDA7Cj4gPiArCWRhdGEucGhhbmRsZSA9IG5wLT5waGFuZGxlOwo+IMKgCj4gPiDCoAlyZXR1
cm4gZG1hX3JlcXVlc3RfY2hhbm5lbChtYXNrLCBzZG1hX2ZpbHRlcl9mbiwgJmRhdGEpOwo+IMKg
fQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5oIGIv
aW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXguaAo+IGluZGV4IDdkOTY0ZTc4NzI5
OS4uZWViNWI3M2FlNTQyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0
YS9kbWEtaW14LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5o
Cj4gQEAgLTU1LDYgKzU1LDcgQEAgc3RydWN0IGlteF9kbWFfZGF0YSB7Cj4gPiDCoAlpbnQgZG1h
X3JlcXVlc3QyOyAvKiBzZWNvbmRhcnkgRE1BIHJlcXVlc3QgbGluZSAqLwo+ID4gwqAJZW51bSBz
ZG1hX3BlcmlwaGVyYWxfdHlwZSBwZXJpcGhlcmFsX3R5cGU7Cj4gPiDCoAlpbnQgcHJpb3JpdHk7
Cj4gPiArCWludCBwaGFuZGxlOwo+IMKgfTsKPiDCoAo+IMKgc3RhdGljIGlubGluZSBpbnQgaW14
X2RtYV9pc19pcHUoc3RydWN0IGRtYV9jaGFuICpjaGFuKQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
