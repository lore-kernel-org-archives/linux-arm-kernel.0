Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E819BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:40:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2087206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cT1rhBP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2087206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f0WofL0ZShhhqR8AU/zjUTJ3Qtcxb26PfM3NP7A6L8c=; b=cT1rhBP5fodqGE
	PFc2O0mpMLgSPQCOg4ZitbGgYfz/bZRcP93vHkIu5NCFRuXycFs/VX55FP/O1LNA0lZTrGuzcZOVa
	1icAqy32M/soFz5/t4+vDd6i3W2CPW27farQkhAKXWE2F0Cstt2UptUjYq0CTkqZq1HMsf/ijHK7c
	QK67I6Q6yNd7m9JXqywRLj7hbk0fdaDffSeC8fYB6JHBKgOJ/8VuDEUV6LAWkREChV+ZK3tnSnjAf
	E4qAM+N/xdfeLm2pfJppqkxpLdiDhq/FBxVmtFIjJiPO42EAIDpzPxDvE39EnRGnGuBmH3Y8ixuLv
	w7zFi4FMoAOIq1IsqqKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2eI-00052T-Bd; Fri, 08 Feb 2019 09:40:42 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2eE-000528-7Z
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:40:39 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gs2e8-0008QY-6W; Fri, 08 Feb 2019 10:40:32 +0100
Message-ID: <1549618831.2544.82.camel@pengutronix.de>
Subject: Re: [RFC v2 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q
 compatible
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 08 Feb 2019 10:40:31 +0100
In-Reply-To: <20190208002941.30343-2-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
 <20190208002941.30343-2-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_014038_422590_60FFB290 
X-CRM114-Status: GOOD (  13.72  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDA3LjAyLjIwMTksIDE2OjI5IC0wODAwIHNjaHJpZWIgQW5kcmV5
IFNtaXJub3Y6Cj4gTWFyayBpb211eGNfZ3ByIGFzIGNvbXBhdGlibGUgd2l0aCAiZnNsLGlteDZx
LWlvbXV4Yy1ncHIiIGluIG9yZGVyIGZvcgo+IHRvIGFsbG93IGkuTVg2IFBDSWUgZHJpdmVyIHRv
IHVzZSBpdC4KPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21p
cm5vdkBnbWFpbC5jb20+Cj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KPiBD
YzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPgo+IENjOiBDaHJpcyBIZWFs
eSA8Y3BoZWFseUBnbWFpbC5jb20+Cj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJv
bml4LmRlPgo+IENjOiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPgo+
IENjOiAiQS5zLiBEb25nIiA8YWlzaGVuZy5kb25nQG54cC5jb20+Cj4gQ2M6IFJpY2hhcmQgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4KPiBDYzogbGludXgtaW14QG54cC5jb20KPiBDYzogbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcKCkkgdGhpbmsgdGhhdCdzIHRoZSByaWdodCB0aGluZyB0byBkby4KCkFja2Vk
LWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4gwqBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8IDIgKy0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gaW5kZXggODkyMDYzYTdjMjZjLi5mNmMzN2Jm
OWNiY2UgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1x
LmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+
IEBAIC0yMzAsNyArMjMwLDcgQEAKPiA+IMKgCQkJfTsKPiDCoAo+IMKgCQkJaW9tdXhjX2dwcjog
c3lzY29uQDMwMzQwMDAwIHsKPiAtCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1pb211eGMt
Z3ByIiwgInN5c2NvbiI7Cj4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtaW9tdXhjLWdw
ciIsICJmc2wsaW14NnEtaW9tdXhjLWdwciIsICJzeXNjb24iOwo+IMKgCQkJCXJlZyA9IDwweDMw
MzQwMDAwIDB4MTAwMDA+Owo+IMKgCQkJfTsKPiDCoAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
