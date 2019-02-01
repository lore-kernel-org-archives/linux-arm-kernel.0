Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD1C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6766218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6hUUKaB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pm3/c6uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6766218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s5zeLUP2QU/SfCkeJnSBV3iwr+YOyc/Y2HAAj9qlbWk=; b=i6hUUKaBUyTUhO
	8zC5a6DAmMLbZIPVhHwsNHPNLfPnuV75iUktZNSM4xxXj21LM+/ls8NsCvQhjJXEllR3flfJfAUFN
	8A5VO95l6P2us4Fy2Y0e13j0WqzOIxfGQ633nPZ4IDsV1W5qOwj88+sQcOUTA2mHJIVTGLYCkqB5Z
	ca+/YgFfmuXWbcruMVOk2x6bwmK58hPn3ff0x66DjJteAI/YzzRdhi0ONOLVRV8TegxM9NSes9IA5
	xVUG5rl7rqcIx37HSuo/XhIoyEZsxpejv+NhkwZhWemmNMq8DFQpbWgRBIR51aq0GB/1ggKjIyOoR
	jtRguh7qvxp6T7EStW3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZIh-0003MM-9i; Fri, 01 Feb 2019 13:56:11 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZIc-0003Ka-EN
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:56:08 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201135604euoutp015cf81862d8c974628ac9957f2c8fec24~-Qf-m91sQ2962729627euoutp01S
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 13:56:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190201135604euoutp015cf81862d8c974628ac9957f2c8fec24~-Qf-m91sQ2962729627euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549029364;
 bh=vGCkjjc38KTLZR8V8dBDUGhzuNKTWM8Hge6EE2HJtZE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Pm3/c6uoGWjqCDj0NZk/gM2TCpcgdJYPyZFdtTA3mSNYcvtueIFDt9hPv7Hke1zE6
 /N11bfjoPZo9IGMtbt2JRey0LhgyRHfbO6UeW7L33pwl//jaQHPpnZkVr3Czsvti/z
 bwzw3XdV+wt3FIrqEB1xrMKgxjownemOwEqJX6Oc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190201135603eucas1p2dc15b83ad9e6dfec8771c12b8cd42954~-Qf-LH5fl1873418734eucas1p2q;
 Fri,  1 Feb 2019 13:56:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.E1.04441.3FF445C5; Fri,  1
 Feb 2019 13:56:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190201135602eucas1p2abc21cde057d4c0e1311a2b02b8e17f9~-Qf_KFds13009530095eucas1p2n;
 Fri,  1 Feb 2019 13:56:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190201135602eusmtrp2b5a46a7b3408ade4a4587f772229dd66~-Qf97FPFv2700327003eusmtrp2f;
 Fri,  1 Feb 2019 13:56:02 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-3d-5c544ff3a203
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.1F.04128.2FF445C5; Fri,  1
 Feb 2019 13:56:02 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190201135601eusmtip1590c3adcd8bc2bfc4ae3f1586e07ca55~-Qf9QTqaU2387923879eusmtip1e;
 Fri,  1 Feb 2019 13:56:01 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
Date: Fri, 1 Feb 2019 14:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3vvdl0tfm7mDmpGqz/KSBMiflD0wBWDosL8Q9SolZclbrN2
 1bSE7OmjVVL4aJZGRc5VqMvMSgumaBnLMl9lb5XKR5ozpHfd7iL/+853zne+88FhKWUbE8Am
 mJM5i1lv1EjldE3Tl9aFng1RcYuKX6hIVVEFQ7rG3zGktPEhQ070DlKktbVSRtwHhmTE2dvJ
 kE/Wlwx5cuuMlHiONSJS1HpHQq42vpCRxy2rSc9+u5Q0DGUx5GdnFb0S60a6D8t0TkeOVHft
 4j7d8WoH0nmcwRuZGPmyeM6YkMpZwpZvle+oy6d3eoLS+kdGqEw0qs5FPizgxXDPeY3ORXJW
 ie0IJorLvcU4glPv3zBi4UFw43ap7J+krf2gt1GGoKJuyCsZRtBSMkgLUyq8Cc42PZUKDT98
 AUF++TeJUFC4XgLnu60oF7GsFIdCrWOXIFDgNZB39yMlYBrPheE+299FM3A0NBz7iMQZX7h/
 uu8v74NXwI2cOomAKayGZ32lXjwLDl4vpsRTv8hg2J4oYi3kFFR6I6hgoLnai4Pg101RC5gH
 d7ZDKuIMyLpf651ZCg3NjxnhZArPh4pbYblI9odeBfUrBRLwdOge9hX9p8PJmkJKpBWQfUQp
 rpgH1dZHXht/KLtSIMtDGtukVLZJSWyTktj+u55DtAOpuRTeZOD4cDO3O5TXm/gUsyF0e5LJ
 if582oOfzWO16HPbNhfCLNJMU1R+jYxTMvpUPt3kQsBSGj+FXRsVp1TE69P3cJakLZYUI8e7
 UCBLa9SKvVNexyqxQZ/MJXLcTs7yrythfQIyUXRwQslUEtKY0R6bpsz0qX2+ILJ9aH0JZQ6M
 COlrfiSdOFzQ72razC156z/zcuHswY4uw7qbkQPZMTFRlrGw8JLn7u+BSQ0Z8drEYK38w9MP
 EZfWqjM7NliseYfyRmt+zHG/orQ9W631uqwBx4B+1lk1Z7w9xrmj8o9mR6gW6RI1NL9DHx5C
 WXj9bzCyDDNlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xu7qf/ENiDE70ilpsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4mPPPVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
 XDzlanG7cQWbxeE37awW/65tZHEQ8Hh/o5XdY9OqTjaPzUvqPfq2rGL0+LxJLoA1Ss+mKL+0
 JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jz1SWgs8yFU/f
 v2duYPwg3sXIySEhYCJx6UozaxcjF4eQwFJGiU0XzzFBJMQkJu3bzg5hC0v8udbFBlH0mlFi
 yY4JbCAJYYFgiS+t7xhBbBGBxYwSX1urQYqYBfYySUzoucwKkhASmMIk8etbTRcjBwebgJ7E
 jlWFIGFeATeJCfvfMYPYLAIqEm+fzGIBsUUFIiQ+Pt3HBFEjKHFy5hOwOKeAvcT2zj1gcWYB
 M4l5mx8yQ9jiEreezIeKy0s0b53NPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73i
 xNzi0rx0veT83E2MwEjeduznlh2MXe+CDzEKcDAq8fBu+BUUI8SaWFZcmXuIUYKDWUmEd4VL
 SIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wOTTF5JvKGpobmFpaG5sbmxmYWSOO95g8oo
 IYH0xJLU7NTUgtQimD4mDk6pBsbDWzgF5TwiV3h39mTr2X6dlHz5xWpN/Vency5v/uJ/1+hW
 DndHgtODSMPINSeb177dyx7hf6uyZ9f/NdP8VE5n6Z0IMHxcWJC6/9+UyA0KX9+/+Cxm2rVD
 bFfaSc8tskfWCN9jz9lq0vTYZdo25ZQFEtM5bmnu65RqOWo9RWJbifSFS+8jXjkosRRnJBpq
 MRcVJwIAvHZ2vfoCAAA=
X-CMS-MailID: 20190201135602eucas1p2abc21cde057d4c0e1311a2b02b8e17f9
X-Msg-Generator: CA
X-RootMTR: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_055606_776812_B4AF3F84 
X-CRM114-Status: GOOD (  21.50  )
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
Cc: b.zolnierkie@samsung.com, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, krzk@kernel.org,
 kyungmin.park@samsung.com, kgene@kernel.org, myungjoo.ham@samsung.com,
 s.nawrocki@samsung.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDIvMS8xOSA5OjQ0IEFNLCBDaGFud29vIENob2kgd3JvdGU6Cj4gSGks
Cj4gCj4gT24gMTkuIDEuIDMxLiDsmKTtm4QgNTo0OSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+IEFk
ZCBuZXcgdGFibGUgcmF0ZSBmb3IgQlBMTCBmb3IgRXh5bm9zNTQyMiBTb0Mgc3VwcG9ydGluZyBE
eW5hbWljIE1lbW9yeQo+PiBDb250cm9sbGVyIGZyZXF1ZW5jaWVzIGZvciBkcml2ZXIncyBEUkFN
IHRpbWluZ3MuCj4+Cj4+IENDOiBTeWx3ZXN0ZXIgTmF3cm9ja2kgPHMubmF3cm9ja2lAc2Ftc3Vu
Zy5jb20+Cj4+IENDOiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4gQ0M6
IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT4KPj4gQ0M6IFN0ZXBo
ZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4KPj4gQ0M6IEt1a2ppbiBLaW0gPGtnZW5lQGtlcm5l
bC5vcmc+Cj4+IENDOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4+IEND
OiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcKPj4gQ0M6IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmcKPj4gQ0M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+
PiBDQzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBMdWth
c3ogTHViYSA8bC5sdWJhQHBhcnRuZXIuc2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMv
Y2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYyB8IDE1ICsrKysrKysrKysrKysrLQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMgYi9kcml2ZXJzL2Ns
ay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMKPj4gaW5kZXggM2U4NzQyMS4uOGJmOTU3OSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstZXh5bm9zNTQyMC5jCj4+ICsrKyBi
L2RyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYwo+PiBAQCAtMTMyNSw2ICsxMzI1
LDE5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Ftc3VuZ19wbGxfcmF0ZV90YWJsZSBleHlub3M1
NDIwX3BsbDI1NTB4XzI0bWh6X3RibFtdIF9faW5pCj4+ICAgCVBMTF8zNVhYX1JBVEUoMjQgKiBN
SFosIDIwMDAwMDAwMCwgIDIwMCwgMywgMyksCj4+ICAgfTsKPj4gICAKPj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgc2Ftc3VuZ19wbGxfcmF0ZV90YWJsZSBleHlub3M1NDIyX2JwbGxfcmF0ZV90YWJs
ZVtdID0gewo+PiArCVBMTF8zNVhYX1JBVEUoMjQgKiBNSFosIDkzMzAwMDAwMCwgMzExLCA0LCAx
KSwKPj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA4MjUwMDAwMDAsIDI3NSwgNCwgMSksCj4+
ICsJUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNzI4MDAwMDAwLCAxODIsIDMsIDEpLAo+PiArCVBM
TF8zNVhYX1JBVEUoMjQgKiBNSFosIDYzMzAwMDAwMCwgMjExLCA0LCAxKSwKPj4gKwlQTExfMzVY
WF9SQVRFKDI0ICogTUhaLCA1NDMwMDAwMDAsIDE4MSwgMiwgMiksCj4+ICsJUExMXzM1WFhfUkFU
RSgyNCAqIE1IWiwgNDEzMDAwMDAwLCA0MTMsIDYsIDIpLAo+PiArCVBMTF8zNVhYX1JBVEUoMjQg
KiBNSFosIDI3NTAwMDAwMCwgMjc1LCAzLCAzKSwKPj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUha
LCAyMDYwMDAwMDAsIDIwNiwgMywgMyksCj4+ICsJUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMTY1
MDAwMDAwLCAxMTAsIDIsIDMpLAo+PiArCVBMTF8zNVhYX1JBVEUoMjQgKiBNSFosIDEzODAwMDAw
MCwgMTg0LCAyLCA0KSwKPiAKPiBFeGNlcHQgZm9yIDgyNU1oeiwgSSBjYW4ndCBmaW5kIHRoZSB0
YXJnZXQgZnJlcXVlbmN5Cj4gb24gRXh5bm9zNTQyMiBUUk0gZG9jdW1lbnQuIFVzdWFsbHksIEV4
eW5vcyBUUk0gc3BlY2lmaWVkCj4gdGhlIHN1cHBvcnRlZCBzdGFibGUgY2xvY2tzLiBJdCBtZWFu
cyB0aGF0IHVuZGVmaW5lZCBjbG9ja3MKPiBhcmUgbm90IHN0YWJsZSBhcyBJIGtuZXcuIFdoZXJl
IGRvIHlvdSBmaW5kIHRoZW0/Cj4gCj4gV2hlbiBJIGNhbGN1bGF0ZWQgdGhlIFBMTCBmcmVxdWVu
Y3kgd2l0aCBQTVMgdmFsdWUsIGl0IGlzIGNvcnJlY3QuCj4gQnV0LCBqdXN0IHdlIG5lZWQgdG8g
Y2hlY2sgdGhlIHJlZmVyZW5jZSBvZiB1bmRlZmluZWQgY2xvY2tzIG9uIFRSTQo+IGluIG9yZGVy
IHRvIGd1YXJhbnRlZSB0aGUgc3RhYmxlIG9wZXJhdGlvbi4KVGhleSB2YWx1ZXMgbGl2ZSBpbiB2
ZW5kb3IgY29kZSBmb3IgQW5kcm9pZC4KSSBoYXZlIHRlc3RlZCB0aGUgRE1DICYgRERSIHdpdGgg
dGhlc2UgcmF0aW9zIGluIHN0cmVzcyBzY2VuYXJpb3MKZm9yIGEgZmV3IGRheXMgYW5kIGl0IHdh
cyBzdGFibGUuCgo+IAo+IFJlbW92ZSA5MzMvMTM4TWh6IGJlY2F1c2UgZXh5bm9zNTQzMy1kbWMu
YyBkb2Vzbid0IHVzZSA5MzNNaHogYW5kIDEzOE1oego+IGFuZCBhbHNvIEV4eW5vczU0MjIgVFJN
IGRvZXNuJ3QgZGVmaW5lIDkzMy8xMzhNaHogb24gcGxsIHRhYmxlLgpPSywgSSB3aWxsIHJlbW92
ZSB0aGVtLgo+IAo+PiArfTsKPj4gKwo+PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Ftc3VuZ19w
bGxfcmF0ZV90YWJsZSBleHlub3M1NDIwX2VwbGxfMjRtaHpfdGJsW10gPSB7Cj4+ICAgCVBMTF8z
NlhYX1JBVEUoMjQgKiBNSFosIDYwMDAwMDAwMFUsIDEwMCwgMiwgMSwgMCksCj4+ICAgCVBMTF8z
NlhYX1JBVEUoMjQgKiBNSFosIDQwMDAwMDAwMFUsIDIwMCwgMywgMiwgMCksCj4+IEBAIC0xNDY3
LDcgKzE0ODAsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgZXh5bm9zNXhfY2xrX2luaXQoc3RydWN0
IGRldmljZV9ub2RlICpucCwKPj4gICAJCWV4eW5vczV4X3BsbHNbYXBsbF0ucmF0ZV90YWJsZSA9
IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+PiAgIAkJZXh5bm9zNXhfcGxsc1tlcGxs
XS5yYXRlX3RhYmxlID0gZXh5bm9zNTQyMF9lcGxsXzI0bWh6X3RibDsKPj4gICAJCWV4eW5vczV4
X3BsbHNba3BsbF0ucmF0ZV90YWJsZSA9IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+
PiAtCQlleHlub3M1eF9wbGxzW2JwbGxdLnJhdGVfdGFibGUgPSBleHlub3M1NDIwX3BsbDI1NTB4
XzI0bWh6X3RibDsKPj4gKwkJZXh5bm9zNXhfcGxsc1ticGxsXS5yYXRlX3RhYmxlID0gZXh5bm9z
NTQyMl9icGxsX3JhdGVfdGFibGU7Cj4gCj4gRXh5bm9zNTQyMiB1c2VkIHRoZSBzYW1lIFBMTCB0
YWJsZSBmb3IgYXBsbCwga3BsbCwgYnBsbCBhbmQgc28gb24uCj4gWW91IGRvbid0IG5lZWQgdG8g
bWFrZSB0aGUgc2VwYXJhdGUgcGxsIHRhYmxlLiBKdXN0IGFkZCBuZXcgZW50cmllcwo+IHRvIGV4
eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsIHRhYmxlLgpPSywgSSB3aWxsIGV4dGVuZCB0aGUg
ZXh5bm9zNTQyMF9wbGwyNTUweF8yNG1oel90YmwgdGFibGUuCgpJbiB2NCBwYXRjaCBzZXQsIGl0
IHdpbGwgYmUgZml4ZWQuCgpSZWdhcmRzLApMdWthc3oKPiAKPj4gICAJfQo+PiAgIAo+PiAgIAlz
YW1zdW5nX2Nsa19yZWdpc3Rlcl9wbGwoY3R4LCBleHlub3M1eF9wbGxzLCBBUlJBWV9TSVpFKGV4
eW5vczV4X3BsbHMpLAo+Pgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
