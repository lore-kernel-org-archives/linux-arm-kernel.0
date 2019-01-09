Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:59:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A099E20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8Z2+F6T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n6zazEX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A099E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z5t4Be89QsmN+x5nxDkrcKqec41ow1GcyqQlTRHtYA8=; b=R8Z2+F6TNCEskU
	9rtaJz9x4s8aiIkMHIk5+Ke8ecd4fjno60my8XHoXZIkhfnXuyfafJF2rPWXLg9B6PbJiGT2+YJ7r
	6cVhuxZDK9QHqaFsMi7NVEu5GsN0adXVyrzuox/W9RcnnvbBgfavwPZr4+lhoP5o8M9hmV3T/VBfR
	0U78UFyVwsA+/MphBRNDBE97WfAmKlnFqnSXgAH/ljBC/K37h5g+BY5J6gofImc76G/OVF0a0OF8R
	fzh/uIy5XOq8oFXjN+UW1sdh+fSscytQ7I2sdqcg4foflRNEvtggWOIS+uLmvSNSPTxMeSPxRpquA
	xcAscaIQXZUEutrxEMHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh521-0008Re-5w; Wed, 09 Jan 2019 03:59:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh51x-0008Qa-9e
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 03:59:51 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20190109035940epoutp0230cd31ef41dc6af8c101e6a8faed3450~4EhteLxT63184931849epoutp02M
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 03:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20190109035940epoutp0230cd31ef41dc6af8c101e6a8faed3450~4EhteLxT63184931849epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547006380;
 bh=fH4qPbBF/D4Bvj4VJqVJBz3eqrQqIqSpfuCCqP5OyBw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=n6zazEX8I3N7KGk2gXbM9WQRSIS9MmRGk+jLOuvZhEOhGG9VaTWDskoea2LCLpOiW
 1uFyCC9v4Ax5KQS5wU3tFQXnoSHFY9zEt5syUb0maL98svw5/V1b07pE5Djyul/JfI
 luxizkd8XqkgoNO48MafbeIoyUnx9fwfShrLgcG0=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190109035937epcas1p204d65e86278ec3c4c14efabb9d92ac09~4EhqQ4kem1045310453epcas1p2I;
 Wed,  9 Jan 2019 03:59:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 EF.F8.04064.9A1753C5; Wed,  9 Jan 2019 12:59:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20190109035936epcas1p41e5ddaa47193278c389298e902c82ced~4Ehpq3-KN2196321963epcas1p4F;
 Wed,  9 Jan 2019 03:59:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190109035936epsmtrp26f353b471251199a2a773a482ec2b9a6~4EhppOias2446024460epsmtrp2P;
 Wed,  9 Jan 2019 03:59:36 +0000 (GMT)
X-AuditID: b6c32a39-011ff70000000fe0-38-5c3571a9bb15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C5.79.03694.8A1753C5; Wed,  9 Jan 2019 12:59:36 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190109035936epsmtip2e51efced8b6701697c82f47114189b99~4EhpXEufQ2481324813epsmtip2L;
 Wed,  9 Jan 2019 03:59:36 +0000 (GMT)
Subject: Re: [PATCH 1/3] drm/exynos: rotator: Add support for s5pv210
To: =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
 krzk@kernel.org, airlied@linux.ie
From: Inki Dae <inki.dae@samsung.com>
Message-ID: <265fadf7-5e6f-6cba-85c8-9dcd3c85ae18@samsung.com>
Date: Wed, 9 Jan 2019 12:59:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219155704.15264-2-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLsWRmVeSWpSXmKPExsWy7bCmnu7KQtMYg443fBa9504yWcw/co7V
 4srX92wWL+5dZLHof/ya2eL8+Q3sFmeb3rBbbHp8jdXi8q45bBYzzu9jslh6/SKTxY/jfcwW
 rXuPsFvMmPySzYHPY828NYweO2fdZffYtKqTzWP7twesHve7jzN5bF5S79G3ZRWjx+dNcgEc
 UQ2MNolFyRmZZakKqXnJ+SmZeem2SqEhbroWSgoZ+cUltkrRhoZGeoYG5npGRkZ6xpaxVkam
 Sgp5ibmptkoVulC9SgpFyQVAtbmVxUADclL1oOJ6xal5KQ5Z+aUgz+oVJ+YWl+al6yXn5yop
 lCXmlAKNUNJP+MaY0fF7JlvBfcmK6cdPsjUwzhPtYuTkkBAwkWhqWMHUxcjFISSwg1FiwtPH
 LBDOJ0aJR5u/sEE43xglTs66yQrTcnbtCWaIxF5GiV/fjkJVvWeU2PT1GiNIlbCAq8St40/B
 bBGBdIkfP2+xgdjMAtuYJBbc4AWx2QRUJSauuA8U5+DgFbCTOPHeESTMIqAicfDIWbByUYEI
 iY77q8FsXgFBiZMzn7CA2JwCLhI3Z+1gghgpLnHryXwoW16ieetssOMkBDaxSzzZuokR4moX
 iXvLNrND2MISr45vgbKlJD6/28sGYZdLPHv3jAXkHgmBGolvcysgTGOJiytSQExmAU2J9bv0
 IYoFJU5f62aG2Mon8e5rDytENa9ER5sQRImSxLGLN6D2S0hcWDIRao+HxJf9axknMCrOQvLX
 LCS/zELyyyyExQsYWVYxiqUWFOempxYbFpgix/YmRnA617LcwXjsnM8hRgEORiUeXov1JjFC
 rIllxZW5hxglOJiVRHjV7wCFeFMSK6tSi/Lji0pzUosPMSYDg30is5Rocj4w1+SVxBuaGhkb
 G1uYGJqZGhoiCZsYGxgYAROquaW5MQ5hJXHeJ1Jzo4UE0hNLUrNTUwtSi2C2MHFwSjUwnlIs
 id929GfCq5NpqwSlfDzf/3h25nhT/TaeC84ZhW5T0i6sll3GsTdVQGwf44EEQ0Yex69iZ+Pb
 z+x5Fb3WaOop/+pv90uKzNf0hz6c/f7XxI3/NwQ+tdSPevz/22Zd0ZZw+fqfbhUXFQTbl3P7
 HWpjuvkmLTO3fMO+u77uLy4azI+3DjneqcRSnJFoqMVcVJwIABDMwy8rBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvO6KQtMYg8s/FCx6z51ksph/5Byr
 xZWv79ksXty7yGLR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2CxmnN/HZLH0+kUmix/H+5gt
 WvceYbeYMfklmwOfx5p5axg9ds66y+6xaVUnm8f2bw9YPe53H2fy2Lyk3qNvyypGj8+b5AI4
 orhsUlJzMstSi/TtErgyOn7PZCu4L1kx/fhJtgbGeaJdjJwcEgImEmfXnmDuYuTiEBLYzSgx
 Y/NJli5GDqCEhMSWrRwQprDE4cPFECVvGSW2LtjODtIrLOAqcev4U0YQW0QgXeJL0zcmkCJm
 gW1MEj0zDjBCdFxklJj67TYTSBWbgKrExBX32UCm8grYSZx47wgSZhFQkTh45CwbiC0qECFx
 9uU6sKG8AoISJ2c+YQGxOQVcJG7O2gE2hllAXeLPvEvMELa4xK0n86Hi8hLNW2czT2AUmoWk
 fRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4LrW0djCeOBF/
 iFGAg1GJh9divUmMEGtiWXFl7iFGCQ5mJRFe9TtAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy
 +ccihQTSE0tSs1NTC1KLYLJMHJxSDYxsJo8l0zY93nAx7z93Qvo7T+v7bgbHlx55dsHlhZvB
 w0sPjqrZmLxpeTl91o3Ly/vWeuu9d41KUfxz++rK6VwBziWzar65Fxo9ktGIXntjdup61vgl
 +fmTdldFv+yOPzHbW9RrQ5vgq4dpJnwfSi7VSXDd05l9wFRBRtdGY2PEMpNCZeGt8TOUWIoz
 Eg21mIuKEwGATJKtxwIAAA==
X-CMS-MailID: 20190109035936epcas1p41e5ddaa47193278c389298e902c82ced
X-Msg-Generator: CA
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181219160447epcas3p4b25fc066564986e75f170e1816c7a48a
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
 <CGME20181219160447epcas3p4b25fc066564986e75f170e1816c7a48a@epcas3p4.samsung.com>
 <20181219155704.15264-2-pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_195949_660893_1EDEFFAC 
X-CRM114-Status: GOOD (  19.97  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org, kyungmin.park@samsung.com,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgoxOC4gMTIuIDIwLiDsmKTsoIQgMTI6NTfsl5AgUGF3ZcWCIENobWllbCDsnbQo6rCAKSDsk7Qg
6riAOgo+IFRoaXMgY29tbWl0IGFkZHMgc3VwcG9ydCBmb3IgczVwdjIxMC4KPiBDdXJyZW50bHkg
b25seSBOVjEyIGFuZCBYUkdCODg4OCBmb3JtYXRzIGFyZSBzdXBwb3J0ZWQuCj4gSXQgd2FzIHRl
c3RlZCBieSB1c2luZyB0b29sIGZyb20KPiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9s
aW51eC1zYW1zdW5nLXNvYy9tc2c2MDQ5OC5odG1sCj4gCj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWC
IENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgpBcHBsaWVkLgoKVGhhbmtz
LApJbmtpIERhZQoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX3Jv
dGF0b3IuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4
eW5vc19kcm1fcm90YXRvci5jIGIvZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX3Jv
dGF0b3IuYwo+IGluZGV4IGE4MjBhNjg0MjliOS4uYTgyMmQzNDBjY2Y2IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9yb3RhdG9yLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fcm90YXRvci5jCj4gQEAgLTM1Nyw2ICszNTcs
MTEgQEAgc3RhdGljIGludCByb3RhdG9yX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRl
dikKPiAgfQo+ICAjZW5kaWYKPiAgCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2V4eW5vc19p
cHBfbGltaXQgcm90YXRvcl9zNXB2MjEwX3JiZzg4OF9saW1pdHNbXSA9IHsKPiArCXsgSVBQX1NJ
WkVfTElNSVQoQlVGRkVSLCAuaCA9IHsgOCwgU1pfMTZLIH0sIC52ID0geyA4LCBTWl8xNksgfSkg
fSwKPiArCXsgSVBQX1NJWkVfTElNSVQoQVJFQSwgLmguYWxpZ24gPSAyLCAudi5hbGlnbiA9IDIp
IH0sCj4gK307Cj4gKwo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9leHlub3NfaXBwX2xpbWl0
IHJvdGF0b3JfNDIxMF9yYmc4ODhfbGltaXRzW10gPSB7Cj4gIAl7IElQUF9TSVpFX0xJTUlUKEJV
RkZFUiwgLmggPSB7IDgsIFNaXzE2SyB9LCAudiA9IHsgOCwgU1pfMTZLIH0pIH0sCj4gIAl7IElQ
UF9TSVpFX0xJTUlUKEFSRUEsIC5oLmFsaWduID0gNCwgLnYuYWxpZ24gPSA0KSB9LAo+IEBAIC0z
NzIsNiArMzc3LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2V4eW5vc19pcHBfbGltaXQg
cm90YXRvcl81MjUwX3JiZzg4OF9saW1pdHNbXSA9IHsKPiAgCXsgSVBQX1NJWkVfTElNSVQoQVJF
QSwgLmguYWxpZ24gPSAyLCAudi5hbGlnbiA9IDIpIH0sCj4gIH07Cj4gIAo+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGRybV9leHlub3NfaXBwX2xpbWl0IHJvdGF0b3JfczVwdjIxMF95dXZfbGltaXRz
W10gPSB7Cj4gKwl7IElQUF9TSVpFX0xJTUlUKEJVRkZFUiwgLmggPSB7IDMyLCBTWl82NEsgfSwg
LnYgPSB7IDMyLCBTWl82NEsgfSkgfSwKPiArCXsgSVBQX1NJWkVfTElNSVQoQVJFQSwgLmguYWxp
Z24gPSA4LCAudi5hbGlnbiA9IDgpIH0sCj4gK307Cj4gKwo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IGRybV9leHlub3NfaXBwX2xpbWl0IHJvdGF0b3JfNDIxMF95dXZfbGltaXRzW10gPSB7Cj4gIAl7
IElQUF9TSVpFX0xJTUlUKEJVRkZFUiwgLmggPSB7IDMyLCBTWl82NEsgfSwgLnYgPSB7IDMyLCBT
Wl82NEsgfSkgfSwKPiAgCXsgSVBQX1NJWkVfTElNSVQoQVJFQSwgLmguYWxpZ24gPSA4LCAudi5h
bGlnbiA9IDgpIH0sCj4gQEAgLTM4Miw2ICszOTIsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
cm1fZXh5bm9zX2lwcF9saW1pdCByb3RhdG9yXzQ0MTJfeXV2X2xpbWl0c1tdID0gewo+ICAJeyBJ
UFBfU0laRV9MSU1JVChBUkVBLCAuaC5hbGlnbiA9IDgsIC52LmFsaWduID0gOCkgfSwKPiAgfTsK
PiAgCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZXh5bm9zX2RybV9pcHBfZm9ybWF0cyByb3RhdG9y
X3M1cHYyMTBfZm9ybWF0c1tdID0gewo+ICsJeyBJUFBfU1JDRFNUX0ZPUk1BVChYUkdCODg4OCwg
cm90YXRvcl9zNXB2MjEwX3JiZzg4OF9saW1pdHMpIH0sCj4gKwl7IElQUF9TUkNEU1RfRk9STUFU
KE5WMTIsIHJvdGF0b3JfczVwdjIxMF95dXZfbGltaXRzKSB9LAo+ICt9Owo+ICsKPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBleHlub3NfZHJtX2lwcF9mb3JtYXRzIHJvdGF0b3JfNDIxMF9mb3JtYXRz
W10gPSB7Cj4gIAl7IElQUF9TUkNEU1RfRk9STUFUKFhSR0I4ODg4LCByb3RhdG9yXzQyMTBfcmJn
ODg4X2xpbWl0cykgfSwKPiAgCXsgSVBQX1NSQ0RTVF9GT1JNQVQoTlYxMiwgcm90YXRvcl80MjEw
X3l1dl9saW1pdHMpIH0sCj4gQEAgLTM5Nyw2ICs0MTIsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBleHlub3NfZHJtX2lwcF9mb3JtYXRzIHJvdGF0b3JfNTI1MF9mb3JtYXRzW10gPSB7Cj4gIAl7
IElQUF9TUkNEU1RfRk9STUFUKE5WMTIsIHJvdGF0b3JfNDQxMl95dXZfbGltaXRzKSB9LAo+ICB9
Owo+ICAKPiArc3RhdGljIGNvbnN0IHN0cnVjdCByb3RfdmFyaWFudCByb3RhdG9yX3M1cHYyMTBf
ZGF0YSA9IHsKPiArCS5mb3JtYXRzID0gcm90YXRvcl9zNXB2MjEwX2Zvcm1hdHMsCj4gKwkubnVt
X2Zvcm1hdHMgPSBBUlJBWV9TSVpFKHJvdGF0b3JfczVwdjIxMF9mb3JtYXRzKSwKPiArfTsKPiAr
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgcm90X3ZhcmlhbnQgcm90YXRvcl80MjEwX2RhdGEgPSB7
Cj4gIAkuZm9ybWF0cyA9IHJvdGF0b3JfNDIxMF9mb3JtYXRzLAo+ICAJLm51bV9mb3JtYXRzID0g
QVJSQVlfU0laRShyb3RhdG9yXzQyMTBfZm9ybWF0cyksCj4gQEAgLTQxNCw2ICs0MzQsOSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHJvdF92YXJpYW50IHJvdGF0b3JfNTI1MF9kYXRhID0gewo+ICAK
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZXh5bm9zX3JvdGF0b3JfbWF0Y2hb
XSA9IHsKPiAgCXsKPiArCQkuY29tcGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtcm90YXRvciIs
Cj4gKwkJLmRhdGEgPSAmcm90YXRvcl9zNXB2MjEwX2RhdGEsCj4gKwl9LCB7Cj4gIAkJLmNvbXBh
dGlibGUgPSAic2Ftc3VuZyxleHlub3M0MjEwLXJvdGF0b3IiLAo+ICAJCS5kYXRhID0gJnJvdGF0
b3JfNDIxMF9kYXRhLAo+ICAJfSwgewo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
