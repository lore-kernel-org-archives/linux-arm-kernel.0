Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:03:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBC721773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="prdKlLch";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eWzkZqE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBC721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nmTeEglv6P9Ctcyh9XN7f5Tfb+X5CCxJMMyvnoGFZNo=; b=prdKlLchUzkupx
	SYRu3vVul/p+2CGek9oknYMFiWZfyPeDI8N/okw3+4fRWG7GpbMJizZ6WZiPdB5160EKqK+mQ0/58
	48UaeZ6OrWXV9o9FrRIhUB2Yvx/P7aNGUm+VpN1ynd3Gs0fVI/8Fu+lj08MG4qUXUHQ6W3ItjKbdo
	p9DRr7cJ/UJNtxo7HUsdnSgB//iREnfo23Q38f/p5067crqJA0s9Oj5zTUeZ+bTcGsHezb+VfnCzF
	4SEyz/1nWpbIXaLoUM9AJcjXfpeWO1tCXF8TbXMnJrCyLoywRRgd7xiKKECKYYxVMbJ/K1ec9KxbN
	jnnM5tKshGe44AdryYaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvssp-0000m2-0k; Tue, 19 Feb 2019 00:03:35 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvssk-0000l7-Uc
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 00:03:33 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20190219000325epoutp02e325c67d0f5c55cc461734062d8fe2ec~EmwJGYWrx2194721947epoutp02i
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 00:03:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20190219000325epoutp02e325c67d0f5c55cc461734062d8fe2ec~EmwJGYWrx2194721947epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550534605;
 bh=F0auFMEAqPPVE3jKEVIOZfcK6wYSDouj31vSnbHwtW4=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=eWzkZqE7brbi9s0rh7Bz8bzwI0SkPeSPiePrYDh9ZZR8Ew9iEfFI5m6ZObeRMcUs8
 jk5grexeDdZc3e4mW2wFe43gBveIXB12+ItbPEuzOPC9AqS9N5JMRq3gZofPAjxADg
 cKULwZx4P3gPYRqmYuF6MNFRXW5b5Hr0erAgSOjA=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190219000321epcas1p26abf01d24258e156cf108e29ef54485b~EmwFAWILf2832528325epcas1p2h;
 Tue, 19 Feb 2019 00:03:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 D5.49.04206.6C74B6C5; Tue, 19 Feb 2019 09:03:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20190219000318epcas1p37ddc0922b8b988737ce97da67c032237~EmwCIbML92815828158epcas1p3F;
 Tue, 19 Feb 2019 00:03:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190219000318epsmtrp2fa95ef2a297f30c8fc843fda25081025~EmwCHh1xS1402514025epsmtrp2w;
 Tue, 19 Feb 2019 00:03:18 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-40-5c6b47c636ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.D1.03601.6C74B6C5; Tue, 19 Feb 2019 09:03:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190219000318epsmtip1aca920ece7f152e462b17d28920e1e81~EmwB_uyMl1439314393epsmtip1l;
 Tue, 19 Feb 2019 00:03:18 +0000 (GMT)
Subject: Re: [PATCH 4/5] ARM: dts: exynos: Add support ARM architected timers
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <584ac777-445c-81de-d1c1-645306ed88d9@samsung.com>
Date: Tue, 19 Feb 2019 09:03:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4c0a5561-b1f0-6938-3e89-eae5014aafa1@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmge4x9+wYg6M39S02zljPajHvs6zF
 +fMb2C02Pb7GajHj/D4mi7VH7rJbbN40ldmB3WPTqk42jzvX9rB5vDt3jt1j85J6j74tqxg9
 Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
 AbpESaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBg
 ZApUmJCdMePXMuaCswoVlzrfsDYwPpfqYuTkkBAwkXjydS9TFyMXh5DADkaJj7Oms0E4nxgl
 Zn3Zxg7hfGOU+D3vNRtcS9ssZojEXkaJw5PmsUI474GqGhczgVQJC/hLHNuyhRHEFhGokug7
 8Ausg1lgK6PE875Z7CAJNgEtif0vboCN5RdQlLj64zFYA6+AncSJHU1gNSwCqhJv3/0EGyoq
 ECFxuPcdVI2gxMmZT1hAbE4Be4k7H+eB1TALiEvcejIfypaXaN46G2yxhMB3Non2pTMZIX5w
 kViy4zArhC0s8er4FnYIW0ri87u9UH9WS6w8eYQNormDUWLL/gtQDcYS+5dOBtrAAbRBU2L9
 Ln2IZXwS7772sIKEJQR4JTrahCCqlSUuP7jLBGFLSixu74Qa7yFxr/0r6wRGxVlI3pmF5IVZ
 SF6YhbBsASPLKkax1ILi3PTUYsMCU+T43sQITqdaljsYj53zOcQowMGoxMO7YHlWjBBrYllx
 Ze4hRgkOZiUR3mM3gEK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5jq80riDU2NjI2NLUwM
 zUwNDZXEedc7OMcICaQnlqRmp6YWpBbB9DFxcEo1MG51edPzeIlawh/1gpD9rYtC1zdGKd6q
 ecC0S1YpbPWNK95yB4Ryk5tkTiSss0uS9OmUnyb5n7MlurZHtNJ9nbL4c+V1TiXHJ+id4Fkm
 dT7s9zmJB+GzxB3Zth46+Dls+j1pDq4qse+OfxIvrv2bfPHAoZXRM/pW+j7a8cv4kQP7Wh4j
 u79sS5RYijMSDbWYi4oTARiiNlu9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO4x9+wYg79X+C02zljPajHvs6zF
 +fMb2C02Pb7GajHj/D4mi7VH7rJbbN40ldmB3WPTqk42jzvX9rB5vDt3jt1j85J6j74tqxg9
 Pm+SC2CL4rJJSc3JLEst0rdL4MqY8WsZc8FZhYpLnW9YGxifS3UxcnJICJhIPGmbxdzFyMUh
 JLCbUWLqoRVMEAlJiWkXjwIlOIBsYYnDh4shat4ySlxb+okVpEZYwFfi6satjCC2iEAVUM1W
 NpAiZoHtjBJXt/SCDRISWM8kcWdeBYjNJqAlsf/FDTYQm19AUeLqj8dgzbwCdhIndjSxg9gs
 AqoSb9/9BOsVFYiQ+Ph0HxNEjaDEyZlPWEBsTgF7iTsf54HFmQXUJf7Mu8QMYYtL3HoyHyou
 L9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3
 MYKjSktrB+OJE/GHGAU4GJV4eBcsz4oRYk0sK67MPcQowcGsJMJ77AZQiDclsbIqtSg/vqg0
 J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUAyPnZznz7fPUQs+zzH4lY1Z0Zu9C
 W+vuOWFd8w3f6gscX1uicFD/2jouiahZoX9E31ku+fTSZePM7ps/N7z8Y7tLJHP/p0/C7L3+
 e6/ta/x5lDd01kzHrrdV+wtlFY26ihUafq9bPKeRN4XRcVrZnT+rD/had0ra+RxkcOtd7LfM
 VmbubPc7vGxKLMUZiYZazEXFiQDnjuXbpgIAAA==
X-CMS-MailID: 20190219000318epcas1p37ddc0922b8b988737ce97da67c032237
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255@eucas1p2.samsung.com>
 <20190215125229.30180-5-m.szyprowski@samsung.com>
 <c73ca3d2-ccd1-e2d0-f81c-5b62a4313a5d@samsung.com>
 <4c0a5561-b1f0-6938-3e89-eae5014aafa1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_160331_487886_1B7A9DAE 
X-CRM114-Status: GOOD (  23.60  )
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

SGkgTWFyZWssCgpPbiAxOS4gMi4gMTguIOyYpO2bhCA5OjI0LCBNYXJlayBTenlwcm93c2tpIHdy
b3RlOgo+IEhpIENoYW53b28sCj4gCj4gT24gMjAxOS0wMi0xOCAxMjo1OCwgQ2hhbndvbyBDaG9p
IHdyb3RlOgo+PiBPbiAxOS4gMi4gMTUuIOyYpO2bhCA5OjUyLCBNYXJlayBTenlwcm93c2tpIHdy
b3RlOgo+Pj4gQWxsIENvcnRleEE3L0ExNSBiYXNlZCBFeHlub3MgU29DcyBoYXZlIEFSTSBhcmNo
aXRlY3RlZCB0aW1lcnMsIHNvIGVuYWJsZQo+Pj4gc3VwcG9ydCBmb3IgdGhlbSBkaXJlY3RseSBp
biB0aGUgYmFzZSBkdHNpIGZvciBFeHlub3MzMjUwLCBFeHlub3M1MjUwCj4+PiBhbmQgRXh5bm9z
NTR4eCBTb0NzLiBOb25lIG9mIHRoZSBrbm93biBmaXJtd2FyZSBwcm9wZXJseSBjb25maWd1cmVz
IGFyY2gKPj4+IHRpbWVyIHJlZ2lzdGVycywgc28gbWFyayB0aGVtIGFzIG5vdC1mdy1jb25maWd1
cmVkIGFuZCBzZXQgZnJlcXVlbmN5Cj4+PiB0byAyNE1Ieiwgd2hpY2ggaXMgdGhlIG9ubHkgY29u
ZmlndXJhdGlvbiBzdXBwb3J0ZWQgYnkgdGhlIHJlbWFpbmluZwo+Pj4gZHJpdmVycyAoY2xvY2tz
KSBzbyBmYXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlw
cm93c2tpQHNhbXN1bmcuY29tPgo+Pj4gLS0tCj4+PiAgYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9z
MzI1MC5kdHNpIHwgMTAgKysrKysrKysrKwo+Pj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczUy
NTAuZHRzaSB8ICAxICsKPj4+ICBhcmNoL2FybS9ib290L2R0cy9leHlub3M1NHh4LmR0c2kgfCAx
MCArKysrKysrKysrCj4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaQo+Pj4gaW5kZXggNjA4ZDE3NDU0MTc5Li4zOTY2
ZTc5NjA5NjQgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9leHlub3MzMjUwLmR0
c2kKPj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaQo+Pj4gQEAgLTEz
NCw2ICsxMzQsMTYgQEAKPj4+ICAJCQl9Owo+Pj4gIAkJfTsKPj4+ICAKPj4+ICsJCXRpbWVyIHsK
Pj4+ICsJCQljb21wYXRpYmxlID0gImFybSxhcm12Ny10aW1lciI7Cj4+PiArCQkJaW50ZXJydXB0
cyA9IDxHSUNfUFBJIDEzIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxf
TE9XKT4sCj4+PiArCQkJCSAgICAgPEdJQ19QUEkgMTQgKEdJQ19DUFVfTUFTS19TSU1QTEUoNCkg
fCBJUlFfVFlQRV9MRVZFTF9MT1cpPiwKPj4+ICsJCQkJICAgICA8R0lDX1BQSSAxMSAoR0lDX0NQ
VV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVMX0xPVyk+LAo+Pj4gKwkJCQkgICAgIDxH
SUNfUFBJIDEwIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxfTE9XKT47
Cj4+PiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDI0MDAwMDAwPjsKPj4+ICsJCQlhcm0sY3B1LXJl
Z2lzdGVycy1ub3QtZnctY29uZmlndXJlZDsKPj4+ICsJCX07Cj4+PiArCj4+PiAgCQlzeXNyYW1A
MjAyMDAwMCB7Cj4+PiAgCQkJY29tcGF0aWJsZSA9ICJtbWlvLXNyYW0iOwo+Pj4gIAkJCXJlZyA9
IDwweDAyMDIwMDAwIDB4NDAwMDA+Owo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2V4eW5vczUyNTAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczUyNTAuZHRzaQo+Pj4g
aW5kZXggODA5ODZiOTdkZmU1Li45NWFmNDA1MGY2OWQgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9leHlub3M1MjUwLmR0c2kKPj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4
eW5vczUyNTAuZHRzaQo+Pj4gQEAgLTIzOSw2ICsyMzksNyBAQAo+Pj4gIAkJCSAqIHNvIHdlIG5l
ZWQgdGhlIHZhbHVlIGZyb20gRFQuCj4+PiAgCQkJICovCj4+PiAgCQkJY2xvY2stZnJlcXVlbmN5
ID0gPDI0MDAwMDAwPjsKPj4+ICsJCQlhcm0sY3B1LXJlZ2lzdGVycy1ub3QtZnctY29uZmlndXJl
ZDsKPj4+ICAJCX07Cj4+PiAgCj4+PiAgCQltY3RAMTAxYzAwMDAgewo+Pj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0eHguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4
eW5vczU0eHguZHRzaQo+Pj4gaW5kZXggZGUyNmU1ZWUwZDJkLi40NWUwNjcxN2VlNTEgMTAwNjQ0
Cj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9leHlub3M1NHh4LmR0c2kKPj4+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0eHguZHRzaQo+Pj4gQEAgLTQ2LDYgKzQ2LDE2IEBACj4+
PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPj4+ICAJCX07Cj4+PiAgCj4+PiArCQl0aW1lciB7
Cj4+PiArCQkJY29tcGF0aWJsZSA9ICJhcm0sYXJtdjctdGltZXIiOwo+Pj4gKwkJCWludGVycnVw
dHMgPSA8R0lDX1BQSSAxMyAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVM
X0xPVyk+LAo+Pj4gKwkJCQkgICAgIDxHSUNfUFBJIDE0IChHSUNfQ1BVX01BU0tfU0lNUExFKDQp
IHwgSVJRX1RZUEVfTEVWRUxfTE9XKT4sCj4+PiArCQkJCSAgICAgPEdJQ19QUEkgMTEgKEdJQ19D
UFVfTUFTS19TSU1QTEUoNCkgfCBJUlFfVFlQRV9MRVZFTF9MT1cpPiwKPj4+ICsJCQkJICAgICA8
R0lDX1BQSSAxMCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8IElSUV9UWVBFX0xFVkVMX0xPVyk+
Owo+Pj4gKwkJCWFybSxjcHUtcmVnaXN0ZXJzLW5vdC1mdy1jb25maWd1cmVkOwo+Pj4gKwkJCWNs
b2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47Cj4+PiArCQl9Owo+Pj4gKwo+Pj4gIAkJc3lzcmFt
QDIwMjAwMDAgewo+Pj4gIAkJCWNvbXBhdGlibGUgPSAibW1pby1zcmFtIjsKPj4+ICAJCQlyZWcg
PSA8MHgwMjAyMDAwMCAweDU0MDAwPjsKPj4+Cj4+IFRoZSBleHlub3M1NHh4LmR0c2kgYWZmZWN0
cyB0aGUgZXh5bm9zNTQxMCBTb0MuCj4+IFdoZW4gSSBjaGVja2VkIHRoZSBQUEkgcG9ydCBudW1i
ZXIgb24gRXh5bm9zNTQxMC9FeHlub3M1NDIyIFRSTSwKPj4gdGhleSBoYXZlIHRoZSBkaWZmZXJl
bnQgUFBJIHBvcnQgbnVtYmVyIGFzIGZvbGxvd2luZzoKPj4KPj4gCQkJCXxFeHlub3M1NDEwCXxF
eHlub3M1NDIyCXwKPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiBBUkNIX1RJ
TUVSX1BIWVNfU0VDVVJFX1BQSQl8MSBuQ05UUFNJUlEJfDEzIG5DTlRQU0lSUQl8U2VjdXJlIHBo
eXNpY2FsIHRpbWVyCj4+IEFSQ0hfVElNRVJfUEhZU19OT05TRUNVUkVfUFBJCXwyIG5DTlRQTlNJ
UlEJfDE0IG5DTlRQTlNJUlEJfE5vbi1zZWN1cmUgcGh5c2ljYWwgdGltZXIKPj4gQVJDSF9USU1F
Ul9WSVJUX1BQSQkJfDQgbkNOVFZJUlEJfDExIG5DTlRWSVJRCXxWaXJ0dWFsIHRpbWVyCj4+IEFS
Q0hfVElNRVJfSFlQX1BQSQkJfDUgbkNOVEhQSVJRCXwxMCBuQ05USFBJUlEJfEh5cGVydmlzb3Ig
dGltZXIKPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IFNhZGx5LCBFeHlu
b3M1NDEwIFRSTSBzZWVtcyB0byBiZSB3cm9uZy4gQWxsIG90aGVyIEV4eW5vczUgVFJNcyAoNTI1
MCwKPiA1MjYwLCA1NDIwLCA1NDIyKSBkZWZpbmVzIDEzLDE0LDExLDEwIFBQSSBmb3IgYXJjaCB0
aW1lci4gSSd2ZSBjaGVja2VkCj4gb24gdGhlIHJlYWwgaGFyZHdhcmUgKEV4eW5vczU0MTAtYmFz
ZWQgT2Ryb2lkIFhVIGJvYXJkKSBhbmQgdGhlIHZhbHVlcwo+IHRha2VuIGZyb20gRXh5bm9zNTQy
MiBUUk0gd29ya3MgZmluZSwgd2hpbGUgdGhlIG9uZXMgZnJvbSA1NDEwIFRSTSBkb24ndC4KClRo
YW5rcyBmb3Igc2hhcmluZyB0aGUgdGVzdGVkIHJlc3VsdC4KClJldmVpd2VkLWJ5OiBDaGFud29v
IENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28g
Q2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
