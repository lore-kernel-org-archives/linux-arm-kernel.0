Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A6C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 12:27:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CE221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Riu8qGHd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MPy5WjsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CE221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XV5udglCeZgLgq1Uil0llzSqMeiVdL8UpDXHsUMCMCs=; b=Riu8qGHdmJqoOn
	7sqB5jPMgIoEVnmolidtYeVfczFwokvHf+gdc9onNObuY4O6TecVjzGPaKp6c/kSWP+RV0D1NQbSA
	6hMvHW+nYKPXacBt2juhVTf5pPEjWHAwsEUO+/Urq4lLjxqmBpgZuOBtNvZdAoFbz5e0s5+GKAz7d
	pRKiAdiTdLaj1n+/BN2Rt9RO6tKl/SSDznoMSntGmRTiqEF+tTY8dmKxiL/AyvwaWDt4JqyDsiKDU
	aspCrZo9EYYQVVnQMUgtUbxr9hu1AI28Y/R/KEiJ0hkjtLeBtMfejhMe6IkBp4TFImpcc+4g4o0N9
	0XUNuLJxtcG3p/XoBhSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnjWX-000853-IY; Sun, 27 Jan 2019 12:26:53 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnjWS-00084j-PL
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 12:26:51 +0000
Received: by mail-ot1-x341.google.com with SMTP id 81so12456854otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FV09SYoL0F04ZmSUaNF5xOhlXlJTckZ/GU1hR92+CcY=;
 b=MPy5WjsJlaQiwcMncMwsJ5UFS7ZMJeBLA+3P1DRfqyigMRlDTk9SBD7VBGVJuoeFx9
 JCDjwxEkl5hg24uZmIH4BB2qy0LWpSXcPwgO1ZQ8qBkEIy3V+wkESXqmHnh1evX1Lw96
 BUjoydtFnWg2EtZvKpWaPO/1jv2AIrB/z9h2HN+BDIM5ZjbT67YMGjmsHQRGP7umF/dK
 1ZT8KiRNiqIefnlL7tGjWSMzaqzHmh08TGsBHiKFL5NKHiO+FOnTnDMH/MF/0HdcXH+s
 SEvVk1gPv/TITcF+7a/0CQU62H/tvSLC8WW5IRwvxMWmigl2eMja+bwDHo5MCFnH4bHA
 7MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FV09SYoL0F04ZmSUaNF5xOhlXlJTckZ/GU1hR92+CcY=;
 b=uaLjTdFyne3Drw3f4lN9K9cNp6hhrm9Rpkb6jygJsotrJBx/8Fe+h5BovoGTCi62Xs
 fYDMhKtyKzyxRdS2iSWp4nsd5dFNvylMOChOcQUjTsFVSukgfqJYwnSjwSylxCcJ4MuC
 SDKhU/FSuAdctFHutyM6CqlDP/aK4xQQo9OfYEwFBwK3aQ1kybeSetNgfRdLaI6LoBVa
 Keh1JqJvesQqH4ZfDwlOxFo+2I6IALfxfEDeRZK1p7dUJ40KJE9e1FL0ymOBPRAEtfGB
 /+hONHetGmbJwbWFeUIjHUPYxmMm/8n+JvCRVK89Bnpz2vSFpmYO9tsbeeyvXX9gBqUS
 KPPA==
X-Gm-Message-State: AJcUukd49MPxGJEbFjJdATIV8BHhtcUNPDLncZ10HGJ6VRsLIG9I9eog
 tok394ATFOA7bwL9rXsIwuedUX7DbIUFPX60TMcJmw==
X-Google-Smtp-Source: ALg8bN4HwA9drGKobG9D/YBH0b7fqsVPIKzg6dyz6wZHcrg8C9kuTgwJ6Z+iOW8kvKSOrp+9PSPce9tS3QjA86cCAhA=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr9862260otj.301.1548592006116; 
 Sun, 27 Jan 2019 04:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20190108091539.16674-1-brgl@bgdev.pl>
 <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
 <20190122122228.GA2736@kroah.com>
In-Reply-To: <20190122122228.GA2736@kroah.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Sun, 27 Jan 2019 13:26:35 +0100
Message-ID: <CAMpxmJW+ODrqCTSaQMOgRG2d3Qy2SipzYQU3JRPbJE_Wn85H0w@mail.gmail.com>
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_042648_892029_DAFEE8DD 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

d3QuLCAyMiBzdHkgMjAxOSBvIDEzOjIyIEdyZWcgS3JvYWgtSGFydG1hbgo8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IG5hcGlzYcWCKGEpOgo+Cj4gT24gVGh1LCBKYW4gMTAsIDIwMTkgYXQg
MDc6NDM6NDdQTSArMDUzMCwgU2VraGFyIE5vcmkgd3JvdGU6Cj4gPiBIaSBCYXJ0b3N6LAo+ID4K
PiA+IE9uIDA4LzAxLzE5IDI6NDUgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6Cj4gPiA+
IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4g
PiA+Cj4gPiA+IEhpIFNla2hhciwKPiA+ID4KPiA+ID4gbm93IHRoYXQgYWxsIGRlcGVuZGVuY2ll
cyBhcmUgaW4gYW5kIHY1LjAtcmMxIGlzIHRhZ2dlZCwgcGxlYXNlIGNvbnNpZGVyCj4gPiA+IHBp
Y2tpbmcgdXAgdGhlIHNlY29uZCBiYXRjaCBvZiBkYXZpbmNpLXNwZWNpZmljIGNoYW5nZXMgaW50
byB5b3VyIHRyZWUuCj4gPiA+IE9uY2UgdGhhdCdzIGRvbmUsIHBsZWFzZSBwcm92aWRlIG1lIHdp
dGggYW4gaW1tdXRhYmxlIGJyYW5jaCBmb3IgbWUgdG8KPiA+ID4gYXBwbHkgdGhlIGxhc3QgcGF0
Y2ggdG8gbXkgYXQyNCB0cmVlLgo+ID4KPiA+IFlvdSBjYW4gdXNlIGJyYW5jaCB2NS4xL2VlcHJv
bS1mb3ItYmFydG9zeiBpbiBteSB0cmVlIGZvciB0aGlzIChjb21taXQKPiA+IGU0MzA2ODVmNDk2
OSkuCj4gPgo+ID4gPgo+ID4gPiBUaGlzIGlzIHRoZSBzZWNvbmQgcGFydCBvZiB0aGUgZWZmb3J0
IHRvIG1vZGVybml6ZSB0aGUgYXQyNCBkcml2ZXIgYW5kCj4gPiA+IHJlbW92ZSB0aGUgbGVnYWN5
IHBsYXRmb3JtIGRhdGEgc3RydWN0dXJlIGluIGZhdm9yIG9mIGRldmljZSBwcm9wZXJ0aWVzLgo+
ID4gPiBJdCByZXF1aXJlZCBnZXR0aW5nIHJpZCBvZiB0aGUgYXQyNCBzZXR1cCBjYWxsYmFjayBp
biBmYXZvciBvZiBudm1lbQo+ID4gPiBsb29rdXBzLgo+ID4gPgo+ID4gPiBSZS10ZXN0ZWQgd2l0
aCBkYTg1MC1ldm0gYW5kIGRtMzY1LWV2bS4KPiA+Cj4gPiBBcHBsaWVkIHBhdGNoZXMgMS0xMSBm
b3IgdjUuMQo+Cj4gRmVlbCBmcmVlIHRvIHRha2UgcGF0Y2ggMTIgYXMgd2VsbCA6KQoKSGkgR3Jl
ZywKCkkgdG9vayBvdmVyIHRoZSBhdDI0IGRyaXZlciBmcm9tIFdvbGZyYW0gU2FuZy4gSSBjb2xs
ZWN0IHBhdGNoZXMgZm9yCml0IGluIG15IGJyYW5jaCBhbmQgdGhlbiBzZW5kIHB1bGwtcmVxdWVz
dHMgdG8gV29sZnJhbSBkaXJlY3RseS4gSSd2ZQphcHBsaWVkIHRoaXMgcGF0Y2ggdG8gbXkgYnJh
bmNoIGluIGNhc2UgdGhlcmUncyBzb21lIG1vcmUgZGV2ZWxvcG1lbnQKZm9yIGF0MjQgaW4gdGhp
cyBjeWNsZS4gU2VraGFyIHByb3ZpZGVkIG1lIHdpdGggYW4gaW1tdXRhYmxlIGJyYW5jaAp3aXRo
IHRoZSBhcmNoIGNvbW1pdHMgSSBtZXJnZWQgaW4uCgpCZXN0IHJlZ2FyZHMsCkJhcnRvc3ogR29s
YXN6ZXdza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
