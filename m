Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAAFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:47:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA91218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AwFVOwl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA91218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QNn3WjJLrlpRHcTIkTY9YeFOhU6SPHMYuonNPOynJBo=; b=AwFVOwl+UtFaI6
	whn3ptAiHytLm62HZt3QfWdcj1GuqRKMHHzGcWU2ajYAfLL/ZZ8Chfpo60chgf2OH3ZketQIk2lEb
	Ar70cieP+J7vQ3+tvtTURRvJnljNINm9C2fPt/xpTp0nz3ucZQ/3Z5fwWuO/7++ndgoJaHX3MXUUs
	3yc9+W7fapb5pA4c0vuwaoAY+DLvqG762e446JZYs8S56m/GKMHuRAUkiW1UYkfZdqFEFxNTiIkQd
	tSmmTrQP5f0hJDgWUbvYGy9bkX8s11YBHQgggM56PTm+5IqKttINkBdmJdTRS5RqWsheibJ8PhaOR
	TW5PSemcdRdHVWm1gZBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2kl-0000x3-9x; Fri, 08 Feb 2019 09:47:23 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2kh-0000wV-Of
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:47:21 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gs2kb-0000fu-LA; Fri, 08 Feb 2019 10:47:13 +0100
Message-ID: <1549619233.2544.87.camel@pengutronix.de>
Subject: Re: [RFC v2 4/5] arm64: dts: imx8mq: Add nodes for PCIe IP blocks
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 08 Feb 2019 10:47:13 +0100
In-Reply-To: <20190208002941.30343-5-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
 <20190208002941.30343-5-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_014719_963936_210BEF4B 
X-CRM114-Status: GOOD (  13.41  )
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
IFNtaXJub3Y6Cj4gQWRkIG5vZGVzIGZvciB0d28gUENJZSBjb250cm9sbGVycyBmb3VuZCBvbiBp
Lk1YOE1RLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNtaXJub3YgPGFuZHJldy5zbWly
bm92QGdtYWlsLmNvbT4KPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Cj4g
PiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPgo+ID4gQ2M6IENocmlz
IEhlYWx5IDxjcGhlYWx5QGdtYWlsLmNvbT4KPiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBw
ZW5ndXRyb25peC5kZT4KPiA+IENjOiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBu
eHAuY29tPgo+ID4gQ2M6ICJBLnMuIERvbmciIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPiA+IENj
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+Cj4gQ2M6IGxpbnV4LWlteEBueHAu
Y29tCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCgpPbmUgbWlub3IgdGhpbmcgYmVsb3csIG90aGVyd2lz
ZToKClJldmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4g
LS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8IDU4ICsr
KysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygr
KQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEu
ZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gaW5kZXgg
ODliYWJjNTMxMzgwLi44Y2VhYjc0OGVkMDQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQo+IEBAIC02LDYgKzYsNyBAQAo+IMKgCj4gwqAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvY2xvY2svaW14OG1xLWNsb2NrLmg+Cj4gwqAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcG93ZXIvaW14OG1xLXBvd2VyLmg+Cj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9p
bXg4bXEtcmVzZXQuaD4KPiDCoCNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4KPiDC
oCNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+Cj4g
wqAjaW5jbHVkZSAiaW14OG1xLXBpbmZ1bmMuaCIKPiBAQCAtNTM5LDYgKzU0MCw2MyBAQAo+ID4g
wqAJCQl9Owo+ID4gwqAJCX07Cj4gwqAKPiA+ID4gKwkJcGNpZTA6IHBjaWVAMzM4MDAwMDAgewo+
ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1wY2llIjsKPiA+ICsJCQlyZWcgPSA8MHgz
MzgwMDAwMCAweDQwMDAwMD4sCj4gPiArCQkJwqDCoMKgwqDCoMKgPDB4MWZmMDAwMDAgMHg4MDAw
MD47Cj4gPiArCQkJcmVnLW5hbWVzID0gImRiaSIsICJjb25maWciOwo+ID4gKwkJCSNhZGRyZXNz
LWNlbGxzID0gPDM+Owo+ID4gKwkJCSNzaXplLWNlbGxzID0gPDI+Owo+ID4gKwkJCWRldmljZV90
eXBlID0gInBjaSI7Cj4gPiArCQkJYnVzLXJhbmdlID0gPDB4MDAgMHhmZj47Cj4gPiArCQkJcmFu
Z2VzID0gPDB4ODEwMDAwMDAgMCAweDAwMDAwMDAwIDB4MWZmODAwMDAgMCAweDAwMDEwMDAwIC8q
IGRvd25zdHJlYW0gSS9PIDY0S0IgKi8KPiA+ICsJCQnCoMKgwqDCoMKgwqDCoMKgwqDCoDB4ODIw
MDAwMDAgMCAweDE4MDAwMDAwIDB4MTgwMDAwMDAgMCAweDA3ZjAwMDAwPjsgLyogbm9uLXByZWZl
dGNoYWJsZSBtZW1vcnkgKi8KPiA+ICsJCQludW0tbGFuZXMgPSA8MT47Cj4gPiArCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDEyMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiA+ICsJCQlpbnRlcnJ1
cHQtbmFtZXMgPSAibXNpIjsKPiA+ICsJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Owo+ID4gKwkJ
CWludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCAweDc+Owo+ID4gKwkJCWludGVycnVwdC1tYXAg
PSA8MCAwIDAgMSAmZ2ljIEdJQ19TUEkgMTI1IElSUV9UWVBFX0xFVkVMX0hJR0g+LAo+ID4gKwkJ
CcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPDAgMCAwIDIgJmdpYyBHSUNfU1BJIDEy
NCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiA+ICsJCQnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDwwIDAgMCAzICZnaWMgR0lDX1NQSSAxMjMgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4g
PiArCQkJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8MCAwIDAgNCAmZ2ljIEdJQ19T
UEkgMTIyIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCWZzbCxtYXgtbGluay1zcGVlZCA9
IDwyPjsKPiA+ICsJCQlwb3dlci1kb21haW5zID0gPCZwZ2NfcGNpZT47Cj4gPiArCQkJcmVzZXRz
ID0gPCZzcmMgSU1YOE1RX1JFU0VUX1BDSUVQSFk+LAo+ID4gKwkJCcKgwqDCoMKgwqDCoMKgwqDC
oDwmc3JjIElNWDhNUV9SRVNFVF9QQ0lFX0NUUkxfQVBQU19FTj4sCj4gPiArCQkJwqDCoMKgwqDC
oMKgwqDCoMKgPCZzcmMgSU1YOE1RX1JFU0VUX1BDSUVfQ1RSTF9BUFBTX1RVUk5PRkY+Owo+ID4g
KwkJCXJlc2V0LW5hbWVzID0gInBjaWVwaHkiLCAiYXBwcyIsICJ0dXJub2ZmIjsKPiA+ICsJCQlz
dGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gKwkJfTsKPiArCj4gKwkJcGNpZTE6IHBjaWVAMHgzM2Mw
MDAwMCB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCk5vZGUgbmFtZSBzaG91bGQgbm90
IGhhdmUgdGhlIGhleCBwcmVmaXggaW4gdGhlIGFkZHJlc3MuCgo+ICsJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXEtcGNpZSI7Cj4gPiArCQkJcmVnID0gPDB4MzNjMDAwMDAgMHg0MDAwMDA+LAo+
ID4gKwkJCcKgwqDCoMKgwqDCoDwweDI3ZjAwMDAwIDB4ODAwMDA+Owo+ID4gKwkJCXJlZy1uYW1l
cyA9ICJkYmkiLCAiY29uZmlnIjsKPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsKPiA+ICsJ
CQkjc2l6ZS1jZWxscyA9IDwyPjsKPiA+ICsJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwo+ID4gKwkJ
CXJhbmdlcyA9wqDCoDwweDgxMDAwMDAwIDAgMHgwMDAwMDAwMCAweDI3ZjgwMDAwIDAgMHgwMDAx
MDAwMCAvKiBkb3duc3RyZWFtIEkvTyA2NEtCICovCj4gPiArCQkJCcKgwqDCoDB4ODIwMDAwMDAg
MCAweDIwMDAwMDAwIDB4MjAwMDAwMDAgMCAweDA3ZjAwMDAwPjsgLyogbm9uLXByZWZldGNoYWJs
ZSBtZW1vcnkgKi8KPiA+ICsJCQludW0tbGFuZXMgPSA8MT47Cj4gPiArCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDc0IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCWludGVycnVwdC1uYW1l
cyA9ICJtc2kiOwo+ID4gKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47Cj4gPiArCQkJaW50ZXJy
dXB0LW1hcC1tYXNrID0gPDAgMCAwIDB4Nz47Cj4gPiArCQkJaW50ZXJydXB0LW1hcCA9IDwwIDAg
MCAxICZnaWMgR0lDX1NQSSA3NyBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiA+ICsJCQkJCTwwIDAg
MCAyICZnaWMgR0lDX1NQSSA3NiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiA+ICsJCQkJCTwwIDAg
MCAzICZnaWMgR0lDX1NQSSA3NSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiA+ICsJCQkJCTwwIDAg
MCA0ICZnaWMgR0lDX1NQSSA3NCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiA+ICsJCQlmc2wsbWF4
LWxpbmstc3BlZWQgPSA8Mj47Cj4gPiArCQkJcG93ZXItZG9tYWlucyA9IDwmcGdjX3BjaWU+Owo+
ID4gKwkJCXJlc2V0cyA9IDwmc3JjIElNWDhNUV9SRVNFVF9QQ0lFUEhZMj4sCj4gPiArCQkJwqDC
oMKgwqDCoMKgwqDCoMKgPCZzcmMgSU1YOE1RX1JFU0VUX1BDSUUyX0NUUkxfQVBQU19FTj4sCj4g
PiArCQkJwqDCoMKgwqDCoMKgwqDCoMKgPCZzcmMgSU1YOE1RX1JFU0VUX1BDSUUyX0NUUkxfQVBQ
U19UVVJOT0ZGPjsKPiA+ICsJCQlyZXNldC1uYW1lcyA9ICJwY2llcGh5IiwgImFwcHMiLCAidHVy
bm9mZiI7Cj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsJCX07Cj4gKwo+ID4gPiDC
oAkJZ2ljOiBpbnRlcnJ1cHQtY29udHJvbGxlckAzODgwMDAwMCB7Cj4gPiDCoAkJCWNvbXBhdGli
bGUgPSAiYXJtLGdpYy12MyI7Cj4gPiA+IMKgCQkJcmVnID0gPDB4Mzg4MDAwMDAgMHgxMDAwMD4s
CS8qIEdJQyBEaXN0ICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
