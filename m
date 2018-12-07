Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:39:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA2920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eyMPVpDr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kWXvJ4eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA2920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bk+q1WMpt8hTjEI0yELY8o5e0SaSXc8mg5H8Yulsn1s=; b=eyMPVpDr4ruzxX7VHXKtkdRy5t
	o3F3+npWEfEk6Dqhvl2ajKEJCbbn2+2vchxQqCQIOKeaCgGyLNvKvZ42pe7SvYn6flXbbn6l59KwQ
	KuJH3faOvzABzS6Izx3ZKM8P95S9k9ws2dvBHmgFbDk3nlxjT6Wb/zh5hHUyFT1ipRqPj2LU5TPWN
	tzhp2lhYTpZdC/Uc7ggrubAuWA/AwVYrCfuRpqmyntsuQFIssTf0UidRZY5wFKmpW7mFeZbmiyuX3
	AilKbYa38GqiUHTJXRRnJwcsAF8SDlWTp3VHNpjfBX+uIWxMCkg1fzdRxiKyfbXv35J8MaW+211EK
	kT9AibZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGLK-0005zu-8N; Fri, 07 Dec 2018 13:38:58 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGLG-0005zS-GE
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:38:56 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB7DcZtw022812;
 Fri, 7 Dec 2018 07:38:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544189915;
 bh=VZ2ddh/yumJv12NJIjjDwmcuqjpickeSaGMbFk1/naI=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=kWXvJ4eJn+x5+WGhrXQDybSr0Pw6LK2LYtwokMH/sbbziQd6jn2aHgSJ8K4Twg1Gr
 lx0RnFmjJbXh9exsRxFBI9O/SdX7B2qdNqySfeQMFrIz304hdpd2Bj8cDcc5i9BrwX
 z25sUfrd/vsfRvboFCp2ORbDa7aOHbUHXY2115JE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB7DcZKq027803
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 07:38:35 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 07:38:35 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 07:38:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7DcXE7022292;
 Fri, 7 Dec 2018 07:38:33 -0600
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Tony Lindgren
 <tony@atomide.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
Date: Fri, 7 Dec 2018 15:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207125224.GW6920@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_053854_627834_8638DEF3 
X-CRM114-Status: GOOD (  27.11  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UnVzc2VsbCwKCk9uIDA3LzEyLzIwMTggMTQuNTIsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3
cm90ZToKPiBJdCB3YXMgbm90aWNlZCB0aGF0IHVuYmluZGluZyBhbmQgcmViaW5kaW5nIHRoZSBL
U1o4ODUxIGV0aGVybmV0Cj4gcmVzdWx0ZWQgaW4gdGhlIGRyaXZlciByZXBvcnRpbmcgImZhaWxl
ZCB0byByZWFkIGRldmljZSBJRCIgYXQgcHJvYmUuCj4gUHJvYmluZyB0aGUgcmVzZXQgbGluZSB3
aXRoIGEgJ3Njb3BlIHdoaWxlIHJlcGVhdGVkbHkgYXR0ZW1wdGluZyB0bwo+IGJpbmQgdGhlIGRy
aXZlciBpbiBhIHNoZWxsIGxvb3AgcmV2ZWFsZWQgdGhhdCB0aGUgS1NaODg1MSBSU1ROIHBpbiBp
cwo+IGNvbnN0YW50bHkgaGVsZCBhdCB6ZXJvLCBtZWFuaW5nIHRoZSBkZXZpY2UgaXMgaGVsZCBp
biByZXNldCwgYW5kCj4gZG9lcyBub3QgcmVzcG9uZCBvbiB0aGUgU1BJIGJ1cy4KPiAKPiBFeHBl
cmltZW50YXRpb24gd2l0aCB0aGUgc3RhcnR1cCBkZWxheSBvbiB0aGUgcmVndWxhdG9yIHNldCB0
byA1MG1zCj4gc2hvd3MgdGhhdCB0aGUgcmVzZXQgaXMgcG9zaXRpdmVseSByZWxlYXNlZCBhZnRl
ciAyMG1zLgo+IAo+IFNjaGVtYXRpY3MgZm9yIHRoaXMgYm9hcmQgYXJlIG5vdCBhdmFpbGFibGUs
IGFuZCB0aGUgdHJhY2VzIGFyZSBidXJpZWQKPiBpbiB0aGUgaW5uZXIgbGF5ZXJzIG9mIHRoZSBi
b2FyZCB3aGljaCBtYWtlcyB0cmFjaW5nIHdoZXJlIHRoZSBSU1ROIHBpbgo+IGV4dHJlbWVseSBk
aWZmaWN1bHQuICBXZSBjYW4gb25seSBndWVzcyB0aGF0IHRoZSBSU1ROIHBpbiBpcyB3aXJlZCB0
byBhCj4gcmVzZXQgZ2VuZXJhdG9yIGNoaXAgZHJpdmVuIG9mZiB0aGUgZXRoZXJuZXQgc3VwcGx5
LCB3aGljaCBmaXRzIHRoZQo+IG9ic2VydmVkIGJlaGF2aW91ci4KCkJhc2VkIG9uIHRoZSBzY2hl
bWF0aWNzIG9mIHRoZSBCbGF6ZSBkZXZpY2UgKHdoaWNoIHNob3VsZCBiZSB2ZXJ5IGNsb3NlCnRv
IFNEUDQ0MzApOgoKVFBTMjI5MDJZRlBSIGlzIHVzZWQgYXMgdGhlIHJlZ3VsYXRvciBzd2l0Y2gg
KGdwaW80OCBjb250cm9sbGVkKQpUaGUgVk9VVCBpcyByb3V0ZWQgdG8gIFRQUzM4MDhHMDFEQlYg
KFNDSCBOb3RlOiBUaHJlc2hvbGQgc2V0IGF0IDkwJS4KVnNlbnNlOiAwLjQwNVYpLgoKQWNjb3Jk
aW5nIHRvIHRoZSBUUFMzODA4IGRhdGEgc2hlZXQgdGhlIFJFU0VUIGRlbGF5IHRpbWUgd2hlbiBD
dCBpcyBvcGVuCih0aGlzIGlzIHRoZSBjYXNlIGluIHRoZSBzY2hlbWEpOiBNSU4vVFlQL01BWDog
MTIvMjAvMjggbXMuCgpUaGUgMjBtcyB5b3UgYXJlIHNlZWluZyBjb25maXJtcyB0aGlzIHNldHVw
LgoKPiBJbmNsdWRlIHRoaXMgZGVsYXkgaW4gdGhlIHJlZ3VsYXRvciBzdGFydHVwIGRlbGF5IC0g
ZWZmZWN0aXZlbHkKPiB0cmVhdGluZyB0aGUgcmVzZXQgYXMgYSAic3VwcGx5IHN0YWJsZSIgaW5k
aWNhdG9yLgo+IAo+IFRoaXMgY2FuIG5vdCBiZSBtb2RlbGxlZCBhcyBhIGRlbGF5IGluIHRoZSBL
U1o4ODUxIGRyaXZlciBzaW5jZSB0aGUKPiByZXNldCBnZW5lcmF0aW9uIGlzIGJvYXJkIHNwZWNp
ZmljIC0gaWYgdGhlIFJTVE4gcGluIGhhZCBiZWVuIHdpcmVkIHRvCj4gYSBHUElPLCByZXNldCBj
b3VsZCBiZSByZWxlYXNlZCBlYXJsaWVyIHZpYSB0aGUgYWxyZWFkeSBwcm92aWRlZCBzdXBwb3J0
Cj4gaW4gdGhlIEtTWjg4NTEgZHJpdmVyLgoKUmV2aWV3ZWQtYnk6IFBldGVyIFVqZmFsdXNpIDxw
ZXRlci51amZhbHVzaUB0aS5jb20+Cgo+IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyA8cm1r
K2tlcm5lbEBhcm1saW51eC5vcmcudWs+Cj4gLS0tCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL29tYXA0
LXNkcC5kdHMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA0LXNkcC5kdHMgYi9hcmNoL2FybS9ib290
L2R0cy9vbWFwNC1zZHAuZHRzCj4gaW5kZXggMDgzMWEyYmY2Y2VjLi41N2FjZjNhOGI4YTEgMTAw
NjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQtc2RwLmR0cwo+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL29tYXA0LXNkcC5kdHMKPiBAQCAtMzMsNiArMzMsNyBAQAo+ICAJCWdwaW8g
PSA8JmdwaW8yIDE2IEdQSU9fQUNUSVZFX0hJR0g+OyAgLyogZ3BpbyBsaW5lIDQ4ICovCj4gIAkJ
ZW5hYmxlLWFjdGl2ZS1oaWdoOwo+ICAJCXJlZ3VsYXRvci1ib290LW9uOwo+ICsJCXN0YXJ0dXAt
ZGVsYXktdXMgPSA8MjUwMDA+Owo+ICAJfTsKPiAgCj4gIAl2YmF0OiBmaXhlZHJlZ3VsYXRvci12
YmF0IHsKPiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2Fs
YW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEt
NC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
