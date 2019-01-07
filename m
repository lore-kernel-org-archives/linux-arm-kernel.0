Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:18:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45DC2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OP//8ArE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45DC2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DhPb3hOBtawrfqjwXaUojkNL8ZYJK0Ji5zMsA1J1WQI=; b=OP//8ArEUrRrfq
	IpiceqLoxA2XhquJQ285Q1rTmemdWZDDklfEpax7uebN7oTT75NPM8pKiO1rASlxdBtoc2eyshVtl
	ytOSeOAg7DVVaYaW07xqYBaycNi14wXacg2ISMBM6OC+2s4uFuVBQhRIh7lb0O4U2sMcXqh4REJVx
	ECKdalGCVkH/8GLodkQNtkl39UTQM4TBc1MV7bvWh9vLM0RrGTcuYYLu9IRcWjXb+OHkFrWYWfKsh
	n/P+R6LHteArlg3zorxHIZMaqrML9YILDDITpn7jf6SSG0IH2BqeB0lIKyF9cLwpLBoI7NRrc026d
	wSZesFOEn2mvai4T5J0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggWfC-0002TI-4m; Mon, 07 Jan 2019 15:18:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggWf9-0002So-6l
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 15:18:00 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1ggWf5-000716-TE; Mon, 07 Jan 2019 16:17:55 +0100
Message-ID: <1546874275.3580.18.camel@pengutronix.de>
Subject: Re: [PATCH RESEND] ARM: dts: imx6sx: Add DISPLAY power domain support
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>,  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Mon, 07 Jan 2019 16:17:55 +0100
In-Reply-To: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
References: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_071759_404709_9B4E0328 
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTW9udGFnLCBkZW4gMDcuMDEuMjAxOSwgMTM6MjggKzAwMDAgc2NocmllYiBMZW9uYXJkIENy
ZXN0ZXo6Cj4gVGhpcyB3YXMgaW1wbGVtZW50ZWQgaW4gdGhlIGRyaXZlciBidXQgbm90IGFjdHVh
bGx5IGRlZmluZWQgYW5kCj4gcmVmZXJlbmNlZCBpbiBkdHMuIFRoaXMgbWFrZXMgaXQgYWx3YXlz
IG9uLgo+IAo+IEZyb20gcmVmZXJlbmNlIG1hbnVhbCBpbiBzZWN0aW9uICIxMC40LjEuNC4xIFBv
d2VyIERpc3RyaWJ1dGlvbiI6Cj4gCj4gIkRpc3BsYXkgZG9tYWluIC0gVGhlIERJU1BMQVkgZG9t
YWluIGNvbnRhaW5zIEdJUywgQ1NJLCBQWFAsIExDRElGLAo+IFBDSWUsIERDSUMsIGFuZCBMREIu
IEl0IGlzIHN1cHBsaWVkIGJ5IGludGVybmFsIHJlZ3VsYXRvci4iCj4gCj4gVGhlIGN1cnJlbnQg
cGRfcGNpZSBpcyBhY3R1YWxseSBvbmx5IGZvciBQQ0lFX1BIWSwgdGhlIFBDSUUgaXAgYmxvY2sg
aXMKPiBhY3R1YWxseSBpbnNpZGUgdGhlIERJU1BMQVkgZG9tYWluLiBIYW5kbGUgdGhpcyBieSBh
ZGRpbmcgdGhlIHBjaWUgbm9kZQo+IGluIGJvdGggcG93ZXIgZG9tYWlucy4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPgoKQWNrZWQt
Ynk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKPiAtLS0KPiDCoGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpIHwgMTkgKysrKysrKysrKysrKysrKysrLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBUaGlzIGlz
IHRoZSBsYXN0IHBhcnQgb2YgYSBzZXJpZXMgd2hpY2ggd2FzIHByZXZpb3VzbHkgYWNjZXB0ZWQs
IGl0IHdhcwo+IGRlbGF5ZWQgYmVjYXVzZSBpdCBkZXBlbmRzIG9uIFBDSSBtdWx0aS1wZCBzdXBw
b3J0LiBBbGwgZHJpdmVyCj4gZGVwZW5kZW5jaWVzIGhhdmUgbGFuZGVkIGluIDUuMC1yYzEsIHJl
c2VuZGluZyBmb3IgNS4xIGFzIGRpc2N1c3NlZDoKPiAKPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcGF0Y2h3b3JrL3BhdGNoLzk5NjgxMi8jMTE5MDc0Ngo+IAo+IE9ubHkgY2hhbmdlIGlzIGEg
bWlub3IgY29uZmxpY3Qgd2l0aCByZW1vdmluZyBhIHB4cCBjbGsuCj4gCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4
LmR0c2kKPiBpbmRleCAyNzJmZjYxMzNlYzEuLmVjZjNmM2U1YzBhMCAxMDA2NDQKPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZzeC5kdHNpCj4gQEAgLTc4MywxMCArNzgzLDIyIEBACj4gPiDCoAkJCQkJCSNwb3dlci1kb21h
aW4tY2VsbHMgPSA8MD47Cj4gPiDCoAkJCQkJCXBvd2VyLXN1cHBseSA9IDwmcmVnX3NvYz47Cj4g
PiDCoAkJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U1hfQ0xLX0dQVT47Cj4gPiDCoAkJCQkJfTsK
PiDCoAo+ID4gPiArCQkJCQlwZF9kaXNwOiBwb3dlci1kb21haW5AMiB7Cj4gPiArCQkJCQkJcmVn
ID0gPDI+Owo+ID4gKwkJCQkJCSNwb3dlci1kb21haW4tY2VsbHMgPSA8MD47Cj4gPiArCQkJCQkJ
Y2xvY2tzID0gPCZjbGtzIElNWDZTWF9DTEtfUFhQX0FYST4sCj4gPiArCQkJCQkJCcKgPCZjbGtz
IElNWDZTWF9DTEtfRElTUExBWV9BWEk+LAo+ID4gKwkJCQkJCQnCoDwmY2xrcyBJTVg2U1hfQ0xL
X0xDRElGMV9QSVg+LAo+ID4gKwkJCQkJCQnCoDwmY2xrcyBJTVg2U1hfQ0xLX0xDRElGX0FQQj4s
Cj4gPiArCQkJCQkJCcKgPCZjbGtzIElNWDZTWF9DTEtfTENESUYyX1BJWD4sCj4gPiArCQkJCQkJ
CcKgPCZjbGtzIElNWDZTWF9DTEtfQ1NJPiwKPiA+ICsJCQkJCQkJwqA8JmNsa3MgSU1YNlNYX0NM
S19WQURDPjsKPiA+ICsJCQkJCX07Cj4gKwo+ID4gPiDCoAkJCQkJcGRfcGNpOiBwb3dlci1kb21h
aW5AMyB7Cj4gPiDCoAkJCQkJCXJlZyA9IDwzPjsKPiA+IMKgCQkJCQkJI3Bvd2VyLWRvbWFpbi1j
ZWxscyA9IDwwPjsKPiA+IMKgCQkJCQkJcG93ZXItc3VwcGx5ID0gPCZyZWdfcGNpZT47Cj4gPiDC
oAkJCQkJfTsKPiBAQCAtMTIwMywxMCArMTIxNSwxMSBAQAo+ID4gwqAJCQkJCWNvbXBhdGlibGUg
PSAiZnNsLGlteDZzeC1weHAiLCAiZnNsLGlteDZ1bGwtcHhwIjsKPiA+IMKgCQkJCQlyZWcgPSA8
MHgwMjIxODAwMCAweDQwMDA+Owo+ID4gwqAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4IElS
UV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gwqAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U1hfQ0xL
X1BYUF9BWEk+Owo+ID4gwqAJCQkJCWNsb2NrLW5hbWVzID0gImF4aSI7Cj4gPiArCQkJCQlwb3dl
ci1kb21haW5zID0gPCZwZF9kaXNwPjsKPiA+IMKgCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+
ID4gwqAJCQkJfTsKPiDCoAo+ID4gPiDCoAkJCQljc2kyOiBjc2lAMjIxYzAwMCB7Cj4gPiDCoAkJ
CQkJcmVnID0gPDB4MDIyMWMwMDAgMHg0MDAwPjsKPiBAQCAtMTIyNCwxMCArMTIzNywxMSBAQAo+
ID4gwqAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA1IElSUV9UWVBFX0VER0VfUklTSU5HPjsK
PiA+IMKgCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlNYX0NMS19MQ0RJRjFfUElYPiwKPiA+IMKg
CQkJCQkJwqA8JmNsa3MgSU1YNlNYX0NMS19MQ0RJRl9BUEI+LAo+ID4gwqAJCQkJCQnCoDwmY2xr
cyBJTVg2U1hfQ0xLX0RJU1BMQVlfQVhJPjsKPiA+IMKgCQkJCQljbG9jay1uYW1lcyA9ICJwaXgi
LCAiYXhpIiwgImRpc3BfYXhpIjsKPiA+ICsJCQkJCXBvd2VyLWRvbWFpbnMgPSA8JnBkX2Rpc3A+
Owo+ID4gwqAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiDCoAkJCQl9Owo+IMKgCj4gPiA+
IMKgCQkJCWxjZGlmMjogbGNkaWZAMjIyNDAwMCB7Cj4gPiDCoAkJCQkJY29tcGF0aWJsZSA9ICJm
c2wsaW14NnN4LWxjZGlmIiwgImZzbCxpbXgyOC1sY2RpZiI7Cj4gQEAgLTEyMzUsMTkgKzEyNDks
MjEgQEAKPiA+IMKgCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNiBJUlFfVFlQRV9FREdFX1JJ
U0lORz47Cj4gPiDCoAkJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZTWF9DTEtfTENESUYyX1BJWD4s
Cj4gPiDCoAkJCQkJCcKgPCZjbGtzIElNWDZTWF9DTEtfTENESUZfQVBCPiwKPiA+IMKgCQkJCQkJ
wqA8JmNsa3MgSU1YNlNYX0NMS19ESVNQTEFZX0FYST47Cj4gPiDCoAkJCQkJY2xvY2stbmFtZXMg
PSAicGl4IiwgImF4aSIsICJkaXNwX2F4aSI7Cj4gPiArCQkJCQlwb3dlci1kb21haW5zID0gPCZw
ZF9kaXNwPjsKPiA+IMKgCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gwqAJCQkJfTsKPiDC
oAo+ID4gPiDCoAkJCQl2YWRjOiB2YWRjQDIyMjgwMDAgewo+ID4gwqAJCQkJCXJlZyA9IDwweDAy
MjI4MDAwIDB4NDAwMD4sIDwweDAyMjJjMDAwIDB4NDAwMD47Cj4gPiDCoAkJCQkJcmVnLW5hbWVz
ID0gInZhZGMtdmFmZSIsICJ2YWRjLXZkZWMiOwo+ID4gwqAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJ
TVg2U1hfQ0xLX1ZBREM+LAo+ID4gwqAJCQkJCQnCoDwmY2xrcyBJTVg2U1hfQ0xLX0NTST47Cj4g
PiDCoAkJCQkJY2xvY2stbmFtZXMgPSAidmFkYyIsICJjc2kiOwo+ID4gKwkJCQkJcG93ZXItZG9t
YWlucyA9IDwmcGRfZGlzcD47Cj4gPiDCoAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+IMKg
CQkJCX07Cj4gPiDCoAkJCX07Cj4gwqAKPiA+ID4gwqAJCQlhZGMxOiBhZGNAMjI4MDAwMCB7Cj4g
QEAgLTEzNjgsMTAgKzEzODQsMTEgQEAKPiA+IMKgCQkJY2xvY2tzID0gPCZjbGtzIElNWDZTWF9D
TEtfUENJRV9BWEk+LAo+ID4gwqAJCQkJwqA8JmNsa3MgSU1YNlNYX0NMS19MVkRTMV9PVVQ+LAo+
ID4gwqAJCQkJwqA8JmNsa3MgSU1YNlNYX0NMS19QQ0lFX1JFRl8xMjVNPiwKPiA+IMKgCQkJCcKg
PCZjbGtzIElNWDZTWF9DTEtfRElTUExBWV9BWEk+Owo+ID4gwqAJCQljbG9jay1uYW1lcyA9ICJw
Y2llIiwgInBjaWVfYnVzIiwgInBjaWVfcGh5IiwgInBjaWVfaW5ib3VuZF9heGkiOwo+ID4gLQkJ
CXBvd2VyLWRvbWFpbnMgPSA8JnBkX3BjaT47Cj4gPiArCQkJcG93ZXItZG9tYWlucyA9IDwmcGRf
ZGlzcD4sIDwmcGRfcGNpPjsKPiA+ICsJCQlwb3dlci1kb21haW4tbmFtZXMgPSAicGNpZSIsICJw
Y2llX3BoeSI7Cj4gPiDCoAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiDCoAkJfTsKPiA+IMKg
CX07Cj4gwqB9OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
