Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F710C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297302147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jpnV7ZM3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BxIStWg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297302147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:To:Subject:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jASV+3NvOcBrz+ImVY9lAVTJoS8O2lfmxvn4x3835g=; b=jpnV7ZM3SkkCsT
	S84O7+819pwsYdklNt2aykhcATxJBdElQwO1QecS1nnhRaBXAHfRhCNaJ/TpRsitj+7a/PS/eli+F
	jOCuGL2hufwtzxKUN58Lz5vOPNbDB8hZ6qa8WcPn4uXe7wnwNiEmxcAWUA5BBHYoEAX10sn3CFf5I
	Nr+zJqwh7QL8Yhl5DLZ7qalblasGhJ5zLk7FwvhmoEn5ngZa+BruHieMxHeCQoFFAMU2UhIk6upPC
	+UaC4g6L5lL9bSl3C2RBI84Lsscg8jTjwz/yhDan9hNniHwASFFBlyb01xj2zUy2eVQuSLWtQOKpZ
	Iqing6nRUY6S/u6QYW+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhZ7-00035d-1k; Mon, 18 Feb 2019 11:58:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhYz-0002wX-Mq
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:58:27 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190218115817epoutp038c5e93beee7fa04d54c54bbeb6cf93e6~Ec3BIvo1C1665716657epoutp03U
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190218115817epoutp038c5e93beee7fa04d54c54bbeb6cf93e6~Ec3BIvo1C1665716657epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550491097;
 bh=SNqVIOLxybvp8P8e4GA59YTiPxiH/hUaDQEUf2J4r+M=;
 h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
 b=BxIStWg/naK8KVqrv1U123BJgtkujozuk3NV2/rj/OwRrstqdgQy+gK1rtzZ11S5c
 VFpoHe54xsJqf38644m1VbRqJ4qEcEv371CY/61DZyKh+/O6xtC0IYQHtJKmXNIGup
 L93Wh+IHYiHW1gDZJsN3Rh/cl9dDvX+R5GeqLOKI=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20190218115813epcas1p44808a711fd3d74e55976744f0c66a8fe~Ec29j_4CV0889908899epcas1p4a;
 Mon, 18 Feb 2019 11:58:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E8.CD.04173.5DD9A6C5; Mon, 18 Feb 2019 20:58:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190218115813epcas1p2749365e1faf76758f5fc4ed699af06f4~Ec28ttdxL1713417134epcas1p2J;
 Mon, 18 Feb 2019 11:58:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190218115813epsmtrp24bec57794d71ba1c9a90d4c25cd22c5f~Ec28qmHbt2591625916epsmtrp2L;
 Mon, 18 Feb 2019 11:58:13 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-01-5c6a9dd5499f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6C.49.03971.4DD9A6C5; Mon, 18 Feb 2019 20:58:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190218115812epsmtip2a2d4c96b2791031215de844102f143b7~Ec28gA-cN0725307253epsmtip2p;
 Mon, 18 Feb 2019 11:58:12 +0000 (GMT)
From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 4/5] ARM: dts: exynos: Add support ARM architected timers
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Organization: Samsung Electronics
Message-ID: <c73ca3d2-ccd1-e2d0-f81c-5b62a4313a5d@samsung.com>
Date: Mon, 18 Feb 2019 20:58:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215125229.30180-5-m.szyprowski@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmge7VuVkxBv+fWlpsnLGe1WLeZ1mL
 8+c3sFtsenyN1WLG+X1MFmuP3GW32LxpKrMDu8emVZ1sHneu7WHzeHfuHLvH5iX1Hn1bVjF6
 fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZ
 A3SJkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDA
 yBSoMCE74+WHWcwFJ+UrOv90MzcwPpTsYuTkkBAwkVi/+gdrFyMXh5DADkaJ3atXskE4nxgl
 /m5exw5SJSTwjVFi5kERmI7LV04yQsT3MkqsOeoB0fCeUeL7426wBJuAlsT+FzfYQGxhAX+J
 Y1u2gMVFBKok+g78YgZpYBbYyijxvG8W2AZ+AUWJqz8eAxVxcPAK2El8PFMDEmYRUJXo2fwY
 bI6oQITE4d53YHN4BQQlTs58wgJicwKVtzTMARvDLCAucevJfCYIW16ieetssF0SAr/ZJK5+
 3sYC8YGLxKMz+6FsYYlXx7ewQ9hSEp/f7WWDsKslVp48wgbR3MEosWX/BVaIhLHE/qWTmUAO
 ZRbQlFi/Sx9iGZ/Eu689rCBhCQFeiY42IYhqZYnLD+4yQdiSEovbO6HGe0jca//KOoFRcRaS
 d2YheWEWkhdmISxbwMiyilEstaA4Nz212LDACDmyNzGCE6mW2Q7GRed8DjEKcDAq8fB+KMuM
 EWJNLCuuzD3EKMHBrCTCGxSbFSPEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST84FJPq8k3tDU
 yNjY2MLE0MzU0FBJnHe9g3OMkEB6YklqdmpqQWoRTB8TB6dUAyPD1jOW/NN/M2VNWd7xOszf
 seBkmH9DT2Ll0ztnt+XG/GDUnGZqYJ3uuSDJWOezX7+b4u0Mvo63lXMZavJXc3g25H8/wCHW
 FPLk3mfmtkhVhfPf3GpSb3dwM/Yy+H5YbnbGbXXvxSPNDPGvgxb36EizCZ9s2lh3jWeF9v0j
 bxexbDQ5KmzOocRSnJFoqMVcVJwIAMFfKsm6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvO6VuVkxBst2WVpsnLGe1WLeZ1mL
 8+c3sFtsenyN1WLG+X1MFmuP3GW32LxpKrMDu8emVZ1sHneu7WHzeHfuHLvH5iX1Hn1bVjF6
 fN4kF8AWxWWTkpqTWZZapG+XwJXx8sMs5oKT8hWdf7qZGxgfSnYxcnJICJhIXL5ykrGLkYtD
 SGA3o0TfysOMEAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZTY9uglE0gNm4CWxP4XN9hAbGEBX4mr
 G7eC9YoIVAHVb2UDaWAW2M4ocXVLLxNE91FGiVXPf7OCVPELKEpc/fGYEWQDr4CdxMczNSBh
 FgFViZ7Nj8GGigpESHx8ug9sGa+AoMTJmU9YQGxOoPKWhjnsIDazgLrEn3mXmCFscYlbT+Yz
 QdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
 P3cTIziqtDR3MF5eEn+IUYCDUYmH90NZZowQa2JZcWXuIUYJDmYlEd6g2KwYId6UxMqq1KL8
 +KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhjnrDnz/fv6tWkNzHdnf1G6
 +oXhxha5zFBNOdH359a+cT6zNlV073GzBcqfzl6rv2G6XqLjwH7fVVWVUX+DOw+f/G3gretT
 cXq95X2D2c3nP32qnHyEc2bGI9/FFjNzPzHpv60trggVqNl59sTZu0GNJ3dq9czNOfvz8qM+
 h/tpRVNeL70wVWbzPCWW4oxEQy3mouJEAG8KSIumAgAA
X-CMS-MailID: 20190218115813epcas1p2749365e1faf76758f5fc4ed699af06f4
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255@eucas1p2.samsung.com>
 <20190215125229.30180-5-m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_035822_263135_5D237512 
X-CRM114-Status: GOOD (  24.89  )
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

SGkgTWFyZWssCgpPbiAxOS4gMi4gMTUuIOyYpO2bhCA5OjUyLCBNYXJlayBTenlwcm93c2tpIHdy
b3RlOgo+IEFsbCBDb3J0ZXhBNy9BMTUgYmFzZWQgRXh5bm9zIFNvQ3MgaGF2ZSBBUk0gYXJjaGl0
ZWN0ZWQgdGltZXJzLCBzbyBlbmFibGUKPiBzdXBwb3J0IGZvciB0aGVtIGRpcmVjdGx5IGluIHRo
ZSBiYXNlIGR0c2kgZm9yIEV4eW5vczMyNTAsIEV4eW5vczUyNTAKPiBhbmQgRXh5bm9zNTR4eCBT
b0NzLiBOb25lIG9mIHRoZSBrbm93biBmaXJtd2FyZSBwcm9wZXJseSBjb25maWd1cmVzIGFyY2gK
PiB0aW1lciByZWdpc3RlcnMsIHNvIG1hcmsgdGhlbSBhcyBub3QtZnctY29uZmlndXJlZCBhbmQg
c2V0IGZyZXF1ZW5jeQo+IHRvIDI0TUh6LCB3aGljaCBpcyB0aGUgb25seSBjb25maWd1cmF0aW9u
IHN1cHBvcnRlZCBieSB0aGUgcmVtYWluaW5nCj4gZHJpdmVycyAoY2xvY2tzKSBzbyBmYXIuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcu
Y29tPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9leHlub3MzMjUwLmR0c2kgfCAxMCArKysr
KysrKysrCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczUyNTAuZHRzaSB8ICAxICsKPiAgYXJj
aC9hcm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5kdHNpIHwgMTAgKysrKysrKysrKwo+ICAzIGZpbGVz
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvZXh5bm9zMzI1MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zMzI1MC5kdHNp
Cj4gaW5kZXggNjA4ZDE3NDU0MTc5Li4zOTY2ZTc5NjA5NjQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvZXh5bm9zMzI1MC5kdHNpCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5
bm9zMzI1MC5kdHNpCj4gQEAgLTEzNCw2ICsxMzQsMTYgQEAKPiAgCQkJfTsKPiAgCQl9Owo+ICAK
PiArCQl0aW1lciB7Cj4gKwkJCWNvbXBhdGlibGUgPSAiYXJtLGFybXY3LXRpbWVyIjsKPiArCQkJ
aW50ZXJydXB0cyA9IDxHSUNfUFBJIDEzIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZ
UEVfTEVWRUxfTE9XKT4sCj4gKwkJCQkgICAgIDxHSUNfUFBJIDE0IChHSUNfQ1BVX01BU0tfU0lN
UExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9XKT4sCj4gKwkJCQkgICAgIDxHSUNfUFBJIDExIChH
SUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9XKT4sCj4gKwkJCQkgICAg
IDxHSUNfUFBJIDEwIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9X
KT47Cj4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47Cj4gKwkJCWFybSxjcHUtcmVn
aXN0ZXJzLW5vdC1mdy1jb25maWd1cmVkOwo+ICsJCX07Cj4gKwo+ICAJCXN5c3JhbUAyMDIwMDAw
IHsKPiAgCQkJY29tcGF0aWJsZSA9ICJtbWlvLXNyYW0iOwo+ICAJCQlyZWcgPSA8MHgwMjAyMDAw
MCAweDQwMDAwPjsKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTI1MC5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTI1MC5kdHNpCj4gaW5kZXggODA5ODZiOTdk
ZmU1Li45NWFmNDA1MGY2OWQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9z
NTI1MC5kdHNpCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTI1MC5kdHNpCj4gQEAg
LTIzOSw2ICsyMzksNyBAQAo+ICAJCQkgKiBzbyB3ZSBuZWVkIHRoZSB2YWx1ZSBmcm9tIERULgo+
ICAJCQkgKi8KPiAgCQkJY2xvY2stZnJlcXVlbmN5ID0gPDI0MDAwMDAwPjsKPiArCQkJYXJtLGNw
dS1yZWdpc3RlcnMtbm90LWZ3LWNvbmZpZ3VyZWQ7Cj4gIAkJfTsKPiAgCj4gIAkJbWN0QDEwMWMw
MDAwIHsKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5kdHNpIGIv
YXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5kdHNpCj4gaW5kZXggZGUyNmU1ZWUwZDJkLi40
NWUwNjcxN2VlNTEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5k
dHNpCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5kdHNpCj4gQEAgLTQ2LDYg
KzQ2LDE2IEBACj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gIAkJfTsKPiAgCj4gKwkJdGlt
ZXIgewo+ICsJCQljb21wYXRpYmxlID0gImFybSxhcm12Ny10aW1lciI7Cj4gKwkJCWludGVycnVw
dHMgPSA8R0lDX1BQSSAxMyAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVM
X0xPVyk+LAo+ICsJCQkJICAgICA8R0lDX1BQSSAxNCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8
IElSUV9UWVBFX0xFVkVMX0xPVyk+LAo+ICsJCQkJICAgICA8R0lDX1BQSSAxMSAoR0lDX0NQVV9N
QVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVMX0xPVyk+LAo+ICsJCQkJICAgICA8R0lDX1BQ
SSAxMCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVMX0xPVyk+Owo+ICsJ
CQlhcm0sY3B1LXJlZ2lzdGVycy1ub3QtZnctY29uZmlndXJlZDsKPiArCQkJY2xvY2stZnJlcXVl
bmN5ID0gPDI0MDAwMDAwPjsKPiArCQl9Owo+ICsKPiAgCQlzeXNyYW1AMjAyMDAwMCB7Cj4gIAkJ
CWNvbXBhdGlibGUgPSAibW1pby1zcmFtIjsKPiAgCQkJcmVnID0gPDB4MDIwMjAwMDAgMHg1NDAw
MD47Cj4gCgpUaGUgZXh5bm9zNTR4eC5kdHNpIGFmZmVjdHMgdGhlIGV4eW5vczU0MTAgU29DLgpX
aGVuIEkgY2hlY2tlZCB0aGUgUFBJIHBvcnQgbnVtYmVyIG9uIEV4eW5vczU0MTAvRXh5bm9zNTQy
MiBUUk0sCnRoZXkgaGF2ZSB0aGUgZGlmZmVyZW50IFBQSSBwb3J0IG51bWJlciBhcyBmb2xsb3dp
bmc6CgoJCQkJfEV4eW5vczU0MTAJfEV4eW5vczU0MjIJfAotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkFSQ0hfVElNRVJfUEhZU19TRUNVUkVfUFBJCXwxIG5DTlRQU0lSUQl8MTMgbkNO
VFBTSVJRCXxTZWN1cmUgcGh5c2ljYWwgdGltZXIKQVJDSF9USU1FUl9QSFlTX05PTlNFQ1VSRV9Q
UEkJfDIgbkNOVFBOU0lSUQl8MTQgbkNOVFBOU0lSUQl8Tm9uLXNlY3VyZSBwaHlzaWNhbCB0aW1l
cgpBUkNIX1RJTUVSX1ZJUlRfUFBJCQl8NCBuQ05UVklSUQl8MTEgbkNOVFZJUlEJfFZpcnR1YWwg
dGltZXIKQVJDSF9USU1FUl9IWVBfUFBJCQl8NSBuQ05USFBJUlEJfDEwIG5DTlRIUElSUQl8SHlw
ZXJ2aXNvciB0aW1lcgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgoKRXh5bm9zNTQx
MCBhbmQgRXh5bm9zNTQyMiBoYXZlIHRoZSBkaWZmZXJlbnQgdXNhZ2Ugb2YgYml0ZmllbGQKb2Yg
IG5DTlRQU0lSUS9uQ05UUE5TSVJRL25DTlRWSVJRL25DTlRIUElSUSBhcyBmb2xsb3dpbmc6CgoJ
CQkJfEV4eW5vczU0MTAJfEV4eW5vczU0MjIKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCm5DTlRQU0lSUVszOjBdCQkJfCBLRkMJCXwg
RUFHTEUKbkNOVFBOU0lSUVszOjBdCQkJfCBLRkMJCXwgRUFHTEUKbkNOVFZJUlFbMzowXQkJCXwg
S0ZDCQl8IEVBR0xFCm5DTlRIUElSUVszOjBdCQkJfCBLRkMJCXwgRUFHTEUKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCm5DTlRQU0lS
UVs3OjRdCQkJfCBFQUdMRQkJfCBLRkMKbkNOVFBOU0lSUVs3OjRdCQkJfCBFQUdMRQkJfCBLRkMK
bkNOVFZJUlFbNzo0XQkJCXwgRUFHTEUJCXwgS0ZDCm5DTlRIUElSUVs3OjRdCQkJfCBFQUdMRQkJ
fCBLRkMKCgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmlj
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
