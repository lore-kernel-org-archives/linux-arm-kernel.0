Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FECE218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LavjgZzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FECE218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VhPDlSXZFBcVeggqvquEKc6uZI/pu5d1be470haGGsE=; b=LavjgZzWs2MfkD
	nzdVpClBnem/VQiMZk/NyK1+EGFM4YBEcy5MRe8tehEq5M+OGvIh3aQiBpM1Bez8/5b8RmqedW2Xv
	owwr/LsBVFTSrY+wrbhFnsPCz3Jow+kr9NICcTHEW/IvF47IpzmzH4IXRk9PPkETp6ANzJDziZavZ
	qn+r77pnFyrebSqAvdv5DToBfyG/0e1vkofC3c/iJuNxMDvMxekf3dPUYng0S2FaVHaVFWqc/f6Xa
	Z1hlvRuBcuOAsljxb9U9J5SLC+4JD9d4BdayC1W4HI2rYS5JfqxnbCOrT0b05Twzot8FiwX/XveTM
	4yBaVyCRH33gP8Hmk4mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAJ7-0003P3-OZ; Mon, 11 Feb 2019 12:03:29 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAJ5-0003Oc-3N
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:03:28 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gtAIw-0005qT-R2; Mon, 11 Feb 2019 13:03:18 +0100
Message-ID: <1549886597.2546.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: Add on-chip OTP controller node
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 11 Feb 2019 13:03:17 +0100
In-Reply-To: <20190202150638.13672-2-ccaione@baylibre.com>
References: <20190202150638.13672-1-ccaione@baylibre.com>
 <20190202150638.13672-2-ccaione@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_040327_296198_23EA3292 
X-CRM114-Status: GOOD (  13.52  )
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

QW0gU2Ftc3RhZywgZGVuIDAyLjAyLjIwMTksIDE1OjA2ICswMDAwIHNjaHJpZWIgQ2FybG8gQ2Fp
b25lOgo+IEFkZCB0aGUgbm9kZSBmb3IgdGhlIE9UUCBjb250cm9sbGVyLiBUaGUgSVAgaXMgdGhl
IHNhbWUgYXMgb24gdGhlIGlteDdkLgoKVGhpcyBpcyBub3QgdHJ1ZS4gQWNjb3JkaW5nIHRvIHRo
ZSByZWZlcmVuY2UgbWFudWFsLCB0aGUgT0NPVFAKY29udHJvbGxlciBvbiBpLk1YOE1RIHVzZXMg
dGhlIG5vbi1iYW5rZWQgd3JpdGUgbW9kZSwgc2FtZSBhcyBpLk1YNi4KVGh1cyBpdCBpcyBpbmNv
bXBhdGlibGUgdG8gdGhlIGkuTVg3IE9DT1RQLgoKQWxzbyB0aGUgbnVtYmVyIG9mIGZ1c2VzIGlz
IGRpZmZlcmVudCwgc28gd2UgcmVhbGx5IG5lZWQgc29tZSBkcml2ZXIKc3VwcG9ydCBmb3IgdGhl
IGlteDhtcSBjb21wYXRpYmxlIGFuZCBjYW4ndCBkZWNsYXJlIHRoZSBjb250cm9sbGVyCmNvbXBh
dGlibGUgdG8gc29tZSBvbGRlciBpbnN0YW5jZS4KClJlZ2FyZHMsCkx1Y2FzCgo+IFNpZ25lZC1v
ZmYtYnk6IENhcmxvIENhaW9uZSA8Y2NhaW9uZUBiYXlsaWJyZS5jb20+Cj4gLS0tCj4gwqBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8IDggKysrKysrKysKPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQo+IGluZGV4IGMzNGNhYmU5YjM1Ni4uZjM3ZjE3YjcxMTUxIDEw
MDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBAQCAtMjQx
LDYgKzI0MSwxNCBAQAo+IMKgCQkJCXJlZyA9IDwweDMwMzQwMDAwIDB4MTAwMDA+Owo+IMKgCQkJ
fTsKPiDCoAo+ICsJCQlvY290cDogb2NvdHAtY3RybEAzMDM1MDAwMCB7Cj4gKwkJCQljb21wYXRp
YmxlID0gImZzbCxpbXg4bXEtb2NvdHAiLCAiZnNsLGlteDdkLW9jb3RwIiwgInN5c2NvbiI7Cj4g
KwkJCQlyZWcgPSA8MHgzMDM1MDAwMCAweDEwMDAwPjsKPiArCQkJCWNsb2NrcyA9IDwmY2xrIElN
WDhNUV9DTEtfT0NPVFBfUk9PVD47Cj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArCQkJ
CSNzaXplLWNlbGxzID0gPDE+Owo+ICsJCQl9Owo+ICsKPiDCoAkJCWFuYXRvcDogc3lzY29uQDMw
MzYwMDAwIHsKPiDCoAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtYW5hdG9wIiwgInN5c2Nv
biI7Cj4gwqAJCQkJcmVnID0gPDB4MzAzNjAwMDAgMHgxMDAwMD47CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
