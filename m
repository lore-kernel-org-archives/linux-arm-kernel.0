Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2BDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA3C2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QoUExERT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA3C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y5mkP+RrGk8PbAP2o9pVLH5G0q8irStBo6N/eGrsw4s=; b=QoUExERTZ29Yvt
	7xhs3lQmHu+JLUrqEEHlM0e/k07uKVbP8Tw7rkOoFxTKm379A+iNIoBvwakoJLz1SkEwkxv5zBBda
	mQPEzcWz54YW/tDZ1ACuQfvfPE6IMWGErIqik0zkVjom638vQKDEzPH1DzfZ9eQEasR7Gu/+WaN37
	AJRgRmaIzip0KeHI+zFW+BcJqgrtgn9Ui7reLS2w3bOXqeauiVHzWFGnCM39OC3DvVCJtxNkLhJfy
	6RyHclfYJ8YLlnT62fA67oqbdfpRKZatTh1+f1919Z5xRmIjAdMsCxXR2Gc7l6zKW/GHh59mZpT6f
	Lj1XZFo4fdrxRFu8H2QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6wJ-0008Rh-Pn; Tue, 19 Feb 2019 15:04:07 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6wF-0008Qx-Oa
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:04:06 +0000
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id D966E240008;
 Tue, 19 Feb 2019 15:03:51 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 jason@lakedaemon.net
Subject: Re: [PATCH] ARM: mvebu: kirkwood: remove error message when
 retrieving mac address
In-Reply-To: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz>
References: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz>
Date: Tue, 19 Feb 2019 16:03:51 +0100
Message-ID: <877edv3jmw.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_070404_204409_4278E948 
X-CRM114-Status: GOOD (  16.00  )
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
Cc: Russell King <linux@armlinux.org.uk>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hyaXMsCiAKIE9uIGx1bi4sIGbDqXZyLiAxOCAyMDE5LCBDaHJpcyBQYWNraGFtIDxjaHJp
cy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdyb3RlOgoKPiBLaXJrd29vZCBoYXMgYWx3
YXlzIGhhZCB0aGUgYWJpbGl0eSB0byByZXRyaWV2ZSB0aGUgbG9jYWwtbWFjLWFkZHJlc3MKPiBm
cm9tIHRoZSBoYXJkd2FyZSAodXN1YWxseSB0aGlzIHdhcyBjb25maWd1cmVkIGJ5IHRoZSBib290
bG9hZGVyKS4gVGhpcwo+IGlzIHBhcnRpY3VsYXJseSB1c2VmdWwgd2hlbiBkZWFsaW5nIHdpdGgg
YSBsZWdhY3kgbm9uLURUIGF3YXJlCj4gYm9vdGxvYWRlci4KPgo+IFRoZSAiZXJyb3IiIG1lc3Nh
Z2UganVzdCBpbmRpY2F0ZWQgdGhhdCB0aGUgYm9hcmQgdXNlZCBhbiBvbGQgYm9vdGxvYWRlcgo+
IGFuZCBpbiBtYW55IGNhc2VzIHVzZXJzIGNhbid0IGRvIGFueXRoaW5nIGFib3V0IHRoaXMuIFRo
ZSBtZXNzYWdlCj4gcHJvYmFibHkgc2hvdWxkIGhhdmUgYmVlbiBwcl9pbmZvKCkgdG8gaW5mb3Jt
IHRoZSB1c2VyIHRoYXQgdGhlIGtlcm5lbAo+IGhhcyBiZWVuIGhlbHBmdWwgYnV0IHJhdGhlciB0
aGFuIHRoYW4gbGV0J3MgcmVtb3ZlIGl0IGVudGlyZWx5IHRvIG1ha2UKPiB0aGUga2VybmVsIGxl
c3Mgbm9pc3kuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFt
QGFsbGllZHRlbGVzaXMuY28ubno+CgpJJ20gT0sgd2l0aCB0aGlzIHBhdGNoLCBob3dldmVyIGFz
IGl0IGlzIG5vdCBhIGZpeCwgaXQncyB0b28gbGF0ZSBmb3IKNS4xLiBJIHdpbGwgYXBwbHkgaXQg
b24gbXZlYnUvYXJtIGZvciA1LjIgb25jZSA1LjEtcmMxIHdpbGwgYmUgcmVsZWFzZWQuCgpUaGFu
a3MsCgpncmVnb3J5Cgo+IC0tLQo+ICBhcmNoL2FybS9tYWNoLW12ZWJ1L2tpcmt3b29kLmMgfCAy
IC0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtbXZlYnUva2lya3dvb2QuYyBiL2FyY2gvYXJtL21hY2gtbXZlYnUva2lya3dv
b2QuYwo+IGluZGV4IDBhYTg4MTA1ZDQ2ZS4uYmYzZmYwZjU4MGMyIDEwMDY0NAo+IC0tLSBhL2Fy
Y2gvYXJtL21hY2gtbXZlYnUva2lya3dvb2QuYwo+ICsrKyBiL2FyY2gvYXJtL21hY2gtbXZlYnUv
a2lya3dvb2QuYwo+IEBAIC0xMDcsOCArMTA3LDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGtpcmt3
b29kX2R0X2V0aF9maXh1cCh2b2lkKQo+ICAJCWNsa19wcmVwYXJlX2VuYWJsZShjbGspOwo+ICAK
PiAgCQkvKiBzdG9yZSBNQUMgYWRkcmVzcyByZWdpc3RlciBjb250ZW50cyBpbiBsb2NhbC1tYWMt
YWRkcmVzcyAqLwo+IC0JCXByX2VycihGV19JTkZPICIlcE9GOiBsb2NhbC1tYWMtYWRkcmVzcyBp
cyBub3Qgc2V0XG4iLCBucCk7Cj4gLQo+ICAJCXBtYWMgPSBremFsbG9jKHNpemVvZigqcG1hYykg
KyA2LCBHRlBfS0VSTkVMKTsKPiAgCQlpZiAoIXBtYWMpCj4gIAkJCWdvdG8gZXRoX2ZpeHVwX25v
X21lbTsKPiAtLSAKPiAyLjIwLjEKPgoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJl
ZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
