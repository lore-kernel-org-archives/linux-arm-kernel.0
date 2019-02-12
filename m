Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:33:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441AD21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kwP0Cy9l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="waRsQ09L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441AD21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0TUL3c4w1ApVdK+Anm3s85fOWmo/lfiuvrKuKWxf114=; b=kwP0Cy9lsZnk2q
	vtGUpJna0/TWqi/QqDuZxeK7qMrDCBl9GdVFa6wBsTeiKCbTFayctmjH/NV3DntTH5BDOvYysevTX
	VQDUg/10wcmLUQ116IXoDDUgwpSRHL0hYk4B96ojexb1KXfpQGsPLF/Sow1YayEGWuGEh2h41vxO5
	8iWu3EK0V5tkYvsuzRk4C9WIO+AW5uYhB/gwUKrEOlRHYcpQZQKyYwHNSh/HTGTu3SHvC7z45FNwc
	+TSm5DiU6gjOXntQnISFxYbtEghO49D2tnlnY34Db2r5WWqAiy7tiR6kaB+PUdBLFTu81OnoT6OaI
	wIwyxUzntnhgQnSQy7Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtURD-00060S-RX; Tue, 12 Feb 2019 09:33:11 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtURA-0005zm-6f
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:33:09 +0000
Received: by mail-it1-x143.google.com with SMTP id z20so5883338itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FgkpX838fo9oz8NedVb0MpKtzZYxkXRP2Z32tbBQYjA=;
 b=waRsQ09LqsI2iWinAIYUZINqbTBFjxarlOd9+DC0LVysmqOPGKyQZXQevhoZD7ZEhQ
 XD6QWGVPF9jAVb560JxHn83NKaENr7/kAFe5UF/at8t97HGm2qfLl4hwl+vkY7t6aVEa
 p5skMV07v/rZfNIddNi1zp6IEh5hCzL4S/raw5qZV0fXiDeF3EZsRA705lMf+8cUP/xy
 VzfQ3yGG91stvmYNjoj9jqCWXV8xt8kipg929/iDJs4T/Ih4BTw8mDCjIg/k1p0IZGWb
 Le44pBV/dpOCtn1qBYBzvdVh9cLAB0pL9cSV4SWBW1AramVHrqYdZWcKTlG96mxlrbII
 mUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FgkpX838fo9oz8NedVb0MpKtzZYxkXRP2Z32tbBQYjA=;
 b=sYpCRkFCtvimUT6dyvOmlOQaEmxwEYkb8KmeeRBMb1VxUuilcIrZvXhhcX8K247heB
 UUW+tmX7f71+5ISq7S6xcIRKtd+NsmRMJtL6+ZjU3T/pivuZEHw40d/xkTRwRN/8MgdU
 N+ZltVp8CwwUeTYwyrwTonKnhmvrEOcgrHgx888WAW7lUd6Z/GI8Fh0QZfBsFe8Zhu4M
 1HNS7LsVJIfABLviWJNX5Rf94vXQHeDZ2FLtzcT3gl+gm3WU62zr/CwDQk/g7NIaxMZp
 tA883AgmY4NgGq0kyqhBQYKNv/HTKKXYk8KIHvk/fzv0HIGOJsBYTV28P32icALCiVHd
 EGxg==
X-Gm-Message-State: AHQUAubAw7R7RG/yyGkB6hpuxptstBwt+3bcM2NDQXhia7h6lXMT9wgh
 wU1L4vfUVMrWQTeHe1NJdcIWzXNCbTuxo32ed4KD9c7w
X-Google-Smtp-Source: AHgI3IaZhlIJttqHaE8stFCUqH6pEM8VirZlSAAtboWLHMCHPeC4nmwDh+OVJj7VeGRCDUjAZULyaH7JZ6Axl3ToCoo=
X-Received: by 2002:a24:7284:: with SMTP id x126mr1557363itc.96.1549963987312; 
 Tue, 12 Feb 2019 01:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-30-brgl@bgdev.pl>
 <2bf9393a-d747-2d86-f298-5f4cf899b85e@arm.com>
In-Reply-To: <2bf9393a-d747-2d86-f298-5f4cf899b85e@arm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Feb 2019 10:32:56 +0100
Message-ID: <CAMRc=MfmKTJcoLzRb5Auz2mYD8pka-=p46MSxjrnXwDYKDR3=Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 29/33] ARM: davinci: cp-intc: use
 readl/writel_relaxed()
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_013308_253272_24C82A50 
X-CRM114-Status: GOOD (  16.41  )
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
 Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cG9uLiwgMTEgbHV0IDIwMTkgbyAxNDowOCBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0u
Y29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDExLzAyLzIwMTkgMTI6MjYsIEJhcnRvc3ogR29sYXN6
ZXdza2kgd3JvdGU6Cj4gPiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lA
YmF5bGlicmUuY29tPgo+ID4KPiA+IFJhcGxhY2UgYWxsIGNhbGxzIHRvIF9fcmF3X3JlYWRsKCkg
JiBfX3Jhd193cml0ZWwoKSB3aXRoIHJlYWRsX3JlbGF4ZWQoKQo+ID4gYW5kIHdyaXRlbF9yZWxh
eGVkKCkgcmVzcGVjdGl2ZWx5LiBJdCdzIHNhZmUgdG8gZG8gYXMgdGhlcmUncyBubwo+ID4gZW5k
aWFubmVzcyBjb252ZXJzaW9uIGJlaW5nIGRvbmUgaW4gdGhlIGNvZGUuCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4K
PiA+IC0tLQo+ID4gIGFyY2gvYXJtL21hY2gtZGF2aW5jaS9jcF9pbnRjLmMgfCA0ICsrLS0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jIGIvYXJjaC9hcm0v
bWFjaC1kYXZpbmNpL2NwX2ludGMuYwo+ID4gaW5kZXggYzFlZmI5MzkwNjU1Li40YmJmMGViYTE5
MjAgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jCj4gPiAr
KysgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jCj4gPiBAQCAtNDUsMTMgKzQ1LDEz
IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxX2RvbWFpbiAqZGF2aW5jaV9jcF9pbnRjX2lycV9kb21haW47
Cj4gPgo+ID4gIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGRhdmluY2lfY3BfaW50Y19yZWFk
KHVuc2lnbmVkIGludCBvZmZzZXQpCj4gPiAgewo+ID4gLSAgICAgcmV0dXJuIF9fcmF3X3JlYWRs
KGRhdmluY2lfY3BfaW50Y19iYXNlICsgb2Zmc2V0KTsKPiA+ICsgICAgIHJldHVybiByZWFkbF9y
ZWxheGVkKGRhdmluY2lfY3BfaW50Y19iYXNlICsgb2Zmc2V0KTsKPiA+ICB9Cj4gPgo+ID4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBkYXZpbmNpX2NwX2ludGNfd3JpdGUodW5zaWduZWQgbG9uZyB2YWx1
ZSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCBvZmZzZXQpCj4gPiAgewo+ID4gLSAgICAgX19yYXdfd3JpdGVsKHZhbHVlLCBkYXZpbmNpX2Nw
X2ludGNfYmFzZSArIG9mZnNldCk7Cj4gPiArICAgICB3cml0ZWxfcmVsYXhlZCh2YWx1ZSwgZGF2
aW5jaV9jcF9pbnRjX2Jhc2UgKyBvZmZzZXQpOwo+ID4gIH0KPiA+Cj4gPiAgc3RhdGljIHZvaWQg
ZGF2aW5jaV9jcF9pbnRjX2Fja19pcnEoc3RydWN0IGlycV9kYXRhICpkKQo+ID4KPgo+IFNhbWUg
dGhpbmcuIFBsZWFzZSBtZXJnZSB0aGlzIHBhdGNoIHdpdGggdGhlIG9uZSB0aGF0IGludHJvZHVj
ZWQgdGhlCj4gX19yYXdfd3JpdGVsKCkgc3R1ZmYuCj4KCkluIHRoaXMgY2FzZSwgbm9uZSBvZiBt
eSBwYXRjaGVzIGludHJvZHVjZWQgaXQgLSBpdCB1c2VkIHRvIGJlIGxpa2UKdGhhdCBmcm9tIHRo
ZSBiZWdpbm5pbmcsIHNvIGEgc2VwYXJhdGUgcGF0Y2ggaXMganVzdGlmaWVkLgoKQmFydAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
