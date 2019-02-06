Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880ECC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555572080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tl2ollon";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bM1+Hdhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555572080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P86JUSAxD2D+APtd1v3RchN7yrEfe0vUxQZzBKkm2rU=; b=tl2ollonJfnIo8
	8rBo0TedrV8cBlCPbMzmZQmAki97rh3oqEvVtPd0XSqVDiYpRDx7ePeNQO3yAflmAVUv+iIEvjhs3
	RspY6GMetlvJweF+8xCyc+2HSmmqFD8Qyiu7eGk/Ali+IJTT9Ou+oa5s4D+xixpLFknRd/G8LIhXR
	aDgbuGQKro7cFdf4gZGpmgDbcmgnnk82jT8wgWcZ1oqjvlX/9iLKULwiX8jKMYjKRdhGJY2SVuvDq
	WDao3lQHIS3LiIybfiRmZXj71xiNj6CoLVbxPHCGDenkLiINiiMcQ+4j8hX0E32VePAlHHiIX22PX
	WOfPcIvzhf8QixmWWZ5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLE3-0001CE-3Y; Wed, 06 Feb 2019 11:18:43 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLDz-0001Bj-Nk
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:18:41 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16BIQF9105556;
 Wed, 6 Feb 2019 05:18:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549451906;
 bh=6KLtT6t2MhwFlIQe4mzX9zJaY6RcA71GnYnsQ6Rnvgc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=bM1+HdhrNKm315kjSkS7qVxOWu7Gqw+Q8IIn2g+dKU1ZLXTQUJZYtEDL1AdNwHjfL
 J7B3IsCu3slnWom0/CLtCw4E+hwK9YiwST6xx9nJQytH62AR05K0crY9PAETQy2lZz
 7x+J9HwC3fw85lwEbBwvZ2FXI6QzwUjFan8RC0FU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16BIQng024728
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 05:18:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:18:25 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:18:25 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16BIHdF022104;
 Wed, 6 Feb 2019 05:18:19 -0600
Subject: Re: [PATCH v5 0/7] Add Armada 3700 COMPHY support
To: Miquel Raynal <miquel.raynal@bootlin.com>, Gregory Clement
 <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew
 Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com>
 <20190206095743.5eed3584@xps13>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <300b86e7-1d00-da92-2203-a7cfeb2d7aa8@ti.com>
Date: Wed, 6 Feb 2019 16:47:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190206095743.5eed3584@xps13>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_031839_876679_08E58695 
X-CRM114-Status: GOOD (  28.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAwNi8wMi8xOSAyOjI3IFBNLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+IEhpIEtpc2hv
biwKPiAKPiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZSBv
biBUdWUsICA4IEphbiAyMDE5Cj4gMTc6MzE6MTcgKzAxMDA6Cj4gCj4+IEhlbGxvLAo+Pgo+PiBU
aGlzIHNlcmllcyBhZGRzIGEgbmV3IGRyaXZlciB0byBzdXBwb3J0IEFybWFkYSAzNzAwIENPTVBI
WSBJUC4KPj4gVGhlIHNlcmllcyBoYXMgYmVlbiB0ZXN0ZWQgb24gYW4gRVNQUkVTU09iaW4gd2l0
aCBTQVRBLCBQQ0llCj4+IGFuZCBVU0IzIGhvc3QuIEZvciB0aGlzIHB1cnBvc2UsIHBhdGNoIDEg
ZW51bWVyYXRlcyB0aGUgU0FUQSBQSFkKPj4gbW9kZS4gVGhlIFNHTUlJIFBIWSBtb2RlIHRoYXQg
aXMgc3VwcG9ydGVkIGJ5IHRoZSBJUCBoYXMgYmVlbiB3cml0dGVuCj4+ICh1c2VzIFNNQyBjYWxs
cyBhbnl3YXkpIGJ1dCBjb3VsZCBub3QgYmUgdGVzdGVkIG9uIHRoaXMgcGxhdGZvcm0uCj4+Cj4+
IFRocmVlIHNlcmllcyB3aWxsIGZvbGxvdyB0byBhZGQgUEhZIHN1cHBvcnQgKG9yIGF0IGxlYXN0
IGEgUEhZIG5vZGVzCj4+IGluIHRoZSBBMzcwMC9FU1BSRVNTT2JpbiBkZXZpY2UgdHJlZXMpIHRv
IHRoZSBNVkVCVSBBSENJIGRyaXZlciwgdGhlCj4+IEFhcmR2YXJrIFBDSSBjb250cm9sbGVyIGRy
aXZlciBhbmQgdGhlIE1WRUJVIHhIQ0kgZHJpdmVyLiBBbGwgdGhpcyBpcwo+PiBuZWVkZWQgaW4g
b3JkZXIgdG8gYWNoaWV2ZSBzdXNwZW5kIHRvIFJBTSBvbiB0aGlzIHBsYXRmb3JtLgo+Pgo+PiBU
aGFua3MsCj4+IE1pcXXDqGwKPj4KPiAKPiBBbnkgaW5wdXRzIG9uIHRoaXMgc2VyaWVzPyBJdCBp
cyBpbXBvcnRhbnQgZm9yIG1lIGJlY2F1c2UgaXQgaW1wYWN0cwo+IFNBVEEsIFBDSWUgYW5kIFVT
QiBjaGFuZ2VzIEkgcGxhbiB0byBnZXQgbWVyZ2UuCgptZXJnZWQgbm93LCB0aGFua3MuCgotS2lz
aG9uCj4gCj4gVGhhbmtzLAo+IE1pcXXDqGwKPiAKPj4KPj4gQ2hhbmdlcyBzaW5jZSB2NDoKPj4g
PT09PT09PT09PT09PT09PT0KPj4gKiBGaXhlZCBlcnJvciBpbiB0aGUgZHJpdmVyIHByb2JlIHdo
ZXJlIFBIWV9JTlRFUkZBQ0VfTU9ERV9OQSB3YXMKPj4gICBhc3NpZ25lZCB0byBsYW5lLT5tb2Rl
IGluc3RlYWQgb2YgbGFuZS0+c3VibW9kZS4KPj4gKiBDb21waWxlLWluIHRoZSBkcml2ZXIgYnkg
ZGVmYXVsdCAoZGVwZW5kcyBvbiBBUkNIX01WRUJVKS4KPj4gKiBBZGQgZGVwZW5kZW5jeSBvbiBI
QVZFX0FSTV9TTUNDIGluIEtjb25maWcuCj4+Cj4+IENoYW5nZXMgc2luY2UgdjM6Cj4+ID09PT09
PT09PT09PT09PT09Cj4+ICogQWRkZWQgUm9iJ3MgUmV2aWV3ZWQtYnkgdGFnIG9uIGJpbmRpbmdz
Lgo+PiAqIFJlYmFzZWQgb24gdG9wIG9mIHBoeSAtbmV4dCBhcyBvZiB0aGUgMTJ0aCBvZiBEZWNl
bWJlciwgMjAxOC4KPj4gKiBBZGFwdGVkIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCBTR01JSS8xMDAw
QkFTRVggYW5kCj4+ICAgSFNfU0dNSUkvMjUwMEJBU0VYLgo+Pgo+PiBDaGFuZ2VzIHNpbmNlIHYy
Ogo+PiA9PT09PT09PT09PT09PT09PQo+PiAqIFJlbW92ZSByZWR1bmRhbnQgY2hlY2sgb24gbGFu
ZS0+cG9ydC9hcmdzLT5hcmdbMF0gYXQgdGhlIGVuZCBvZiB0aGUKPj4gICAtPnhsYXRlKCkgY2Fs
bGJhY2suIERvIGl0IG9uIGJvdGggYXJtYWRhLWNwMTEwIGFuZCBhcm1hZGEtYTM3MDAgIAo+PiAg
IENPTVBIWSBkcml2ZXJzLgo+PiAqIFB1dCBteSBTb0IgYXMgYXV0aG9yIG9mIHRoZSBwYXRjaCBm
aXJzdCB3aGVuIGEgcGF0Y2ggaXMgY28tZGV2ZWxvcGVkLgo+Pgo+PiBDaGFuZ2VzIHNpbmNlIHYx
Ogo+PiA9PT09PT09PT09PT09PT09PQo+PiAqIEZpeCB3cm9uZyBjaGVjayBpbiAtPnhsYXRlKCku
Cj4+ICogQXBwbHkgdGhlIHNhbWUgZml4IHRvIHRoZSBjcDExMCBjb21waHkgZHJpdmVyIGZyb20g
d2hpY2ggdGhlIGEzNzAwCj4+ICAgZHJpdmVyIGlzIGJhc2VkLgo+PiAqIEFkZGVkIGNyZWRpdCB0
byBHcmVnb3J6IEphc3pjenlrIGZvciBoaXMgd29yay4KPj4gKiBBZGRlZCBTdWdnZXN0ZWQtYnkg
dGFnIHRvIHRoZSBwYXRjaCBhZGRpbmcgdGhlIENPTVBIWSBEVCBub2RlLgo+Pgo+Pgo+PiBHcnpl
Z29yeiBKYXN6Y3p5ayAoMSk6Cj4+ICAgcGh5OiBlbnVtZXJhdGUgU0FUQSBQSFkgbW9kZQo+Pgo+
PiBNaXF1ZWwgUmF5bmFsICg2KToKPj4gICBwaHk6IG12ZWJ1LWNwMTEwLWNvbXBoeTogZml4IHBv
cnQgY2hlY2sgaW4gLT54bGF0ZSgpCj4+ICAgcGh5OiBhZGQgQTM3MDAgQ09NUEhZIHN1cHBvcnQK
Pj4gICBkdC1iaW5kaW5nczogcGh5OiBtdmVidS1jb21waHk6IGV4dGVuZCB0aGUgZmlsZSB0byBk
ZXNjcmliZSBhMzcwMAo+PiAgICAgYmluZGluZ3MKPj4gICBNQUlOVEFJTkVSUzogcGh5OiBhZGQg
ZW50cnkgZm9yIEFybWFkYSAzNzAwIENPTVBIWSBkcml2ZXIKPj4gICBBUk02NDogZHRzOiBtYXJ2
ZWxsOiBhcm1hZGEtMzd4eDogZml4IFNBVEEgbm9kZSBzY29wZQo+PiAgIEFSTTY0OiBkdHM6IG1h
cnZlbGw6IGFybWFkYS0zN3h4OiBkZWNsYXJlIHRoZSBDT01QSFkgbm9kZQo+Pgo+PiAgLi4uL2Jp
bmRpbmdzL3BoeS9waHktbXZlYnUtY29tcGh5LnR4dCAgICAgICAgIHwgIDY1ICsrKy0KPj4gIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArCj4+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSAgfCAgMzEgKy0KPj4g
IGRyaXZlcnMvcGh5L21hcnZlbGwvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAxMiArCj4+
ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+
PiAgZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtY29tcGh5LmMgIHwgMzE4ICsr
KysrKysrKysrKysrKysrKwo+PiAgZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtY3AxMTAt
Y29tcGh5LmMgIHwgICAyIC0KPj4gIGluY2x1ZGUvbGludXgvcGh5L3BoeS5oICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArCj4+ICA4IGZpbGVzIGNoYW5nZWQsIDQyMSBpbnNlcnRpb25zKCsp
LCAxNSBkZWxldGlvbnMoLSkKPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9tYXJ2
ZWxsL3BoeS1tdmVidS1hMzcwMC1jb21waHkuYwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
