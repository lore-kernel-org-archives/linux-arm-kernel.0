Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0718C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A343420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dBM3q0o0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y1uvGU6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A343420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DbicXhA+nELtfvf8chmLJPZ2SbkG3brHAKNe/VU75fA=; b=dBM3q0o0kviXRe
	Whff9LVCoHf9ACSx0Nb96O8C/6LnHpDecYG+L58UsRrsQDms78UrksEP1SJk8+lx+VaoeX8VUDaSb
	umfZa4ODCYThsdD+c0qGRFJVM3tK6JR8HE/w3rNvWXwovtvYni67/tY58n1DKgZn/iyyiWG0Qrrxg
	Ow9g/J3Fb/bCgSvVhY+CX5kBE/TQijSxPWpq2nxsAKMuP9wQbLuVsO/Kj9zCl2LwVeYjK5g25FU/q
	7r5EAs0wdBlw3U7NySKDYbIyPzQdFQTq4CXWFZIgYWoUvaegtZQEbIGy29apSflQdUScA/XnxffdE
	5Btik+w6vA1rtHgbthfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6F7-00038z-Cr; Tue, 04 Dec 2018 08:39:45 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6Ev-0002rc-Uy
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:39:38 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181204083805euoutp01247e4a7df00bcc92a26ef9e9ff7ea891~tFGhVCc4h1892618926euoutp01N
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 08:38:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181204083805euoutp01247e4a7df00bcc92a26ef9e9ff7ea891~tFGhVCc4h1892618926euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543912685;
 bh=WGxtswQqn4h66ME4iCiW15yYR9vJ45S5aAsiCuNpQqY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Y1uvGU6JEPevaRa/8QDYfh7bvwdYHnU7Z0HpruhQ/VWRgioWnDzs7DWQxHa1RbPuL
 rEGLN1hAPvwExCCzYnMIey7ESbnQV8gX5FbEdMwkpdna1ctZLWK7AAJuy6plOs5UNJ
 OQryigJGt/Hi8orCMhsg6Iv/0PPMvZsoF+PF/tgo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181204083804eucas1p165844a3c9db9db56b2e3cdc5013e72c0~tFGgl_tAj1670116701eucas1p1Z;
 Tue,  4 Dec 2018 08:38:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.4D.04441.CEC360C5; Tue,  4
 Dec 2018 08:38:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181204083803eucas1p2d3db2562c83ae4f6d56d2811943e44dd~tFGfu-ipX1273112731eucas1p2i;
 Tue,  4 Dec 2018 08:38:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181204083803eusmtrp169804637468478bd3253004effc5f36e~tFGftAMVJ2288622886eusmtrp1W;
 Tue,  4 Dec 2018 08:38:03 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c8-5c063cecbf6c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.E0.04284.BEC360C5; Tue,  4
 Dec 2018 08:38:03 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181204083803eusmtip2a6d759f5f7d18c87f55bd99f5a8c88ee~tFGfPGk_A0835708357eusmtip2U;
 Tue,  4 Dec 2018 08:38:03 +0000 (GMT)
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux-foundation.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
Date: Tue, 4 Dec 2018 09:38:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTtm7fMm7GRz9HwopUwhlCUZiQ9UGyCKeZfVqBYko35UHFtRk3L
 yg21wbCaUptMJURzaXNLVBQV9zK3TM0fhpIpyqhjprSQz5flv3PPPYdzLlyGkDdQdkxIRDSn
 jdCEKWgpWdux/v7QvAftd3hybg9rKs5EbGl5u4gtbHZnSxvXRGzl1AjFDtXn0eyv9jNsy+I0
 xc4udZFKiboivwKp9Wu5lLqq6JbaMFqC1A1jibTa1PSBVpsr93qJz0s9ArmwkFhO6+J5SRo8
 +uWHKGreIS7ZYCIT0RN7PZIwgI/C6vMGsR5JGTl+hiCnYBoJwwqCr7nfKWEwI3g4s0huWcyT
 C2Iey3EJgvIRK0FkQjCXZt5cWGNv+JlcumFgGBscCre7TvMaAo8jeJWUjXgNjV1Bv6CneSzD
 nlDY+pjgMYn3QdODTDHv3YX9oH4mQZBYQfej6c0OEuwOZeZKiscEdoCUGsFKYFsYny4Q8VmA
 e8RQk9VICaVVkLOe+Bdbw1xntVjAu6HXkEkKhhQE6blGsTBkIqjJq6MFlTu0dQ5QfCMC74eX
 9S4CfQJWp4ppngZsCaMLVkIJS7hfm0MItAwy0uSC2gmMnS/+xbb0DxJ3kcK47TTjtnOM284x
 /s8tRGQZsuVidOFBnM41grvqrNOE62IigpwvR4ZXoo2X6v3duVyHvg0GtCLMIMVOmVJJ+ckp
 TawuPrwVAUMobGQTTrSfXBaoib/GaSP9tTFhnK4V2TOkwlZ2fcfkBTkO0kRzoRwXxWm3tiJG
 YpeIVNypi26TRpFvVkB/T226l/+ItXdClWHi5KdjHzuchl1QHLhJGqpzfB3P+lYdDLxxJGkI
 WxCkKit7KO3KZ9/FhNeOSpXS595Yib/B3Wep72bkLPhnvHuab93ntPp2RVk7fAfapvqW1cdN
 qecslCVmpUNW93Jq10DRG5VDhbRZQeqCNa4HCK1O8wcdIkI6TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7qvbdhiDLoe6Fm8X9bDaLFy9VEm
 iwX7rS1W7vnBZLHp8TVWi8u75rBZ/D0aaHHwwxNWi5cfT7A4cHqsmbeG0aPrxwxWj81L6j0m
 31jO6LH7ZgObx/t9V9k8Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
 MlXSt7NJSc3JLEst0rdL0Mu48ew3U8Eb+Yqmye9ZGhjnSncxcnJICJhIfH7wlr2LkYtDSGAp
 o8TWKafYIRIyEienNbBC2MISf651sYHYQgJvGSXmPQ8GsYUFwiT+NK1kAbFFBLIl7u69yAwy
 iFngFqPEvtmfGCGmAjnLTk5jBqliEzCU6HoLMYlXwE5iwaHZYHEWARWJfVN6wDaLCsRITLn8
 mhWiRlDi5MwnYBs4BawlVn3eBBZnFlCX+DPvEjOELS/RvHU2lC0ucevJfKYJjEKzkLTPQtIy
 C0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG5rZjPzfvYLy0MfgQowAHoxIP
 7wwn1hgh1sSy4srcQ4wSHMxKIrx31NhihHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmDTy
 SuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwmpZaTGpkdL7youuM
 YMb+nwXpOzfIN64JdQiaufkp/9obe/eu1dr9YY1IvsqaNRlX/3NHXF57ojjy1x95z4DFRRJW
 gS1vKou+32eQav+3cdOlLGfGy7P5pSWYlh+e/GKCw2ueo1EN6jsfPZ/38qeD2wm7nLWWR12z
 /PR+rnk+c+ZVFs/fosmf1ZVYijMSDbWYi4oTAbHi/FXiAgAA
X-CMS-MailID: 20181204083803eucas1p2d3db2562c83ae4f6d56d2811943e44dd
X-Msg-Generator: CA
X-RootMTR: 20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-6-hch@lst.de>
 <CGME20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7@epcas3p2.samsung.com>
 <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_003934_408648_0E41942F 
X-CRM114-Status: GOOD (  20.14  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQWxsLAoKT24gMjAxOC0xMS0zMCAyMDowNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDA1
LzExLzIwMTggMTI6MTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBCeSB1c2luZyBfX2Rt
YV9kaXJlY3RfYWxsb2NfcGFnZXMgd2UgY2FuIGRlYWwgZW50aXJlbHkgd2l0aCBzdHJ1Y3QgcGFn
ZQo+PiBpbnN0ZWFkIG9mIGhhdmluZyB0byBkZXJpdmUgYSBrZXJuZWwgdmlydHVhbCBhZGRyZXNz
Lgo+Cj4gU2ltcGxlIGVub3VnaCA6KQo+Cj4gUmV2aWV3ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9i
aW4ubXVycGh5QGFybS5jb20+CgpUaGlzIHBhdGNoIGhhcyBsYW5kZWQgbGludXgtbmV4dCB5ZXN0
ZXJkYXkgYW5kIEkndmUgbm90aWNlZCB0aGF0IGl0CmJyZWFrcyBvcGVyYXRpb24gb2YgbWFueSBk
cml2ZXJzLiBUaGUgY2hhbmdlIGxvb2tlZCBzaW1wbGUsIGJ1dCBhIHN0dXBpZApidWcgbWFuYWdl
ZCB0byBzbGlwIGludG8gdGhlIGNvZGUuIEFmdGVyIGEgc2hvcnQgaW52ZXN0aWdhdGlvbiBJJ3Zl
Cm5vdGljZWQgdGhhdCBfX2RtYV9kaXJlY3RfYWxsb2NfcGFnZXMoKSBkb2Vzbid0IHNldCBkbWFf
aGFuZGxlIGFuZCB6ZXJvCmFsbG9jYXRlZCBtZW1vcnksIHdoaWxlIGRtYV9kaXJlY3RfYWxsb2Nf
cGFnZXMoKSBkaWQuIFRoZSBvdGhlcgpkaWZmZXJlbmNlIGlzIHRoZSBsYWNrIG9mIHNldF9tZW1v
cnlfZGVjcnlwdGVkKCkgaGFuZGxpbmcuCgpGb2xsb3dpbmcgcGF0Y2ggZml4ZXMgdGhlIGlzc3Vl
LCBidXQgbWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGZpeCBpdAppbiBrZXJuZWwvZG1hL2Rp
cmVjdC5jOgoKZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvcmVtYXAuYyBiL2tlcm5lbC9kbWEvcmVt
YXAuYwppbmRleCBkY2M4MmRkNjY4ZjguLjc3NjVkZGM1NmU0ZSAxMDA2NDQKLS0tIGEva2VybmVs
L2RtYS9yZW1hcC5jCisrKyBiL2tlcm5lbC9kbWEvcmVtYXAuYwpAQCAtMjE5LDggKzIxOSwxNCBA
QCB2b2lkICphcmNoX2RtYV9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdApzaXplLCBk
bWFfYWRkcl90ICpkbWFfaGFuZGxlLArCoMKgwqDCoMKgwqDCoCByZXQgPSBkbWFfY29tbW9uX2Nv
bnRpZ3VvdXNfcmVtYXAocGFnZSwgc2l6ZSwgVk1fVVNFUk1BUCwKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNoX2RtYV9tbWFwX3BncHJvdChkZXYsIFBB
R0VfS0VSTkVMLCBhdHRycyksCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgX19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsKLcKgwqDCoMKgwqDCoCBpZiAo
IXJldCkKK8KgwqDCoMKgwqDCoCBpZiAoIXJldCkgewrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgX19kbWFfZGlyZWN0X2ZyZWVfcGFnZXMoZGV2LCBzaXplLCBwYWdlKTsKK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKK8KgwqDCoMKgwqDCoCB9CisKK8KgwqDC
oMKgwqDCoCAqZG1hX2hhbmRsZSA9IHBoeXNfdG9fZG1hKGRldiwgcGFnZV90b19waHlzKHBhZ2Up
KTsKK8KgwqDCoMKgwqDCoCBtZW1zZXQocmV0LCAwLCBzaXplKTsKKwrCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcmV0OwrCoH0KCj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+Cj4+IC0tLQo+PiDCoCBrZXJuZWwvZG1hL3JlbWFwLmMgfCAxNCArKysrKysrLS0t
LS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9yZW1hcC5jIGIva2VybmVsL2RtYS9yZW1h
cC5jCj4+IGluZGV4IGJjNDI3NjZmNTJkZi4uOGYxZmNhMzRiODk0IDEwMDY0NAo+PiAtLS0gYS9r
ZXJuZWwvZG1hL3JlbWFwLmMKPj4gKysrIGIva2VybmVsL2RtYS9yZW1hcC5jCj4+IEBAIC0xOTYs
NyArMTk2LDcgQEAgdm9pZCAqYXJjaF9kbWFfYWxsb2Moc3RydWN0IGRldmljZSAqZGV2LCBzaXpl
X3QKPj4gc2l6ZSwgZG1hX2FkZHJfdCAqZG1hX2hhbmRsZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGdmcF90IGZsYWdzLCB1bnNpZ25lZCBsb25nIGF0dHJzKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IHBhZ2UgKnBhZ2UgPSBOVUxMOwo+PiAtwqDCoMKgIHZvaWQgKnJldCwgKmthZGRyOwo+
PiArwqDCoMKgIHZvaWQgKnJldDsKPj4gwqAgwqDCoMKgwqDCoCBzaXplID0gUEFHRV9BTElHTihz
aXplKTsKPj4gwqAgQEAgLTIwOCwxMCArMjA4LDkgQEAgdm9pZCAqYXJjaF9kbWFfYWxsb2Moc3Ry
dWN0IGRldmljZSAqZGV2LAo+PiBzaXplX3Qgc2l6ZSwgZG1hX2FkZHJfdCAqZG1hX2hhbmRsZSwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCAt
wqDCoMKgIGthZGRyID0gZG1hX2RpcmVjdF9hbGxvY19wYWdlcyhkZXYsIHNpemUsIGRtYV9oYW5k
bGUsIGZsYWdzLAo+PiBhdHRycyk7Cj4+IC3CoMKgwqAgaWYgKCFrYWRkcikKPj4gK8KgwqDCoCBw
YWdlID0gX19kbWFfZGlyZWN0X2FsbG9jX3BhZ2VzKGRldiwgc2l6ZSwgZG1hX2hhbmRsZSwgZmxh
Z3MsCj4+IGF0dHJzKTsKPj4gK8KgwqDCoCBpZiAoIXBhZ2UpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gTlVMTDsKPj4gLcKgwqDCoCBwYWdlID0gdmlydF90b19wYWdlKGthZGRyKTsKPj4g
wqAgwqDCoMKgwqDCoCAvKiByZW1vdmUgYW55IGRpcnR5IGNhY2hlIGxpbmVzIG9uIHRoZSBrZXJu
ZWwgYWxpYXMgKi8KPj4gwqDCoMKgwqDCoCBhcmNoX2RtYV9wcmVwX2NvaGVyZW50KHBhZ2UsIHNp
emUpOwo+PiBAQCAtMjIxLDcgKzIyMCw3IEBAIHZvaWQgKmFyY2hfZG1hX2FsbG9jKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc2l6ZV90Cj4+IHNpemUsIGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUsCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFyY2hfZG1hX21tYXBfcGdwcm90KGRldiwgUEFHRV9L
RVJORUwsIGF0dHJzKSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19idWlsdGluX3Jl
dHVybl9hZGRyZXNzKDApKTsKPj4gwqDCoMKgwqDCoCBpZiAoIXJldCkKPj4gLcKgwqDCoMKgwqDC
oMKgIGRtYV9kaXJlY3RfZnJlZV9wYWdlcyhkZXYsIHNpemUsIGthZGRyLCAqZG1hX2hhbmRsZSwg
YXR0cnMpOwo+PiArwqDCoMKgwqDCoMKgwqAgX19kbWFfZGlyZWN0X2ZyZWVfcGFnZXMoZGV2LCBz
aXplLCBwYWdlKTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCB9Cj4+IMKgIEBAIC0y
MjksMTAgKzIyOCwxMSBAQCB2b2lkIGFyY2hfZG1hX2ZyZWUoc3RydWN0IGRldmljZSAqZGV2LCBz
aXplX3QKPj4gc2l6ZSwgdm9pZCAqdmFkZHIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfYWRk
cl90IGRtYV9oYW5kbGUsIHVuc2lnbmVkIGxvbmcgYXR0cnMpCj4+IMKgIHsKPj4gwqDCoMKgwqDC
oCBpZiAoIWRtYV9mcmVlX2Zyb21fcG9vbCh2YWRkciwgUEFHRV9BTElHTihzaXplKSkpIHsKPj4g
LcKgwqDCoMKgwqDCoMKgIHZvaWQgKmthZGRyID0gcGh5c190b192aXJ0KGRtYV90b19waHlzKGRl
diwgZG1hX2hhbmRsZSkpOwo+PiArwqDCoMKgwqDCoMKgwqAgcGh5c19hZGRyX3QgcGh5cyA9IGRt
YV90b19waHlzKGRldiwgZG1hX2hhbmRsZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFn
ZSAqcGFnZSA9IHBmbl90b19wYWdlKF9fcGh5c190b19wZm4ocGh5cykpOwo+PiDCoCDCoMKgwqDC
oMKgwqDCoMKgwqAgdnVubWFwKHZhZGRyKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGRtYV9kaXJlY3Rf
ZnJlZV9wYWdlcyhkZXYsIHNpemUsIGthZGRyLCBkbWFfaGFuZGxlLCBhdHRycyk7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBfX2RtYV9kaXJlY3RfZnJlZV9wYWdlcyhkZXYsIHNpemUsIHBhZ2UpOwo+PiDC
oMKgwqDCoMKgIH0KPj4gwqAgfQo+PiDCoAo+CkJlc3QgcmVnYXJkcwotLSAKTWFyZWsgU3p5cHJv
d3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
