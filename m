Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B71FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:32:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA5D20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qJ9OJvsW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XcGOfzkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA5D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJtBaMROWjSEsStOo9HDW2br3A6XK8Tr+zve4bV1dHs=; b=qJ9OJvsWQLaWpp
	ibOpsC9kC4/SUDfSfL9VI1Rc0wUhjd9cVjAW3WcdXzlavFtUf5Yfa3JT2l3OpyTt5KYWlKZ9IJqlO
	BnVX0W6Ho8EqcOqmOmCHdON9P0JSB7lJp1beuypvYrMxH3onHOgT8VwJP0xqf3fQpEDseQQzWJpSL
	NCW1VgGSjwCZUGv4Mxox0623rtL9wPaar+5nAMKnHkT+ZWWjjm2Nsl3oUszwLyp/qaOL5t+maI4EC
	+sLelgrMjXJLvtKxOHMvE7NSq1lH0aWb2DYFFercCibHZJ9sBFquEPXCehekJ9u+Cpvw1Yal/jwC9
	HQjIqD/w94A9OoJRhlHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk428-0001am-4s; Thu, 17 Jan 2019 09:32:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk423-0001a1-Qs
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:32:18 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190117093211epoutp03ff56f9eabc651fb0623451dc97206626~6mOT2oiam1816518165epoutp03M
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 09:32:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190117093211epoutp03ff56f9eabc651fb0623451dc97206626~6mOT2oiam1816518165epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547717531;
 bh=fA3LmYG+MDE8TCnlq/z+qYQ9ll7Qp0SFsr6Ft8sFcFg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=XcGOfzkdh5dE/Jx5Kh/CtkLM2lfLzwy/LoUwMGusoEBZUOzc8jKt+QdWlvsw6zsR0
 ITez2HtOawnpVIKarORvp8s6r/TTS4O06oF1k4gFg+cVj55GIkSw5MKDFeIBIUnl3Y
 K32YQlWHh4u7hU2oKPmRvyMbaEneBDLKQ8UosLiY=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190117093208epcas1p11df0bfa3593521b54920ef4432df8eb8~6mORibQm30091700917epcas1p1R;
 Thu, 17 Jan 2019 09:32:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 64.8D.04057.89B404C5; Thu, 17 Jan 2019 18:32:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190117093207epcas1p299ca1fc3771a377401abdc15c743360a~6mOQYAJJk3230632306epcas1p2_;
 Thu, 17 Jan 2019 09:32:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190117093207epsmtrp2ff742e914b4f79747c2dc1c9eefeed8a~6mOQTf-fA0180801808epsmtrp2X;
 Thu, 17 Jan 2019 09:32:07 +0000 (GMT)
X-AuditID: b6c32a36-d31ff70000000fd9-28-5c404b98e003
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 71.BD.03694.79B404C5; Thu, 17 Jan 2019 18:32:07 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190117093207epsmtip1f45b8d9f4dec70ea3daf7a4b2ea35baa~6mOQGppQu1010710107epsmtip1i;
 Thu, 17 Jan 2019 09:32:07 +0000 (GMT)
Subject: Re: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
To: Christoph Manszewski <c.manszewski@samsung.com>,
 dri-devel@lists.freedesktop.org
From: Inki Dae <inki.dae@samsung.com>
Message-ID: <f51289f2-e94f-40f4-2a61-054d87914030@samsung.com>
Date: Thu, 17 Jan 2019 18:32:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmnu4Mb4cYg8/N8ha31p1jteg9d5LJ
 YuOM9awWx3cvZbS48vU9m8WLexdZLPofv2a2OH9+A7vF2aY37BabHl9jtbi8aw6bxYzz+5gs
 1h65y26x8ONWFosHL/czWtydfITRYsbkl2wOgh7z1lR7bFrVyeax/dsDVo95JwM97ncfZ/LY
 vKTe4/iuW+wefVtWMXp83iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGu
 pJCXmJtqq+TiE6DrlpkD9ImSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84
 Mbe4NC9dLzk/18rQwMDIFKgwITuj+fRi5oITnBWb7/xka2D8y97FyMkhIWAisf3/RZYuRi4O
 IYEdjBKzd5xmh3A+MUqsPrWTCcL5xijxdfZCRpiWpz+OQbXsZZQ4feARK0hCSOA9UP82fxBb
 WMBRoufGX6AGDg4RgTCJHW8CQeqZBZ6xSHx5NANsEJuAqsTEFffZQGxeATuJM8cvgdksQPG3
 P9vA7hMViJDouL8aqkZQ4uTMJywgNqeAh8TxzeeYQGxmAXGJW0/mQ9nyEs1bZzODLJMQOMUu
 sXhiLxPE1S4Sb17OYIWwhSVeHd8CDQApic/v9rJB2OUSz949YwE5WkKgRuLb3AoI01ji4ooU
 EJNZQFNi/S59iE18Eu++9rBCVPBKdLQJQcxQkjh28QY0pCQkLiyZCDXbQ+Lk/n/QULvJKLH3
 eDPrBEaFWUgem4XkmVlInpmFsHkBI8sqRrHUguLc9NRiwwIj5LjexAhO41pmOxgXnfM5xCjA
 wajEw2tgYh8jxJpYVlyZe4hRgoNZSYS30NkhRog3JbGyKrUoP76oNCe1+BCjKTDcJzJLiSbn
 A3NMXkm8oamRsbGxhYmhmamhoZI47xOpudFCAumJJanZqakFqUUwfUwcnFINjEvXsm+Y77I7
 02f5IQnOKNOn3S9ePN7d2aw55Uknz8/3DIs8n+c6fs4L+3dqjgN7kejb1ik/uyd4hcxu2vj5
 YI38JnuJD8WK0q0BOzecjprwPv4062aBklrbpwXxLxaqVIbxyPrah15U19uc78/OXraEZUJB
 0hsm/R/TGR94mSQce2jjv0Q/WYmlOCPRUIu5qDgRAHy5ld/5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSnO50b4cYgyvX+S1urTvHatF77iST
 xcYZ61ktju9eymhx5et7NosX9y6yWPQ/fs1scf78BnaLs01v2C02Pb7GanF51xw2ixnn9zFZ
 rD1yl91i4cetLBYPXu5ntLg7+QijxYzJL9kcBD3mran22LSqk81j+7cHrB7zTgZ63O8+zuSx
 eUm9x/Fdt9g9+rasYvT4vEkugDOKyyYlNSezLLVI3y6BK6P59GLmghOcFZvv/GRrYPzL3sXI
 ySEhYCLx9Mcxli5GLg4hgd2MEmv7vjF1MXIAJSQktmzlgDCFJQ4fLgYpFxJ4yyhxY14BiC0s
 4CjRc+MvI0iJiECYxLStliBTmAVesEjcP3WUCWLkTUaJfXeWMIM0sAmoSkxccZ8NxOYVsJM4
 c/wSmM0CFH/7sw3sHlGBCImzL9cxQtQISpyc+YQFxOYU8JA4vvkcE4jNLKAu8WfeJWYIW1zi
 1pP5UHF5ieats5knMArNQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqX
 rpecn7uJERy5Wlo7GE+ciD/EKMDBqMTD22FmHyPEmlhWXJl7iFGCg1lJhLfQ2SFGiDclsbIq
 tSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA+NMj1sZ1/rs9vO/P136
 3Gz5UXPecHPD39JNS/w/pss3a008vmP6EcFzvoVXbLryXJvX9b6u+yE1rd87xsHK45/AjsI5
 9UWLVxySPK2dLtAe/ya/3CtxidGjTZyF/3NzzWpu3lLcqOi85iOvrt7WKZ7bNFfeXXVn11c7
 FZa1fD4ivrvn8Fw8WqbEUpyRaKjFXFScCABSUZax2AIAAA==
X-CMS-MailID: 20190117093207epcas1p299ca1fc3771a377401abdc15c743360a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
 <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_013216_384172_BF2CB517 
X-CRM114-Status: GOOD (  18.76  )
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
Cc: linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgoxOC4gMTIuIDE0LiDsmKTtm4QgOToxMOyXkCBDaHJpc3RvcGggTWFuc3pld3NraSDsnbQo
6rCAKSDsk7Qg6riAOgo+IFJhbmdlIHNldHRpbmcgbWFrZXMgc2Vuc2UgZm9yIFlDYkNyIGFuZCBS
R0IgYnVmZmVycy4gQ3VycmVudAo+IGRybV9jb2xvcl9yYW5nZSBlbnVtIGxhYmVscyBzdWdnZXN0
IHVzZSB3aXRoIFlDYkNyIGJ1ZmZlcnMuCj4gQ3JlYXRlIGVudW0gbGFiZWxzIHdpdGhvdXQgY29s
b3JzcGFjZSBzcGVjaWZpY2F0aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBNYW5z
emV3c2tpIDxjLm1hbnN6ZXdza2lAc2Ftc3VuZy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvZHJtL2Ry
bV9jb2xvcl9tZ210LmggfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
PiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2NvbG9yX21nbXQuaCBiL2luY2x1ZGUv
ZHJtL2RybV9jb2xvcl9tZ210LmgKPiBpbmRleCA5MGVmOTk5NmQ5YTQuLjUyZjZkNTIyMWEwZCAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5oCj4gKysrIGIvaW5jbHVk
ZS9kcm0vZHJtX2NvbG9yX21nbXQuaAo+IEBAIC02Miw2ICs2Miw4IEBAIGVudW0gZHJtX2NvbG9y
X3JhbmdlIHsKPiAgCURSTV9DT0xPUl9ZQ0JDUl9MSU1JVEVEX1JBTkdFLAo+ICAJRFJNX0NPTE9S
X1lDQkNSX0ZVTExfUkFOR0UsCj4gIAlEUk1fQ09MT1JfUkFOR0VfTUFYLAo+ICsJRFJNX0NPTE9S
X0xJTUlURURfUkFOR0UgPSBEUk1fQ09MT1JfWUNCQ1JfTElNSVRFRF9SQU5HRSwKPiArCURSTV9D
T0xPUl9GVUxMX1JBTkdFID0gRFJNX0NPTE9SX1lDQkNSX0ZVTExfUkFOR0UsCgpJIGRvbid0IHNl
ZSB3aHkgYWJvdmUgdHdvIHR5cGVzIGFyZSBuZWVkZWQuIElzIHRoZXJlIGFueSBjYXNlIHRoYXQg
dGhlIHJhbmdlIGNoZWNraW5nIGJlaGF2aW9yIHNob3VsZCBiZSBkaWZmZXJlbnQgYWNjb3JkaW5n
IHRvIHRoZSBjb2xvciBzcGFjZT8KQW5kIGV2ZW4gaWYgdGhlcmUgaXMgdGhhdCBjYXNlLCBJIHRo
aW5rIHlvdSBoYXZlIHRvIHB1dCBEUk1fQ09MT1JfUkFOR19NQVggdW5kZXIgRFJNX0NPTE9SX0ZV
TExfUkFOR0UuCgpUaGFua3MsCklua2kgRGFlCgo+ICB9Owo+ICAKPiAgaW50IGRybV9wbGFuZV9j
cmVhdGVfY29sb3JfcHJvcGVydGllcyhzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwKPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
