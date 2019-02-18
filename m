Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9AB2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gLeRvgjL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SAIHzO8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9AB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cyi4cmHVuE0ggTn7YTDWlsACkJNBoq/khaqlNdqyv4c=; b=gLeRvgjL7NIoBv
	rFnLYT9VIJfItCztl0E27ED32ur2MfTiVZvnhLsfwTBRKenZmWY+B/wboJtLaEsqK5F/1e7kX9CA+
	3ZFeUDLFkJuV4h1rNxA/vIEIxEy81eFzmUFq8mjMVYewOU1/dlpP4we+VERmt90J6/db6V4IXn+Z5
	9Gv4xRtL/poyWpNPaKsdVoQEdhONKSYxF5HhcMvMFVzYhr4/7iOGbPv206s3c4PB/OJ0zZo+SJDSw
	pQYaMkObHJoIhO/MW2gNwDIKWX2x04BI/IpZps+dStqg3POmsg6Mzkyqy2mc/KjdmkZ0vk1VdJih9
	1QfpuLQWLFDGhUgUB6bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWuA-0000dj-SI; Mon, 18 Feb 2019 00:35:30 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWu6-0000am-QR
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:35:28 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190218003523epoutp03734b6f13634b4bbfcd417dfa980fcfb3~ETiwd9h_22381523815epoutp03P
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:35:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190218003523epoutp03734b6f13634b4bbfcd417dfa980fcfb3~ETiwd9h_22381523815epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550450123;
 bh=s586eAn0yDUxx/F2Ly8n7yy6QpAP+0VaSGFu21YdEwE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=SAIHzO8uwsb7AcIFXNzPQQXFwRYTbZm5hbR6ORvOmCm4JIgxT1/MfVFjstog01oUf
 k0a5+dm9sgt6IOqXUEhec8U4feaed0+atOoBfccMZWhiaxZgGiELURvTfGW4QOKEVX
 jXQSWGw4IOokKyJq4KjO9y8Vb3aWV5WmqFK4R4Xg=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190218003520epcas1p2e617fdb5b624e8c988940cda69f70a2e~ETiuUpA-F0451604516epcas1p2N;
 Mon, 18 Feb 2019 00:35:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 78.F4.04069.8CDF96C5; Mon, 18 Feb 2019 09:35:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20190218003520epcas1p3bc3c0c45a681aea39e900b83d487eed4~ETityAyRW2409824098epcas1p3v;
 Mon, 18 Feb 2019 00:35:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190218003520epsmtrp22535e642467f0f1bbcb066e82beb20c5~ETitwmqkI1279112791epsmtrp2Y;
 Mon, 18 Feb 2019 00:35:20 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-8d-5c69fdc892bd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7E.37.03971.8CDF96C5; Mon, 18 Feb 2019 09:35:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190218003519epsmtip271812fe34ee93b8b7d2b353fb867c057~ETitgIedg2160621606epsmtip2M;
 Mon, 18 Feb 2019 00:35:19 +0000 (GMT)
Subject: Re: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
To: Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com,
 jonathanh@nvidia.com
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
Date: Mon, 18 Feb 2019 09:35:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216151826.11584-3-tiny.windzz@gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmvu6Jv5kxBpsb9S3+P3rNatEyaxGL
 xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFp8e/Ge26Pwyi83iduMKNoufu+axWMz9PYHNgdtj56y7
 7B6bl9R79Da/Y/Po27KK0WP7tXnMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
 GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
 SMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzti39xBzwRr2iuu/MxsYG9m6GDk5JARMJJY3
 v2btYuTiEBLYwSjRcqGPBcL5xCgxe/s2NgjnG6PEh6UzmGFa7h9vYYZI7GWU2PTnPVT/e0aJ
 K8vPMIJUCQsESNxa38YIkhARWMAosa5zKjuIwyywlFFi7t5PLCBVbAJaEvtf3AA7hV9AUeLq
 j8dAHRwcvAJ2EhfWg61jEVCVuHJyEyuILSoQIXG49x3YAl4BQYmTM5+AjeEUsJbYuOAAmM0s
 IC5x68l8JghbXqJ562ywUyUEJrNLHDg5jx3iBxeJDw9eskDYwhKvjm+BiktJfH63Fxo01RIr
 Tx5hg2juYJTYsv8CK0TCWGL/0slMIIcyC2hKrN+lD7GMT+Ld1x5WkLCEAK9ER5sQRLWyxOUH
 d5kgbEmJxe2dbBAlHhKXLjBNYFScheSbWUg+mIXkg1kIuxYwsqxiFEstKM5NTy02LDBGju1N
 jOCkq2W+g3HDOZ9DjAIcjEo8vB/KMmOEWBPLiitzDzFKcDArifAu+gYU4k1JrKxKLcqPLyrN
 SS0+xGgKDOyJzFKiyfnAjJBXEm9oamRsbGxhYmhmamioJM673sE5RkggPbEkNTs1tSC1CKaP
 iYNTqoGx2a9EYO5tgbL0uPcH8u/lTpc9bHLj7uHCC9XvD7zb+TR2i3fpWZZt++sOul/2CLp9
 ySigoeXVtrniIouEnrb+j/6ffnPztDkbpnqcDSiP+rJR7Xzwztq8zCdTN4hGOD+V4tC1nqg6
 ZVJRy8a4R6ZnP29+fnXjMen9PzwKmZ2bIv/zrI1aVlxbqsRSnJFoqMVcVJwIAMT1jvXQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO6Jv5kxBp/bOSz+P3rNatEyaxGL
 xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFp8e/Ge26Pwyi83iduMKNoufu+axWMz9PYHNgdtj56y7
 7B6bl9R79Da/Y/Po27KK0WP7tXnMHp83yQWwRXHZpKTmZJalFunbJXBl7Nt7iLlgDXvF9d+Z
 DYyNbF2MnBwSAiYS94+3MHcxcnEICexmlOh9e44RIiEpMe3iUaAEB5AtLHH4cDFEzVtGiaZj
 L5lAaoQF/CTapm0AaxYRWMAo8ffjC1aQBLPAUkaJ/W9YITr2M0pM6tjADpJgE9CS2P/iBthq
 fgFFias/HjOCbOAVsJO4sJ4ZJMwioCpx5eQmsDmiAhESH5/uA1vGKyAocXLmExYQm1PAWmLj
 ggMsELvUJf7Mu8QMYYtL3HoynwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW5
 6bnFhgWGeanlesWJucWleel6yfm5mxjB0aeluYPx8pL4Q4wCHIxKPLwfyjJjhFgTy4orcw8x
 SnAwK4nwLvoGFOJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNT
 qoGRf4nfAatOeZ2td49k6z0ya7/i+CDD6uWinldMq9iiiyf+dNnr+t6phH9PqLpK46eLeox2
 L95P5Pi94Mekb59F1bPVlF4sfPRB0/H4sZ6t/wu1f8x0UThkpRU/4wP/FIXCyUc+TbL6PUXL
 6fKdZa6frLp2P5+gVr4h37NdZ/k2A3ONld1rcnKTlFiKMxINtZiLihMBgpbBb7oCAAA=
X-CMS-MailID: 20190218003520epcas1p3bc3c0c45a681aea39e900b83d487eed4
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190216152000epcas1p216810769e13852c4b92896348657b6d6
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216152000epcas1p216810769e13852c4b92896348657b6d6@epcas1p2.samsung.com>
 <20190216151826.11584-3-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_163527_025935_AA60E82F 
X-CRM114-Status: GOOD (  22.54  )
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
Cc: linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAxOS4gMi4gMTcuIOyYpOyghCAxMjoxOCwgWWFuZ3RhbyBMaSB3cm90ZToKPiBUaGUg
c2VtaWNvbG9uIGlzIHVubmVlZGVkLCBzbyByZW1vdmUgaXQuCj4gCj4gU2lnbmVkLW9mZi1ieTog
WWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2RldmZy
ZXEvZXZlbnQvcm9ja2NoaXAtZGZpLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEv
ZXZlbnQvcm9ja2NoaXAtZGZpLmMgYi9kcml2ZXJzL2RldmZyZXEvZXZlbnQvcm9ja2NoaXAtZGZp
LmMKPiBpbmRleCAyMmIxMTMzNjNmZmMuLmZjYmY3NmViZjU1ZCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2RldmZyZXEvZXZlbnQvcm9ja2NoaXAtZGZpLmMKPiArKysgYi9kcml2ZXJzL2RldmZyZXEv
ZXZlbnQvcm9ja2NoaXAtZGZpLmMKPiBAQCAtMjExLDcgKzIxMSw3IEBAIHN0YXRpYyBpbnQgcm9j
a2NoaXBfZGZpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAlpZiAoSVNf
RVJSKGRhdGEtPmNsaykpIHsKPiAgCQlkZXZfZXJyKGRldiwgIkNhbm5vdCBnZXQgdGhlIGNsayBk
bWNfY2xrXG4iKTsKPiAgCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5jbGspOwo+IC0JfTsKPiArCX0K
PiAgCj4gIAkvKiB0cnkgdG8gZmluZCB0aGUgb3B0aW9uYWwgcmVmZXJlbmNlIHRvIHRoZSBwbXUg
c3lzY29uICovCj4gIAlub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShucCwgInJvY2tjaGlwLHBtdSIs
IDApOwo+IAoKUmV2aWV3ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29t
PgoKLS0gCkJlc3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
