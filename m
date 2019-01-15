Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D533C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:52:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12E020861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b3gR228Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12E020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XUY/72y1oxG+9UXkWzV4HVIoh9NOrYQ2IIhx/BBgFpQ=; b=b3gR228YLQjIK8
	hcGwY8/qWjtWgnRIPeIMpXb8lOqarPLMrPv7dBD++WuJ8gKGyfIcdV21nKdaihQMNg4jIGMeyvsv8
	v8O+3sykNdqkhJjfibOLiMSYyiZNYa63iZ0CgNXB/8ck4Uib4R8YLk4E63ichVLnT1h3u/LKZsUGd
	qsWHEzeSPTu07IGuSQ8WeDHgdjcOgq+Q2NZdxEtDqKAFceIgMlkdeKbfBovBzkZf6+EvGCJRDp6N0
	bLSmYJpgUNqcDIzfNMjI6y7SD5ZK0MrknH6NWX1Jyx2oXKB/cvUZX9jNu8IL0qUfV84i45btZr58M
	Z3CQDLXUObZ6eA1O+54g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNGK-00052p-C7; Tue, 15 Jan 2019 11:52:08 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNGG-00052K-RT
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:52:06 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gjNG9-0002C5-Pl; Tue, 15 Jan 2019 12:51:57 +0100
Message-ID: <1547553117.4339.8.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add system reset controller
From: Lucas Stach <l.stach@pengutronix.de>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
Date: Tue, 15 Jan 2019 12:51:57 +0100
In-Reply-To: <20190115114641.GA15870@bogon.m.sigxcpu.org>
References: <20190115114641.GA15870@bogon.m.sigxcpu.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_035205_044935_91722EA2 
X-CRM114-Status: GOOD (  17.75  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAxNS4wMS4yMDE5LCAxMjo0NiArMDEwMCBzY2hyaWViIEd1aWRvIEfD
vG50aGVyOgo+IFdlIGNhbiByZXVzZSB0aGUgc3JjIGZyb20gZnNsLGlteDUxLXNyYyBhcyB3aXRo
IG90aGVyIGlteCBTT0NzLgoKVGhhdCdzIG5vdCB0cnVlLiBUaGUgU1JDIGlzIHNpZ25pZmljYW50
bHkgZGlmZmVyZW50IGZyb20gdGhlIGkuTVg1MQpvbmUuIFNlZSBzZXJpZXMgIltQQVRDSCB2NCAw
LzNdIFJlc2V0IGNvbnRyb2xsZXIgc3VwcG9ydCBmb3IgaS5NWDhNUSIuCgpXZSBnZW5lcmFsbHkg
ZG9uJ3QgYWRkIHRoZSBEVCBub2RlcyB1bnRpbCBhdCBsZWFzdCB0aGUgYmluZGluZywgYmV0dGVy
CnlldCB0aGUgZnVsbCBkcml2ZXIsIGlzIHVwc3RyZWFtLgoKUmVnYXJkcywKTHVjYXMKCj4gCj4g
PiBTaWduZWQtb2ZmLWJ5OiBHdWlkbyBHw7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPgo+IC0tLQo+
IEknbSBtb3N0bHkgaW50ZXJlc3RlZCBpbiB0aGUgc3lzY29uIHBhcnQgdG8gYmUgYWJsZSB0byB1
c2UgcmVnbWFwIGZvcgo+IE1JUEkgRFNJIGhlcmUuCj4gCj4gUGF0Y2ggaXMgYWdhaW5zdCBuZXh0
LTIwMTkwMTE0IHBsdXMgTHVjYXMgImFybTY0OiBkdHM6IGlteDhtcTogbW92ZQo+IHdhdGNoZG9n
IG5vZGVzIHRvIGNvcnJlY3QgbG9jYXRpb24iIGJ1dCBhbHNvIGFwcGxpZXMgdG8KPiAKPiDCoMKg
wqDCoGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3NoYXdu
Z3VvL2xpbnV4LmdpdC9sb2cvP2g9aW14L2R0NjQKPiAKPiBJdCB3aWxsIGNvbmZsaWN0IHdpdGgg
ImFybTY0OiBkdHM6IGlteDhtcTogYWRkIEdQQyBwb3dlciBkb21haW5zIiB3aGljaAo+IGlzIG5v
dCB5ZXQgaW4gYW55IHRyZWUgSSd2ZSBzZWVuLgo+IAo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1xLmR0c2kgfCA3ICsrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRz
aQo+IGluZGV4IDAyMjVlYWUyMjE2ZS4uN2IxZTBiZGJkOTMyIDEwMDY0NAo+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBAQCAtMjUyLDYgKzI1MiwxMyBAQAo+ID4g
wqAJCQkJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJjbGtfZXh0MSIsICJjbGtfZXh0MiIs
Cj4gPiDCoAkJCQnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgImNsa19leHQzIiwgImNsa19l
eHQ0IjsKPiA+IMKgCQkJfTsKPiArCj4gPiA+ICsJCQlzcmM6IHNyY0AzMDM5MDAwMCB7Cj4gPiAr
CQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1zcmMiLCAiZnNsLGlteDUxLXNyYyIsICJzeXNj
b24iOwo+ID4gKwkJCQlyZWcgPSA8MHgzMDM5MDAwMCAweDEwMDAwPjsKPiA+ICsJCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDg5IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCQkjcmVzZXQt
Y2VsbHMgPSA8MT47Cj4gPiArCQkJfTsKPiA+IMKgCQl9Owo+IMKgCj4gPiDCoAkJYnVzQDMwNDAw
MDAwIHsgLyogQUlQUzIgKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
