Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FBDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:04:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E346920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SUhL68yV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pm+jw6fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E346920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hWYmedpZ7PV3Vz8wFkqDr0/FaG9r/JkUGU1O4TLBXik=; b=SUhL68yVDP/V12
	jQ8IPk6oa12ROzMrHo6hEquW89Sscl3eJS17VuGK1zOIhpvG5EekQAwwBmFPh0QsP3rlLXEVdvrNj
	YLY2FwrbtNXFj6QCLeT5kiNoj59Zv9SsxbIUE+FeabTFPBsJ/r1erm7C/hVEbX0NhGcMA8f5IKLt1
	qoHGHCYHq6uwOJEGIUjppFpHrHq5t2h8giUpsw1Wt9lX0janq/L1ZbPEmgt+JiYeUyHc/Rqnz8osr
	6B1dP7DY0BmCpLP2zUVrM2Aq/rCThhsSjuSgZ79cggD9uYtWn+bMeAEVaurwbQSddjL7msPKVp+w3
	u/8L/s3GyjLgiWPu8qTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs8dH-0000k1-RW; Fri, 08 Feb 2019 16:04:03 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs8dF-0000jH-1x
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:04:02 +0000
Received: by mail-it1-x143.google.com with SMTP id z7so9969467iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MN+tt0M/O3yQP7ix9uKQqFk42RY7a7HW2j0BfCCiIlg=;
 b=pm+jw6fKPJ+4WZqGC2IvbXEdpH+pMkh7cHaOfoX4GzcTbYnp9Yppk5pR5PvDhqKhOW
 70p+ry4NBAz6fmWq0j4b+hQfEHj8cwoUaD64AITLKuSglBVyogFRsQVZEgr9zHOF2kXK
 lp13/5VmthzmPzLO3r0+2CKpbyQbpP0t6PGACCESOYKr/M23SIen+PXmrtqmTlG23I1b
 f/MUfjECBo3rzuWnGbeTMnbGc6LyButwVG4rWFeWmAVTYzUUyHzINMIZscvocwo8MInI
 lzK2FDfOIYXiFNw90dysA8r3DdCPfQbih1bQ4qWYFKb1YEREr0j5vz2KGlg13cCc54pp
 cvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MN+tt0M/O3yQP7ix9uKQqFk42RY7a7HW2j0BfCCiIlg=;
 b=LUxSgnYs7CO5KtGlI3vn/XjmFDYgLHT6IU4Lt8qFXn2T2Qw0uFQ9LlLdwbVNzZJOF2
 qMeBxKvX0f9iF/s/zlEiwf42YNNxLle86Edm3MuGI2ZqD6diTIkhdM/aTsquDPUeC8Z6
 8R72ok0ZgROvq2pkbIpJsktbPduMSlIwdqDK8XZmosBsNSXLl6NzGWXDNrr6iCF/wBFv
 bMO9R8crT2f9ZYJYTy0oYld0KyZ8S7AACBvLIKpJZ2aApLpq0VM66p7T3Z40pcLb1L9l
 zmKsCwFC5KrPSp1LKVXcXwWRK/TyMmWHrFJtfWhPOG3PyDtaxsJmu5sH85FCXQ1mqsJo
 vNTA==
X-Gm-Message-State: AHQUAuaztQIKANTMWq4DH30EE6Wd/Ak82sMxarI6X5S2gSMAy+U3wxap
 uNu8avjsaNnyeozmsbq/X+WG7H6XzAB1Z2rGyjlUkQ==
X-Google-Smtp-Source: AHgI3IZRv64cdRpB2Qx2UCcSsdUrNleNlxRVqgghTFMUwNS33e0B14YnixZzHQYKYfw3ev9kM6CkLjGFTT8XM61uz2Q=
X-Received: by 2002:a24:5d94:: with SMTP id w142mr7077266ita.74.1549641839811; 
 Fri, 08 Feb 2019 08:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-19-brgl@bgdev.pl>
 <9fb82a77-9732-b9ec-5394-c6a5148b4f7f@lechnology.com>
In-Reply-To: <9fb82a77-9732-b9ec-5394-c6a5148b4f7f@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 8 Feb 2019 17:03:49 +0100
Message-ID: <CAMRc=MdCbeaRr54pyPvc9cKBD9=Rz2H-S6cFaNzpkGMkfwthAw@mail.gmail.com>
Subject: Re: [PATCH 18/35] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_080401_239771_036ADDB6 
X-CRM114-Status: GOOD (  14.10  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

d3QuLCA1IGx1dCAyMDE5IG8gMDA6NDMgRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5j
b20+IG5hcGlzYcWCKGEpOgo+Cj4gT24gMS8zMS8xOSA3OjM5IEFNLCBCYXJ0b3N6IEdvbGFzemV3
c2tpIHdyb3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJh
eWxpYnJlLmNvbT4KPiA+Cj4gPiBUaGUgYWludGMgZHJpdmVyIGhhcyBub3cgYmVlbiBjbGVhbmVk
IHVwLiBNb3ZlIGl0IHRvIGRyaXZlcnMvaXJxY2hpcAo+ID4gd2hlcmUgaXQgYmVsb25ncy4gVGhl
cmUncyBubyBkZXZpY2UtdHJlZSBzdXBwb3J0IGZvciBhbnkgZG0qIGJvYXJkIHNvCj4gPiB0aGVy
ZSdzIG5vIElSUUNISVBfT0ZfREVDTEFSRSgpIC0gdGhlcmUncyBvbmx5IHRoZSBleHBvcnRlZCBp
bml0Cj4gPiBmdW5jdGlvbiBjYWxsZWQgZnJvbSBtYWNoaW5lIGNvZGUuCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4K
PiA+IC0tLQo+Cj4gUmV2aWV3ZWQtYnk6IERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xvZ3ku
Y29tPgo+Cj4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZyBiL2RyaXZl
cnMvaXJxY2hpcC9LY29uZmlnCj4gPiBpbmRleCAzZDFlNjA3NzkwNzguLmVhMGViODJiZjFkMiAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9LY29uZmlnCj4gPiArKysgYi9kcml2ZXJz
L2lycWNoaXAvS2NvbmZpZwo+ID4gQEAgLTEyOSw2ICsxMjksMTEgQEAgY29uZmlnIEJSQ01TVEJf
TDJfSVJRCj4gPiAgICAgICBzZWxlY3QgR0VORVJJQ19JUlFfQ0hJUAo+ID4gICAgICAgc2VsZWN0
IElSUV9ET01BSU4KPiA+Cj4gPiArY29uZmlnIERBVklOQ0lfQUlOVEMKPiA+ICsgICAgIGJvb2wK
PiA+ICsgICAgIHNlbGVjdCBHRU5FUklDX0lSUV9DSElQCj4gPiArICAgICBzZWxlY3QgSVJRX0RP
TUFJTgo+Cj4gTm8gaGVscCBzZWN0aW9uPyA6LSkKPgoKTW9zdCBLY29uZmlnIG9wdGlvbnMgdGhh
dCBjYW5ub3QgYmUgaW50ZXJhY3RpdmVseSBzZWxlY3RlZCBkb24ndCBoYXZlIG9uZS4KCkknbGwg
bGVhdmUgaXQgYXMgaXMuCgpCYXJ0Cgo+ID4gKwo+ID4gICBjb25maWcgRFdfQVBCX0lDVEwKPiA+
ICAgICAgIGJvb2wKPiA+ICAgICAgIHNlbGVjdCBHRU5FUklDX0lSUV9DSElQCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
