Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F581C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EFE2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q9N7ODUK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NVf5yZTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EFE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x1NJni/W6UZvPdctg79/p8NQiUunNaHLiQ7p9YOrLws=; b=q9N7ODUK5ozLYK
	iVXrXtPZonnAZOD0tzGw16GpoK2b6q356kiTnwdVkrGoQskjWJU5GQ3MYpUYe5WGKQLdzBZywZKz7
	0EA46M+OMF+S65IjUHo5ckZKta3wlguolIHEjSHMohFg9JeuHHNt6eirE315Sld1R41oHeSozD8Yy
	cAhekh1kNH88xbJSzNJHOpQvF4kLhg/tunr9FMUUUYKV1n09PWAbhNLKThtQ/7D7Vt37LjIgq9DQM
	jZ4StDAmQOYHNATDjKVm6FVw/DccDRAsKVg6MiEq7aqrSniuH3WimU7wcju1o66VM+/f71YgR+VYV
	3urIikeDjMDNANZ4d1fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8vg-00062I-BV; Mon, 11 Feb 2019 10:35:12 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8vb-00054y-VI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:35:10 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20190211103502epoutp02844de41db6c324a6e62afb111b412430~CSNUqaSI83017530175epoutp02S
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20190211103502epoutp02844de41db6c324a6e62afb111b412430~CSNUqaSI83017530175epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549881302;
 bh=kvJT524Acja0/UcdtDWaZ04nkAJMpL0CGUrN0Y/rid8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=NVf5yZTOoFQe6/1M9AmFo7FLc173ISEKqpGMDeF59Nhkvhg/VxOJ9qZ7CbrWz4Sql
 F1lCYjeZ+zNsj+zNx83ZXlHXpy04vS8An1GKCSzYFTL5vMsUlmDVjVVAN+v+Ew8vdE
 hzgR8YvPteG/zIyHhd4121SbiLn36Z4cSqalZtj0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20190211103459epcas1p3faf7108b710ebbdbb7a59038a1980847~CSNSX5j6M2023720237epcas1p3P;
 Mon, 11 Feb 2019 10:34:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 D1.1D.04069.3DF416C5; Mon, 11 Feb 2019 19:34:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20190211103459epcas1p3904fadb55b588dcceb5bc0248a1dce60~CSNR9WRYW2023020230epcas1p3R;
 Mon, 11 Feb 2019 10:34:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190211103459epsmtrp262c15a03e9dad3de4a684c3c2988611b~CSNR5zRi00604906049epsmtrp2A;
 Mon, 11 Feb 2019 10:34:59 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-62-5c614fd34ce8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 4E.9C.03971.2DF416C5; Mon, 11 Feb 2019 19:34:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190211103458epsmtip161de85e79249ea9616f4c0a737de038b~CSNRoOEQS2986329863epsmtip1R;
 Mon, 11 Feb 2019 10:34:58 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To: Lukasz Luba <l.luba@partner.samsung.com>, cwchoi00@gmail.com
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <790ea13b-7a44-2452-a6b2-51102e60c290@samsung.com>
Date: Mon, 11 Feb 2019 19:34:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmru5l/8QYg9XvVS02zljPavHsqLbF
 /CPnWC36H79mtjh/fgO7xdmmN+wWtxpkLDY9vsZq8bHnHqvF5V1z2Cw+9x5htJhxfh+Txdoj
 d9ktLp5ytbjduILN4vCbdlaLf9c2sjgIery/0crusXPWXXaPTas62Tw2L6n3OPhuD5NH35ZV
 jB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
 ZeYAna+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0
 MDAyBSpMyM74cHMFa8FF/Yrmb4vZGxhPqHYxcnBICJhILPlU3sXIxSEksINRYt6KLcwQzidG
 iUmHLzJBON8YJc739zDCdHSs8YWI72WUWPOqAaroPaPEwmXNQEWcHMICwRJzj91kA7FFBBwk
 dt58yQhSxCwwnVWi+fpeFpAEm4CWxP4XN8CK+AUUJa7+eAzWzCtgJ/Gn/Q1YDYuAqsSCWc1g
 tqhAhMTh3ndQNYISJ2c+AYtzCrhLzNv/iBnEZhYQl7j1ZD4ThC0v0bx1Ntg/EgKH2CVeL/0E
 ViQh4CIxs+8fC4QtLPHq+BZ2CFtK4vO7vWwQdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyEygs
 mAU0Jdbv0odYxifx7msPKySIeCU62oQgqpUlLj+4ywRhS0osbu+EGu8hMWnuJLYJjIqzkLwz
 C8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBcbIsb2JEZy0tcx3MG4453OIUYCDUYmH90NiQowQ
 a2JZcWXuIUYJDmYlEd5Q38QYId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPzCh5JfGGpkbG
 xsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6mDg4pRoYO44FNrhz7V+Q5qnLUNT4TNLn
 tJT/tVcnd7F8PePSXy+0s3mK9Z/VhS4bpiht999SzeQ9ebtU3FbRpuN7E85q7BSdtulzhccM
 /fzae9tf33Z+u9fhjWD2Svvq59knNwYYxO8/U/xZkWcyL6Me673zNxdKnr5n9NdwxYwjD7bs
 2/FvUeCKzym6UkosxRmJhlrMRcWJAKuT2mzwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnO5l/8QYg2uLmC02zljPavHsqLbF
 /CPnWC36H79mtjh/fgO7xdmmN+wWtxpkLDY9vsZq8bHnHqvF5V1z2Cw+9x5htJhxfh+Txdoj
 d9ktLp5ytbjduILN4vCbdlaLf9c2sjgIery/0crusXPWXXaPTas62Tw2L6n3OPhuD5NH35ZV
 jB6fN8kFsEdx2aSk5mSWpRbp2yVwZXy4uYK14KJ+RfO3xewNjCdUuxg5OCQETCQ61vh2MXJy
 CAnsZpQ4voMHxJYQkJSYdvEoM0SJsMThw8VdjFxAJW8ZJWbdWMUOUiMsECzxpfUdI4gtIuAg
 sfPmSzCbWWAuq8S1M7UQDVeZJT59XA7WwCagJbH/xQ02EJtfQFHi6o/HYA28AnYSf9rfsIDY
 LAKqEgtmNYPZogIREh+f7mOCqBGUODnzCVicU8BdYt7+R8wQy9Ql/sy7BGWLS9x6Mp8JwpaX
 aN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsY
 wbGrpbmD8fKS+EOMAhyMSjy8HxITYoRYE8uKK3MPMUpwMCuJ8Ib6JsYI8aYkVlalFuXHF5Xm
 pBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwNgswCY+8aK0T8+qr3lSb+epXNNs
 /rmrdsLOE8d9zdZsLGIVrNwSmG3hHpuQdPz01AVbdt60uPjr/2aLkI/K3fELr2gd0y/U8XIq
 WRzqvv7PF1Zrhs/bp7xI2HFh4tHF0p6Gu1ztSqSb4+7PnV0Rf+3wpCWqbXMKs3xYN0xY1P/l
 99UrjVf8JBmVWIozEg21mIuKEwGc9ccJ2QIAAA==
X-CMS-MailID: 20190211103459epcas1p3904fadb55b588dcceb5bc0248a1dce60
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
 <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
 <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
 <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023508_357867_6F6F9EC9 
X-CRM114-Status: GOOD (  26.90  )
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
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVrYXN6LAoKT24gMTkuIDIuIDExLiDsmKTtm4QgNzoyMSwgTHVrYXN6IEx1YmEgd3JvdGU6
Cj4gSGkgQ2hhbndvbywKPiAKPiBPbiAyLzMvMTkgODo1NCBBTSwgQ2hhbndvbyBDaG9pIHdyb3Rl
Ogo+PiBIaSBMdWthc3osCj4+Cj4+IDIwMTnrhYQgMuyblCAx7J28ICjquIgpIOyYpO2bhCAxMToy
MiwgTHVrYXN6IEx1YmEgPGwubHViYUBwYXJ0bmVyLnNhbXN1bmcuY29tPuuLmOydtCDsnpHshLE6
Cj4+Cj4+Pgo+Pj4gSGkgQ2hhbndvbywKPj4+Cj4+PiBPbiAyLzEvMTkgOTo0NCBBTSwgQ2hhbndv
byBDaG9pIHdyb3RlOgo+Pj4+IEhpLAo+Pj4+Cj4+Pj4gT24gMTkuIDEuIDMxLiDsmKTtm4QgNTo0
OSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+Pj4+IEFkZCBuZXcgdGFibGUgcmF0ZSBmb3IgQlBMTCBm
b3IgRXh5bm9zNTQyMiBTb0Mgc3VwcG9ydGluZyBEeW5hbWljIE1lbW9yeQo+Pj4+PiBDb250cm9s
bGVyIGZyZXF1ZW5jaWVzIGZvciBkcml2ZXIncyBEUkFNIHRpbWluZ3MuCj4+Pj4+Cj4+Pj4+IEND
OiBTeWx3ZXN0ZXIgTmF3cm9ja2kgPHMubmF3cm9ja2lAc2Ftc3VuZy5jb20+Cj4+Pj4+IENDOiBD
aGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4+Pj4gQ0M6IE1pY2hhZWwgVHVy
cXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT4KPj4+Pj4gQ0M6IFN0ZXBoZW4gQm95ZCA8
c2JveWRAa2VybmVsLm9yZz4KPj4+Pj4gQ0M6IEt1a2ppbiBLaW0gPGtnZW5lQGtlcm5lbC5vcmc+
Cj4+Pj4+IENDOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4+Pj4+IEND
OiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcKPj4+Pj4gQ0M6IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmcKPj4+Pj4gQ0M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwo+Pj4+PiBDQzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBMdWthc3ogTHViYSA8bC5sdWJhQHBhcnRuZXIuc2Ftc3VuZy5jb20+Cj4+Pj4+IC0t
LQo+Pj4+PiAgICBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMgfCAxNSArKysr
KysrKysrKysrKy0KPj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3NhbXN1bmcv
Y2xrLWV4eW5vczU0MjAuYyBiL2RyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYwo+
Pj4+PiBpbmRleCAzZTg3NDIxLi44YmY5NTc5IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2Ns
ay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMKPj4+Pj4gKysrIGIvZHJpdmVycy9jbGsvc2Ftc3Vu
Zy9jbGstZXh5bm9zNTQyMC5jCj4+Pj4+IEBAIC0xMzI1LDYgKzEzMjUsMTkgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBzYW1zdW5nX3BsbF9yYXRlX3RhYmxlIGV4eW5vczU0MjBfcGxsMjU1MHhfMjRt
aHpfdGJsW10gX19pbmkKPj4+Pj4gICAgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMjAwMDAw
MDAwLCAgMjAwLCAzLCAzKSwKPj4+Pj4gICAgfTsKPj4+Pj4KPj4+Pj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgc2Ftc3VuZ19wbGxfcmF0ZV90YWJsZSBleHlub3M1NDIyX2JwbGxfcmF0ZV90YWJsZVtd
ID0gewo+Pj4+PiArICAgIFBMTF8zNVhYX1JBVEUoMjQgKiBNSFosIDkzMzAwMDAwMCwgMzExLCA0
LCAxKSwKPj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA4MjUwMDAwMDAsIDI3NSwg
NCwgMSksCj4+Pj4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNzI4MDAwMDAwLCAxODIs
IDMsIDEpLAo+Pj4+PiArICAgIFBMTF8zNVhYX1JBVEUoMjQgKiBNSFosIDYzMzAwMDAwMCwgMjEx
LCA0LCAxKSwKPj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCA1NDMwMDAwMDAsIDE4
MSwgMiwgMiksCj4+Pj4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNDEzMDAwMDAwLCA0
MTMsIDYsIDIpLAo+Pj4+PiArICAgIFBMTF8zNVhYX1JBVEUoMjQgKiBNSFosIDI3NTAwMDAwMCwg
Mjc1LCAzLCAzKSwKPj4+Pj4gKyAgICBQTExfMzVYWF9SQVRFKDI0ICogTUhaLCAyMDYwMDAwMDAs
IDIwNiwgMywgMyksCj4+Pj4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMTY1MDAwMDAw
LCAxMTAsIDIsIDMpLAo+Pj4+PiArICAgIFBMTF8zNVhYX1JBVEUoMjQgKiBNSFosIDEzODAwMDAw
MCwgMTg0LCAyLCA0KSwKPj4+Pgo+Pj4+IEV4Y2VwdCBmb3IgODI1TWh6LCBJIGNhbid0IGZpbmQg
dGhlIHRhcmdldCBmcmVxdWVuY3kKPj4+PiBvbiBFeHlub3M1NDIyIFRSTSBkb2N1bWVudC4gVXN1
YWxseSwgRXh5bm9zIFRSTSBzcGVjaWZpZWQKPj4+PiB0aGUgc3VwcG9ydGVkIHN0YWJsZSBjbG9j
a3MuIEl0IG1lYW5zIHRoYXQgdW5kZWZpbmVkIGNsb2Nrcwo+Pj4+IGFyZSBub3Qgc3RhYmxlIGFz
IEkga25ldy4gV2hlcmUgZG8geW91IGZpbmQgdGhlbT8KPj4+Pgo+Pj4+IFdoZW4gSSBjYWxjdWxh
dGVkIHRoZSBQTEwgZnJlcXVlbmN5IHdpdGggUE1TIHZhbHVlLCBpdCBpcyBjb3JyZWN0Lgo+Pj4+
IEJ1dCwganVzdCB3ZSBuZWVkIHRvIGNoZWNrIHRoZSByZWZlcmVuY2Ugb2YgdW5kZWZpbmVkIGNs
b2NrcyBvbiBUUk0KPj4+PiBpbiBvcmRlciB0byBndWFyYW50ZWUgdGhlIHN0YWJsZSBvcGVyYXRp
b24uCj4+PiBUaGV5IHZhbHVlcyBsaXZlIGluIHZlbmRvciBjb2RlIGZvciBBbmRyb2lkLgo+Pj4g
SSBoYXZlIHRlc3RlZCB0aGUgRE1DICYgRERSIHdpdGggdGhlc2UgcmF0aW9zIGluIHN0cmVzcyBz
Y2VuYXJpb3MKPj4+IGZvciBhIGZldyBkYXlzIGFuZCBpdCB3YXMgc3RhYmxlLgo+Pgo+PiBJZiBw
b3NzaWJsZSwgcGxlYXNlIHNoYXJlIHRoZSB1cmwgb2Ygb3JpZ2luYWwgdmVuZG9yIGNvZGUuCj4g
SGVyZSBpcyB0aGUgdmVuZG9yIGNvZGUgZm9yIHRoZSBCUExMIHZhbHVlczoKPiBodHRwczovL2dp
dGh1Yi5jb20vaGFyZGtlcm5lbC9saW51eC9ibG9iL29kcm9pZHh1My0zLjEwLnktYW5kcm9pZC9k
cml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDIyLmMjTDIwMjYKClRoYW5rcyBmb3Igc2hh
cmluZy4KCmJwbGxfcmF0ZV90YWJsZSBoYXMgdHdvIGRpZmZlcmVudCBzdXBwb3J0ZWQgZnJlcXVl
bmN5CmFjY29yZGluZyB0byBleHlub3M1NDIyIHJldmlzaW9uIGFzIGZvbGxvd2luZzoKQnV0LCB0
aGlzIHBhdGNoIG9ubHkgaGFzIG9ubHkgb25lIGZyZXF1ZW5jeSBzZXQKZm9yIENPTkZJR19TT0Nf
RVhZTk9TNTQyMl9SRVZfMC4KCkNvdWxkIHlvdSBndWFyYW50ZWUgdGhhdCBhbGwgRXh5bm9zNTQy
Mi1iYXNlZCBPZHJvaWQteHUzIGJvYXJkCmhhcyBDT05GSUdfU09DX0VYWU5PUzU0MjJfUkVWXzAg
ZXJzaW9uPyBJZiBub3QgZ3VhcmFudGVlZCwKc29tZSBib2FyZCBtaWdodCBiZSBmYXVsdCBiZWNh
dXNlIG9mIHVzaW5nIHRoZSB1bnN1cHBvcnRlZApmcmVxdWVuY2llcy4KCkl0IGlzIGRhbmdlcm91
cyBhbmQgdW5zdGFibGUgdG8gdXNlIHRoZSB1bnN1cHBvcnRlZCBmcmVxdWVuY2llcyB0byBTb0Mu
CgpzdHJ1Y3Qgc2Ftc3VuZ19wbGxfcmF0ZV90YWJsZSBicGxsX3JhdGVfdGFibGVbXSA9IHsKCS8q
IHJhdGUJCXAJbQlzCWsgKi8KI2lmZGVmIENPTkZJR19TT0NfRVhZTk9TNTQyMl9SRVZfMAoJeyA5
MzMwMDAwMDBVLCAgIDQsICAzMTEsICAgIDEsICAwfSwKCXsgOTI1MDAwMDAwVSwgICA0LCAgMzA3
LCAgICAxLCAgMH0sCgl7IDgyNTAwMDAwMFUsICAgNCwgIDI3NSwgICAgMSwgIDB9LAoJeyA3Mjgw
MDAwMDBVLCAgIDMsICAxODIsICAgIDEsICAwfSwKCXsgNjMzMDAwMDAwVSwgICA0LCAgMjExLCAg
ICAxLCAgMH0sCgl7IDU0MzAwMDAwMFUsICAgMiwgIDE4MSwgICAgMiwgIDB9LAoJeyA0MTMwMDAw
MDBVLCAgIDYsICA0MTMsICAgIDIsICAwfSwKCXsgMjc1MDAwMDAwVSwgICAzLCAgMjc1LCAgICAz
LCAgMH0sCgl7IDIwNjAwMDAwMFUsICAgMywgIDIwNiwgICAgMywgIDB9LAoJeyAxNjUwMDAwMDBV
LCAgIDIsICAxMTAsICAgIDMsICAwfSwKCXsgMTM4MDAwMDAwVSwgICAyLCAgMTg0LCAgICA0LCAg
MH0sCiNlbHNlCgl7IDkzMzAwMDAwMFUsICAgNCwgIDMxMSwgICAgMSwgIDB9LAoJeyA4MDAwMDAw
MDBVLCAgIDMsICAyMDAsICAgIDEsICAwfSwKCXsgNzMzMDAwMDAwVSwgICAyLCAgMTIyLCAgICAx
LCAgMH0sCgl7IDY2NzAwMDAwMFUsICAgMiwgIDExMSwgICAgMSwgIDB9LAoJeyA1MzMwMDAwMDBV
LCAgIDMsICAyNjYsICAgIDIsICAwfSwKCXsgNDAwMDAwMDAwVSwgICAzLCAgMjAwLCAgICAyLCAg
MH0sCgl7IDI2NjAwMDAwMFUsICAgMywgIDI2NiwgICAgMywgIDB9LAoJeyAyMDAwMDAwMDBVLCAg
IDMsICAyMDAsICAgIDMsICAwfSwKCXsgMTYwMDAwMDAwVSwgICAzLCAgMTYwLCAgICAzLCAgMH0s
CiNlbmRpZgp9OwoKCj4gCj4gUmVnYXJkcywKPiBMdWthc3oKPj4KPj4+Cj4+Pj4KPj4+PiBSZW1v
dmUgOTMzLzEzOE1oeiBiZWNhdXNlIGV4eW5vczU0MzMtZG1jLmMgZG9lc24ndCB1c2UgOTMzTWh6
IGFuZCAxMzhNaHoKPj4+PiBhbmQgYWxzbyBFeHlub3M1NDIyIFRSTSBkb2Vzbid0IGRlZmluZSA5
MzMvMTM4TWh6IG9uIHBsbCB0YWJsZS4KPj4+IE9LLCBJIHdpbGwgcmVtb3ZlIHRoZW0uCj4+Pj4K
Pj4+Pj4gK307Cj4+Pj4+ICsKPj4+Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBzYW1zdW5nX3Bs
bF9yYXRlX3RhYmxlIGV4eW5vczU0MjBfZXBsbF8yNG1oel90YmxbXSA9IHsKPj4+Pj4gICAgICAg
UExMXzM2WFhfUkFURSgyNCAqIE1IWiwgNjAwMDAwMDAwVSwgMTAwLCAyLCAxLCAwKSwKPj4+Pj4g
ICAgICAgUExMXzM2WFhfUkFURSgyNCAqIE1IWiwgNDAwMDAwMDAwVSwgMjAwLCAzLCAyLCAwKSwK
Pj4+Pj4gQEAgLTE0NjcsNyArMTQ4MCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBleHlub3M1eF9j
bGtfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLAo+Pj4+PiAgICAgICAgICAgICAgIGV4eW5v
czV4X3BsbHNbYXBsbF0ucmF0ZV90YWJsZSA9IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJs
Owo+Pj4+PiAgICAgICAgICAgICAgIGV4eW5vczV4X3BsbHNbZXBsbF0ucmF0ZV90YWJsZSA9IGV4
eW5vczU0MjBfZXBsbF8yNG1oel90Ymw7Cj4+Pj4+ICAgICAgICAgICAgICAgZXh5bm9zNXhfcGxs
c1trcGxsXS5yYXRlX3RhYmxlID0gZXh5bm9zNTQyMF9wbGwyNTUweF8yNG1oel90Ymw7Cj4+Pj4+
IC0gICAgICAgICAgICBleHlub3M1eF9wbGxzW2JwbGxdLnJhdGVfdGFibGUgPSBleHlub3M1NDIw
X3BsbDI1NTB4XzI0bWh6X3RibDsKPj4+Pj4gKyAgICAgICAgICAgIGV4eW5vczV4X3BsbHNbYnBs
bF0ucmF0ZV90YWJsZSA9IGV4eW5vczU0MjJfYnBsbF9yYXRlX3RhYmxlOwo+Pj4+Cj4+Pj4gRXh5
bm9zNTQyMiB1c2VkIHRoZSBzYW1lIFBMTCB0YWJsZSBmb3IgYXBsbCwga3BsbCwgYnBsbCBhbmQg
c28gb24uCj4+Pj4gWW91IGRvbid0IG5lZWQgdG8gbWFrZSB0aGUgc2VwYXJhdGUgcGxsIHRhYmxl
LiBKdXN0IGFkZCBuZXcgZW50cmllcwo+Pj4+IHRvIGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpf
dGJsIHRhYmxlLgo+Pj4gT0ssIEkgd2lsbCBleHRlbmQgdGhlIGV4eW5vczU0MjBfcGxsMjU1MHhf
MjRtaHpfdGJsIHRhYmxlLgo+Pj4KPj4+IEluIHY0IHBhdGNoIHNldCwgaXQgd2lsbCBiZSBmaXhl
ZC4KPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gTHVrYXN6Cj4+Pj4KPj4+Pj4gICAgICAgfQo+Pj4+Pgo+
Pj4+PiAgICAgICBzYW1zdW5nX2Nsa19yZWdpc3Rlcl9wbGwoY3R4LCBleHlub3M1eF9wbGxzLCBB
UlJBWV9TSVpFKGV4eW5vczV4X3BsbHMpLAo+Pj4+Pgo+Pj4+Cj4+Cj4+Cj4+Cj4+IC0tCj4+IEJl
c3QgUmVnYXJkcywKPj4gQ2hhbndvbyBDaG9pCj4+IFNhbXN1bmcgRWxlY3Ryb25pY3MKPj4KPj4K
PiAKPiAKCgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmlj
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
