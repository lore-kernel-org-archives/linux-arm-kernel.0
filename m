Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECE820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FIMfWXn8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p/btbM9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECE820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WuN7z32jNvZPEm2ucrSMJX+WEdCs+OtGYxdfgWyDWFY=; b=FIMfWXn8aNo+a/
	eDXizA43OQZBdFO49RX9X16xNdp2btUtSNO01GiXPMit/6aWYqtySruI8+75hm4e1AOtBMA67Q7B3
	sbGOUPKyHqhE5PzySELm5eFyS0PtjZSArsg6sCbC9RMx2y89ibQm16t1WYitfu+5COuqLv/LqQR2/
	d5JPqe8oUpMV5NF3FmXrOxUhhNfx5dPUUAWTnOmoMDnODNrM7xuRR9wGOcXSlLbDkxsJoUv3QJe+s
	gzeC4sdzBM/tRb/EPW+9R1pBvP1Kl0QD/z+tXpREIUqqKuA2DZ5f6DE/qVFz7qf9LOSF8Q7BsF3AC
	iLnVU51ddwtYNvyWD9mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8iP-0000bT-GH; Mon, 11 Feb 2019 10:21:29 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8iL-0000aW-KE
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:21:28 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190211102120euoutp01be149fead2ca7032c5f9ba1277cd6dc9~CSBXjbdNs2870428704euoutp019
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:21:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190211102120euoutp01be149fead2ca7032c5f9ba1277cd6dc9~CSBXjbdNs2870428704euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549880480;
 bh=K2FIyDmnWvCgj41oCrevnXqZlOJCrg0iCZ9pY71VDXA=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=p/btbM9jv36Fa+R+PQJYYwCJXQ7iOR7KCeD16gu5WCMaDoJppDy84Yh0fgmYPOmKd
 qoDiYriQHBahMCasKKIlKtYqWgFXAsrdQEci9oUCZENo3Asg4EPKx4SYCokHPeLf3Y
 JYi1nTbkE2ITVKafk1EbyqY98prZ2sjuxsaAtaFc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190211102119eucas1p23f2c92e207e580bf5e9f3534aed79a94~CSBWa0eCg1662316623eucas1p2q;
 Mon, 11 Feb 2019 10:21:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.2A.04441.F9C416C5; Mon, 11
 Feb 2019 10:21:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190211102118eucas1p10b2314a2e0cd705d33b4c38fb0689e0f~CSBVcw-NF0736807368eucas1p1D;
 Mon, 11 Feb 2019 10:21:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190211102118eusmtrp2e3f9fc078c216c81a0d09f338d4b3a54~CSBVauSFO2373523735eusmtrp2x;
 Mon, 11 Feb 2019 10:21:18 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-d0-5c614c9f44c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.9B.04284.E9C416C5; Mon, 11
 Feb 2019 10:21:18 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190211102117eusmtip11f839c551290c2939e80d5ff8e800197~CSBUvhTfM0168301683eusmtip1f;
 Mon, 11 Feb 2019 10:21:17 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To: cwchoi00@gmail.com
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Date: Mon, 11 Feb 2019 11:21:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURj1zps377mMXEfNj0lKBm0lNwJvC1KhMUVE0Y+ihHrlcynHbJ5a
 lpAmpZktirhMhoaVNhXlaKWDmrkNWm6Vtm80FJpj5kKWoTk+Jf+de8757vkOfCyleEMr2cjo
 WF4bzUWpZHbSB82/O1YUbuFCfLuNDCnLu0uTlyPfaPK1aTkpbGynycUv3ynS0XGPIW2n+hli
 +NJDk58ZH2jy3FggI8PnGxHJ66iVkDuN7xnS1RpM3iaXykhDfypNJnrKpOuc1D9enWbUVbr3
 jNqgPytTl187qb5QoUfqYcOCbbLddmtD+ajIeF7rE7jPLqK33z9mXHWsu9giSUIG93RkywJe
 Cf352VQ6smMVuBTB+FgNsgoKPIKgp9VTFIYR3M+7xcxO6C0PaVEoQZBRfEMiPiwI3hWfo6wu
 Z7wDrjS/llmxC54HD3PMyGqi8CMajL19U+MsK8PeUKk/YvXI8UbILKyYTpBiL8gtvimxYle8
 CxrODyDR4wQt+WapFdvi7VBnLp3mKewGb8yFEhEvhJT7l6f7AE5mIbusfmbtIDAm3ZKK2Bn6
 TBUzvDtMVonDgAVoS9PLRJwIqS2VM5410GDqmt6ZwkvhrtEnHTFT9HqoWWclATvCK4uTuIAj
 ZD3IpURaDmlnFOIXS6Aio3MmZh6U3M5hLiGVbk4t3ZwqujlVdP9Ti5BUj9z4OEETzgt+0fxR
 b4HTCHHR4d4HDmsMaOrinkyYhirR6LP99QizSOUgH+T2hShoLl5I0NQjYCmVi3z/Ji5EIQ/l
 Eo7z2sN7tXFRvFCP5rNSlZv8hM2nPQoczsXyh3g+htfOqhLWVpmEXBZX2zsN3PgccPXM2Iux
 gA2JHuWqZ6vKOX/LhdrXi1IXf0xWHlBybb6bbbwO5po1muT8waUlXp8dOhsG0of9jio8U+qq
 R9P0QmNAe7Bbnun6n1QPX4/HLdtdBv56B6Ktul/2YZlDpCri+dOCpsoiiJ90NQ29Wx2kHKva
 meXYlB+mkgoRnN8ySitw/wBcWbGwbQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7rzfBJjDG6uF7TYOGM9q8X1L89Z
 LZ4d1baYf+Qcq0X/49fMFufPb2C3ONv0ht1i0+NrrBYfe+6xWlzeNYfN4nPvEUaLGef3MVms
 PXKX3eLiKVeL240r2CwOv2lntfh3bSOLg6DH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5v
 kgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL
 ePnGqOC3UsXVxW+ZGhg3yXQxcnJICJhIrHq7nbWLkYtDSGApo8SbDd3sEAkxiUn7tkPZwhJ/
 rnWxQRS9ZpS4frSFGSQhLBAs8aX1HSOILQLUsH3aE0aQImaBo6wS1zpvQY2dwSwx+/hCIIeD
 g01AT2LHqkKQBl4BN4mJ87eAbWARUJWYvnglE4gtKhAh8fHpPiaIGkGJkzOfsIDYnAKBEgee
 rABbxixgJjFv80NmCFtc4taT+UwQtrxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3O
 Tc8tNtQrTswtLs1L10vOz93ECIzubcd+bt7BeGlj8CFGAQ5GJR7eD4kJMUKsiWXFlbmHGCU4
 mJVEeJM8E2OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YePJK4g1NDc0tLA3Njc2NzSyU
 xHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBO21+yLGnPPpYDM35mKd8VP84lnnv54o9d9xcw
 5n14nckj3Boidm/T5htRU+Wt25untLcc/nw0Szvr14asJz9EP96fP1EmzqHszW9v3yQbT7+t
 Ej9u9O2clzPr+Mw/Z98xlN9oYNcwMPHvj8786fbR+NWmt2eYdaraTP+snTdfPHCGOe+y85vW
 KrEUZyQaajEXFScCAMIXbYoEAwAA
X-CMS-MailID: 20190211102118eucas1p10b2314a2e0cd705d33b4c38fb0689e0f
X-Msg-Generator: CA
X-RootMTR: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
 <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
 <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_022125_801037_483B1DF6 
X-CRM114-Status: GOOD (  22.69  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDIvMy8xOSA4OjU0IEFNLCBDaGFud29vIENob2kgd3JvdGU6Cj4gSGkg
THVrYXN6LAo+IAo+IDIwMTnrhYQgMuyblCAx7J28ICjquIgpIOyYpO2bhCAxMToyMiwgTHVrYXN6
IEx1YmEgPGwubHViYUBwYXJ0bmVyLnNhbXN1bmcuY29tPuuLmOydtCDsnpHshLE6Cj4gCj4+Cj4+
IEhpIENoYW53b28sCj4+Cj4+IE9uIDIvMS8xOSA5OjQ0IEFNLCBDaGFud29vIENob2kgd3JvdGU6
Cj4+PiBIaSwKPj4+Cj4+PiBPbiAxOS4gMS4gMzEuIOyYpO2bhCA1OjQ5LCBMdWthc3ogTHViYSB3
cm90ZToKPj4+PiBBZGQgbmV3IHRhYmxlIHJhdGUgZm9yIEJQTEwgZm9yIEV4eW5vczU0MjIgU29D
IHN1cHBvcnRpbmcgRHluYW1pYyBNZW1vcnkKPj4+PiBDb250cm9sbGVyIGZyZXF1ZW5jaWVzIGZv
ciBkcml2ZXIncyBEUkFNIHRpbWluZ3MuCj4+Pj4KPj4+PiBDQzogU3lsd2VzdGVyIE5hd3JvY2tp
IDxzLm5hd3JvY2tpQHNhbXN1bmcuY29tPgo+Pj4+IENDOiBDaGFud29vIENob2kgPGN3MDAuY2hv
aUBzYW1zdW5nLmNvbT4KPj4+PiBDQzogTWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5
bGlicmUuY29tPgo+Pj4+IENDOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+Cj4+Pj4g
Q0M6IEt1a2ppbiBLaW0gPGtnZW5lQGtlcm5lbC5vcmc+Cj4+Pj4gQ0M6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemtAa2VybmVsLm9yZz4KPj4+PiBDQzogbGludXgtc2Ftc3VuZy1zb2NAdmdlci5r
ZXJuZWwub3JnCj4+Pj4gQ0M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmcKPj4+PiBDQzogbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4+Pj4gQ0M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcKPj4+PiBTaWduZWQtb2ZmLWJ5OiBMdWthc3ogTHViYSA8bC5sdWJhQHBh
cnRuZXIuc2Ftc3VuZy5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9jbGsvc2Ftc3VuZy9j
bGstZXh5bm9zNTQyMC5jIHwgMTUgKysrKysrKysrKysrKystCj4+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMgYi9kcml2ZXJzL2Nsay9zYW1z
dW5nL2Nsay1leHlub3M1NDIwLmMKPj4+PiBpbmRleCAzZTg3NDIxLi44YmY5NTc5IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYwo+Pj4+ICsrKyBi
L2RyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYwo+Pj4+IEBAIC0xMzI1LDYgKzEz
MjUsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzYW1zdW5nX3BsbF9yYXRlX3RhYmxlIGV4eW5v
czU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsW10gX19pbmkKPj4+PiAgICAgICBQTExfMzVYWF9SQVRF
KDI0ICogTUhaLCAyMDAwMDAwMDAsICAyMDAsIDMsIDMpLAo+Pj4+ICAgIH07Cj4+Pj4KPj4+PiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBzYW1zdW5nX3BsbF9yYXRlX3RhYmxlIGV4eW5vczU0MjJfYnBs
bF9yYXRlX3RhYmxlW10gPSB7Cj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA5MzMw
MDAwMDAsIDMxMSwgNCwgMSksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA4MjUw
MDAwMDAsIDI3NSwgNCwgMSksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA3Mjgw
MDAwMDAsIDE4MiwgMywgMSksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA2MzMw
MDAwMDAsIDIxMSwgNCwgMSksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA1NDMw
MDAwMDAsIDE4MSwgMiwgMiksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA0MTMw
MDAwMDAsIDQxMywgNiwgMiksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAyNzUw
MDAwMDAsIDI3NSwgMywgMyksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAyMDYw
MDAwMDAsIDIwNiwgMywgMyksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAxNjUw
MDAwMDAsIDExMCwgMiwgMyksCj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAxMzgw
MDAwMDAsIDE4NCwgMiwgNCksCj4+Pgo+Pj4gRXhjZXB0IGZvciA4MjVNaHosIEkgY2FuJ3QgZmlu
ZCB0aGUgdGFyZ2V0IGZyZXF1ZW5jeQo+Pj4gb24gRXh5bm9zNTQyMiBUUk0gZG9jdW1lbnQuIFVz
dWFsbHksIEV4eW5vcyBUUk0gc3BlY2lmaWVkCj4+PiB0aGUgc3VwcG9ydGVkIHN0YWJsZSBjbG9j
a3MuIEl0IG1lYW5zIHRoYXQgdW5kZWZpbmVkIGNsb2Nrcwo+Pj4gYXJlIG5vdCBzdGFibGUgYXMg
SSBrbmV3LiBXaGVyZSBkbyB5b3UgZmluZCB0aGVtPwo+Pj4KPj4+IFdoZW4gSSBjYWxjdWxhdGVk
IHRoZSBQTEwgZnJlcXVlbmN5IHdpdGggUE1TIHZhbHVlLCBpdCBpcyBjb3JyZWN0Lgo+Pj4gQnV0
LCBqdXN0IHdlIG5lZWQgdG8gY2hlY2sgdGhlIHJlZmVyZW5jZSBvZiB1bmRlZmluZWQgY2xvY2tz
IG9uIFRSTQo+Pj4gaW4gb3JkZXIgdG8gZ3VhcmFudGVlIHRoZSBzdGFibGUgb3BlcmF0aW9uLgo+
PiBUaGV5IHZhbHVlcyBsaXZlIGluIHZlbmRvciBjb2RlIGZvciBBbmRyb2lkLgo+PiBJIGhhdmUg
dGVzdGVkIHRoZSBETUMgJiBERFIgd2l0aCB0aGVzZSByYXRpb3MgaW4gc3RyZXNzIHNjZW5hcmlv
cwo+PiBmb3IgYSBmZXcgZGF5cyBhbmQgaXQgd2FzIHN0YWJsZS4KPiAKPiBJZiBwb3NzaWJsZSwg
cGxlYXNlIHNoYXJlIHRoZSB1cmwgb2Ygb3JpZ2luYWwgdmVuZG9yIGNvZGUuCkhlcmUgaXMgdGhl
IHZlbmRvciBjb2RlIGZvciB0aGUgQlBMTCB2YWx1ZXM6Cmh0dHBzOi8vZ2l0aHViLmNvbS9oYXJk
a2VybmVsL2xpbnV4L2Jsb2Ivb2Ryb2lkeHUzLTMuMTAueS1hbmRyb2lkL2RyaXZlcnMvY2xrL3Nh
bXN1bmcvY2xrLWV4eW5vczU0MjIuYyNMMjAyNgoKUmVnYXJkcywKTHVrYXN6Cj4gCj4+Cj4+Pgo+
Pj4gUmVtb3ZlIDkzMy8xMzhNaHogYmVjYXVzZSBleHlub3M1NDMzLWRtYy5jIGRvZXNuJ3QgdXNl
IDkzM01oeiBhbmQgMTM4TWh6Cj4+PiBhbmQgYWxzbyBFeHlub3M1NDIyIFRSTSBkb2Vzbid0IGRl
ZmluZSA5MzMvMTM4TWh6IG9uIHBsbCB0YWJsZS4KPj4gT0ssIEkgd2lsbCByZW1vdmUgdGhlbS4K
Pj4+Cj4+Pj4gK307Cj4+Pj4gKwo+Pj4+ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Ftc3VuZ19w
bGxfcmF0ZV90YWJsZSBleHlub3M1NDIwX2VwbGxfMjRtaHpfdGJsW10gPSB7Cj4+Pj4gICAgICAg
UExMXzM2WFhfUkFURSgyNCAqIE1IWiwgNjAwMDAwMDAwVSwgMTAwLCAyLCAxLCAwKSwKPj4+PiAg
ICAgICBQTExfMzZYWF9SQVRFKDI0ICogTUhaLCA0MDAwMDAwMDBVLCAyMDAsIDMsIDIsIDApLAo+
Pj4+IEBAIC0xNDY3LDcgKzE0ODAsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgZXh5bm9zNXhfY2xr
X2luaXQoc3RydWN0IGRldmljZV9ub2RlICpucCwKPj4+PiAgICAgICAgICAgICAgIGV4eW5vczV4
X3BsbHNbYXBsbF0ucmF0ZV90YWJsZSA9IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+
Pj4+ICAgICAgICAgICAgICAgZXh5bm9zNXhfcGxsc1tlcGxsXS5yYXRlX3RhYmxlID0gZXh5bm9z
NTQyMF9lcGxsXzI0bWh6X3RibDsKPj4+PiAgICAgICAgICAgICAgIGV4eW5vczV4X3BsbHNba3Bs
bF0ucmF0ZV90YWJsZSA9IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+Pj4+IC0gICAg
ICAgICAgICBleHlub3M1eF9wbGxzW2JwbGxdLnJhdGVfdGFibGUgPSBleHlub3M1NDIwX3BsbDI1
NTB4XzI0bWh6X3RibDsKPj4+PiArICAgICAgICAgICAgZXh5bm9zNXhfcGxsc1ticGxsXS5yYXRl
X3RhYmxlID0gZXh5bm9zNTQyMl9icGxsX3JhdGVfdGFibGU7Cj4+Pgo+Pj4gRXh5bm9zNTQyMiB1
c2VkIHRoZSBzYW1lIFBMTCB0YWJsZSBmb3IgYXBsbCwga3BsbCwgYnBsbCBhbmQgc28gb24uCj4+
PiBZb3UgZG9uJ3QgbmVlZCB0byBtYWtlIHRoZSBzZXBhcmF0ZSBwbGwgdGFibGUuIEp1c3QgYWRk
IG5ldyBlbnRyaWVzCj4+PiB0byBleHlub3M1NDIwX3BsbDI1NTB4XzI0bWh6X3RibCB0YWJsZS4K
Pj4gT0ssIEkgd2lsbCBleHRlbmQgdGhlIGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsIHRh
YmxlLgo+Pgo+PiBJbiB2NCBwYXRjaCBzZXQsIGl0IHdpbGwgYmUgZml4ZWQuCj4+Cj4+IFJlZ2Fy
ZHMsCj4+IEx1a2Fzego+Pj4KPj4+PiAgICAgICB9Cj4+Pj4KPj4+PiAgICAgICBzYW1zdW5nX2Ns
a19yZWdpc3Rlcl9wbGwoY3R4LCBleHlub3M1eF9wbGxzLCBBUlJBWV9TSVpFKGV4eW5vczV4X3Bs
bHMpLAo+Pj4+Cj4+Pgo+IAo+IAo+IAo+IC0tCj4gQmVzdCBSZWdhcmRzLAo+IENoYW53b28gQ2hv
aQo+IFNhbXN1bmcgRWxlY3Ryb25pY3MKPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
