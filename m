Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD02C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:25:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D74217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TmNEYKBe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j8xF6/yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D74217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rS+feEP63yxdUqtJX6CpBrMmzPlpsALmL08QoEHy9Us=; b=TmNEYKBeR20dW0
	ulvWFCMFciOoxizM1N1nhhAaV1EeZ8k7YUDdUocwgmDL8i+ISj1/EZh8+cxOJTR5B0liC2Gt286Hq
	guYuTLtC5/I5ITKuFTJMxHlcH074qpqsYVPT6OarfVeffR1iRAR6svmCHidhTBELRPqp09a5lCHMH
	1heKlgf4LaWt7O5Hrj2vJYt2+gzU28j4gwRxlNLUf3mDKjIGs/3oz5Ywpu2/w9NYmgl54T6xcV/U9
	E9sngpr71UqG5aHQGXX12TTTu0tsjteozT45y9WKEIsU99Sv7wPqqIoLOg2MLXZ6Y9rxMCaVejk47
	YZoC8bCnt0MBEytWXBCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhyj-0005jY-SM; Mon, 18 Feb 2019 12:24:57 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhyg-0005jC-B6
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:24:56 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190218122451euoutp012d3e74833b27393a84e8844fa222849e~EdONbXWvj0334903349euoutp01Y
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 12:24:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190218122451euoutp012d3e74833b27393a84e8844fa222849e~EdONbXWvj0334903349euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550492691;
 bh=Ghv0BSlXyuvbO/afYNzY7v0IY0nLsWqNOjGlx717jo8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=j8xF6/yycKN2tiuna3087rx1EKUS0cUtuO+lj9H43BrJbQ7gn4I+Skar0HhAccpOo
 KshkdfdOvnyCpiGJuyVZesh2pvI0xFCcXvsY+4q/f2Ys1neC/QWWRIwl8isTkt1+Op
 TPAKxSTSk/xn7SHjXEHcjwlEno9cl8tG3DMCKrKc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190218122451eucas1p2a6656eb6e68570233169dda6ee095249~EdOM_IjN80245802458eucas1p2m;
 Mon, 18 Feb 2019 12:24:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.81.04806.214AA6C5; Mon, 18
 Feb 2019 12:24:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190218122449eucas1p114c6297d7b3c4a1074600b288c2df097~EdOL6JzF_2828728287eucas1p1s;
 Mon, 18 Feb 2019 12:24:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190218122449eusmtrp162ca27435e025804bcef8c114562c511~EdOLry34i1056610566eusmtrp1_;
 Mon, 18 Feb 2019 12:24:49 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-50-5c6aa412066c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.CE.04128.114AA6C5; Mon, 18
 Feb 2019 12:24:49 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190218122449eusmtip2e6e1ac65b444065a762211db1dc41a47~EdOLNAwrB0583305833eusmtip2U;
 Mon, 18 Feb 2019 12:24:49 +0000 (GMT)
Subject: Re: [PATCH 4/5] ARM: dts: exynos: Add support ARM architected timers
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4c0a5561-b1f0-6938-3e89-eae5014aafa1@samsung.com>
Date: Mon, 18 Feb 2019 13:24:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <c73ca3d2-ccd1-e2d0-f81c-5b62a4313a5d@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUiTYRTt8f10tPE6LR+0ZawyDfxCfwwMK4pcgVgRFbWomS863absVUv7
 kSKZDl1Zq+YUNRkYc0ydmy4pqSmOWDgVUhP7gGSmNB2plBDSthfLf+fce+4998AlEb4ZiyJl
 yhJapZTKhTgH7R/dcCfwDQWS5DcdyaJeXTcmml5bwEStqwKR291DiCzfpjCRzj0UIuqzPEGO
 EWKLsQ4Xz029wsXLY2OEuM9wV6yxGoF41bL3LH6FcySXlsvKaFVSxg1O/q+Fday4+sDtez4b
 VglsAjUIJSGVBu1WM6oGHJJPvQDwtW8WZ8kagE9/VyEsWQXQ6m3AtkZaP/wk2Eanf2SxLoQl
 KwB2abQgoAqnsuGo1RrEERQDp12dICBCKBuACxo9EWjgVApUe9V4AHOpDKhTa4MWKHUQmnpq
 gvVdlARqx0YIVhMG3zXNowEcSh2Fc4aJoB6hYmC1rRlhcSScnW8LXgSpQQL+8Hj8hPSTk/B9
 y342QjhccloJFu+Brsf1KKuvBvC+Tk+wpB5AW4sdZ1XpcNgZcCP9DvGwezCJ3XkcNm+eYyEP
 znjD2BN48FH/M4Qtc2FtDZ/dEQv1TvM/17fjk8hDINRvC6bfFka/LYz+v207QI0gki5lFHk0
 k6qkbyUyUgVTqsxLvFmksAD/F7k2net2MPQnxwEoEgh3cn1lMgkfk5Yx5QoHgCQijOCev1Yg
 4XNzpeUVtKrouqpUTjMOEE2iwkjunR1fr/KpPGkJXUjTxbRqqxtChkZVAl3+Wc2IZKDAk9Vr
 LLzY6RsfPPP8c66jsegSzxOOZq+MpkV/NxwaSZdnN2obYk+1VsaVPOAZL8g6TLsbmpY+Fgo6
 vH3tmZ/6TbF2TDw+KTC3z2R0nfbqazcGhucqLp8QtcVjTGbVRA7XtfzSNL2vHv+SMJulxpwx
 qVI7HrcoRJl8acphRMVI/wLqWh88QQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7qCS7JiDBZfV7fYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksXnTVGYHdo9NqzrZPO5c28Pm8e7cOXaPzUvqPfq2rGL0
 +LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
 QS/j+/OvrAXNKhWtH7ayNjBule1i5OSQEDCRmHf1E3sXIxeHkMBSRolTV56zQyRkJE5Oa2CF
 sIUl/lzrYoMoessoce/PbyaQhLCAr8TVjVsZQWwRgWKJk2d+soAUMQtsZ5S4uqWXCaLjF6PE
 nlebwKrYBAwlut6CjOLk4BWwk5jRNQVsBYuAqsSaDW1AcQ4OUYEYiavnGCFKBCVOznzCAmJz
 CthL3FlyEaycWUBd4s+8S8wQtrxE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUo
 klpanJueW2ykV5yYW1yal66XnJ+7iREYfduO/dyyg7HrXfAhRgEORiUe3g9lmTFCrIllxZW5
 hxglOJiVRHiDYrNihHhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmBjySuINTQ3NLSwNzY3N
 jc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwyoqnfz97hvHmibMB24/f+zAlXd7uQI6G
 F+fBlUVpy/qUeLd3/eJ6PXnzuXNnenbK2FssuP7sgK2kV9PVmZbhFzUjXDkTG75e09ZYt5/Z
 PuzsJg+JjLvime2Hjx7+Y7H9iemptVqlK7q0J5zldpv5yUuS/drh0EsmqlqnbJ5bfjsYdue0
 9SvNt0osxRmJhlrMRcWJABJXPVrUAgAA
X-CMS-MailID: 20190218122449eucas1p114c6297d7b3c4a1074600b288c2df097
X-Msg-Generator: CA
X-RootMTR: 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255@eucas1p2.samsung.com>
 <20190215125229.30180-5-m.szyprowski@samsung.com>
 <c73ca3d2-ccd1-e2d0-f81c-5b62a4313a5d@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_042454_678456_A2D4EB4B 
X-CRM114-Status: GOOD (  20.28  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDIwMTktMDItMTggMTI6NTgsIENoYW53b28gQ2hvaSB3cm90ZToKPiBP
biAxOS4gMi4gMTUuIOyYpO2bhCA5OjUyLCBNYXJlayBTenlwcm93c2tpIHdyb3RlOgo+PiBBbGwg
Q29ydGV4QTcvQTE1IGJhc2VkIEV4eW5vcyBTb0NzIGhhdmUgQVJNIGFyY2hpdGVjdGVkIHRpbWVy
cywgc28gZW5hYmxlCj4+IHN1cHBvcnQgZm9yIHRoZW0gZGlyZWN0bHkgaW4gdGhlIGJhc2UgZHRz
aSBmb3IgRXh5bm9zMzI1MCwgRXh5bm9zNTI1MAo+PiBhbmQgRXh5bm9zNTR4eCBTb0NzLiBOb25l
IG9mIHRoZSBrbm93biBmaXJtd2FyZSBwcm9wZXJseSBjb25maWd1cmVzIGFyY2gKPj4gdGltZXIg
cmVnaXN0ZXJzLCBzbyBtYXJrIHRoZW0gYXMgbm90LWZ3LWNvbmZpZ3VyZWQgYW5kIHNldCBmcmVx
dWVuY3kKPj4gdG8gMjRNSHosIHdoaWNoIGlzIHRoZSBvbmx5IGNvbmZpZ3VyYXRpb24gc3VwcG9y
dGVkIGJ5IHRoZSByZW1haW5pbmcKPj4gZHJpdmVycyAoY2xvY2tzKSBzbyBmYXIuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4K
Pj4gLS0tCj4+ICBhcmNoL2FybS9ib290L2R0cy9leHlub3MzMjUwLmR0c2kgfCAxMCArKysrKysr
KysrCj4+ICBhcmNoL2FybS9ib290L2R0cy9leHlub3M1MjUwLmR0c2kgfCAgMSArCj4+ICBhcmNo
L2FybS9ib290L2R0cy9leHlub3M1NHh4LmR0c2kgfCAxMCArKysrKysrKysrCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2V4eW5vczMyNTAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRz
aQo+PiBpbmRleCA2MDhkMTc0NTQxNzkuLjM5NjZlNzk2MDk2NCAxMDA2NDQKPj4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvZXh5bm9zMzI1MC5kdHNpCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2V4eW5vczMyNTAuZHRzaQo+PiBAQCAtMTM0LDYgKzEzNCwxNiBAQAo+PiAgCQkJfTsKPj4gIAkJ
fTsKPj4gIAo+PiArCQl0aW1lciB7Cj4+ICsJCQljb21wYXRpYmxlID0gImFybSxhcm12Ny10aW1l
ciI7Cj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19QUEkgMTMgKEdJQ19DUFVfTUFTS19TSU1QTEUo
NCkgfCBJUlFfVFlQRV9MRVZFTF9MT1cpPiwKPj4gKwkJCQkgICAgIDxHSUNfUFBJIDE0IChHSUNf
Q1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9XKT4sCj4+ICsJCQkJICAgICA8
R0lDX1BQSSAxMSAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVMX0xPVyk+
LAo+PiArCQkJCSAgICAgPEdJQ19QUEkgMTAgKEdJQ19DUFVfTUFTS19TSU1QTEUoNCkgfCBJUlFf
VFlQRV9MRVZFTF9MT1cpPjsKPj4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47Cj4+
ICsJCQlhcm0sY3B1LXJlZ2lzdGVycy1ub3QtZnctY29uZmlndXJlZDsKPj4gKwkJfTsKPj4gKwo+
PiAgCQlzeXNyYW1AMjAyMDAwMCB7Cj4+ICAJCQljb21wYXRpYmxlID0gIm1taW8tc3JhbSI7Cj4+
ICAJCQlyZWcgPSA8MHgwMjAyMDAwMCAweDQwMDAwPjsKPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2V4eW5vczUyNTAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczUyNTAu
ZHRzaQo+PiBpbmRleCA4MDk4NmI5N2RmZTUuLjk1YWY0MDUwZjY5ZCAxMDA2NDQKPj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTI1MC5kdHNpCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2V4eW5vczUyNTAuZHRzaQo+PiBAQCAtMjM5LDYgKzIzOSw3IEBACj4+ICAJCQkgKiBzbyB3
ZSBuZWVkIHRoZSB2YWx1ZSBmcm9tIERULgo+PiAgCQkJICovCj4+ICAJCQljbG9jay1mcmVxdWVu
Y3kgPSA8MjQwMDAwMDA+Owo+PiArCQkJYXJtLGNwdS1yZWdpc3RlcnMtbm90LWZ3LWNvbmZpZ3Vy
ZWQ7Cj4+ICAJCX07Cj4+ICAKPj4gIAkJbWN0QDEwMWMwMDAwIHsKPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0eHguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5v
czU0eHguZHRzaQo+PiBpbmRleCBkZTI2ZTVlZTBkMmQuLjQ1ZTA2NzE3ZWU1MSAxMDA2NDQKPj4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5kdHNpCj4+ICsrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2V4eW5vczU0eHguZHRzaQo+PiBAQCAtNDYsNiArNDYsMTYgQEAKPj4gIAkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7Cj4+ICAJCX07Cj4+ICAKPj4gKwkJdGltZXIgewo+PiArCQkJY29t
cGF0aWJsZSA9ICJhcm0sYXJtdjctdGltZXIiOwo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfUFBJ
IDEzIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9XKT4sCj4+ICsJ
CQkJICAgICA8R0lDX1BQSSAxNCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xF
VkVMX0xPVyk+LAo+PiArCQkJCSAgICAgPEdJQ19QUEkgMTEgKEdJQ19DUFVfTUFTS19TSU1QTEUo
NCkgfCBJUlFfVFlQRV9MRVZFTF9MT1cpPiwKPj4gKwkJCQkgICAgIDxHSUNfUFBJIDEwIChHSUNf
Q1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9XKT47Cj4+ICsJCQlhcm0sY3B1
LXJlZ2lzdGVycy1ub3QtZnctY29uZmlndXJlZDsKPj4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwy
NDAwMDAwMD47Cj4+ICsJCX07Cj4+ICsKPj4gIAkJc3lzcmFtQDIwMjAwMDAgewo+PiAgCQkJY29t
cGF0aWJsZSA9ICJtbWlvLXNyYW0iOwo+PiAgCQkJcmVnID0gPDB4MDIwMjAwMDAgMHg1NDAwMD47
Cj4+Cj4gVGhlIGV4eW5vczU0eHguZHRzaSBhZmZlY3RzIHRoZSBleHlub3M1NDEwIFNvQy4KPiBX
aGVuIEkgY2hlY2tlZCB0aGUgUFBJIHBvcnQgbnVtYmVyIG9uIEV4eW5vczU0MTAvRXh5bm9zNTQy
MiBUUk0sCj4gdGhleSBoYXZlIHRoZSBkaWZmZXJlbnQgUFBJIHBvcnQgbnVtYmVyIGFzIGZvbGxv
d2luZzoKPgo+IAkJCQl8RXh5bm9zNTQxMAl8RXh5bm9zNTQyMgl8Cj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+IEFSQ0hfVElNRVJfUEhZU19TRUNVUkVfUFBJCXwxIG5DTlRQU0lS
UQl8MTMgbkNOVFBTSVJRCXxTZWN1cmUgcGh5c2ljYWwgdGltZXIKPiBBUkNIX1RJTUVSX1BIWVNf
Tk9OU0VDVVJFX1BQSQl8MiBuQ05UUE5TSVJRCXwxNCBuQ05UUE5TSVJRCXxOb24tc2VjdXJlIHBo
eXNpY2FsIHRpbWVyCj4gQVJDSF9USU1FUl9WSVJUX1BQSQkJfDQgbkNOVFZJUlEJfDExIG5DTlRW
SVJRCXxWaXJ0dWFsIHRpbWVyCj4gQVJDSF9USU1FUl9IWVBfUFBJCQl8NSBuQ05USFBJUlEJfDEw
IG5DTlRIUElSUQl8SHlwZXJ2aXNvciB0aW1lcgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KClNhZGx5LCBFeHlub3M1NDEwIFRSTSBzZWVtcyB0byBiZSB3cm9uZy4gQWxsIG90aGVy
IEV4eW5vczUgVFJNcyAoNTI1MCwKNTI2MCwgNTQyMCwgNTQyMikgZGVmaW5lcyAxMywxNCwxMSwx
MCBQUEkgZm9yIGFyY2ggdGltZXIuIEkndmUgY2hlY2tlZApvbiB0aGUgcmVhbCBoYXJkd2FyZSAo
RXh5bm9zNTQxMC1iYXNlZCBPZHJvaWQgWFUgYm9hcmQpIGFuZCB0aGUgdmFsdWVzCnRha2VuIGZy
b20gRXh5bm9zNTQyMiBUUk0gd29ya3MgZmluZSwgd2hpbGUgdGhlIG9uZXMgZnJvbSA1NDEwIFRS
TSBkb24ndC4KCj4gRXh5bm9zNTQxMCBhbmQgRXh5bm9zNTQyMiBoYXZlIHRoZSBkaWZmZXJlbnQg
dXNhZ2Ugb2YgYml0ZmllbGQKPiBvZiAgbkNOVFBTSVJRL25DTlRQTlNJUlEvbkNOVFZJUlEvbkNO
VEhQSVJRIGFzIGZvbGxvd2luZzoKPgo+IAkJCQl8RXh5bm9zNTQxMAl8RXh5bm9zNTQyMgo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IG5DTlRQU0lSUVszOjBdCQkJfCBLRkMJCXwgRUFHTEUKPiBuQ05UUE5TSVJRWzM6MF0JCQl8
IEtGQwkJfCBFQUdMRQo+IG5DTlRWSVJRWzM6MF0JCQl8IEtGQwkJfCBFQUdMRQo+IG5DTlRIUElS
UVszOjBdCQkJfCBLRkMJCXwgRUFHTEUKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBuQ05UUFNJUlFbNzo0XQkJCXwgRUFHTEUJ
CXwgS0ZDCj4gbkNOVFBOU0lSUVs3OjRdCQkJfCBFQUdMRQkJfCBLRkMKPiBuQ05UVklSUVs3OjRd
CQkJfCBFQUdMRQkJfCBLRkMKPiBuQ05USFBJUlFbNzo0XQkJCXwgRUFHTEUJCXwgS0ZDCgpUaGlz
IGlzIG5vdCBhbiBpc3N1ZSwgdGhpcyBpcyBhIHJlc3VsdCBvZiBkaWZmZXJlbnQgb3JkZXIgb2Yg
Yml0L0xJVFRMRQpjb3Jlcy4gU2FtZSBmb3IgRXh5bm9zNTQyMC4KCkJlc3QgcmVnYXJkcwotLSAK
TWFyZWsgU3p5cHJvd3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
