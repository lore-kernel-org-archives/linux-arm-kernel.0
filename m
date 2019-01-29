Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:35:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC0A20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TVmsRA8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC0A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6rjsdUxc3f40crAPuFb661fLK0zthoQBkQGKxFsnqpU=; b=TVmsRA8OAMKF4j
	BEgmV8Erof7SelkycMoSDPuxWWPTxwRTWKMTV5MfRxKMgLdhvhTz6rtKZtIkUtHhJwd0++7ui3Zng
	4U3ZsPrRAN9ur/zOuathvIcibkszwtg2RTiIxqKRghmW0Xup7/dG507RuwyYD1SheNyEnmyxL3gc2
	NMopEMAbabcDawZdEXwysQTBYG9XUl3G00oJbax5d7w4k3BrOA3TChCmcJFEx0keMNhNae0E+HmPq
	38ssNNCzVzEX4mQzma4qJkb5EfDKo8DCx8fZjaEY5FTRpN8uLWrbv7Qw0YyTPZuNxVDKtZYq3N7Cl
	Yp8SzFB48c8wuXXXjREQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUUH-0007o5-CG; Tue, 29 Jan 2019 14:35:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUUD-0007nl-UU
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:35:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61407A78;
 Tue, 29 Jan 2019 06:35:36 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3197F3F589;
 Tue, 29 Jan 2019 06:35:36 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
 id 81DA8680110; Tue, 29 Jan 2019 14:35:34 +0000 (GMT)
Date: Tue, 29 Jan 2019 14:35:34 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/4] arm64: dts: models: use list instead of tuple for
 mmci interrupts
Message-ID: <20190129143534.GG25147@e110455-lin.cambridge.arm.com>
References: <20190125175606.6607-1-sudeep.holla@arm.com>
 <20190125175606.6607-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125175606.6607-2-sudeep.holla@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_063537_986647_F8A8921C 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMDU6NTY6MDRQTSArMDAwMCwgU3VkZWVwIEhvbGxhIHdy
b3RlOgo+IFJUU00vRlZQIHZleHByZXNzIG1vdGhlcmJvYXJkIG1vZGVsIE1NQ0kgcmVxdWlyZXMg
ZGVkaWNhdGVkIGludGVycnVwdHMKPiBmb3IgQ01EIGFuZCBQSU8sIHdoaWNoIG9idmlvdXNseSBz
aG91bGQgYmUgZXhwcmVzc2VkIGFzIGEgbGlzdC4gQ3VycmVudAo+IGZvcm0gdXNlcyB0dXBsZSBh
bmQgaXQgd29ya3MgZmluZSBzaW5jZSBpbnRlcnJ1cHQtY2VsbHMgZXF1YWwgdG8gMS4KPiAKPiBD
YzogTGl2aXUgRHVkYXUgPGxpdml1LmR1ZGF1QGFybS5jb20+CgpGb3IgdGhlIHJlc3Qgb2YgdGhl
IHNlcmllczoKCkFja2VkLWJ5OiBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT4KCkJl
c3QgcmVnYXJkcywKTGl2aXUKCj4gUmVwb3J0ZWQtYnk6IFZsYWRpbWlyIE11cnppbiA8dmxhZGlt
aXIubXVyemluQGFybS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAu
aG9sbGFAYXJtLmNvbT4KPiAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9hcm0vcnRzbV92ZS1t
b3RoZXJib2FyZC5kdHNpIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9hcm0v
cnRzbV92ZS1tb3RoZXJib2FyZC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcm0vcnRzbV92
ZS1tb3RoZXJib2FyZC5kdHNpCj4gaW5kZXggYjI1ZjNjYmQzZGE4Li4xMDJlOTM3NDRlZGMgMTAw
NjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9hcm0vcnRzbV92ZS1tb3RoZXJib2FyZC5k
dHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcm0vcnRzbV92ZS1tb3RoZXJib2FyZC5k
dHNpCj4gQEAgLTg2LDcgKzg2LDcgQEAKPiAgCQkJCW1tY2lANTAwMDAgewo+ICAJCQkJCWNvbXBh
dGlibGUgPSAiYXJtLHBsMTgwIiwgImFybSxwcmltZWNlbGwiOwo+ICAJCQkJCXJlZyA9IDwweDA1
MDAwMCAweDEwMDA+Owo+IC0JCQkJCWludGVycnVwdHMgPSA8OSAxMD47Cj4gKwkJCQkJaW50ZXJy
dXB0cyA9IDw5PiwgPDEwPjsKPiAgCQkJCQljZC1ncGlvcyA9IDwmdjJtX3N5c3JlZyAwIDA+Owo+
ICAJCQkJCXdwLWdwaW9zID0gPCZ2Mm1fc3lzcmVnIDEgMD47Cj4gIAkJCQkJbWF4LWZyZXF1ZW5j
eSA9IDwxMjAwMDAwMD47Cj4gLS0gCj4gMi4xNy4xCj4gCgotLSAKPT09PT09PT09PT09PT09PT09
PT0KfCBJIHdvdWxkIGxpa2UgdG8gfAp8IGZpeCB0aGUgd29ybGQsICB8CnwgYnV0IHRoZXkncmUg
bm90IHwKfCBnaXZpbmcgbWUgdGhlICAgfAogXCBzb3VyY2UgY29kZSEgIC8KICAtLS0tLS0tLS0t
LS0tLS0KICAgIMKvXF8o44OEKV8vwq8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
