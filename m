Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A12214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eoKNxt3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A12214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EuNk/aDWA8477nat3mT7tMKN1I5Yb6/DaFNtAilAgOY=; b=eoKNxt3EOX81TC
	b49Z5NP/ZWhg5WzZ1IpZIp12TCk1eaelbXQd0Aj6EwN5MAqOKTVz9II8iGNTcHJwdPZH/OL2XSMZO
	e2+8L1kx3/s4j0OzuyIG6/j/PDQoec6D5DaQbezW4chSLfAiASDgYihR33rGKiPYDfNt1x9UbZDcS
	ahWbFfvExACf4EkfnU+egQr/d8hZ1CGE4WlUKuO3wIxh/eUGVg3sN7CrURzZv8r0iGUbtChoUnEHi
	dgpdXg9DS1A1mFkQ3oNFY95z2kCTl2/Hy6ZkjCAhkU2GyaEIxABHo3DSbhpkIZUiyLogFgXHiBwLQ
	lL0KrkHiZLyWXj8GiDhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghY8z-0003CH-Ke; Thu, 10 Jan 2019 11:05:01 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghY8w-0003Bm-6O
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 11:04:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CDE97209D7; Thu, 10 Jan 2019 12:04:56 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr
 [109.213.84.72])
 by mail.bootlin.com (Postfix) with ESMTPSA id 94941206DC;
 Thu, 10 Jan 2019 12:04:46 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
Date: Thu, 10 Jan 2019 12:04:46 +0100
In-Reply-To: <20181221164503.5128-1-xypron.glpk@gmx.de> (Heinrich Schuchardt's
 message of "Fri, 21 Dec 2018 17:45:03 +0100")
Message-ID: <874lagpycx.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_030458_374449_7DE1202D 
X-CRM114-Status: GOOD (  18.67  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGVpbnJpY2gsCiAKIE9uIHZlbi4sIGTDqWMuIDIxIDIwMTgsIEhlaW5yaWNoIFNjaHVjaGFy
ZHQgPHh5cHJvbi5nbHBrQGdteC5kZT4gd3JvdGU6Cgo+IFRoZSBtZW1vcnkgYXJlYSBbMHg0MDAw
MDAwLTB4NDIwMDAwMFsgaXMgb2NjdXBpZWQgYnkgdGhlIFBTQ0kgZmlybXdhcmUuIEFueQo+IGF0
dGVtcHQgdG8gYWNjZXNzIGl0IGZyb20gTGludXggbGVhZHMgdG8gYW4gaW1tZWRpYXRlIGNyYXNo
Lgo+Cj4gU28gbGV0J3MgbWFrZSB0aGUgc2FtZSBtZW1vcnkgcmVzZXJ2YXRpb24gYXMgdGhlIHZl
bmRvciBrZXJuZWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXBy
b24uZ2xwa0BnbXguZGU+CgoKQXBwbGllZCBvbiBtdmVidS9maXhlcwoKSSBhZGRlZCBhIGNvbW1l
bnQgYWJvdXQgdGhlIHVzZSB3aXRoIGEgbWFpbmxpbmUgL1UtQm9vdAoKVGhhbmtzLAoKR3JlZ29y
eQoKCj4gLS0tCj4gdjIKPiAJTW92ZSB0aGUgY2hhbmdlIGZyb20gYXJtYWRhLTgwNDAtbWNiaW4u
ZHRzIHRvIGFybWFkYS1hcDgwNi5kdHNpLgo+IAlJIG9ubHkgaGF2ZSBhIE1BQ0NISUFUT2JpbiBm
b3IgdGVzdGluZyBidXQKPiAJaHR0cHM6Ly9naXRodWIuY29tL01hcnZlbGxFbWJlZGRlZFByb2Nl
c3NvcnMvbGludXgtbWFydmVsbAo+IAloYXMgdGhlIHJlc2VydmF0aW9uIGluIHRoYXQgZmlsZS4K
PiAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi5kdHNpIHwg
MTEgKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kKPiBpbmRleCA3
ZDk0YzFmYTU5MmEuLmY4ZGFmZWY4M2RiMCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kKPiBAQCAtMjgsNiArMjgsMTcgQEAKPiAgCQltZXRo
b2QgPSAic21jIjsKPiAgCX07Cj4gIAo+ICsJcmVzZXJ2ZWQtbWVtb3J5IHsKPiArCQkjYWRkcmVz
cy1jZWxscyA9IDwyPjsKPiArCQkjc2l6ZS1jZWxscyA9IDwyPjsKPiArCQlyYW5nZXM7Cj4gKwo+
ICsJCXBzY2ktYXJlYUA0MDAwMDAwIHsKPiArCQkJcmVnID0gPDB4MCAweDQwMDAwMDAgMHgwIDB4
MjAwMDAwPjsKPiArCQkJbm8tbWFwOwo+ICsJCX07Cj4gKwl9Owo+ICsKPiAgCWFwODA2IHsKPiAg
CQkjYWRkcmVzcy1jZWxscyA9IDwyPjsKPiAgCQkjc2l6ZS1jZWxscyA9IDwyPjsKPiAtLSAKPiAy
LjE5LjIKPgoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJlZGRlZCBMaW51eCBhbmQg
S2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
