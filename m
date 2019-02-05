Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FFCC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD83217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAvUrJea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD83217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yqGM7rkFuhrfqadH7YXvxz1kXcy+YaruCrCvr+pVj3I=; b=UAvUrJeaOW3nsO
	AHAsjvg/n/pt7ZdlCDYyoyVjdUrJUBh5KqHrFubXcY7XrGuChO9lkHEwAUCJsNTvOrjEzZc8Uu2Nw
	sbPX/4nH9KCjJaB1TcwsPZaD55+IaJl2KVs9tGDVnf2xPUYsNjFO0XGDatx4yCfo115d6qnvKBpZA
	/tGy83AvoVWhxa78WBsyEzWUCFStcCDFyx8eNYdaUunkrCGUKEsvYUH0gyowqa5cF0f1kkAJTSVN2
	kkdy2va49270wJn+W2Gct1YAmFanU9W7QWDRsypTlXOx0qk21WVotN8tmjLI+Quoy4HJZdf92ARET
	3Rjp8gYlxvkK11GWpCrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr62t-0000GK-08; Tue, 05 Feb 2019 19:06:11 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr62d-0008Tr-6r; Tue, 05 Feb 2019 19:06:05 +0000
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2EB2760008;
 Tue,  5 Feb 2019 19:05:47 +0000 (UTC)
Date: Tue, 5 Feb 2019 20:05:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next] mtd: rawnand: meson: fix missing assignment of
 ret on a call to meson_chip_buffer_init
Message-ID: <20190205200545.2952f548@xps13>
In-Reply-To: <20190129105757.19138-1-colin.king@canonical.com>
References: <20190129105757.19138-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_110556_954295_EE1A4872 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Liang Yang <liang.yang@amlogic.com>, linux-mtd@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ29saW4sCgpDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+IHdyb3RlIG9u
IFR1ZSwgMjkgSmFuIDIwMTkKMTA6NTc6NTcgKzAwMDA6Cgo+IEZyb206IENvbGluIElhbiBLaW5n
IDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4gCj4gVGhlIGNhbGwgdG8gbWVzb25fY2hpcF9i
dWZmZXJfaW5pdCBpcyBub3QgYXNzaWduaW5nIHJldCwgaG93ZXZlciwgcmV0Cj4gaXMgYmVpbmcg
Y2hlY2tlZCBmb3IgZmFpbHVyZS4gRml4IHRoaXMgYnkgYWRkaW5nIGluIHRoZSBtaXNzaW5nIGFz
c2lnbm1lbnQuCj4gCj4gRml4ZXM6IDJkNTcwYjM0YjQxYSAoIm10ZDogcmF3bmFuZDogbWVzb246
IGFkZCBzdXBwb3J0IGZvciBBbWxvZ2ljIE5BTkQgZmxhc2ggY29udHJvbGxlciIpCj4gU2lnbmVk
LW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jIHwgMiArLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKCk1lcmdlZCBpbiBuYW5kL25l
eHQgd2l0aCB0aGUgb3JpZ2luYWwgY29tbWl0LgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
