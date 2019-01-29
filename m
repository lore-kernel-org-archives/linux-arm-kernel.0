Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB3CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4842184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u1cGRLYE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c1elvF0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4842184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W7sECB620WhzpwwxKkWUzGfE/irHSmFX10roqxCTswo=; b=u1cGRLYEUPbd0k
	J7PaEHRZIps0BMemTtRSl3gNo1crxWByoAFc1EM+LtlskWWNG+LXeDC6Q+xANn3Dk9PLDFF5iYWs7
	ltBu0OEbpBZQm9jlIaAyUHBP1u/rjcUnFEiDpYVCI67jaHmQcAXdbaSzcO9qbm5QB2EsxrnByABqz
	x05bNZ4oUgIT0gU6ATXL1qkFkR9Zg6LKBo++SmNhjg4zLdJ8E3iTuG2TzDS6jX9lW08lUezcl9Um6
	SyzkBEP7yb8BWufNeBxg8++DqQnTVPFhtOype1o5EnV4u2wRc0yu2tbNgR2E5oZtntOLCBiCqu/yx
	zyTBj9XRrj9BeagUBw7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVm5-00056c-Pl; Tue, 29 Jan 2019 15:58:09 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVm0-000558-Gs
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:58:06 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190129155759euoutp0164e772b8be55b97b98e457e553bdcdff~_XOlxMUub1520915209euoutp01D
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 15:57:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190129155759euoutp0164e772b8be55b97b98e457e553bdcdff~_XOlxMUub1520915209euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548777479;
 bh=efA1xgq/E6H2bvJ060ZQWL4+mu93Fz0joqPMVYcT+hk=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=c1elvF0pcQfD481UxWd+lsPqXeThn4ylVvH2AZerCuQ9B9q0BIlPSmZ2i4BSylkqw
 IcfLM1jBQ8Rj8rRP1PKZN9k/g24J/GvYyb2BpUWlY7pDW0+BxImUpw+43W7ZsnvUYP
 z7qXwWIlJZSeaG8NYKykp+Ji5bn7fpRxERbIvSJ4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190129155759eucas1p2acbb97bf26d1a3625dcbd266d371a5fc~_XOlQXk1N2552225522eucas1p25;
 Tue, 29 Jan 2019 15:57:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 51.07.04294.608705C5; Tue, 29
 Jan 2019 15:57:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190129155758eucas1p13ee7f9bf17b10d104e198770fa8a9122~_XOkasFnM2320423204eucas1p1v;
 Tue, 29 Jan 2019 15:57:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190129155757eusmtrp19b9a3923bb352f53395ae36b909421fd~_XOkL_9A02822928229eusmtrp15;
 Tue, 29 Jan 2019 15:57:57 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-ab-5c507806155d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.FF.04284.508705C5; Tue, 29
 Jan 2019 15:57:57 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190129155757eusmtip113b4e6905e9601c05a055ec1e1810d6c~_XOjn2lsb2108621086eusmtip1h;
 Tue, 29 Jan 2019 15:57:57 +0000 (GMT)
Subject: Re: [PATCH 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f41259c2-fe37-261d-2029-e4d4aecf52d6@partner.samsung.com>
Date: Tue, 29 Jan 2019 16:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6cbbeac-c15f-91b8-caf3-b22b8715665a@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7psFQExBreW61hsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsll6/yGRxu3EFm0Xr3iPsFofftLM6
 8HismbeG0WPTqk42j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr4/2W5WwFMyUrWta0
 sDcwnhXpYuTkkBAwkTiy5DYLiC0ksIJRouWJXxcjF5D9hVGi8dIuVgjnM6PErs9r2GE6NvTe
 YoJILGeUmP71LiOE85ZRYuf1ZawgVcICIRLbV+wB6xARcJH4dLGXEcRmFjjJJNE02aSLkYOD
 TUBPYseqQpAwr4CbxONPS8BaWQRUJd69aWYGsUUFIiQO975jhKgRlDg58wnYqZwC9hKzXx1n
 gRgpLnHryXwmCFteonnrbGaQeyQEbrFLHG4+zgpxtYvEua9voT4Qlnh1fAuULSNxenIPC4Rd
 LHG2YxUbhF0j0X5yB1SNtcTh4xdZQW5mFtCUWL9LHyLsKHF+/n12kLCEAJ/EjbeCECfwSUza
 Np0ZIswr0dEmBFGtIbGl5wIThC0msXzNNPYJjEqzkDw2C8kzs5A8Mwth7wJGllWM4qmlxbnp
 qcVGeanlesWJucWleel6yfm5mxiB6er0v+NfdjDu+pN0iFGAg1GJh5chOCBGiDWxrLgy9xCj
 BAezkgiv4W//GCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTByc
 Ug2Mnp/lDfj+2t6tskieHfvUe5L/jn973r6fztknPulZqtUru/M5+c62VqtKol7Lx516xMRm
 7Cqq+3r2Bb9b0zjbN8+xXvt947EDGz6afHiWNT/Gaorg4i8LFZ0zLHOecPJcUJBTDWZrk6us
 /SdyxfbvL6abk53MciakBb3q1Npi3nc580fxLP4CJZbijERDLeai4kQAOh0lqFMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7qsFQExBos+6ltsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsll6/yGRxu3EFm0Xr3iPsFofftLM6
 8HismbeG0WPTqk42j81L6j36tqxi9Pi8SS6ANUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
 Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4/2W5WwFMyUrWta0sDcwnhXpYuTkkBAwkdjQe4up
 i5GLQ0hgKaPEgSvn2CASYhKT9m1nh7CFJf5c62KDKHrNKPFt+h8mkISwQIjE9hV7wIpEBFwk
 Pl3sZQQpYhY4ySTR/G4SI0THFCaJrX2ngRwODjYBPYkdqwpBGngF3CQef1rCCmKzCKhKvHvT
 zAxiiwpESHx8uo8JokZQ4uTMJywgNqeAvcTsV8fBbGYBM4l5mx8yQ9jiEreezGeCsOUlmrfO
 Zp7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmCcbjv2c/MO
 xksbgw8xCnAwKvHwMgQHxAixJpYVV+YeYpTgYFYS4TX87R8jxJuSWFmVWpQfX1Sak1p8iNEU
 6LmJzFKiyfnAFJJXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx
 ZuPCYycKkgU4izfMVJ65RfK0r6tWnMEu1Ub/OvXTd2oC9hnP0mKYeTasp0d3988li2ayuR1j
 3CL+Z+XjiKSHyxc99Vp89Vmh/rsr1/3vL9uwW7iiau6alreb8melND/4VsSu8tIso+KFr82N
 Hyq/vvHrFah13F4ZmcX00zMkxkRtyf623EePlFiKMxINtZiLihMBkIHJt+kCAAA=
X-CMS-MailID: 20190129155758eucas1p13ee7f9bf17b10d104e198770fa8a9122
X-Msg-Generator: CA
X-RootMTR: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96@eucas1p1.samsung.com>
 <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
 <d6cbbeac-c15f-91b8-caf3-b22b8715665a@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_075804_851587_F4D56881 
X-CRM114-Status: GOOD (  20.54  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, b.zolnierkie@samsung.com,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 Rob Herring <robh+dt@kernel.org>, myungjoo.ham@samsung.com,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDEvMjkvMTkgMTo1NCBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBUaGlzIHBhdGNoc2V0IGRvbid0IGNvbnRhaW4gdGhlIGNvdmVyLWxldHRl
ci4gUGxlYXNlIHNlbmQgdGhlCj4gY292ZXItbGV0dGVyIHdoaWNoIGV4cGxhaW5zIHdoYXQgdG8g
ZG8gb24gdGhpcyBwYXRjaHNldC4KPiAKPiBBbmQgaXMgaXQgc3VwcG9ydGluZyBhbGwgRXh5bm9z
NSBmb3IgYm90aCAzMmJpdCg1NDIwLDU0MjIpCj4gYW5kIDY0Yml0KDU0MzMpIG9yIG9ubHkgRXh5
bm9zNTQyeCgzMmJpdCk/IElmIGl0IG9ubHkgc3VwcG9ydAo+IHRoZSBFeHlub3MgNTQyeCBzZXJp
ZXMsIHlvdSBoYXZlIHRvIGNoYW5nZSB0aGUgZHJpdmVyIG5hbWUKPiBmcm9tICdleHlub3M1LWRt
Yy5jJyB0byAnZXh5bm9zNTQyMC1kbWMuYycgb3IgJ2V4eW5vczU0MjItZG1jLmMnCj4gaW4gb3Jk
ZXIgdG8gcHJldmVudCB0aGUgY29uZnVzaW9uIGFjY29yZGluZyB0byB0aGUgZHJpdmVyIG5hbWUu
Ckkgd2lsbCByZW5hbWUgdGhlIGRyaXZlciBmaWxlIHRvIGV4eW5vczU0MjItZG1jLmMgYW5kIHRo
ZSBjb25maWcgZW50cnkuCldoZW4gdGhlIGRyaXZlciB3aWxsIGdldCBzdXBwb3J0IGZvciBFeHlu
b3M1NDMzLCB0aGUgZmlsZSBuYW1lIHdvdWxkCmhhdmUgdG8gYmUgY2hhbmdlZCBhZ2Fpbi4KClJl
Z2FyZHMsCkx1a2FzegoKPiAKPiAKPiBPbiAxOS4gMS4gMjkuIOyYpOyghCA0OjIxLCBMdWthc3og
THViYSB3cm90ZToKPj4gRGVmaW5lIG5ldyBJRHMgZm9yIGNsb2NrcyB1c2VkIGJ5IER5bmFtaWMg
TWVtb3J5IENvbnRyb2xsZXIgaW4KPj4gRXh5bm9zNTQyMiBTb0MuCj4+Cj4+IENDOiBTeWx3ZXN0
ZXIgTmF3cm9ja2kgPHMubmF3cm9ja2lAc2Ftc3VuZy5jb20+Cj4+IENDOiBDaGFud29vIENob2kg
PGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4gQ0M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+Cj4+IENDOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+PiBDQzog
S3VramluIEtpbSA8a2dlbmVAa2VybmVsLm9yZz4KPj4gQ0M6IEtyenlzenRvZiBLb3psb3dza2kg
PGtyemtAa2VybmVsLm9yZz4KPj4gQ0M6IGxpbnV4LXNhbXN1bmctc29jQHZnZXIua2VybmVsLm9y
Zwo+PiBDQzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPj4gQ0M6IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+PiBDQzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zwo+PiBTaWduZWQtb2ZmLWJ5OiBMdWthc3ogTHViYSA8bC5sdWJhQHBhcnRuZXIuc2Ftc3VuZy5j
b20+Cj4+IC0tLQo+PiAgIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQyMC5oIHwg
MTggKysrKysrKysrKysrKysrKystCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3Mv
Y2xvY2svZXh5bm9zNTQyMC5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDIw
LmgKPj4gaW5kZXggMzU1ZjQ2OS4uMTgyN2E2NCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9leHlub3M1NDIwLmgKPj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9leHlub3M1NDIwLmgKPj4gQEAgLTYwLDYgKzYwLDcgQEAKPj4gICAjZGVmaW5lIENMS19N
QVVfRVBMTAkJMTU5Cj4+ICAgI2RlZmluZSBDTEtfU0NMS19IU0lDXzEyTQkxNjAKPj4gICAjZGVm
aW5lIENMS19TQ0xLX01QSFlfSVhUQUwyNAkxNjEKPj4gKyNkZWZpbmUgQ0xLX1NDTEtfQlBMTAkJ
MTYyCj4+ICAgCj4+ICAgLyogZ2F0ZSBjbG9ja3MgKi8KPj4gICAjZGVmaW5lIENMS19VQVJUMAkJ
MjU3Cj4+IEBAIC0xOTUsNiArMTk2LDE2IEBACj4+ICAgI2RlZmluZSBDTEtfQUNMSzQzMl9DQU0J
CTUxOAo+PiAgICNkZWZpbmUgQ0xLX0FDTEtfRkwxNTUwX0NBTQk1MTkKPj4gICAjZGVmaW5lIENM
S19BQ0xLNTUwX0NBTQkJNTIwCj4+ICsjZGVmaW5lIENMS19DTEtNX1BIWTAJCTUyMQo+PiArI2Rl
ZmluZSBDTEtfQ0xLTV9QSFkxCQk1MjIKPj4gKyNkZWZpbmUgQ0xLX0FDTEtfUFBNVV9EUkVYMF8w
CTUyMwo+PiArI2RlZmluZSBDTEtfQUNMS19QUE1VX0RSRVgwXzEJNTI0Cj4+ICsjZGVmaW5lIENM
S19BQ0xLX1BQTVVfRFJFWDFfMAk1MjUKPj4gKyNkZWZpbmUgQ0xLX0FDTEtfUFBNVV9EUkVYMV8x
CTUyNgo+PiArI2RlZmluZSBDTEtfUENMS19QUE1VX0RSRVgwXzAJNTI3Cj4+ICsjZGVmaW5lIENM
S19QQ0xLX1BQTVVfRFJFWDBfMQk1MjgKPj4gKyNkZWZpbmUgQ0xLX1BDTEtfUFBNVV9EUkVYMV8w
CTUyOQo+PiArI2RlZmluZSBDTEtfUENMS19QUE1VX0RSRVgxXzEJNTMwCj4+ICAgCj4+ICAgLyog
bXV4IGNsb2NrcyAqLwo+PiAgICNkZWZpbmUgQ0xLX01PVVRfSERNSQkJNjQwCj4+IEBAIC0yMTcs
NiArMjI4LDEwIEBACj4+ICAgI2RlZmluZSBDTEtfTU9VVF9FUExMCQk2NTcKPj4gICAjZGVmaW5l
IENMS19NT1VUX01BVV9FUExMCTY1OAo+PiAgICNkZWZpbmUgQ0xLX01PVVRfVVNFUl9NQVVfRVBM
TAk2NTkKPj4gKyNkZWZpbmUgQ0xLX01PVVRfRFBMTAkJNjYwCj4+ICsjZGVmaW5lIENMS19NT1VU
X0FDTEtfRzNECTY2MQo+PiArI2RlZmluZSBDTEtfTU9VVF9TQ0xLX1NQTEwJNjYyCj4+ICsjZGVm
aW5lIENMS19NT1VUX01YX01TUExMX0NDT1JFX1BIWQk2NjMKPj4gICAKPj4gICAvKiBkaXZpZGVy
IGNsb2NrcyAqLwo+PiAgICNkZWZpbmUgQ0xLX0RPVVRfUElYRUwJCTc2OAo+PiBAQCAtMjQ4LDgg
KzI2Myw5IEBACj4+ICAgI2RlZmluZSBDTEtfRE9VVF9DQ0xLX0RSRVgwCTc5NAo+PiAgICNkZWZp
bmUgQ0xLX0RPVVRfQ0xLMlhfUEhZMAk3OTUKPj4gICAjZGVmaW5lIENMS19ET1VUX1BDTEtfQ09S
RV9NRU0JNzk2Cj4+ICsjZGVmaW5lIENMS19GRl9ET1VUX1NQTEwyCTc5Nwo+PiAgIAo+PiAgIC8q
IG11c3QgYmUgZ3JlYXRlciB0aGFuIG1heGltYWwgY2xvY2sgaWQgKi8KPj4gLSNkZWZpbmUgQ0xL
X05SX0NMS1MJCTc5Nwo+PiArI2RlZmluZSBDTEtfTlJfQ0xLUwkJNzk4Cj4+ICAgCj4+ICAgI2Vu
ZGlmIC8qIF9EVF9CSU5ESU5HU19DTE9DS19FWFlOT1NfNTQyMF9IICovCj4+Cj4gCj4gCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
