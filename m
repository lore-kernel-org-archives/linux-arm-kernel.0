Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69530C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:32:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5332081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a/tzlYKH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sp6MVQ3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5332081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nImvxoKnB/uufepEp8X4oGAAfzJuTp5kOyy45VAnzSU=; b=a/tzlYKHYWfCOA
	IdiknrD8ZDJD5cd3uB2ogXKE38ckHNqfvsPHrMYKqsSEddO71SIYv+rIx0iGONAfdU3g+RCx7/bKQ
	Wqk9GEHT0n6N688tOPy22VSD194pbrWQvGL3n8ehzvsrNim2Jt0k47t9qY13YzSIgGvga/xS/vhfv
	Q+/y/ijTKNgIblGKTL2SpMXlbwFULHWeFG9ha2ex410arx8YE7kGrTOpkVpNFXPPZpZaMxgQ6FWok
	bVez9Fer6lUBRRMcQwr6+ej8htynKSr/oCU54cqYJlE16hj3JxSDO/FOzSEnkVpwEAJfbYBNJnVXx
	KLYUc8CHWs2asoaDr8+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWj56-0005zd-UY; Tue, 11 Dec 2018 14:32:16 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWj52-0005z0-6o
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:32:14 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBEVmpG122803;
 Tue, 11 Dec 2018 08:31:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544538708;
 bh=z6RMwz2aS+JQ4j1x2hc42fwAFUQIeAkM/A40ClKL7RA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Sp6MVQ3t6CBXChXQVnTydjiEh8ASSrmdhet0yY0L3EItmsHc73nfbx0jaKIH3VaC0
 slGoKA03Yrcf+9GJ28hFRQDq4Psdno1RAg/APcs/B9cfjiHEld6evnPUqNiyGTYyVF
 tbmfbVGLI6B8yJkUkzYHwL/7xPMgIJL3O2miZIDc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBEVmK1017490
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 08:31:48 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 08:31:47 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 08:31:48 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBEVjx3006171;
 Tue, 11 Dec 2018 08:31:46 -0600
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Ulf Hansson
 <ulf.hansson@linaro.org>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
 <CAPDyKFr=vqNh+auGXjYJs+oq70+VksuOJNF7cFm-VifSKf6f9w@mail.gmail.com>
 <20181211134937.GE9507@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1ecb5b44-92a9-cf05-cb5f-eabb1f3b001f@ti.com>
Date: Tue, 11 Dec 2018 16:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211134937.GE9507@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_063212_329145_702ED570 
X-CRM114-Status: GOOD (  23.17  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Kishon <kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UnVzc2VsbCwKCk9uIDExLzEyLzIwMTggMTUuNDksIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3
cm90ZToKPj4+IFRoZSBvbmx5IHRoaW5nIEkgY2FuIHRoaW5rIG9mIGRvaW5nIGlzIGFkZGluZyBp
bnRvIG9tYXBfaHNtbWM6Cj4+Pgo+Pj4gICAgICAgICBtbWMtPm1heF9zZWdfc2l6ZSA9IG1pbiht
bWMtPm1heF9yZXFfc2l6ZSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWlu
KGRtYV9nZXRfbWF4X3NlZ19zaXplKGhvc3QtPnJ4X2NoYW4tPmRldmljZS0+ZGV2KSwKPj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9nZXRfbWF4X3NlZ19zaXplKGhv
c3QtPnR4X2NoYW4tPmRldmljZS0+ZGV2KSkpOwo+Pj4KPj4+IHRvIGxpbWl0IHRoZSBtYXhpbXVt
IHNlZ21lbnQgc2l6ZSB0byB0aGF0IG9mIHRoZSBkZXZpY2UgX2FuZF8gZG1hCj4+PiBlbmdpbmUn
cyBjYXBhYmlsaXRpZXMuCj4+Pgo+Pj4gRG9pbmcgdGhpcyBzb2x2ZXMgdGhlIHByb2JsZW0gZm9y
IG1lLgo+Pgo+PiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIC0gaXQgc291bmRzIGxpa2UgYSBy
ZWFzb25hYmxlIHdheSB0byBmaXggdGhlCj4+IHByb2JsZW0sIGF0IGxlYXN0IGZvciBub3cuCj4g
Cj4gSSBkb24ndCB0aGluayB0aGVyZSdzIGFueSAiYXQgbGVhc3QgZm9yIG5vdyIgYWJvdXQgdGhp
cyBhcHByb2FjaCAtIGl0J3MKPiBub3Qgc29tZXRoaW5nIHRoYXQgdGhlIE1NQyBjb3JlIGNhbiBr
bm93IGFib3V0LCBiZWNhdXNlIHdoZXRoZXIgYSBkcml2ZXIKPiB1c2VzIERNQSBlbmdpbmUgb3Ig
bm90LCBhbmQgaG93IG1hbnkgY2hhbm5lbHMgaXQgdXNlcyBpcyBjb21wbGV0ZWx5Cj4gZHJpdmVy
IHNwZWNpZmljLgoKSSBhZ3JlZS4KCj4gVGhlIG9ubHkgcXVlc3Rpb25hYmxlIHRoaW5nIGlzIGFy
b3VuZCB0aGUgZG1hX2dldF9tYXhfc2VnX3NpemUoKQo+IGludGVyZmFjZSwgYnV0IHRoZSBvbmx5
IHdheSB0aGF0J3MgZ29pbmcgdG8gZ2V0IHNvbHZlZCBpcyB0byBlbGltaW5hdGUKPiBpdCBlbnRp
cmVseSBhcyBpdCBpc24ndCBhIHBlci1kZXZpY2UgcHJvcGVydHkgd2l0aCBzb21lIERNQSBlbmdp
bmVzCj4gc3VjaCBhcyBvbWFwLWRtYSAtIGl0J3MgYSBwZXItcmVxdWVzdCBwcm9wZXJ0eS4gIFRo
YXQgYWxzbyBtZWFucwo+IGtpbGxpbmcgdGhlIGNoZWNrIGluIHRoZSBETUEgZGVidWcgY29kZSwg
d2hpY2ggaXNuJ3QgZ29pbmcgdG8gZ28gZG93bgo+IHZlcnkgd2VsbC4KPiAKPj4gRG8geW91IHdh
bnQgdG8gc2VuZCB0byBwYXRjaCBvciBkbyB5b3UgZXhwZWN0IHNvbWVvbmUgZWxzZSB0byBkbyBp
dD8KPiAKPiBJJ2xsIHNlbmQgYSBwYXRjaCBvbmNlIEkndmUgY2hlY2tlZCB0aGUgY29ybmVyIGNh
c2VzLCBhbmQgd2hldGhlcgo+IHdlIHNob3VsZCBnbyBmdXJ0aGVyIGFuZCBpbmNsdWRlIG90aGVy
IERNQSBwYXJhbWV0ZXJzIGZyb20gdGhlCj4gZG1hIGVuZ2luZS4KClRoZXJlIGlzIG9uZSB0aGlu
ZyB3aGljaCBJJ20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQ6CnNETUEgKGFuZCBFRE1BIGFsc28pIGhh
dmUgbGltaXRhdGlvbiBvbiB0aGUgbGVuZ3RoIG9mIGVhY2ggc2cgc2VnbWVudC4KClRvIG1ha2Ug
dGhpbmdzIGEgYml0IG1vcmUgaW50ZXJlc3RpbmcgdGhlIGxpbWl0IGlzIG5vdCBpbiBieXRlcywg
YnV0IGluCm51bWJlciBvZiBidXJzdHM6Cgo2NTUzNSAqIGJ1cnN0ICogYWRkcl93aWR0aCA9IG1h
eF9zZ19zZWdtZW50X2xlbiBpbiBieXRlcy4KCldlIGNhbiBub3Qgc2V0IHRoaXMgdG8gYSBzdGF0
aWMgdmFsdWUgYXMgZGVwZW5kaW5nIG9uIHRoZSBhZGRyX3dpZHRoIGFuZApidXJzdCBpdCBjYW4g
YmUgZGlmZmVyZW50IGZvciBlYWNoIHRyYW5zZmVyLgoKLSBQw6l0ZXIKClRleGFzIEluc3RydW1l
bnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51
cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
