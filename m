Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A23218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUF34PNV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Areo76/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A23218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ekL9jRR3KyKyZyAIYGXTqBeEyxxk0XQFQ0O3mi3O5N0=; b=ZUF34PNV6dRkyq
	DhYLfYJLKsOxvqct0FSiaO4V39Zzj7tuGtrS4IA+DXEs8awrWesiD6wHr/PYU6GJ7JFBvAKeU6vzL
	3sbBqgrRKJehZfPpH4Cw6TciM26ylZlbqUeoSA8BilyOg4xisAHPDtnpBy+E4se1aFBdm6FPGjArP
	NPX/PKReE/XFo3c8nx87mYVnPYjFA8JXz4p3lXY1laXM6esqMvaw78s+AvFMWJDV3MKvlq0tlWHGk
	SIjj6y7DNxtDv1zQfH8Mc1WA4qhKiKH3iAdAqY48LLhWzhjBE/kD4rhQa7vy37ZKxdMPcCJHf2oaR
	kJdCv3FjWPbZd0lQFPYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gelNQ-0000ln-Go; Wed, 02 Jan 2019 18:36:24 +0000
Received: from smtprelay4.synopsys.com ([198.182.47.9]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gelNN-0000ko-1s
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 18:36:22 +0000
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
 by smtprelay.synopsys.com (Postfix) with ESMTP id 4D89D24E0EA3;
 Wed,  2 Jan 2019 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1546454178; bh=QZ1F5Bc2hwQdWvFOj5M8RYiUnujm9yVhM6A5Xc0RMr8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=Areo76/dBuaCYgF7pNjh90m+Z6YWpadZ90vPKQT1pPJ5CR4qeTAh43b9EuYgIrPKM
 nMPxHe41qSGIDkap822H+ktNTTwvguc6cmpEIk89lfvQt05TXrMK1dwCXrhFPTpJAw
 iOFc8eR34mc0b8B6rbNyFHxWZSyzvXKqAmFg++oNK3wPE7ShMI7fgo1swC+jm8egFR
 2semBzzbBA1ro0x81GM3Dpat/kFXe/YRkUSDq1ARFsi8sRoRpg5Km3ONpeIk6sM2vn
 ghB5SzeqIdwsktfIaKeWawaC3k8U2YLduJVNKtG8Ckw3C9YWjXBxFnp9E+rqWCxDg+
 1MOH1hbYbsbVQ==
Received: from US01WEHTC3.internal.synopsys.com
 (us01wehtc3.internal.synopsys.com [10.15.84.232])
 by mailhost.synopsys.com (Postfix) with ESMTP id 2D3B631CD;
 Wed,  2 Jan 2019 10:36:18 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 10:36:16 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 19:36:14 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 19:36:14 +0100
Subject: Re: [PATCH 11/21] PCI: designware: Make use of BIT() in constant
 definitions
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-12-andrew.smirnov@gmail.com>
 <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
 <CAHQ1cqH3uFj51ORhp1eHPp6jVNoM0D1nv5qHvQESnmPX3-ESoQ@mail.gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <0fd12beb-1e53-4596-a261-9870452a6c19@synopsys.com>
Date: Wed, 2 Jan 2019 18:31:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqH3uFj51ORhp1eHPp6jVNoM0D1nv5qHvQESnmPX3-ESoQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.107.25.131]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_103621_143416_42F73267 
X-CRM114-Status: GOOD (  14.97  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabio
 Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAwMi8wMS8yMDE5IDE4OjI4LCBBbmRyZXkgU21pcm5vdiB3cm90ZToKPiBPbiBXZWQs
IERlYyAyNiwgMjAxOCBhdCA3OjE5IEFNIEd1c3Rhdm8gUGltZW50ZWwKPiA8Z3VzdGF2by5waW1l
bnRlbEBzeW5vcHN5cy5jb20+IHdyb3RlOgo+Pgo+PiBIaSwKPj4KPj4gT24gMjEvMTIvMjAxOCAw
NzoyNywgQW5kcmV5IFNtaXJub3Ygd3JvdGU6Cj4+PiBBdm9pZCB1c2luZyBleHBsaWNpdCBsZWZ0
IHNoaWZ0cyBhbmQgY29udmVydCB2YXJpb3VzIGRlZmluaXRpb25zIHRvCj4+PiB1c2UgQklUKCkg
aW5zdGVhZC4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuCj4+Pgo+Pj4gQ2M6IExvcmVu
em8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPgo+Pj4gQ2M6IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4+PiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8u
ZXN0ZXZhbUBueHAuY29tPgo+Pj4gQ2M6IENocmlzIEhlYWx5IDxjcGhlYWx5QGdtYWlsLmNvbT4K
Pj4+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPj4+IENjOiBMZW9u
YXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPgo+Pj4gQ2M6ICJBLnMuIERvbmci
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPj4+IENjOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1
QG54cC5jb20+Cj4+PiBDYzogbGludXgtaW14QG54cC5jb20KPj4+IENjOiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnCj4+PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZwo+Pj4gU2lnbmVkLW9mZi1ieTog
QW5kcmV5IFNtaXJub3YgPGFuZHJldy5zbWlybm92QGdtYWlsLmNvbT4KPj4+IC0tLQo+Pj4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgIDIgKy0KPj4+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCB8IDE4ICsrKysrKysr
Ky0tLS0tLS0tLQo+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmMKPj4+IGluZGV4IGQxMjNhYzI5MGI5ZS4uMDg2ZTg3YTQwMzE2IDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMKPj4+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jCj4+PiBAQCAt
MzAwLDcgKzMwMCw3IEBAIHZvaWQgZHdfcGNpZV9kaXNhYmxlX2F0dShzdHJ1Y3QgZHdfcGNpZSAq
cGNpLCBpbnQgaW5kZXgsCj4+PiAgICAgICB9Cj4+Pgo+Pj4gICAgICAgZHdfcGNpZV93cml0ZWxf
ZGJpKHBjaSwgUENJRV9BVFVfVklFV1BPUlQsIHJlZ2lvbiB8IGluZGV4KTsKPj4+IC0gICAgIGR3
X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfQVRVX0NSMiwgflBDSUVfQVRVX0VOQUJMRSk7Cj4+
PiArICAgICBkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0FUVV9DUjIsICh1MzIpflBDSUVf
QVRVX0VOQUJMRSk7Cj4+Cj4+IFRoaXMgaXMgdW5yZWxhdGVkIHdpdGggdGhlIHBhdGNoIGRlc2Ny
aXB0aW9uIHB1cnBvc2UuCj4+Cj4gCj4gVGhpcyBpcyBhIGRpcmVjdCByZXN1bHQgb2YgY29udmVy
dGluZyBQQ0lFX0FUVV9FTkFCTEUgdG8gQklUKDMxKS4KPiBCSVQoMzEpIGV4cGFuZHMgdG8gKDFV
TCA8PCAzMSkgc28sIHdpdGhvdXQgdGhhdCBjYXN0IEkgZ2V0Cj4gCj4gZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmM6IEluIGZ1bmN0aW9uCj4g4oCYZHdfcGNpZV9k
aXNhYmxlX2F0deKAmToKPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuYzozMDM6NDA6IHdhcm5pbmc6IGxhcmdlCj4gaW50ZWdlciBpbXBsaWNpdGx5IHRydW5jYXRl
ZCB0byB1bnNpZ25lZCB0eXBlIFstV292ZXJmbG93XQo+ICAgZHdfcGNpZV93cml0ZWxfZGJpKHBj
aSwgUENJRV9BVFVfQ1IyLCB+UENJRV9BVFVfRU5BQkxFKTsKPiAKPiBvbiBBQXJjaDY0LiBJIGFt
IGd1ZXNzaW5nIHRoYXQgb3JpZ2luYWwgZGVmaW5pdGlvbiBvZiAoMSA8PCAzMSkgYXZvaWRzCj4g
dGhpcyBwcm9ibGVtIGJ5IGJlaW5nIGFuICJpbnQiIGluc3RlYWQgb2YgInVuc2lnbmVkIGxvbmci
LgoKT2ssIHVuZGVyc3Rvb2QuCgpBY2tlZC1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5w
aW1lbnRlbEBzeW5vcHN5cy5jb20+Cgo+IAo+IFRoYW5rcywKPiBBbmRyZXkgU21pcm5vdgo+IAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
