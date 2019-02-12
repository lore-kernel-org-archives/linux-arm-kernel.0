Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31002082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZ1S/tZr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TR0xj5P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31002082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dh8sk91qF5RiEzQZtf0CUme94+sk3nFRhFvWfUGQJZo=; b=VZ1S/tZrW+Qg67
	RZnkPxy6/thTsYmJPm5IZ9QkYl7HnZZHFo+1vKmqze+Vr2lNiFBpFcQIX8kxaoJQREO9/ckol79OE
	P5sap+K2Tq3OxeBST+G5A7qyfRZMVtNWg2bx4Un2Ljjd+0c19CAiYPAiJkzANF2XCflQUSuGVu9Up
	4TnERPRmJrR2NK7ECJSFg1VwYhNhg6JHAqXAj8pds37Nto2SpnERGchmPbzc3vOQHchku+aOQhxtE
	X+w1H0E+hu55aAqWCx6fbJ/TOrrFOTXn3/FCtJ53CKlT+bkdc/GevQ3MDag+QQIpNpUVheiHHgF0T
	CMFeO26E0PTXDhcrdYxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTUE-0003Zd-EO; Tue, 12 Feb 2019 08:32:14 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTU7-0003Uo-FL
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:32:11 +0000
Received: by mail-ot1-x342.google.com with SMTP id b3so3064282otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 00:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=r/MtKpa4761DXWQUhuz6Dd1LL8SOhaerQOxx15a6k3g=;
 b=TR0xj5P7yc2Csi1UPes3wPhR18oWs/tTD5xusancZlJtjcak9JrNv0A9kUXWXchV1m
 3o8i1HU5HLMd5QLkEF5kkQkS6CfLROEFBDp+7dCJutSOZsPPgR/aaXfLm/fn4vhClJXQ
 huUfRBaGKUZWKpgYbgJG0YvuxGroDDBZraRNO62iqepOt47Dx0fY7A5GJps/rK+5fwds
 0SGkuTXTMgOHkzTHEziOVy6H8LOL0u9yP8wwKxDrBkIgtCX2gT93T3/4MgRpMQow/kpe
 FjLYoyr3UPwws/C6NUz7Bv3jgicNjqHfSdQPS/oNm+tkrMwaHIFcqS+NAaajooPpEfdm
 AJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r/MtKpa4761DXWQUhuz6Dd1LL8SOhaerQOxx15a6k3g=;
 b=VRdQEyrRIaXIprEZnCe4fZ0G0SBOBFefudiwh0pKTsSsI8lB7xfFzKBuND0EBvbRX4
 2r72v3RxgCTjPTC/x2qV03nevUN+nuGmjMjyyLeVVzmRS5CSoP5tod/qx5qQWEhNYXMd
 mY5/mpENquE/2Nu+2eHSdbPgCIl97uXAWfBFzJ7jHYTedYBavOx1oi7dQCiYrl6qy+Gt
 nnes/xq3w9QCLEQuhEvbY9Q9SWqoO2vYO/OTf24guhlSha2KhguE0v+MlhdSe1FXAnuc
 ZLxIF73wN6cFEyLjLkVfjIqBuFaS6tuHyQOSbmqI91xeCDq0koo1FiL5vkzU3TYveT9C
 0NKQ==
X-Gm-Message-State: AHQUAubgPT4ogLmz2kFtYaiDXCdpr1fGz2jYeaFiENTc810kPj+reahI
 VUtg6u8a/aypkmAgldmtr3w+GeO5vRwn7v5SiolKGg==
X-Google-Smtp-Source: AHgI3Ia+dhS3kqkHVI512MvgSHV+MHbl80BetH5wNP878OMvJJ7YK/nA58fNKqSAcWSETd7fKODREoVbgxQP2Tg+cEE=
X-Received: by 2002:a9d:6191:: with SMTP id g17mr2680441otk.56.1549960326066; 
 Tue, 12 Feb 2019 00:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <a333fac0-955e-d04a-6076-42a5b6edda34@ti.com>
In-Reply-To: <a333fac0-955e-d04a-6076-42a5b6edda34@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 12 Feb 2019 09:31:55 +0100
Message-ID: <CAMpxmJWZoPkM7LW8HvVi2SRP5097f9YTnbEZMAXpbM69JHG8fg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 00/33] ARM: davinci: modernize the irq support
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_003207_536687_065C7DC1 
X-CRM114-Status: GOOD (  14.45  )
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

d3QuLCAxMiBsdXQgMjAxOSBvIDA5OjI0IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gbmFw
aXNhxYIoYSk6Cj4KPiBPbiAxMS8wMi8xOSA1OjU1IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdy
b3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJl
LmNvbT4KPiA+Cj4gPiBOT1RFOiByZXNlbmRpbmcgZHVlIHRvIG1pc3NpbmcgaXJxY2hpcCBtYWlu
dGFpbmVycyBpbiBDYwo+ID4KPiA+IFRoaXMgc2VyaWVzIHBvcnRzIHRoZSBkYXZpbmNpIHBsYXRm
b3JtIHRvIHVzaW5nIFNQQVJTRV9JUlEsIGNsZWFucyB1cAo+ID4gdGhlIGlycWNoaXAgZHJpdmVy
cyBhbmQgbW92ZXMgdGhlbSBvdmVyIHRvIGRyaXZlcnMvaXJxY2hpcC4KPiA+Cj4gPiBUaGUgc2Vy
aWVzIGNhbiBiZSBsb2dpY2FsbHkgc3BsaXQgaW50byBmb3VyIHBhcnRzLiBUaGUgZmlyc3QgKDEt
OCkgYWltcwo+ID4gYXQgaW50cm9kdWNpbmcgc3VwcG9ydCBmb3IgU1BBUlNFX0lSUS4gSXQgY29u
dGFpbnMgYSBjb3VwbGUgY2hhbmdlcwo+ID4gcmVxdWlyZWQgZm9yIHRoYXQgZnVuY3Rpb25hbGl0
eSBhbmQgdGhlIGZpbmFsIHBhdGNoIGFjdHVhbGx5IHNlbGVjdGluZwo+ID4gaXQuCj4gPgo+ID4g
U2Vjb25kIHBhcnQgKDktMTkpIG1ha2VzIHRoZSBhaW50YyBkcml2ZXIgc3VpdGFibGUgZm9yIGRy
aXZlcnMvaXJxY2hpcAo+ID4gYW5kIGV2ZW50dWFsbHkgbW92ZXMgaXQgb3ZlciB0aGVyZS4KPiA+
Cj4gPiBQYXJ0IDMgKDIwLTMyKSBkb2VzIHRoZSBzYW1lIGZvciB0aGUgY3AtaW50YyBkcml2ZXIu
Cj4gPgo+ID4gTGFzdCBwYXRjaCByZW1vdmVzIHVubmVjZXNzYXJ5IGNvZGUuCj4gPgo+ID4gVGhl
IHNlcmllcyBoYXMgYmVlbiB0ZXN0ZWQgb24gZGE4NTAtbGNkayAoZm9yIGNwLWludGMpIGFuZAo+
ID4gZG0zNjUtZXZtIChmb3IgYWludGMpLgo+Cj4gVGhlcmUgaXMgYnVpbGQgYnJlYWthZ2UgaW4g
ZHJpdmVycy9pbnB1dC9rZXlib2FyZC9kYXZpbmNpX2tleXNjYW4uYwo+IGFmdGVyIHRoaXMgc2Vy
aWVzIGR1ZSB0byA8bWFjaC9pcnFzLmg+IHJlbW92YWwuCj4KPiBUaGFua3MsCj4gU2VraGFyCgpU
aGFua3MsIEknbGwgZml4IHRoYXQuCgpCYXJ0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
