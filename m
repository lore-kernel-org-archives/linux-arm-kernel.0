Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5068A21927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JE4S4w1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5068A21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EG3DL3sTH2HI2OHDRB7LuwkxTVj1Pacj2sjFML1sq7k=; b=JE4S4w1SAefuRp
	NxmWz4hocEFaahLLagDIoCbIMjPIuuDEfIWUBFgfBi5JAb3ztlw8uMDV4CFjtp1pPxJA8T6AqXqYN
	chZ45GPc08Hr05h6A6UMEekOxvsNedxJ2lWQabsFbCX0RGV6ADlTJFxBTdupeGCthMJehdZiCsfPu
	ORKkSPUj7nzfKYrXqqFtyTL584R+FkIDp7aDHxzPqXfyGFi4B6XNea+AHA1S7HYtCjZtSve8B7aNq
	13WcJAYCtn+eCUOVPVu/HBhrC44u1agt7pTqBCMt7FsDSg0KjtHhfnvANlSYum1cAxtC+339X9m88
	NQfSiRCKVtEFnsZt2Whw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufzm-0007gK-Q7; Fri, 15 Feb 2019 16:05:46 +0000
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]
 helo=mtlfep01.bell.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufzj-0007dr-RL
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:05:45 +0000
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net with ESMTP
 id <20190215160542.ECLL28651.mtlfep01.bell.net@mtlspm02.bell.net>
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:05:42 -0500
Received: from [192.168.0.138] (really [64.231.92.241])
 by mtlspm02.bell.net with ESMTP
 id <20190215160542.XNMD26679.mtlspm02.bell.net@[192.168.0.138]>;
 Fri, 15 Feb 2019 11:05:42 -0500
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
 (1f947a7a011fcceb14cb912f5481a53b18f1879a)
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
 <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com> <20190214173642.GA2704@lst.de>
 <fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
From: John David Anglin <dave.anglin@bell.net>
Openpgp: preference=signencrypt
Message-ID: <8f4cd5ad-1a29-0910-de19-65cd5bc87e73@bell.net>
Date: Fri, 15 Feb 2019 11:05:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=QLaHfkDL c=1 sm=0 tr=0
 a=jJmVOGxBrKxWvcjqaG+oVg==:17 a=IkcTkHD0fZMA:10 a=CFTnQlWoA9kA:10
 a=FBHGMhGWAAAA:8 a=nDzz-NkYIIUYEwoamN8A:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_080544_109132_DD13A037 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMi0xNCAxMjo1OCBwLm0uLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gSG1tLCBoYXZp
bmcgZmVsdCBicmF2ZSBlbm91Z2ggdG8gdGFrZSBhIGNsb3NlciBsb29rLCBpdCBtaWdodCBhY3R1
YWxseSBiZcKgYXPCoHNpbXBsZcKgYXPCoHRoaXPCoC3CoERhdmUswqBhcmXCoHlvdcKgYWJsZcKg
dG/CoGdpdmXCoHRoZcKgZGlmZsKgYmVsb3fCoGHCoHNwaW4/Cj4gCj4gUm9iaW4uCj4gCj4gLS0t
LS0+OC0tLS0tCj4gZGlmZsKgLS1naXTCoGEvZHJpdmVycy9kbWEvbXZfeG9yLmPCoGIvZHJpdmVy
cy9kbWEvbXZfeG9yLmMKPiBpbmRleMKgN2Y1OTUzNTVmYjc5Li5mZTRhN2M3MWZlZGXCoDEwMDY0
NAo+IC0tLcKgYS9kcml2ZXJzL2RtYS9tdl94b3IuYwo+ICsrK8KgYi9kcml2ZXJzL2RtYS9tdl94
b3IuYwo+IEBAwqAtMTA1OSw2wqArMTA1OSw3wqBAQMKgbXZfeG9yX2NoYW5uZWxfYWRkKHN0cnVj
dMKgbXZfeG9yX2RldmljZcKgKnhvcmRldiwKPiDCoMKgwqDCoMKgwqDCoMKgwqBtdl9jaGFuLT5v
cF9pbl9kZXNjwqA9wqBYT1JfTU9ERV9JTl9ERVNDOwo+IAo+IMKgwqDCoMKgwqBkbWFfZGV2wqA9
wqAmbXZfY2hhbi0+ZG1hZGV2Owo+ICvCoMKgwqDCoGRtYV9kZXYtPmRldsKgPcKgJnBkZXYtPmRl
djsKPiDCoMKgwqDCoMKgbXZfY2hhbi0+eG9yZGV2wqA9wqB4b3JkZXY7Cj4gCj4gwqDCoMKgwqDC
oC8qCj4gQEDCoC0xMDkxLDfCoCsxMDkyLDbCoEBAwqBtdl94b3JfY2hhbm5lbF9hZGQoc3RydWN0
wqBtdl94b3JfZGV2aWNlwqAqeG9yZGV2LAo+IMKgwqDCoMKgwqBkbWFfZGV2LT5kZXZpY2VfZnJl
ZV9jaGFuX3Jlc291cmNlc8KgPcKgbXZfeG9yX2ZyZWVfY2hhbl9yZXNvdXJjZXM7Cj4gwqDCoMKg
wqDCoGRtYV9kZXYtPmRldmljZV90eF9zdGF0dXPCoD3CoG12X3hvcl9zdGF0dXM7Cj4gwqDCoMKg
wqDCoGRtYV9kZXYtPmRldmljZV9pc3N1ZV9wZW5kaW5nwqA9wqBtdl94b3JfaXNzdWVfcGVuZGlu
ZzsKPiAtwqDCoMKgwqBkbWFfZGV2LT5kZXbCoD3CoCZwZGV2LT5kZXY7Cj4gCj4gwqDCoMKgwqDC
oC8qwqBzZXTCoHByZXDCoHJvdXRpbmVzwqBiYXNlZMKgb27CoGNhcGFiaWxpdHnCoCovCj4gwqDC
oMKgwqDCoGlmwqAoZG1hX2hhc19jYXAoRE1BX0lOVEVSUlVQVCzCoGRtYV9kZXYtPmNhcF9tYXNr
KSkKClRoZSBwYXRjaCBpcyBmaW5lIGFuZCBpdCBmaXhlcyB0aGUgYm9vdCBmYWlsdXJlLgoKSSBt
aXNhcHBsaWVkIGl0IGluIHByZXZpb3VzIHRlc3QuCgpUaGFua3MsCkRhdmUKCi0tIApKb2huIERh
dmlkIEFuZ2xpbiAgZGF2ZS5hbmdsaW5AYmVsbC5uZXQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
