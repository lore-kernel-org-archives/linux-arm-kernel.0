Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721E2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:33:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3280220B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qr8iBWyI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vilk9vjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3280220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tc4ipxAy+636d8wf7zxFlPbMAolwR7K+F2c6n1GZTPo=; b=Qr8iBWyIzbyxhc
	Mokz2GKaEnq7tIkCFIJuPw9iN9iCTwVCyUoJYgdfLkkbYhgb5M8UbBE/2HiapzPIFBShJHCBHUX1y
	WPlEu9BxFBPPIBy9lveg7SN0N/qsvpMlA37ZR42OEBm/fSIJgeYn5u0JsdoGo0vhH/SRmXYUNcNAD
	g4+9tsb3JwJky5wHKzCcpJ9AudNdOIlRBGaYTxL5/kgoKXkDW4KBGCamzvMNl44/i+bYml1mrfrtd
	xUoRctz8qHCKaJkFNJIgVIjyVYSk4COV2rkgCLjKo9sEg4+GT2rRD7pg+cl4oSp1M69XGOI4Yf2p2
	Z9N6MgxbRQtfRpCI+lxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNKX-0004p3-E2; Wed, 06 Feb 2019 13:33:33 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNJL-0003dv-R6
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 13:33:02 +0000
Received: by mail-ot1-x343.google.com with SMTP id v23so11769893otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 05:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=F/qt4tOu4YYqybfv4UJoo2T+jbR7jAA87z2QlXzOjEY=;
 b=vilk9vjq3CaKNA0t5v0tVaQIWqd+0mB0FyJ7aXmtUiYau1b505mxBJJ7OD1zv5ISL2
 tN5PmWoubR+CpNu8b8BZijbdTiU9dGCDJw8zvkM2Xf9nMqp4HkxUuxNszOIFQJ58BHKr
 FwJNjQ4MBI2XuOQVlmnN/mQTvS1NFceogSoZgMDBXDQPh1pyOcAa30FUabK0CsR/Wuax
 TS5Ot7oa2EmUE9VPCdw+vMcXehUjqP0bUxN0rnGKyrUsoQi+PHuf/t8rxCFBRmJ1XEar
 cdsRlNeHBVzsTaAIzaEufGu03+SC0uEBWfzlWaby8p5pBcKG3XCMDGMBzvOW/4TlSwuk
 ZTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F/qt4tOu4YYqybfv4UJoo2T+jbR7jAA87z2QlXzOjEY=;
 b=ciod2mkLxCYPbLtfwLIG09Q0C15wHBVSgFlrnbHLjkFA5rGKFX6JnFWkJSdg6rbv24
 EqWFkh+WLaINrUAgN0pdUK8Ld5skbEynuwZYHurJFMDLHbmfuKMpT2vdi4RrlV36C3C8
 3BxlEsg/7uaIwhWR8wvDcsBOfYhABOtPKZV5Cd7N1/qdeMhork86cNpG6HQA98papAJ6
 9k5ZycFAAehswI6KWRI01IrmbPM5fMaGzWqB6yqurtZxuOvQ3gwGH3pM25Of+c4qk/oP
 Zoftd3lSZq6BK7EyztPBX82A/wnC0duhxDdfVs7oNfUi2abCWs56nUOuIBnICxLBo+pk
 zbnQ==
X-Gm-Message-State: AHQUAubqBbRb0RA23KqtqpDmNa0qK2tTxBZrrZotEM8a1lUCvp385Y4C
 Qneu3Lu2j8+Hcw0lOp0u4xmtLaoI5z0Pz96eJ5TDDw==
X-Google-Smtp-Source: AHgI3IbELqlgQEcvURTaUnmH+k0qZfJuVHtSyOwrKIQqn3FIutEeDXXaO0TGgC61gV/1FYiQqNNIaZEjcRnYg+0h2Oc=
X-Received: by 2002:aca:b6c3:: with SMTP id g186mr5663822oif.289.1549459937405; 
 Wed, 06 Feb 2019 05:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
 <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com>
 <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
In-Reply-To: <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 6 Feb 2019 14:32:06 +0100
Message-ID: <CAMpxmJWU6WRK70xNN72Ke2kXi6F-uLWrCpF+K-+qKX3DcRy7uw@mail.gmail.com>
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_053220_566719_B4BC8AD1 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

xZtyLiwgNiBsdXQgMjAxOSBvIDE0OjAzIFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gbmFw
aXNhxYIoYSk6Cj4KPiBPbiAwNS8wMi8xOSAzOjUxIEFNLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
ID4gT24gMS8zMS8xOSA3OjM4IEFNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+ID4+IEZy
b206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4gPj4K
PiA+PiBJbiBvcmRlciB0byBzZWxlY3QgU1BBUlNFX0lSUSB3ZSBuZWVkIHRvIG1ha2UgdGhlIGlu
dGVycnVwdCBudW1iZXJzCj4gPj4gZHluYW1pYyAoYXQgbGVhc3QgYXQgYnVpbGQtdGltZSBmb3Ig
dGhlIHRvcC1sZXZlbCBjb250cm9sbGVyKS4gVGhlCj4gPj4gaW50ZXJydXB0IG51bWJlcnMgYXJl
IHVzZWQgYXMgYXJyYXkgaW5kZXhlcyBmb3IgaXJxIHByaW9yaXRpZXMuCj4gPj4KPiA+PiBEcm9w
IHRoZSBkZWZpbmVzIGFuZCBqdXN0IGluaXRpYWxpemUgdGhlIGFycmF5cyBpbiBhIGxpbmVhciBt
YW5uZXIuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29s
YXN6ZXdza2lAYmF5bGlicmUuY29tPgo+ID4+IC0tLQo+ID4KPiA+IC4uLgo+ID4KPiA+PiAtc3Rh
dGljIHU4IGRtMzU1X2RlZmF1bHRfcHJpb3JpdGllc1tEQVZJTkNJX05fQUlOVENfSVJRXSA9IHsK
PiA+PiAtICAgIFtJUlFfRE0zNTVfQ0NEQ19WRElOVDBdICAgICAgICA9IDIsCj4gPj4gLSAgICBb
SVJRX0RNMzU1X0NDRENfVkRJTlQxXSAgICAgICAgPSA2LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9D
Q0RDX1ZESU5UMl0gICAgICAgID0gNiwKPiA+PiAtICAgIFtJUlFfRE0zNTVfSVBJUEVfSFNUXSAg
ICAgICAgPSA2LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9IM0FJTlRdICAgICAgICA9IDYsCj4gPj4g
LSAgICBbSVJRX0RNMzU1X0lQSVBFX1NEUl0gICAgICAgID0gNiwKPiA+PiAtICAgIFtJUlFfRE0z
NTVfSVBJUEVJRklOVF0gICAgICAgID0gNiwKPiA+PiAtICAgIFtJUlFfRE0zNTVfT1NESU5UXSAg
ICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9WRU5DSU5UXSAgICAgICAgPSA2LAo+ID4+
IC0gICAgW0lSUV9BU1FJTlRdICAgICAgICAgICAgPSA2LAo+ID4+IC0gICAgW0lSUV9JTVhJTlRd
ICAgICAgICAgICAgPSA2LAo+ID4+IC0gICAgW0lSUV9VU0JJTlRdICAgICAgICAgICAgPSA0LAo+
ID4+IC0gICAgW0lSUV9ETTM1NV9SVE9JTlRdICAgICAgICA9IDQsCj4gPj4gLSAgICBbSVJRX0RN
MzU1X1VBUlRJTlQyXSAgICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9USU5UNl0gICAg
ICAgID0gNywKPiA+PiAtICAgIFtJUlFfQ0NJTlQwXSAgICAgICAgICAgID0gNSwgICAgLyogZG1h
ICovCj4gPj4gLSAgICBbSVJRX0NDRVJSSU5UXSAgICAgICAgICAgID0gNSwgICAgLyogZG1hICov
Cj4gPj4gLSAgICBbSVJRX1RDRVJSSU5UMF0gICAgICAgICAgICA9IDUsICAgIC8qIGRtYSAqLwo+
ID4+IC0gICAgW0lSUV9UQ0VSUklOVF0gICAgICAgICAgICA9IDUsICAgIC8qIGRtYSAqLwo+ID4+
IC0gICAgW0lSUV9ETTM1NV9TUElOVDJfMV0gICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfRE0z
NTVfVElOVDddICAgICAgICA9IDQsCj4gPj4gLSAgICBbSVJRX0RNMzU1X1NESU9JTlQwXSAgICAg
ICAgPSA3LAo+ID4+IC0gICAgW0lSUV9NQlhJTlRdICAgICAgICAgICAgPSA3LAo+ID4+IC0gICAg
W0lSUV9NQlJJTlRdICAgICAgICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9NTUNJTlRdICAgICAg
ICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9NTUNJTlQxXSAgICAgICAgPSA3LAo+ID4+
IC0gICAgW0lSUV9ETTM1NV9QV01JTlQzXSAgICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9ERFJJ
TlRdICAgICAgICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9BRU1JRklOVF0gICAgICAgICAgICA9
IDcsCj4gPj4gLSAgICBbSVJRX0RNMzU1X1NESU9JTlQxXSAgICAgICAgPSA0LAo+ID4+IC0gICAg
W0lSUV9USU5UMF9USU5UMTJdICAgICAgICA9IDIsICAgIC8qIGNsb2NrZXZlbnQgKi8KPiA+PiAt
ICAgIFtJUlFfVElOVDBfVElOVDM0XSAgICAgICAgPSAyLCAgICAvKiBjbG9ja3NvdXJjZSAqLwo+
ID4+IC0gICAgW0lSUV9USU5UMV9USU5UMTJdICAgICAgICA9IDcsICAgIC8qIERTUCB0aW1lciAq
Lwo+ID4+IC0gICAgW0lSUV9USU5UMV9USU5UMzRdICAgICAgICA9IDcsICAgIC8qIHN5c3RlbSB0
aWNrICovCj4gPj4gLSAgICBbSVJRX1BXTUlOVDBdICAgICAgICAgICAgPSA3LAo+ID4+IC0gICAg
W0lSUV9QV01JTlQxXSAgICAgICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfUFdNSU5UMl0gICAg
ICAgICAgICA9IDcsCj4gPj4gLSAgICBbSVJRX0kyQ10gICAgICAgICAgICA9IDMsCj4gPj4gLSAg
ICBbSVJRX1VBUlRJTlQwXSAgICAgICAgICAgID0gMywKPiA+PiAtICAgIFtJUlFfVUFSVElOVDFd
ICAgICAgICAgICAgPSAzLAo+ID4+IC0gICAgW0lSUV9ETTM1NV9TUElOVDBfMF0gICAgICAgID0g
MywKPiA+PiAtICAgIFtJUlFfRE0zNTVfU1BJTlQwXzFdICAgICAgICA9IDMsCj4gPj4gLSAgICBb
SVJRX0RNMzU1X0dQSU8wXSAgICAgICAgPSAzLAo+ID4+IC0gICAgW0lSUV9ETTM1NV9HUElPMV0g
ICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfRE0zNTVfR1BJTzJdICAgICAgICA9IDQsCj4gPj4g
LSAgICBbSVJRX0RNMzU1X0dQSU8zXSAgICAgICAgPSA0LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9H
UElPNF0gICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfRE0zNTVfR1BJTzVdICAgICAgICA9IDcs
Cj4gPj4gLSAgICBbSVJRX0RNMzU1X0dQSU82XSAgICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9E
TTM1NV9HUElPN10gICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfRE0zNTVfR1BJTzhdICAgICAg
ICA9IDcsCj4gPj4gLSAgICBbSVJRX0RNMzU1X0dQSU85XSAgICAgICAgPSA3LAo+ID4+IC0gICAg
W0lSUV9ETTM1NV9HUElPQk5LMF0gICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfRE0zNTVfR1BJ
T0JOSzFdICAgICAgICA9IDcsCj4gPj4gLSAgICBbSVJRX0RNMzU1X0dQSU9CTksyXSAgICAgICAg
PSA3LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9HUElPQk5LM10gICAgICAgID0gNywKPiA+PiAtICAg
IFtJUlFfRE0zNTVfR1BJT0JOSzRdICAgICAgICA9IDcsCj4gPj4gLSAgICBbSVJRX0RNMzU1X0dQ
SU9CTks1XSAgICAgICAgPSA3LAo+ID4+IC0gICAgW0lSUV9ETTM1NV9HUElPQk5LNl0gICAgICAg
ID0gNywKPiA+PiAtICAgIFtJUlFfQ09NTVRYXSAgICAgICAgICAgID0gNywKPiA+PiAtICAgIFtJ
UlFfQ09NTVJYXSAgICAgICAgICAgID0gNywKPiA+PiAtICAgIFtJUlFfRU1VSU5UXSAgICAgICAg
ICAgID0gNywKPiA+PiArc3RhdGljIHU4IGRtMzU1X2FpbnRjX3ByaW9zW10gPSB7Cj4gPj4gKyAg
ICAyLCA2LCA2LCA2LCA2LCA2LCA2LCA3LAo+ID4+ICsgICAgNiwgNiwgNiwgNCwgNCwgNywgNywg
NSwKPiA+PiArICAgIDUsIDUsIDUsIDcsIDQsIDcsIDcsIDcsCj4gPj4gKyAgICA3LCA3LCA3LCA3
LCA3LCA0LCAyLCAyLAo+ID4+ICsgICAgNywgNywgNywgNywgNywgMywgMywgMywKPiA+PiArICAg
IDMsIDMsIDMsIDcsIDQsIDQsIDcsIDcsCj4gPj4gKyAgICA3LCA3LCA3LCA3LCA3LCA3LCA3LCA3
LAo+ID4+ICsgICAgNywgNywgNywgNywgNywgNywgMCwgMCwKPiA+PiAgIH07Cj4gPgo+ID4gSG1t
Li4uIHRoaXMgbWFrZXMgaXQgaGFyZGVyIHRvIHNlZSB3aGF0IGlzIGdvaW5nIG9uIGhlcmUuCj4g
PiBZb3UgY2FuIG5vIGxvbmdlciBzZWUgd2hpY2ggcHJpb3JpdHkgY29ycmVzcG9uZHMgdG8gd2hp
Y2gKPiA+IElSUSB3aXRob3V0IGNvbnN1bHRpbmcgYSBtYW51YWwuCj4KPiBJIGFncmVlIHdpdGgg
RGF2aWQgaGVyZS4gVGhlIGludGVycnVwdCBudW1iZXJzIGFyZSBkeW5hbWljLCBidXQgdGhlCj4g
aW50ZXJydXB0IG51bWJlciBvZmZzZXQgZnJvbSBoYXJkd2FyZSBwb2ludC1vZi12aWV3IGlzIGZp
eGVkLiBTbyBjYW4KPiB0aGVzZSBtYWNyb3MgYmUgcmUtcHVycG9zZWQgdG8gcmVwcmVzZW50IHRo
ZSBoYXJkd2FyZSBvZmZzZXQgKGV2ZW50dWFsbHkKPiB5b3Ugd291bGQgcGFzcyB0aGVtIHRvIERB
VklOQ0lfSU5UQ19JUlEoKSk/Cj4KPiBUaGFua3MsCj4gU2VraGFyCgpTaG91bGQgd2Uga2VlcCB0
aGUgbWFjaC9pcnFzLmggaGVhZGVyIHRoZW4/IFdoaWxlIHdvcmtpbmcgb24gcGF0Y2hlcwpmb3Ig
c3VwcG9ydGluZyB0aGUgbXVsdGlfdjVfZGVmY29uZmlnIGJ1aWxkIEkgbm90aWNlZCB0aGUgbWFj
aC8qCmhlYWRlcnMgdGVuZCB0byBjYXVzZSBidWlsZCBwcm9ibGVtcyBpbiBjZXJ0YWluIGRyaXZl
cnMgdGhhdCB1c2UgdGhlbS4KTW9zdCBtYWNoaW5lcyBoYXZlIGdvdHRlbiByaWQgb2YgdGhlbS4g
U2hvdWxkIHdlIG1heWJlIGNyZWF0ZSBhIGxvY2FsCmhlYWRlciBpbiBtYWNoLWRhdmluY2kvPwoK
QmFydAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
