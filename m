Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:37:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4BE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dqFWSJxZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UHh90Wwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4BE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fq98TVr3WvPW7BrUP7CXOpSTb6+GwM6ceO8emc9vvwQ=; b=dqFWSJxZ2G0n8Z
	Az7806SEYSq2HM5UlQeow09qlns7VXjui/cs3WSwCnzFLvJ8hx599ESt3/UDxQIvWunBPIjFx1JQD
	nbu3q1lnxoIg5tq9ICg/3F1VwSPROzjDuY6fnuW+G18FwNN8So2H7IYvfxJx7voYWQKfcckkh0b7m
	gbKNQlrad/ERk+2hhcPva11W7sHkgCDrAUby+BSi4+UqT1SCN4kUiRQ9+inyL3U0hsGD2ESocszPL
	ZUyDRAnPZAb5U+EBRgO+JYyCLzU8lCBd5rnq/9JTHC8y6ODR6BqLouSKeUNUxlxK4nDlZytLjfMp7
	cbmiAIYQV3teVzLnrsFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiZE-0000xc-7n; Wed, 16 Jan 2019 10:37:04 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiZ8-0000rz-FG
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:37:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190116103655euoutp01271e144e9da485af25bc93aa7bd89011~6TdiwJagv2430524305euoutp01V
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 10:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190116103655euoutp01271e144e9da485af25bc93aa7bd89011~6TdiwJagv2430524305euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547635015;
 bh=ftbTReww1KSdTJelR5LMhyUhmrnhYK1Ep9I6yDYu89M=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=UHh90Wwbb0xsI8dHtu2JttIIFuqgkJRpfK07ATqOV7KslZI9ytRAkVG8xp3nln7pU
 MVRPYYqozL9Y6IbFSPCNWJ8oBdWuFOIg+Pnr5N8KRdiDx5VLB7pKgqlERP4oqBUIhr
 1HsS3dYNIJcPC5XOLFcgikXF1yNd0BUAMs8iaPm4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190116103654eucas1p1e4dea5f9ab8e1dcb31f3bef7ad2ebdfd~6TdiOEtLa0817708177eucas1p1J;
 Wed, 16 Jan 2019 10:36:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.AA.04441.6490F3C5; Wed, 16
 Jan 2019 10:36:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190116103653eucas1p122bd1a979a2d621332b720580c157908~6TdhIumgF2551925519eucas1p1U;
 Wed, 16 Jan 2019 10:36:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190116103653eusmtrp2e7e23e0103bed7435e7904eab4d231cf~6Tdg4hHwV0861408614eusmtrp2G;
 Wed, 16 Jan 2019 10:36:53 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-51-5c3f0946cc2b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.3D.04128.4490F3C5; Wed, 16
 Jan 2019 10:36:52 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190116103652eusmtip19286f6cd05e62a098de76ae2ded752e6~6TdgVwWbl2642126421eusmtip1Q;
 Wed, 16 Jan 2019 10:36:52 +0000 (GMT)
Subject: Re: [PATCH] Revert
 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
To: Robin Murphy <robin.murphy@arm.com>, Thierry Reding <treding@nvidia.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a24660a6-a9d7-ce97-5e2b-17928981551c@samsung.com>
Date: Wed, 16 Jan 2019 11:36:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuzs7s+PibnfXwpO9twcZpQn9MaVYgcRAUpFUZEJNNa2Vq7Lj
 I3uQYFmslVlZtpqP8FFqru/UqNDIzQxtZ0nUkFI3emFp2kMKy2my/O873zm/+50Dlyb0baQX
 fSAyhjdHchEGSq2sbR5tX77ebU3YCkuVmqnIsJHMu6IziLlV8kjB5D7wZyr7O0jG2ZBFMWJq
 moJpHHSRTHLJIMm8+KFdq2ZLs0sR6+xwEGxV/gn2UmcRYu92JVLsWLOKPZf0kWI/3X9Oseer
 ixE7XDlnszpUHbCPjzgQx5t9A3erw1/39BPRdbrDb0twImrQWpAbDXglpNpspAWpaT2+iSDt
 bTeSixEEYssHSi6GEbT2ZhMTSPqdR4TcKEKQIRb/5T8h+JrzeJynaQ/MQbtrowRMw8HQd+/y
 H4DAjQr4Lg5RUoPCfmAZsPzRGhwITksHKWklXgQ/xS5Kemc6DoNTTrU8ooOWay6lpN2wP9iu
 JCNJE3guJNVkErL2hG5XjkLKAtyngtru05S8dRCUFQwiWXvAe3u1Staz4Ff9BJCE4HSGVSUX
 ZxHUZNX9pf3hod1BShsR2BtsDb6yvQ4qq5wqyQashc4BnbyEFi7WXiVkWwNnkvXy9GKw2sv+
 xTY+E4kLyGCddJp10jnWSedY/+fmImUx8uRjBZORF/wi+XgfgTMJsZFGn71Rpko0/stax+yf
 69AXcU8TwjQyuGuY0MAwPcnFCQmmJgQ0YZimGc0ftzT7uIQjvDlqlzk2ghea0ExaafDUHJ3y
 aqceG7kY/hDPR/Pmia6CdvNKRNuPz1h25Kmf07uj9V24Y2PFwAg9P/il6VvnArsjP+Gior5k
 k6NHF7bEWF70JM6ypVec6tjw5mSbT562kJ3tClAVdG1t3pHrlVnmWxrtlRPSy/WnOdzHVl1K
 PbjttvkYsbrmSkrIPGFtUN7+lqHMxphOsTzd48b19EKf4JSE+IURyKAUwjm/pYRZ4H4Dvozt
 oGEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7ounPYxBo/O2VhsnLGe1eLl8g5G
 i5WrjzJZLNhvbbHp8TVWi8u75rBZXOqfyGRx8MMTVou21R9YLW7/5nPg8lgzbw2jx+VrF5k9
 Ni+p95h8Yzmjx+6bDWwe/46xe/Q2v2PzeL/vKptH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fY
 KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTy9+5i5YIdgxYvVAg2Mu/i6
 GDk5JARMJKZuP8rcxcjFISSwlFFiZ8MXFoiEjMTJaQ2sELawxJ9rXWwQRW8ZJVbOXM8EkhAW
 SJRoW3gRzBYR8JF4tHcK2CRmgYNMEiveTYQae59RYv+uq8wgVWwChhJdb0FGcXLwCthJXO66
 BraCRUBV4s+lm2BxUYEYiVlP+tghagQlTs58AnYSp4C1xPppbYwgNrOAusSfeZeYIWx5ieat
 s6FscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj
 MH63Hfu5ZQdj17vgQ4wCHIxKPLwWUXYxQqyJZcWVuYcYJTiYlUR4fy4BCvGmJFZWpRblxxeV
 5qQWH2I0BXpuIrOUaHI+MLXklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLp
 Y+LglGpg7EqfsK7szYz9NzWf1x84H7r4yY8fjjE/L0eaPunP5v5Tc36d8YWZkiXxze9SVZly
 A1bnRzk+WNhbOo/X0+plzsv/m904A6aLBUgr/NxzqeKNdQ37yZ0CV4pKXI2UP/olKc0V+ig0
 f51E7GeG6SGvZ91P6TtssYT1dgL3j7vGIgq9pmz7/z5TUWIpzkg01GIuKk4EAA2xHqb1AgAA
X-CMS-MailID: 20190116103653eucas1p122bd1a979a2d621332b720580c157908
X-Msg-Generator: CA
X-RootMTR: 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo> <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_023658_806512_17CD1F87 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iaW4sCgpPbiAyMDE5LTAxLTE0IDE3OjM4LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MTQvMDEvMjAxOSAxNjowOSwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6Cj4+IE9uIE1vbiwgSmFuIDE0
LCAyMDE5IGF0IDAyOjIyOjQwUE0gKzAxMDAsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+PiBU
aGlzIHJldmVydHMgY29tbWl0IDE4NzQ2MTlhN2RmNGIxNGIyM2IxNDg3N2U3MDVhZTE1MzI1Nzcz
ZTMuCj4+Pgo+Pj4gVGhhdCBwYXRjaCBicm9rZSBJT01NVSBzdXBwb3J0IGZvciBkZXZpY2VzLCB3
aGljaCBmYWlscyB0byBwcm9iZSBmb3IKPj4+IHRoZQo+Pj4gZmlyc3QgdGltZSBhbmQgdXNlIGRl
ZmVycmVkIHByb2JlIGFwcHJvYWNoLiBXaGVuIG5vbi1OVUxMIGRtYV9vcHMgaXMKPj4+IHNldAo+
Pj4gaW4gYXJtX2lvbW11X2RldGFjaF9kZXZpY2UoKSwgdGhlIGdpdmVuIGRldmljZSBsYXRlciBp
Z25vcmVkIGJ5Cj4+PiBhcmNoX3NldHVwX2RtYV9vcHMoKSBhbmQgc3RheXMgd2l0aCBub24tSU9N
TVUgZG1hX29wcy4KPj4+Cj4+PiBSZXBvcnRlZC1ieTogVG9iaWFzIEpha29iaSA8dGpha29iaUBt
YXRoLnVuaS1iaWVsZWZlbGQuZGU+Cj4+PiBGaXhlczogMTg3NDYxOWE3ZGY0ICJBUk06IGRtYS1t
YXBwaW5nOiBTZXQgcHJvcGVyIERNQSBvcHMgaW4KPj4+IGFybV9pb21tdV9kZXRhY2hfZGV2aWNl
KCkiCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ft
c3VuZy5jb20+Cj4+PiAtLS0KPj4+IMKgIGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmMgfCAxMiAr
KysrKystLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCj4+Cj4+IENhbiB5b3UgcG9pbnQgb3V0IGV4YWN0bHkgd2hhdCBkcml2ZXJzIGJy
ZWFrIGJlY2F1c2Ugb2YgdGhpcyBjaGFuZ2U/IFdlCj4+IG5lZWQgdG8gZmluZCBhIHNvbHV0aW9u
IHRoYXQgd29ya3MgZm9yIGV2ZXJ5b25lLiBSZXZlcnRpbmcgaXMgb25seQo+PiBtYXJnaW5hbGx5
IHVzZWZ1bCBiZWNhdXNlIHNvbWVib2R5IHdpbGwganVzdCBlbmQgdXAgd2FudGluZyB0byByZXZl
cnQKPj4gdGhlIHJldmVydCBiZWNhdXNlIGEgZGlmZmVyZW50IGRyaXZlciBpcyBub3cgYnJva2Vu
Lgo+Cj4gQXQgZmlyc3QgZ2xhbmNlLCBpdCBzb3VuZHMgbGlrZSB3aGF0IHdlIHJlYWxseSB3YW50
IGlzIGZvcgo+IGFyY2hfdGVhcmRvd25faW9tbXVfb3BzKCkgdG8gY29tcGxldGVseSBjbGVhciBh
bnkgb3BzIHRoYXQKPiBhcmNoX3NldHVwX2RtYV9vcHMoKSBpbnN0YWxsZWQgLSBkb2VzIHRoZSBi
ZWxvdyBzdWZmaWNlPwoKSSd2ZSBpbml0aWFsbHkgYWxzbyB0aG91Z2h0IGFib3V0IHNpbWlsYXIg
Zml4LCBidXQgdGhlbiBJIGZvdW5kIHRoZQpjb21taXQgMTg3NDYxOWE3ZGY0YjE0YjIzYjE0ODc3
ZTcwNWFlMTUzMjU3NzNlMywgd2hpY2ggd2FzIHRoZSBzb3VyY2Ugb2YKdGhpcyBwcm9ibGVtLgoK
Um9iaW46IGRvIHlvdSBwbGFuIHRvIHNlbmQgdGhpcyBmaXggYXMgYSBjb21wbGV0ZSBwYXRjaCBv
ciBkbyB5b3Ugd2FudAptZSB0byByZXNlbmQgaXQgd2l0aCB0aGUgYWJvdmUgY29tbWl0IG1lc3Nh
Z2UgYW5kIHlvdXIncyBzdWdnZXN0ZWQtYnk/Cgo+Cj4gUm9iaW4uCj4KPiAtLS0tLT44LS0tLS0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYyBiL2FyY2gvYXJtL21tL2Rt
YS1tYXBwaW5nLmMKPiBpbmRleCBmMWUyOTIyZTQ0N2MuLjFlM2UwOGExYzQ1NiAxMDA2NDQKPiAt
LS0gYS9hcmNoL2FybS9tbS9kbWEtbWFwcGluZy5jCj4gKysrIGIvYXJjaC9hcm0vbW0vZG1hLW1h
cHBpbmcuYwo+IEBAIC0yMzkwLDQgKzIzOTAsNiBAQCB2b2lkIGFyY2hfdGVhcmRvd25fZG1hX29w
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4KPiDCoMKg
wqDCoCBhcm1fdGVhcmRvd25faW9tbXVfZG1hX29wcyhkZXYpOwo+ICvCoMKgwqAgLyogTGV0IGFy
Y2hfc2V0dXBfZG1hX29wcygpIHN0YXJ0IGFnYWluIGZyb20gc2NyYXRjaCB1cG9uCj4gcmUtcHJv
YmUgKi8KPiArwqDCoMKgIHNldF9kbWFfb3BzKGRldiwgTlVMTCk7Cj4gwqB9Cj4KPgpCZXN0IHJl
Z2FyZHMKLS0gCk1hcmVrIFN6eXByb3dza2ksIFBoRApTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9s
YW5kCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
