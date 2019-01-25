Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A40C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70ACA218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tN05RJMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ACA218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2atspBwBivylb0IBoKghMP/wsUkP/UsvWliVjBB+opQ=; b=tN05RJMmPVoICD
	vH5lxMSgYJmpybN76YP60aMsWJvHxvY9ynm9mAc4OOLgLnQ4h+0kxzhZ3uN5dghJ8OR6+NIpm0A+i
	YkJIB/8fu/4V2B5xdQYKoH30x637djTWW3HGsP3E9FHzACIky1kuiVDqNPkHOE207x+hrCJ3MuNmH
	sepqqjHgpCwKCJJnM9tfeaFqpQJoHORMUEvSKjorB5SCwoOZUG4p0Q4mUt0WwA9zeOk9GS+XxFzp0
	+QUDgHH8z2ggxp11wVoi5r6oU1SYLxnNZcCKtfeu0fMlxhWkcGF9fkhJVZLBzsgYBNXZYBB/0qxgs
	4bg5UZGLDp6UpNp9QIug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxwe-0005IS-Hh; Fri, 25 Jan 2019 09:38:40 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxwW-0005Hd-PK
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:38:38 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmxwS-00025Q-0K; Fri, 25 Jan 2019 10:38:28 +0100
Message-ID: <1548409107.28802.36.camel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] imx8mq.dtsi: add the sdma nodes
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Fri, 25 Jan 2019 10:38:27 +0100
In-Reply-To: <20190125025528.15645-6-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
 <20190125025528.15645-6-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013832_978014_553BEE74 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDI0LjAxLjIwMTksIDE5OjU1IC0wNzAwIHNjaHJpZWIgQW5ndXMg
QWluc2xpZSAoUHVyaXNtKToKPiBBZGQgdGhlIHNkbWEgbm9kZXMgdG8gdGhlIGJhc2UgZGV2aWNl
dHJlZSBmb3IgdGhlIGlteDhtcQo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIEFpbnNsaWUgKFB1
cmlzbSkgPGFuZ3VzQGFra2VhLmNhPgoKT25lIG5pdCBiZWxvdywgd2l0aCB0aGF0IGZpeGVkOgoK
UmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKWW91IG1p
Z2h0IG5lZWQgdG8gc3BsaXQgdGhpcyBwYXRjaCBvdXQgZnJvbSB0aGUgc2VyaWVzIGFuZCBzZW5k
IGl0IHRvClNoYXduIHNlcGFyYXRlbHkgYWZ0ZXIgdGhlIGRtYWVuZ2luZSBjaGFuZ2VzIGhhdmUg
YmVlbiBhY2NlcHRlZC4KCnJlZ2FyZHMsCkx1Y2FzCgo+IC0tLQo+IMKgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKwo+
IMKgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+IGluZGV4IGMwNDAyMzc1ZTdjMS4uZjBjZDM2NzVl
YWQwIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5k
dHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBA
QCAtMzM2LDYgKzMzNiwxNyBAQAo+ID4gwqAJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19X
RE9HM19ST09UPjsKPiA+IMKgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiDCoAkJCX07Cj4g
Kwo+ID4gPiArCQkJc2RtYTI6IHNkbWFAMzAyYzAwMDAgewo+ID4gKwkJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXEtc2RtYSIsICJmc2wsaW14N2Qtc2RtYSI7Cj4gPiArCQkJCXJlZyA9IDwweDMw
MmMwMDAwIDB4MTAwMDA+Owo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTAzIElSUV9U
WVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1NETUEy
X1JPT1Q+LAo+ICsJCQkJCTwmY2xrIElNWDhNUV9DTEtfU0RNQTJfUk9PVD47CgpTb21lIHNwYWNl
cyB0byBhbGlnbiB0aGUgc2Vjb25kIGNsb2NrIHJlZmVyZW5jZSBhcyBpbiB0aGUgcmVzdCBvZiB0
aGlzCmZpbGUsIHBsZWFzZS4KCj4gKwkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIjsKPiA+
ICsJCQkJI2RtYS1jZWxscyA9IDwzPjsKPiA+ICsJCQkJZnNsLHNkbWEtcmFtLXNjcmlwdC1uYW1l
ID0gImlteC9zZG1hL3NkbWEtaW14N2QuYmluIjsKPiA+ICsJCQl9Owo+ID4gwqAJCX07Cj4gwqAK
PiA+IMKgCQlidXNAMzA0MDAwMDAgeyAvKiBBSVBTMiAqLwo+IEBAIC0zNzAsNiArMzgxLDggQEAK
PiA+IMKgCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfVUFSVDNfUk9PVD4sCj4gPiDCoAkJ
CQnCoMKgwqDCoMKgwqDCoMKgwqA8JmNsayBJTVg4TVFfQ0xLX1VBUlQzX1JPT1Q+Owo+ID4gwqAJ
CQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7Cj4gPiArCQkJCWRtYXMgPSA8JnNkbWExIDI2
IDQgMD4sIDwmc2RtYTEgMjcgNCAwPjsKPiA+ICsJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsK
PiA+IMKgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiDCoAkJCX07Cj4gwqAKPiBAQCAtMzgx
LDYgKzM5NCw4IEBACj4gPiDCoAkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1VBUlQyX1JP
T1Q+LAo+ID4gwqAJCQkJwqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19VQVJUMl9S
T09UPjsKPiA+IMKgCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOwo+ID4gKwkJCQlkbWFz
ID0gPCZzZG1hMSAyNCA0IDA+LCA8JnNkbWExIDI1IDQgMD47Cj4gPiArCQkJCWRtYS1uYW1lcyA9
ICJyeCIsICJ0eCI7Cj4gPiDCoAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gwqAJCQl9Owo+
IMKgCj4gQEAgLTQzMiw2ICs0NDcsOCBAQAo+ID4gwqAJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1R
X0NMS19VQVJUNF9ST09UPiwKPiA+IMKgCQkJCcKgwqDCoMKgwqDCoMKgwqDCoDwmY2xrIElNWDhN
UV9DTEtfVUFSVDRfUk9PVD47Cj4gPiDCoAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsK
PiA+ICsJCQkJZG1hcyA9IDwmc2RtYTEgMjggNCAwPiwgPCZzZG1hMSAyOSA0IDA+Owo+ID4gKwkJ
CQlkbWEtbmFtZXMgPSAicngiLCAidHgiOwo+ID4gwqAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsK
PiA+IMKgCQkJfTsKPiDCoAo+IEBAIC00NjUsNiArNDgyLDE3IEBACj4gPiDCoAkJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOwo+ID4gwqAJCQl9Owo+IMKgCj4gPiA+ICsJCQlzZG1hMTogc2RtYUAzMGJk
MDAwMCB7Cj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1zZG1hIiwgImZzbCxpbXg3
ZC1zZG1hIjsKPiA+ICsJCQkJcmVnID0gPDB4MzBiZDAwMDAgMHgxMDAwMD47Cj4gPiArCQkJCWlu
dGVycnVwdHMgPSA8R0lDX1NQSSAyIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCQljbG9j
a3MgPSA8JmNsayBJTVg4TVFfQ0xLX1NETUExX1JPT1Q+LAo+ID4gKwkJCQkJPCZjbGsgSU1YOE1R
X0NMS19BSEI+Owo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIjsKPiA+ICsJCQkJ
I2RtYS1jZWxscyA9IDwzPjsKPiA+ICsJCQkJZnNsLHNkbWEtcmFtLXNjcmlwdC1uYW1lID0gImlt
eC9zZG1hL3NkbWEtaW14N2QuYmluIjsKPiA+ICsJCQl9Owo+ICsKPiA+ID4gwqAJCQlmZWMxOiBl
dGhlcm5ldEAzMGJlMDAwMCB7Cj4gPiDCoAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZmVj
IiwgImZzbCxpbXg2c3gtZmVjIjsKPiA+IMKgCQkJCXJlZyA9IDwweDMwYmUwMDAwIDB4MTAwMDA+
OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
