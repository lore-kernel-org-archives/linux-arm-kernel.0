Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E652520896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sFfQ560f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E652520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XpgIkh+TthSvU9603pJx7NN/WkA5zJV7lhOI7No7XyQ=; b=sFfQ560fLE+BWI
	imRsQrLTdiXhw/AaryNU7W84rsVCoDAA+dqIHpvipKhRSACiIWtzamKki3R5RjKCC8V7xypio8KE3
	YpZU8LDZ81Zmb1e5Zcp1VlwCbzUETK3bs0wIKt/PqjGAZXBlhHOslqTsN3dNi96zkzPnGcUBQQNJe
	YIEmX4EvJzNbrpo//3Lbdsy45B7q/O/dLylQKAW8sLn0keXRSC0RNt4/+ehNqZXK5WprzrBUSuWcB
	yX/QpczEHn6t2sK9/S+F80CL87hsZHhjvLfhQXyW2cYMTKTl0dDBr9ZItQbaixpC+m7PzZJQYxif7
	GGXIAs5or99uRJsYIIgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUso-00084Y-F4; Fri, 18 Jan 2019 14:12:30 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUsl-00083u-2L
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:12:28 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gkUsY-0002Rx-E9; Fri, 18 Jan 2019 15:12:14 +0100
Message-ID: <1547820733.2626.11.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: imx6q: add pmu interrupt-affinity
From: Lucas Stach <l.stach@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org, s.hauer@pengutronix.de
Date: Fri, 18 Jan 2019 15:12:13 +0100
In-Reply-To: <20190118135907.2336-1-stefan@agner.ch>
References: <20190118135907.2336-1-stefan@agner.ch>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_061227_269587_A7578371 
X-CRM114-Status: GOOD (  13.80  )
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
Cc: max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, dev@pschenker.ch, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDE4LjAxLjIwMTksIDE0OjU5ICswMTAwIHNjaHJpZWIgU3RlZmFuIEFn
bmVyOgo+IEV4cGxpY2l0bHkgc3BlY2lmeSBpbnRlcnJ1cHQgYWZmaW5pdHkgdG8gYXZvaWQgSFcg
cGVyZmV2ZW50cwo+IG5lZWQgdG8gZ3Vlc3MuIFRoaXMgYXZvaWRzIHRoZSBmb2xsb3dpbmcgZXJy
b3IgdXBvbiBib290Ogo+IMKgIGh3IHBlcmZldmVudHM6IG5vIGludGVycnVwdC1hZmZpbml0eSBw
cm9wZXJ0eSBmb3IgL3BtdSwgZ3Vlc3NpbmcuCj4gCkJ1dCB0aGVuIGl0IGlzbid0IGNvcnJlY3Qg
ZWl0aGVyIEFGQUlDUy4gT24gaS5NWDYgYWxsIHRoZSBQTVUgSVJRcyBhcmUKT1JlZCB0b2dldGhl
ciBpbnRvIGEgc2luZ2xlIFNQSSwgaW5zdGVhZCBvZiBlYWNoIGNvcmUgZGVhbGluZyB3aXRoIGl0
cwpvd24gUFBJLiBTbyBwcmV0ZW5kaW5nIHRoYXQgdGhlcmUgYXJlIG1vcmUgSVJRcyB3aXRoIGFm
ZmluaXR5IHRvIGVhY2gKY29yZSBpc24ndCB0aGUgcmlnaHQgdGhpbmcgdG8gZG8sIG5vPwoKUmVn
YXJkcywKTHVjYXMKCj4gU3BlY2lmeWluZyBhbGwgZm91ciBDUFVzIHNob3dzIG5vIGF2ZXJzaXZl
IGVmZmVjdHMgb24gaS5NWCA2RHVhbAo+IFNvQ3MuCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gQWduZXIgPHN0ZWZhbkBhZ25lci5jaD4KPiAtLS0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxLmR0c2kgfCA3ICsrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykK
PiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxLmR0c2kKPiBpbmRleCA4MzgxZDI0ZWZmN2QuLmQyYzE5NzdjOGIxNiAx
MDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpCj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnEuZHRzaQo+IEBAIC01MzcsNiArNTM3LDEzIEBACj4gPiDCoAkJCTww
eDI4IDB4MDAwMDAwMGM+OyAvKiBEQ0lDMl9NVVhfQ1RMICovCj4gwqB9Owo+IMKgCj4gKyZwbXUg
ewo+ID4gPiArCWludGVycnVwdC1hZmZpbml0eSA9IDwmey9jcHVzL2NwdUAwfT4sCj4gPiA+ICsJ
CQnCoMKgwqDCoMKgPCZ7L2NwdXMvY3B1QDF9PiwKPiA+ID4gKwkJCcKgwqDCoMKgwqA8JnsvY3B1
cy9jcHVAMn0+LAo+ID4gPiArCQkJwqDCoMKgwqDCoDwmey9jcHVzL2NwdUAzfT47Cj4gK307Cj4g
Kwo+IMKgJnZwdSB7Cj4gPiDCoAljb21wYXRpYmxlID0gImZzbCxpbXg2cS12cHUiLCAiY25tLGNv
ZGE5NjAiOwo+IMKgfTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
