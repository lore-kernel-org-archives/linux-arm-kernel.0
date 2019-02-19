Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7418BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B1F21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pi9/LSjN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cd1zI6r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B1F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CeXO6yVZ/38iSxB66kZLr8RSt5OZvJW+NUb1arhvVd0=; b=pi9/LSjNJhMCXn
	hMLAYcWJQfxeftsfGxJuUYwOhZ33zurhwDMCMT4zjW+F+5D084n2jtV0vv0ZSI5dLLVPdeNV+Yk69
	IxTW8I2Yp/XBv84ao6sbonZ1XKEKZ68I4VOjIQgX1zBSF99X7tKSB4HoCLVuF0NM9873MC3RzuRzO
	/pOZhUu+z9F3JamFSJji6XTGJmFX+j3ZUsLh4cYR3/7orvtiRYrg11p1xoiiOI/zVbwhWrXnBRAnu
	mDogynjO5ytasLNJa+41SiAulfwmj1G35+lJqmm3s57ApkvqMZLv9BCSWWu4uJc6QMxXLGMlYOs1G
	bsXC1/x/df23vuG40sRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvsvm-0002Qa-Md; Tue, 19 Feb 2019 00:06:38 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvsvi-0002Q6-Rf
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 00:06:36 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20190219000631epoutp015d2ae9cb940e375f6421b036ea5b88e7~Emy126WwR0446804468epoutp01e
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 00:06:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20190219000631epoutp015d2ae9cb940e375f6421b036ea5b88e7~Emy126WwR0446804468epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550534791;
 bh=exMVINYQL1yzReeiEsxXdOGi9jVTogha67qNwmZro/c=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Cd1zI6r7TlwouTlS3gBbp71T7JQ3tyPK4rWQ97+uwMRddJzMl3qJ6qHYgTMh27X2G
 A7i0d9imcyY9v+wdITNIo1gvQskM9rDmtdkvQCyWj1xKn+ynYdskc58PZnabBQUlDw
 PkDOxsKNUyxV+UjNUAFMQqKyCyHFmWqOSVCMCY10=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190219000627epcas1p2f00574e40894a4bd4e817e304d17df88~EmyycHNpb3005230052epcas1p2M;
 Tue, 19 Feb 2019 00:06:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 49.7F.04173.2884B6C5; Tue, 19 Feb 2019 09:06:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190219000626epcas1p1c35d1942be1a26d55fc8b53156a01f36~EmyxNYx0L2681726817epcas1p1F;
 Tue, 19 Feb 2019 00:06:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190219000626epsmtrp2ddf0fb146b8ee6661eeeb75c2cae742f~EmyxMXlQL1503315033epsmtrp2j;
 Tue, 19 Feb 2019 00:06:26 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-09-5c6b4882ba17
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 00.14.03971.2884B6C5; Tue, 19 Feb 2019 09:06:26 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190219000626epsmtip2d99b850975e635ad5cbf2da58eb27569~EmyxBs8_V3002530025epsmtip2m;
 Tue, 19 Feb 2019 00:06:26 +0000 (GMT)
Subject: Re: [PATCH 5/5] ARM: exynos: Enable support for ARM architected timers
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <724bfe6c-477d-63b2-cd79-15b2acd60811@samsung.com>
Date: Tue, 19 Feb 2019 09:06:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215125229.30180-6-m.szyprowski@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOjtXya1q+CqadCEoyPc7ZsdKCJEYZ2eVHxMgOenLmbuxs
 XelCdnGSVppU67YuWolmTTOz0ppSGaFFaSKJgnY1tBqZVFTbjpH/nvd5n4fnfb/vpQjlFTKM
 yjZaeYuR09PkOGlt06yY6L2aHG3s6bcR7I0TVTL2rCecbWu7LmddfR0y9kRbg4StbO6Ws9Wu
 EmKRXOMqt5Oa1x13Sc1ga6tcU31pt6awphxpPK6paeS6nAU6nsvkLZG8McOUmW3MSqKXrU5f
 nK5OiGWimUR2Lh1p5Ax8Ep2Smha9JFvvnYSO3MzpbV4qjRMEOiZ5gcVks/KROpNgTaJ5c6be
 nGieI3AGwWbMmpNhMsxjYmPj1F7hhhxdW0WZ1PxZvrVguBftQfVkPgqgAMdD89AdST4aRylx
 HYLKfQ9IsfiK4OpApUwshhG8Oj6C/llO5X8nxMY9BH/s+0dVQwh6fo9IfaogvBKeN+QRPhyM
 t0Ph/R9+B4FvInhX6JD7GiSOgsb3nf5JAvE0aB/p80ZQlAInw9GnU320FM+AG1+KZT48Ga+F
 poJB/xQKPAlaTvb7swK88rs9b/yYwCHQ1X9OIuIIyL15yp8L2EPCp/KG0a1T4MN5DyHiIPj4
 qEYu4jDwDN4b1eyAqy3NpGjOQ1DT+EwmNlTQWFos8Q1K4FlQVR8jhk2EwW+HZD4asALyDihF
 9XR40dstEXEoXDxoJ0WJBiqdsiNommPMNo4xGzjGbOD4n+VE0nI0hTcLhixeYMxxY3/bhfxX
 GpVQhy60proRphA9QeG8vEmrlHGbhW0GNwKKoIMVDzu9lCKT27adt5jSLTY9L7iR2vvYR4mw
 yRkm780bremMOk6lUrHxTIKaYegQRdWixVolzuKsfA7Pm3nLP5+ECgjbg0IOvtgIHc7meis9
 UFGkKpupdiftXNfacs42ED6kzfuh7W7fkvsztNijUtQ/W7iq81f+fNi4Ourk+uVrHq+w2VF7
 YDR9+3xXR3FRyMCtZOeHT7PJUPf4JyXxLytGOo/3Xys6Ux3c9P3w3tTEubnDy/um9NZusUtS
 bi/ddSxcF1SaUkhLBR3HRBEWgfsLmSZge7sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvG6TR3aMwdwuXouNM9azWsz7LGtx
 /vwGdotNj6+xWsw4v4/JYu2Ru+wWmzdNZXZg99i0qpPN4861PWwe786dY/fYvKTeo2/LKkaP
 z5vkAtiiuGxSUnMyy1KL9O0SuDLOr1nGUvCBvaL32wPGBsZdbF2MnBwSAiYSs7u+M3cxcnEI
 CexmlGg7+wkqISkx7eJRoAQHkC0scfhwMUTNW0aJ4weegtUICwRKXNzXwQxiiwhUAdVsZQMp
 YhbYzihxdUsvE0THUUaJnmvdLCBVbAJaEvtf3ADr5hdQlLj64zEjyAZeATuJiWfkQMIsAqoS
 Gz9OZgWxRQUiJD4+3ccEYvMKCEqcnPkEbAwnUPme+0/BbGYBdYk/8y4xQ9jiEreezGeCsOUl
 mrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
 cFRpae5gvLwk/hCjAAejEg/vguVZMUKsiWXFlbmHGCU4mJVEeI/dAArxpiRWVqUW5ccXleak
 Fh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAWO/Nc12W75qOpYKR8tEqi3ubth11
 cAhVqnlQcU4gkY1r0T/ln+5vWV+KmlfN54+dFxmz5y/z5//tLrNr9m5/JMVkr7tohi1XuazX
 8YNdk3e/TnPK+sn5sPzJtVt2aTsip2ufXcF4JOxA+5GOx3HGE8v6Ik0sbC+W/hc4LCwQ1xqm
 bnM/0O+ZEktxRqKhFnNRcSIAfzgnjqYCAAA=
X-CMS-MailID: 20190219000626epcas1p1c35d1942be1a26d55fc8b53156a01f36
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190215125240eucas1p219154e5bd27bd09dac0b8419c3e4e259
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125240eucas1p219154e5bd27bd09dac0b8419c3e4e259@eucas1p2.samsung.com>
 <20190215125229.30180-6-m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_160635_078954_70164446 
X-CRM114-Status: GOOD (  22.98  )
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
b3RlOgo+IEFSTSBhcmNoaXRlY3RlZCB0aW1lciBjYW4gYmUgdXNlZCB0b2dldGhlciB3aXRoIEV4
eW5vcyBNdWx0aUNvcmUgVGltZXIKPiBkcml2ZXIsIHNvIGVuYWJsZSBzdXBwb3J0IGZvciBpdC4g
U3VwcG9ydCBmb3IgQVJNIGFyY2hpdGVjdGVkIHRpbWVycyBpcwo+IGVzc2VudGlhbCBmb3IgZW5h
YmxpbmcgcHJvcGVyIEtWTSBzdXBwb3J0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFN6eXBy
b3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPiAtLS0KPiAgYXJjaC9hcm0vbWFjaC1l
eHlub3MvS2NvbmZpZyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAK
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1leHlub3MvS2NvbmZpZyBiL2FyY2gvYXJtL21h
Y2gtZXh5bm9zL0tjb25maWcKPiBpbmRleCBiNDA5NjNjZjkxYzcuLmI1ZWMyMWMwMjdhMSAxMDA2
NDQKPiAtLS0gYS9hcmNoL2FybS9tYWNoLWV4eW5vcy9LY29uZmlnCj4gKysrIGIvYXJjaC9hcm0v
bWFjaC1leHlub3MvS2NvbmZpZwo+IEBAIC0xOCw2ICsxOCw3IEBAIG1lbnVjb25maWcgQVJDSF9F
WFlOT1MKPiAgCXNlbGVjdCBFWFlOT1NfU1JPTQo+ICAJc2VsZWN0IEVYWU5PU19QTV9ET01BSU5T
IGlmIFBNX0dFTkVSSUNfRE9NQUlOUwo+ICAJc2VsZWN0IEdQSU9MSUIKPiArCXNlbGVjdCBIQVZF
X0FSTV9BUkNIX1RJTUVSCj4gIAlzZWxlY3QgSEFWRV9BUk1fU0NVIGlmIFNNUAo+ICAJc2VsZWN0
IEhBVkVfUzNDMjQxMF9JMkMgaWYgSTJDCj4gIAlzZWxlY3QgSEFWRV9TM0MyNDEwX1dBVENIRE9H
IGlmIFdBVENIRE9HCj4gCgpSZXZlaXdlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ft
c3VuZy5jb20+CgoKLS0gCkJlc3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ry
b25pY3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
