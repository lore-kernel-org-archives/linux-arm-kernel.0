Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88824C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:44:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2E421726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnjblXpa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qiLvC6aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2E421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdnSFiQCxopKeXbOOQTGCLLmHHVSarpaGInBbbMcJoI=; b=jnjblXpaVTTxvy
	iuEPpydfLRxeYqEgCt9JXAPIvJ+NePb0t0ydlKoiutqpsKdRFQIEY/1ACHzTzbfYbl0oyUXD68pp/
	jS70Tkwt6ZcU3R3KIj4D4Qj4uI67ItkNAvcwpg7nNBe+CLQH7+NksaVfGZQ1+aUxFKQqoXryDIxL1
	6Qu1mmxP3tQEGEHAyvkKQwM6DeNvojL3bTixF+2cDAn8Ad0AQnB9bOWG2lt4o9nKgikL7d0zZk4Tn
	MI86kRdz14pAe2JQhWsZgnaA/HPR8LU/iZtfZCEMSlsLvS9j3R1ywxl2nMBNqy2epsRc/2OU4yJEO
	1G5Gb30SdMNvA3XIR4XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUR1-0007Eo-3x; Fri, 01 Feb 2019 08:44:27 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUQx-00074n-2L
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:44:25 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190201084419epoutp03360072c93d11355e2a226a3b5f2b92b3~-MPzpi4so0407604076epoutp03D
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 08:44:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190201084419epoutp03360072c93d11355e2a226a3b5f2b92b3~-MPzpi4so0407604076epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549010659;
 bh=ZhVPXQJDOYPfOvRAQbEOsJtAluOWxGuxTxMUeSiN9r4=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=qiLvC6aEcMxxmFRVBccmPIaxFbm/qcLEmGrHpMTcKKY5BcBCYv0SGf3dlYjRe8Uua
 Om7t7iRfUref25eCx7u+Hl7YoUP6ad+s34kIiw03Or0Vn62slV/O7r0wrQLrMTnMPP
 Lg2lmIGNJgg+M/j6j1dPhSmMWqFB1afCLN5VuUtI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20190201084415epcas1p3491fc42304671bef4dbf2d26eab31a71~-MPvWkBeq1970119701epcas1p3P;
 Fri,  1 Feb 2019 08:44:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F0.46.04074.ED6045C5; Fri,  1 Feb 2019 17:44:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20190201084414epcas1p3f302302313e90b13966aca98289aadd1~-MPu6Ma3o2143721437epcas1p3H;
 Fri,  1 Feb 2019 08:44:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190201084414epsmtrp1c90129596bafeba042d9ab70ae8b09d4~-MPu4qcKu3138631386epsmtrp1i;
 Fri,  1 Feb 2019 08:44:14 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-3e-5c5406de1515
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.7C.03971.ED6045C5; Fri,  1 Feb 2019 17:44:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190201084414epsmtip2eec3b5cddd11d74f61de0ffbf62bc084~-MPumtpms2316023160epsmtip2H;
 Fri,  1 Feb 2019 08:44:14 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
Date: Fri, 1 Feb 2019 17:44:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmge49tpAYg9uLbCw2zljPajH/yDlW
 i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVp87LnHanF51xw2i8+9RxgtZpzfx2Sx9shddouL
 p1wtbjeuYLM4/Kad1eLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALSrb
 JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoaiWFssSc
 UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbs
 JWsZCx5LVry8F9PAeFi0i5GTQ0LAROLgpIfsXYxcHEICOxglFs9+ywThfGKU2NB8GCrzjVGi
 98p6dpiWc3++MYLYQgJ7GSX+Pq2EKHrPKNE8tw+sSFggWGLusZtsIAkRgeWMEvum3mUEcZgF
 9jJJLLrRA9bOJqAlsf/FDTYQm19AUeLqj8dgcV4BO4kn7b/B4iwCKhKXFs8FmyoqECFxuPcd
 VI2gxMmZT1hAbE4Bb4mXuyA2MwuIS9x6Mp8JwpaXaN46mxni7H3sEte250DYLhJPPv+CekdY
 4tXxLVC2lMTL/jYou1pi5ckjYB9ICHQwSmzZf4EVImEssX/pZKAFHEALNCXW79KH2MUn8e5r
 DytIWEKAV6KjTQiiWlni8oO7TBC2pMTi9k42CNtDYtLcSWwTGBVnIflmFpIPZiH5YBbCsgWM
 LKsYxVILinPTU4sNCwyRY3sTIzhFa5nuYJxyzucQowAHoxIP74ZfQTFCrIllxZW5hxglOJiV
 RHhns4TECPGmJFZWpRblxxeV5qQWH2I0BQb2RGYp0eR8YP7IK4k3NDUyNja2MDE0MzU0VBLn
 Xe/gHCMkkJ5YkpqdmlqQWgTTx8TBKdXAmLO0f8WGPxGne75urRX+wfnurtn+9WLzPXaLLM+9
 N0u6Vfl7pPHJZGnZ8vcZB791Tcw8aOv75FaTjMxKpc5d+T4WWz9Xz9+z6JKeqNyxY2cemV6c
 UXST07zeOplzlpqNc5vIiZbpaQ8+TPERSV7mxp902eltn5+du3TtSvbVE84lqKdY/szbqcRS
 nJFoqMVcVJwIAKl6majnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvO49tpAYg/enpS02zljPajH/yDlW
 i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVp87LnHanF51xw2i8+9RxgtZpzfx2Sx9shddouL
 p1wtbjeuYLM4/Kad1eLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
 JiU1J7MstUjfLoErY/aStYwFjyUrXt6LaWA8LNrFyMkhIWAice7PN8YuRi4OIYHdjBJfO2ex
 QiQkJaZdPMrcxcgBZAtLHD5cDBIWEnjLKLG9lQPEFhYIlvjS+g6sV0RgOaPE3L9LWUAcZoG9
 TBITei6zQky9zyjxZ99TRpAWNgEtif0vbrCB2PwCihJXfzwGi/MK2Ek8af8NFmcRUJG4tHgu
 O4gtKhAh8fHpPiaIGkGJkzOfsIDYnALeEi939YHVMAuoS/yZd4kZwhaXuPVkPhOELS/RvHU2
 8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCo1VL
 cwfj5SXxhxgFOBiVeHg3/AqKEWJNLCuuzD3EKMHBrCTCO5slJEaINyWxsiq1KD++qDQntfgQ
 ozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRnG7rZ/r+d849G/pbfq/sO50yXKdW2tb
 ax01jy6W8l3w6kGz/GWHOdsvfQo//9hZ+8vDm4e2Zmxd/vHGWasc86MTjn/l4zzOqqP6mut5
 XMk03QU+bLpyv5+YZXXNc2eqXyqV/ffJx9RLWgs7Eic//n/Y20z4/rLHzxf/tE7qYyj4LxcR
 92n2/m9KLMUZiYZazEXFiQBEQO800gIAAA==
X-CMS-MailID: 20190201084414epcas1p3f302302313e90b13966aca98289aadd1
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004423_445701_4C8AC407 
X-CRM114-Status: GOOD (  19.76  )
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

SGksCgpPbiAxOS4gMS4gMzEuIOyYpO2bhCA1OjQ5LCBMdWthc3ogTHViYSB3cm90ZToKPiBBZGQg
bmV3IHRhYmxlIHJhdGUgZm9yIEJQTEwgZm9yIEV4eW5vczU0MjIgU29DIHN1cHBvcnRpbmcgRHlu
YW1pYyBNZW1vcnkKPiBDb250cm9sbGVyIGZyZXF1ZW5jaWVzIGZvciBkcml2ZXIncyBEUkFNIHRp
bWluZ3MuCj4gCj4gQ0M6IFN5bHdlc3RlciBOYXdyb2NraSA8cy5uYXdyb2NraUBzYW1zdW5nLmNv
bT4KPiBDQzogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cj4gQ0M6IE1pY2hh
ZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT4KPiBDQzogU3RlcGhlbiBCb3lk
IDxzYm95ZEBrZXJuZWwub3JnPgo+IENDOiBLdWtqaW4gS2ltIDxrZ2VuZUBrZXJuZWwub3JnPgo+
IENDOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4gQ0M6IGxpbnV4LXNh
bXN1bmctc29jQHZnZXIua2VybmVsLm9yZwo+IENDOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3Jn
Cj4gQ0M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENDOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1ieTogTHVrYXN6IEx1YmEgPGwubHVi
YUBwYXJ0bmVyLnNhbXN1bmcuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1l
eHlub3M1NDIwLmMgfCAxNSArKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
c2Ftc3VuZy9jbGstZXh5bm9zNTQyMC5jIGIvZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstZXh5bm9z
NTQyMC5jCj4gaW5kZXggM2U4NzQyMS4uOGJmOTU3OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Ns
ay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMKPiArKysgYi9kcml2ZXJzL2Nsay9zYW1zdW5nL2Ns
ay1leHlub3M1NDIwLmMKPiBAQCAtMTMyNSw2ICsxMzI1LDE5IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgc2Ftc3VuZ19wbGxfcmF0ZV90YWJsZSBleHlub3M1NDIwX3BsbDI1NTB4XzI0bWh6X3RibFtd
IF9faW5pCj4gIAlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAyMDAwMDAwMDAsICAyMDAsIDMsIDMp
LAo+ICB9Owo+ICAKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzYW1zdW5nX3BsbF9yYXRlX3RhYmxl
IGV4eW5vczU0MjJfYnBsbF9yYXRlX3RhYmxlW10gPSB7Cj4gKwlQTExfMzVYWF9SQVRFKDI0ICog
TUhaLCA5MzMwMDAwMDAsIDMxMSwgNCwgMSksCj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA4
MjUwMDAwMDAsIDI3NSwgNCwgMSksCj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA3MjgwMDAw
MDAsIDE4MiwgMywgMSksCj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA2MzMwMDAwMDAsIDIx
MSwgNCwgMSksCj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA1NDMwMDAwMDAsIDE4MSwgMiwg
MiksCj4gKwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA0MTMwMDAwMDAsIDQxMywgNiwgMiksCj4g
KwlQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAyNzUwMDAwMDAsIDI3NSwgMywgMyksCj4gKwlQTExf
MzVYWF9SQVRFKDI0ICogTUhaLCAyMDYwMDAwMDAsIDIwNiwgMywgMyksCj4gKwlQTExfMzVYWF9S
QVRFKDI0ICogTUhaLCAxNjUwMDAwMDAsIDExMCwgMiwgMyksCj4gKwlQTExfMzVYWF9SQVRFKDI0
ICogTUhaLCAxMzgwMDAwMDAsIDE4NCwgMiwgNCksCgpFeGNlcHQgZm9yIDgyNU1oeiwgSSBjYW4n
dCBmaW5kIHRoZSB0YXJnZXQgZnJlcXVlbmN5Cm9uIEV4eW5vczU0MjIgVFJNIGRvY3VtZW50LiBV
c3VhbGx5LCBFeHlub3MgVFJNIHNwZWNpZmllZAp0aGUgc3VwcG9ydGVkIHN0YWJsZSBjbG9ja3Mu
IEl0IG1lYW5zIHRoYXQgdW5kZWZpbmVkIGNsb2NrcwphcmUgbm90IHN0YWJsZSBhcyBJIGtuZXcu
IFdoZXJlIGRvIHlvdSBmaW5kIHRoZW0/CgpXaGVuIEkgY2FsY3VsYXRlZCB0aGUgUExMIGZyZXF1
ZW5jeSB3aXRoIFBNUyB2YWx1ZSwgaXQgaXMgY29ycmVjdC4KQnV0LCBqdXN0IHdlIG5lZWQgdG8g
Y2hlY2sgdGhlIHJlZmVyZW5jZSBvZiB1bmRlZmluZWQgY2xvY2tzIG9uIFRSTQppbiBvcmRlciB0
byBndWFyYW50ZWUgdGhlIHN0YWJsZSBvcGVyYXRpb24uCgpSZW1vdmUgOTMzLzEzOE1oeiBiZWNh
dXNlIGV4eW5vczU0MzMtZG1jLmMgZG9lc24ndCB1c2UgOTMzTWh6IGFuZCAxMzhNaHoKYW5kIGFs
c28gRXh5bm9zNTQyMiBUUk0gZG9lc24ndCBkZWZpbmUgOTMzLzEzOE1oeiBvbiBwbGwgdGFibGUu
Cgo+ICt9Owo+ICsKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzYW1zdW5nX3BsbF9yYXRlX3RhYmxl
IGV4eW5vczU0MjBfZXBsbF8yNG1oel90YmxbXSA9IHsKPiAgCVBMTF8zNlhYX1JBVEUoMjQgKiBN
SFosIDYwMDAwMDAwMFUsIDEwMCwgMiwgMSwgMCksCj4gIAlQTExfMzZYWF9SQVRFKDI0ICogTUha
LCA0MDAwMDAwMDBVLCAyMDAsIDMsIDIsIDApLAo+IEBAIC0xNDY3LDcgKzE0ODAsNyBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgZXh5bm9zNXhfY2xrX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpucCwK
PiAgCQlleHlub3M1eF9wbGxzW2FwbGxdLnJhdGVfdGFibGUgPSBleHlub3M1NDIwX3BsbDI1NTB4
XzI0bWh6X3RibDsKPiAgCQlleHlub3M1eF9wbGxzW2VwbGxdLnJhdGVfdGFibGUgPSBleHlub3M1
NDIwX2VwbGxfMjRtaHpfdGJsOwo+ICAJCWV4eW5vczV4X3BsbHNba3BsbF0ucmF0ZV90YWJsZSA9
IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+IC0JCWV4eW5vczV4X3BsbHNbYnBsbF0u
cmF0ZV90YWJsZSA9IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+ICsJCWV4eW5vczV4
X3BsbHNbYnBsbF0ucmF0ZV90YWJsZSA9IGV4eW5vczU0MjJfYnBsbF9yYXRlX3RhYmxlOwoKRXh5
bm9zNTQyMiB1c2VkIHRoZSBzYW1lIFBMTCB0YWJsZSBmb3IgYXBsbCwga3BsbCwgYnBsbCBhbmQg
c28gb24uCllvdSBkb24ndCBuZWVkIHRvIG1ha2UgdGhlIHNlcGFyYXRlIHBsbCB0YWJsZS4gSnVz
dCBhZGQgbmV3IGVudHJpZXMKdG8gZXh5bm9zNTQyMF9wbGwyNTUweF8yNG1oel90YmwgdGFibGUu
Cgo+ICAJfQo+ICAKPiAgCXNhbXN1bmdfY2xrX3JlZ2lzdGVyX3BsbChjdHgsIGV4eW5vczV4X3Bs
bHMsIEFSUkFZX1NJWkUoZXh5bm9zNXhfcGxscyksCj4gCgotLSAKQmVzdCBSZWdhcmRzLApDaGFu
d29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
