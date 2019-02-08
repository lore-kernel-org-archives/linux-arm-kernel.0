Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:12:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5814206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OvX31jG6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIjR52MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5814206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OCSFf106cgAJyIOQ/VnVBJiYVoXdaLO4TPbhIgxGbks=; b=OvX31jG6O+0/wm
	FElSBOZMHab5Sr1lqKCP+MkQgKaEFiLjLJ9mCPS8mL//uddYxlH40Du6H09duA0/U8BQi9/f8kAmi
	OAg8sG9dRFK2i5v8QS02nnnMR30MrfUBAu8t2bRAzbLotuqkcbGa6cHT0nRZNMOBFOPfoW2JttIM1
	GMTwHpxFlXjynKudqeeLYoE8z7LYGS3aiQbKVIWd87O52wapMJEVQNodwjhKahyBW527d39REVpWM
	LpVfZXrpEzS62weaYc0SKeu6u0bzhpJO4LjDMtZopv+5NJOThuNCJGq6AaCWl4tOvDtHklywbX/JS
	nwOE9d2so3IOrNlNXWIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs38h-0005PL-NK; Fri, 08 Feb 2019 10:12:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs38f-0005EN-UA
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 10:12:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qIH/AcyUSPZCEL+1IcZ3vupatyGgtwTIsLSJ1vI95Wg=; b=aIjR52MS6NQs6YBZw2fp2l/lbt
 O5diOQ5O9OF2CzWgRf5X4P4TwevWQ2/aqeLW7DL3x3o70Xi2zlkigcDBcpOzhPSYBkrBloYklsVDg
 qOjfB+2Nw2uC8OgSlIAJQHF56Rw+8SHfq5txPacg0kdJVd94015K5sir40Xfo7jdaOO+/vSFowaXD
 sjundzID/3by18PT429mQtsn634SKZ9+1D4RpZpa/p0V6bX7U5nJplUg7mt6YbmXwbGhmNmUeUmSo
 /2T1E9rfjLERv+9M5SvN8C+de3NC18DbgYfJee86ziGGp8YLUsXacCN2gk7pRTEYG+7A8znqGp/gU
 hKcNNgYg==;
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2rc-0004HM-B8
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:54:32 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gs2rU-0001QD-KN; Fri, 08 Feb 2019 10:54:20 +0100
Message-ID: <1549619660.2544.89.camel@pengutronix.de>
Subject: Re: [RFC v2 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 08 Feb 2019 10:54:20 +0100
In-Reply-To: <20190208002941.30343-6-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
 <20190208002941.30343-6-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_095428_541034_FF457A21 
X-CRM114-Status: GOOD (  16.24  )
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
IFNtaXJub3Y6Cj4gRW5hYmxlIFBDSUUwIGludGVyZmFjZSBjb25uZWN0ZWQgdG8gQkNNNDM1NiBX
aUZpL0JsdWV0b290aCBtb2R1bGUuCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU21pcm5v
diA8YW5kcmV3LnNtaXJub3ZAZ21haWwuY29tPgo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtl
cm5lbC5vcmc+Cj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4KPiBD
YzogQ2hyaXMgSGVhbHkgPGNwaGVhbHlAZ21haWwuY29tPgo+IENjOiBMdWNhcyBTdGFjaCA8bC5z
dGFjaEBwZW5ndXRyb25peC5kZT4KPiBDYzogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0
ZXpAbnhwLmNvbT4KPiBDYzogIkEucy4gRG9uZyIgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+IENj
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+Cj4gQ2M6IGxpbnV4LWlteEBueHAu
Y29tCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyB8IDM0ICsrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gaW5kZXggNjRhY2NjYzRiZmNiLi4yMGFmZGI5ZmZk
ZDkgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2
ay5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0
cwo+IEBAIC0zMSw2ICszMSwxMiBAQAo+IMKgCQlncGlvID0gPCZncGlvMiAxOSBHUElPX0FDVElW
RV9ISUdIPjsKPiDCoAkJZW5hYmxlLWFjdGl2ZS1oaWdoOwo+IMKgCX07Cj4gKwo+ICsJcGNpZTBf
cmVmY2xrOiBwY2llMC1yZWZjbGsgewo+ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOwo+
ICsJCSNjbG9jay1jZWxscyA9IDwwPjsKPiArCQljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwMDAw
PjsKPiArCX07Cj4gwqB9Owo+IMKgCj4gwqAmZmVjMSB7Cj4gQEAgLTQwLDYgKzQ2LDE0IEBACj4g
PiDCoAlzdGF0dXMgPSAib2theSI7Cj4gwqB9Owo+IMKgCj4gKyZncGlvNSB7Cj4gK8KgCXdsLXJl
Zy1vbiB7Cj4gKwkJZ3Bpby1ob2c7Cj4gKwkJZ3Bpb3MgPSA8MjkgR1BJT19BQ1RJVkVfSElHSD47
Cj4gKwkJb3V0cHV0LWhpZ2g7Cj4gKwl9Owo+ICt9Owo+ICsKPiDCoCZpMmMxIHsKPiA+IMKgCWNs
b2NrLWZyZXF1ZW5jeSA9IDwxMDAwMDA+Owo+ID4gwqAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsKPiBAQCAtMTMxLDYgKzE0NSwxOCBAQAo+ID4gwqAJfTsKPiDCoH07Cj4gwqAKPiArJnBjaWUw
IHsKPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfcGNpZTA+Owo+ICsJcmVzZXQtZ3BpbyA9IDwmZ3BpbzUgMjggR1BJT19BQ1RJVkVfTE9XPjsK
PiArCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUENJRTFfUk9PVD4sCj4gKwkJwqA8JmNsayBJ
TVg4TVFfQ0xLX1BDSUUxX0FVWD4sCj4gKwkJwqA8JmNsayBJTVg4TVFfQ0xLX1BDSUUxX1BIWT4s
Cj4gKwkJwqA8JnBjaWUwX3JlZmNsaz47Cj4gKwljbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVf
YXV4IiwgInBjaWVfcGh5IiwgInBjaWVfYnVzIjsKPiArCXN0YXR1cyA9ICJva2F5IjsKPiArfTsK
CkZyb20gYSBQQ0llIFBvViBJIHRoaW5rIHRoaXMgaXMgZmluZS4gUGxlYXNlIHNlbmQgYSBwYXRj
aCBmb3IgdGhlIFBDSWUKZHJpdmVyIHRvIHVzZSB0aGUgcGNpZV9hdXggY2xvY2suCgo+ICsKPiDC
oCZ1YXJ0MSB7Cj4gwqAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiDCoAlwaW5jdHJsLTAg
PSA8JnBpbmN0cmxfdWFydDE+Owo+IEBAIC0xOTUsNiArMjIxLDE0IEBACj4gwqAJCT47Cj4gwqAJ
fTsKPiDCoAo+ICsJcGluY3RybF9wY2llMDogcGNpZTBncnAgewo+ICsJCWZzbCxwaW5zID0gPAo+
ICsJCQlNWDhNUV9JT01VWENfSTJDNF9TQ0xfUENJRTFfQ0xLUkVRX0IJCTB4NzYKPiArCQkJTVg4
TVFfSU9NVVhDX1VBUlQ0X1RYRF9HUElPNV9JTzI5CQkweDE2CgpTaG91bGRuJ3QgdGhpcyBHUElP
IGJlIHNlcGFyYXRlZCBpbiBhIHBpbmN0cmwgZ3JvdXAgZm9yIGdwaW81PwoKPiArCQkJTVg4TVFf
SU9NVVhDX1VBUlQ0X1JYRF9HUElPNV9JTzI4CQkweDE2Cj4gKwkJPjsKPiArCX07Cj4gKwo+IMKg
CXBpbmN0cmxfcmVnX3VzZGhjMjogcmVndXNkaGMyZ3JwZ3BpbyB7Cj4gwqAJCWZzbCxwaW5zID0g
PAo+IMKgCQkJTVg4TVFfSU9NVVhDX1NEMl9SRVNFVF9CX0dQSU8yX0lPMTkJCTB4NDEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
