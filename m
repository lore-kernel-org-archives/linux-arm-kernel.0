Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CECCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE0E21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mcb/lghM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE0E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wU1PJodYBWVbTozLGzmIB0R5j4qf2NIB/C59hPisNf4=; b=Mcb/lghMRCQpw/
	0qbqsxBHcP6/yMPdvWuegjDKrr5c+yZ/nA6WNT2W0SeEkHmdL490iF4iTGDfKhe+EGabvX0B3BOLi
	hoC8ZDBFZc9LkZqjvFO3xSusPC8hsUycalK6549GoMm+RmfS0N951IRFLWTnU1x3iLYiUQIbQ8Glt
	exPHlE5cK5JwT2RLGWeKi+5K8zoL6grEMRQRUEDk+U9RYSItbyKgq9CO66KDQVsk7ljyFIoJl6X3/
	RQRnXPIsz+KMGr9Pwmql4encl7kAJnWcahgGIm81O6FEo2I76mr1sdNm6GVAex3aeCyL3hTHfspK7
	pSNe+NczaA6lv+SweqQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZC6r-0004oD-De; Tue, 18 Dec 2018 09:56:17 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZC6o-0004cg-1E
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:56:15 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5BC7C20824; Tue, 18 Dec 2018 10:56:00 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2A6BA20717;
 Tue, 18 Dec 2018 10:55:50 +0100 (CET)
Date: Tue, 18 Dec 2018 10:55:50 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] clk: at91: enable AUDIOPLL as source for PCKx
Message-ID: <20181218095550.GW19816@piout.net>
References: <e07fdef0c9a959a6e820a040048e9ab5b7aec9d2.1545075103.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e07fdef0c9a959a6e820a040048e9ab5b7aec9d2.1545075103.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_015614_210545_4CD56D63 
X-CRM114-Status: GOOD (  12.65  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpPbiAxNy8xMi8yMDE4IDIwOjM3OjA0KzAxMDAsIE1pY2hhxYIgTWlyb3PFgmF3IHdy
b3RlOgo+IFNBTUE1RDJ4IGhhdmUgNiBzb3VyY2VzLCB0aGUgbGFzdCBiZWluZyBBVURJT1BMTC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9zxYJhdyA8bWlycS1saW51eEByZXJlLnFt
cW0ucGw+Cj4gLS0tCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaSB8IDIgKy0KPiAg
ZHJpdmVycy9jbGsvYXQ5MS9kdC1jb21wYXQuYyAgIHwgMiArLQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNp
Cj4gaW5kZXggZGQwZGRhNmVkNDRiLi42YzhjMTVjMzYzZTQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVk
Mi5kdHNpCj4gQEAgLTUyNiw3ICs1MjYsNyBAQAo+ICAJCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+
Owo+ICAJCQkJCSNzaXplLWNlbGxzID0gPDA+Owo+ICAJCQkJCWludGVycnVwdC1wYXJlbnQgPSA8
JnBtYz47Cj4gLQkJCQkJY2xvY2tzID0gPCZjbGszMms+LCA8Jm1haW4+LCA8JnBsbGFkaXY+LCA8
JnV0bWk+LCA8Jm1jaz47Cj4gKwkJCQkJY2xvY2tzID0gPCZjbGszMms+LCA8Jm1haW4+LCA8JnBs
bGFkaXY+LCA8JnV0bWk+LCA8Jm1jaz4sIDwmYXVkaW9fcGxsX3BtYz47CgpUaGlzIHdvbid0IGFw
cGx5IGFzIHNhbWE1ZDIgaGFzIG5vdyBzd2l0Y2ggdG8gdGhlIG5ldyBiaW5kaW5nLiBQbGVhc2UK
Zml4IGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jIGluc3RlYWQuCgo+ICAKPiAgCQkJCQlwcm9n
MDogcHJvZzAgewo+ICAJCQkJCQkjY2xvY2stY2VsbHMgPSA8MD47Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL2F0OTEvZHQtY29tcGF0LmMgYi9kcml2ZXJzL2Nsay9hdDkxL2R0LWNvbXBhdC5j
Cj4gaW5kZXggYjk1YmI0ZTJhOTI3Li4xOWJhZGZjNTFmNTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9jbGsvYXQ5MS9kdC1jb21wYXQuYwo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvZHQtY29tcGF0
LmMKPiBAQCAtMTcsNyArMTcsNyBAQAo+ICAKPiAgI2RlZmluZSBQRVJJUEhFUkFMX0lEX01JTgky
Cj4gIAo+IC0jZGVmaW5lIFBST0dfU09VUkNFX01BWAkJNQo+ICsjZGVmaW5lIFBST0dfU09VUkNF
X01BWAkJNgo+ICAjZGVmaW5lIFBST0dfSURfTUFYCQk3Cj4gIAo+ICAjZGVmaW5lIFNZU1RFTV9N
QVhfSUQJCTMxCj4gLS0gCj4gMi4xOS4yCj4gCgotLSAKQWxleGFuZHJlIEJlbGxvbmksIEJvb3Rs
aW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwczovL2Jvb3RsaW4u
Y29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
