Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:11:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E84021855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j6EDdeMV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ylLZUh+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E84021855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V55PdObSli+gHilpUgzNV6mgiTuc5R3fkuIC8OeZMsQ=; b=j6EDdeMVWma7wd
	EAxM7ixfE39ZYIIFL5jVnFVOm5MyFysqEkgBEPpphviDR1fTlc2bf6xjByXx92MWS6GL7IWIjHaHL
	V75qvlJg7Y0HCl/NyRaIJ+5O6jzhvgM+xVpV7PL2IT90m2W5oQupuMArYfFBf2GYEJH9N3a29sYZS
	QugNTZ/caD8EIMLmgChWdZtt7mKbYD5Diild0cIje2Gm4nGugSS2eElmzG2/m22ntTTwJSZtYuJhW
	tQQpGErBPbukdMhKl/xtY/Ibgjl8JYjLZFNaexoRi066oV4l/YudoU+LPUhN+kbUzL+7RHEQ4+lmL
	I+NG9jZOz0WxdkGGV4/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBMJ-0004X4-2J; Mon, 11 Feb 2019 13:10:51 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBM9-0004Ql-PK
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:10:44 +0000
Received: by mail-ot1-x343.google.com with SMTP id u16so17283104otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 05:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w50+3ASKiEiTs8l6R7PImkIxaHDwdrCXPI3EEoULF/Q=;
 b=ylLZUh+EAxAKOvZ0r2I6S/s8TRR94avJkN9ghhtt3Crrkt9ZWha5yk8jAT8+XAFXN8
 h02rjoHEgAixJPczMnVDg18BYrGuO2GMxN2WPXGKWpMm3XdeG9Ls+MDwt4Ysprkn3lN4
 xzOkXbXZdJOfy6foDnuhGkd6SvTqJsnxgkLVe5usUgwzPclJVuovVbxEiOl63yZBq9eM
 vUWo/QgYeBlTfnpiAFK6Vn6524Vgi+eHJI2xiLuvZH+UF1H1vpcNFmutTjcbAjj0HiH/
 DWTf9P3av4B3k8f6NwMKFVsw9qPrJP4RdAqhyDLVxawu4R3RuwKaQqtMNG6HpVtJvPKq
 89wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w50+3ASKiEiTs8l6R7PImkIxaHDwdrCXPI3EEoULF/Q=;
 b=alN3cozGnIWtYQaxV4cSDZvdMk5XdGsTLNjCkHzVRiZ5UqZuqqMlW9wRKQsriO/tdr
 2L7KTX/rxbLhAqvAbyszGMeeDzk9edMqbyJuUpamW6CiScIGNYKF2I9qq569XuhlzNs+
 YrrC96nKrn08oMJnA42hj/gN15rOE6ANIT6sQUFUV/lX+oh8X9UdHZYzuJzy+fy/R7x7
 3m4NxQZ8WTuv3SlzF66GxeS8T/NKRv/NZfA1VwQQDYyqbUAEeNR+A8TeNzYpYCr1bVuN
 g4B0aYeeC9OP8U63HB/sZR3B4WabcbfyHRS6z6lLd/x063xk+rQxKRQCPsXWOuR7Q0yy
 t0Tw==
X-Gm-Message-State: AHQUAubCXudTtOAYh4W7lm1ECOQLMDaCCayG2OpLpt0Bdu4lfTXUSuK+
 ZEnkFIr0ZvnTq+kw/QOJSfHuLYOytpH5m8FLPNV+9A==
X-Google-Smtp-Source: AHgI3Ia4tUepeDzqYWBWee0Ussok87OvXuN31D03SvsqJY9qdmP7IYZBEdGwiuWf63V3pha9F/9wVnSL92muhrl1Gzo=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr18606097ote.234.1549890640607; 
 Mon, 11 Feb 2019 05:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-29-brgl@bgdev.pl>
 <7b494951-7b37-3ee5-5ece-f486b7a566fe@arm.com>
In-Reply-To: <7b494951-7b37-3ee5-5ece-f486b7a566fe@arm.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 11 Feb 2019 14:10:29 +0100
Message-ID: <CAMpxmJVeQe7sxfharvA8REsOdmeaQUr2f1ByJwHCc5NnaFYEsw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 28/33] ARM: davinci: cp-intc: unify error
 handling
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_051042_311063_E03D8340 
X-CRM114-Status: GOOD (  16.87  )
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
 Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cG9uLiwgMTEgbHV0IDIwMTkgbyAxNDowOCBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0u
Y29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDExLzAyLzIwMTkgMTI6MjYsIEJhcnRvc3ogR29sYXN6
ZXdza2kgd3JvdGU6Cj4gPiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lA
YmF5bGlicmUuY29tPgo+ID4KPiA+IFVzZSBXQVJOX09OKCkgb24gZW55IGVycm9yIGluIGNwLWlu
dGMgaW5pdGlhbGl6YXRpb24gYW5kIGRyb3AgYWxsCj4gPiBjdXN0b20gZXJyb3IgbWVzc2FnZXMu
Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tp
QGJheWxpYnJlLmNvbT4KPiA+IFJldmlld2VkLWJ5OiBEYXZpZCBMZWNobmVyIDxkYXZpZEBsZWNo
bm9sb2d5LmNvbT4KPiA+IC0tLQo+ID4gIGFyY2gvYXJtL21hY2gtZGF2aW5jaS9jcF9pbnRjLmMg
fCAxMCArKystLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2Nw
X2ludGMuYyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9jcF9pbnRjLmMKPiA+IGluZGV4IGYzNzg3
YWU0Y2RiZC4uYzFlZmI5MzkwNjU1IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZp
bmNpL2NwX2ludGMuYwo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2NwX2ludGMuYwo+
ID4gQEAgLTIwMCwyMCArMjAwLDE2IEBAIGRhdmluY2lfY3BfaW50Y19kb19pbml0KGNvbnN0IHN0
cnVjdCBkYXZpbmNpX2NwX2ludGNfY29uZmlnICpjb25maWcsCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgREFWSU5DSV9DUF9JTlRDX0NIQU5fTUFQKG9mZnNldCkpOwo+ID4KPiA+ICAgICAgIGly
cV9iYXNlID0gaXJxX2FsbG9jX2Rlc2NzKC0xLCAwLCBjb25maWctPm51bV9pcnFzLCAwKTsKPiA+
IC0gICAgIGlmIChpcnFfYmFzZSA8IDApIHsKPiA+IC0gICAgICAgICAgICAgcHJfd2FybigiQ291
bGRuJ3QgYWxsb2NhdGUgSVJRIG51bWJlcnNcbiIpOwo+ID4gLSAgICAgICAgICAgICBpcnFfYmFz
ZSA9IDA7Cj4gPiAtICAgICB9Cj4gPiArICAgICBpZiAoV0FSTl9PTihpcnFfYmFzZSA8IDApKQo+
ID4gKyAgICAgICAgICAgICByZXR1cm4gaXJxX2Jhc2U7Cj4gPgo+ID4gICAgICAgLyogY3JlYXRl
IGEgbGVnYWN5IGhvc3QgKi8KPiA+ICAgICAgIGRhdmluY2lfY3BfaW50Y19pcnFfZG9tYWluID0g
aXJxX2RvbWFpbl9hZGRfbGVnYWN5KAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBub2RlLCBjb25maWctPm51bV9pcnFzLCBpcnFfYmFzZSwgMCwKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmRhdmluY2lfY3BfaW50Y19pcnFfZG9tYWlu
X29wcywgTlVMTCk7Cj4gPgo+ID4gLSAgICAgaWYgKCFkYXZpbmNpX2NwX2ludGNfaXJxX2RvbWFp
bikgewo+ID4gLSAgICAgICAgICAgICBwcl9lcnIoImNwX2ludGM6IGZhaWxlZCB0byBhbGxvY2F0
ZSBpcnEgaG9zdCFcbiIpOwo+ID4gKyAgICAgaWYgKFdBUk5fT04oIWRhdmluY2lfY3BfaW50Y19p
cnFfZG9tYWluKSkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiAtICAgICB9
Cj4gPgo+ID4gICAgICAgc2V0X2hhbmRsZV9pcnEoZGF2aW5jaV9jcF9pbnRjX2hhbmRsZV9pcnEp
Owo+ID4KPiA+Cj4KPiBJJ20gc29ycnksIGJ1dCBob3cgaXMgdHVybmluZyBhbiBleHBsaWNpdCBt
ZXNzYWdlIGludG8gYSBsb25nIHN0YWNrCj4gdHJhY2UgcmVhbGx5IHVzZWZ1bD8KPgoKSWYgYW55
IG9mIHRoZXNlIGNhbGxzIGZhaWxzLCB0aGUgc3lzdGVtIGlzIGZyaWVkLiBJIGFzc3VtZWQgdGhh
dCBhCnN0YWNrIHRyYWNlIHdpbGwgcG9pbnQgdXNlcnMgc3RyYWlnaHQgdG8gdGhlIG9mZmVuZGlu
ZyBsaW5lLgoKQmFydAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
