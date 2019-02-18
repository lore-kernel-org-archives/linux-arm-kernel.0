Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7102CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:35:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4842089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2IucYbj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d9YBINQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4842089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TmuiizEAVTe7LfOwY1yc0DREgW3wm0wx3j7swuXtcbI=; b=l2IucYbjkRKgFm
	F4R5xt967DRS5fFqTnDMZcSXdITSMYM0KKbWUhSMDpDwB1qq7nVemf1nXskqr8Yyl6jLpKB6b3eaj
	qCJ4Ry88i/2ML4ZiHb0/8B61Kpn1B2mlr/7wu3dkf+s9F7lbBYB6KuYOASx7/a6G2j9I+w7L3wP5H
	I2x3uKygyH8nunu9xix37KVyWYTdGsT3SKl0ZCWNQEGqPSP7yqgeyoNxzuS5BhBb2o2Wrk4uOscDZ
	oln5WidyL7BKZ4ZYSDeryg0uq/5nasovMJ5VZnt+PcN2x+mlpl+lkUuNI0D//t36d6eCM/0jwnINB
	wQS06XssxMpa69ddk47A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWtq-0000K0-K2; Mon, 18 Feb 2019 00:35:10 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWtm-0007nL-8y
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:35:08 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20190218003501epoutp02ffa48ac24f7b349e32f413dd2cb03f2d~ETicE4eiK3197131971epoutp02h
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:35:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20190218003501epoutp02ffa48ac24f7b349e32f413dd2cb03f2d~ETicE4eiK3197131971epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550450101;
 bh=kt92MKYao0ua5UEjTusIy1ELa/itcGRUBvaadkv/PDM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=d9YBINQsLywZGEXi/jW+kPfgSZDGZjajHGyPk+qio++RL2lHanMfd9D7iHo7wWnd0
 Nhhl5/yTSXzXIu17upT9aXZI/fFqoUWZRmD4nbSHURC9nWaukeAoQETiGDmKK+JsC7
 5IIpcmWobYhVG2uFtwZcJ4dihqTD0HYQqt8FtlN0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20190218003458epcas1p3f6f2fc9827780e5534520acb61eaf90f~ETiZjhQab0296202962epcas1p3W;
 Mon, 18 Feb 2019 00:34:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 47.D4.04069.2BDF96C5; Mon, 18 Feb 2019 09:34:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190218003457epcas1p11d8c26022f11c1cbb86633164aa87e14~ETiZB7UeM0621106211epcas1p15;
 Mon, 18 Feb 2019 00:34:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190218003457epsmtrp1ad965ac915eaad0119da8627e5f82290~ETiZAn2NH0256802568epsmtrp1Q;
 Mon, 18 Feb 2019 00:34:57 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-c1-5c69fdb21ee2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.37.03971.1BDF96C5; Mon, 18 Feb 2019 09:34:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190218003457epsmtip1bccfd951888e9b775d6b2ab05e1aa020~ETiYvf6U40754207542epsmtip1b;
 Mon, 18 Feb 2019 00:34:57 +0000 (GMT)
Subject: Re: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
To: Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com,
 jonathanh@nvidia.com
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
Date: Mon, 18 Feb 2019 09:34:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216151826.11584-2-tiny.windzz@gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta2xLYRj27ZyenqF86rJXBXMYsWSXo7odbCK20LDEFn9EFnWsJ22z3vS0
 jREMs4vYEPdSwyzuG7WxLWQxi2YJ4rrIxOK2uC3FsLDFpu2p2L/nfb7n+d73+S40oWymVLTJ
 6hQcVt7MUMPJ63dmJyX4/phykx8PxHCDbz7LuCLPaZK7v71bzvnetsu4J03HKe57eSviel4N
 ElzZDw/Fvdh2juJ+N50gOW//XmrRCG2j56Vce+3MVm35jgClrai7gLQ32k8Q2u++KdnU6vw0
 o8DrBUesYM2z6U1WQzqzfKUuQ6dJSWYT2HlcKhNr5S1COpOZlZ2wxGQOjsfEunmzK0hl86LI
 JC1Mc9hcTiHWaBOd6Yxg15vt8+yJIm8RXVZDYp7NMp9NTp6jCQrX5htrOispezu14ea3e0Qh
 apTtQtE04LnQUtGIdqHhtBI3IKg+2ENJRQ+Cb3d9pFT0Iqh485D4Z/HfrCKkhVsIes+9j/i/
 IKi91EOGVGNxFrzuvB+2j8MnEdSUHZSHCgJXI/DeklQUjofmD8+pEB6Np8GzX29RCCvwQugs
 7Q+PSOI4aD3cFsbj8Sq4Ux6IaMZA29F3wX1oOhovAP/TZSGawDHQ8a4ySsJTYUf9sfCogPfL
 oSvQh6QMmXD04qHIEYyFT/46uYRV8HFPcQRvgvNtrZRkLkVQ1/wwYlBDc/X+qFBjAs+G2qYk
 qdkoCPzcLQvRgBVQWqyU1NPhyauXURKeCFUlZZSEtXC74al8L5rmGZLGMySCZ0gEz/9mJxF5
 AU0Q7KLFIIisXT30vn0o/HjjUxvQlQdZLQjTiBmp+Oo25SplvFsssLQgoAlmnOJ0b5BS6PmC
 jYLDpnO4zILYgjTBw95HqMbn2YJfwerUsZo5arWam8umaFiWiVHULsrIVWID7xTyBcEuOP75
 ouhoVSHa+bre6+7SNbUGHqlyGn6QS0cUddzzD149kFFy2bul25j6q4yepfezhrPDnAPKi+tm
 +euLCx/HlSzuXzOlu29SYde6TxPr3THe9ZUFNe8nDOtvS6CfTU7MZ+PiU86SjZNWHEnbvOXa
 ZW9mzkBVkepnUY5r3+KZpX237acedfgGZ8x4zpCikWfjCYfI/wW42Ftm0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO7Gv5kxBjvu6Vv8f/Sa1aJl1iIW
 i7NNb9gtNj2+xmpxedccNovPvUcYLT49+M9s0fllFpvF7cYVbBY/d81jsZj7ewKbA7fHzll3
 2T02L6n36G1+x+bRt2UVo8f2a/OYPT5vkgtgi+KySUnNySxLLdK3S+DKWHdvPlvBNbaKPR/P
 MDcw7mTtYuTkkBAwkTi+ZzFzFyMXh5DAbkaJb39/sEEkJCWmXTwKlOAAsoUlDh8uhqh5yygx
 tWEuO0iNsICPxMN7Z1lAEiICCxgl/n58ATaVWWApo8T+N6wQHfsZJZq/zAHrYBPQktj/4gbY
 Bn4BRYmrPx4zgti8AnYS9zp+gzWzCKhKHJl+EswWFYiQ+Ph0HxNEjaDEyZlPWEAu4hSwljh+
 xQtil7rEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR7FpKWWUhaZiFpWcDIsopRMrWgODc9
 t9iwwDAvtVyvODG3uDQvXS85P3cTIzj+tDR3MF5eEn+IUYCDUYmH90NZZowQa2JZcWXuIUYJ
 DmYlEd5F34BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1
 MPZ8n/ZjfnCN6exvu45P2XT2b0msdG1HyMlb1WsOcBS+uKjEX7bjr87nnYLs85Om6/3d9qhu
 20/+9p5fGk52Nxf/PfjWcL7kVh/X3HVh9rUHPypMTt411V3UPKH8658JhhNldm666SV9jmf+
 2cUrDrRweV6uEDoz5UeFOvOq0jkmz37t8/rktixfiaU4I9FQi7moOBEA0lBeGrsCAAA=
X-CMS-MailID: 20190218003457epcas1p11d8c26022f11c1cbb86633164aa87e14
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e@epcas4p3.samsung.com>
 <20190216151826.11584-2-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_163506_842928_89F2DF82 
X-CRM114-Status: GOOD (  19.85  )
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
ZXEvcmszMzk5X2RtYy5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL3JrMzM5OV9k
bWMuYyBiL2RyaXZlcnMvZGV2ZnJlcS9yazMzOTlfZG1jLmMKPiBpbmRleCBlNzk1YWQyYjNmNmIu
LmEyMjhkYWQyYmVlNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvcmszMzk5X2RtYy5j
Cj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL3JrMzM5OV9kbWMuYwo+IEBAIC0zMjIsNyArMzIyLDcg
QEAgc3RhdGljIGludCByazMzOTlfZG1jZnJlcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQo+ICAKPiAgCQlkZXZfZXJyKGRldiwgIkNhbm5vdCBnZXQgdGhlIGNsayBkbWNfY2xr
XG4iKTsKPiAgCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5kbWNfY2xrKTsKPiAtCX07Cj4gKwl9Cj4g
IAo+ICAJZGF0YS0+ZWRldiA9IGRldmZyZXFfZXZlbnRfZ2V0X2VkZXZfYnlfcGhhbmRsZShkZXYs
IDApOwo+ICAJaWYgKElTX0VSUihkYXRhLT5lZGV2KSkKPiAKClJldmlld2VkLWJ5OiBDaGFud29v
IENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28g
Q2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
