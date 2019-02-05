Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F01C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B1A2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ow0J2UlJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I2T7xdo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B1A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KKZdh9yLSuZ2eVjGxOyFEtm52ZcUDtFtncsFidvw9M4=; b=ow0J2UlJNGX+la
	v5k6jo55l1Pn2h+2I6oOLvRMmKysx087MDdrijxxFiwkUsDBOLGZbDVHz07Doj0FHidbDgsK/RpDy
	Tt4OlbKM/Q0YSm5J+1wODsal3h436Mqbq8vmRPFIT3KdCQmM4kGAtpAuSX7YcmTmZDUDZNOuYV/QS
	U+wmVaCXzbLGyCd9o2Lq4iHjTpxnttZKa7BP4+33X2NfA/sfHG42zWVDHIKQFN06NT03dRgwB6SV+
	sJt3yKYzdSPRkgUVbX1XAFkSd8XIvXEhTMam+e3qAWm0+7diGewWrIH2WRcvzy+R1dhGKpvDaRbL4
	OVVmlDeyAItZbB77xanw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3Jb-0004tR-Fb; Tue, 05 Feb 2019 16:11:15 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3JY-0004t1-7I
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:11:13 +0000
Received: by mail-it1-x141.google.com with SMTP id p197so9546404itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PDyxZQez69poaTeCS0qHlzzySskONvPAxl2nUBIaDiw=;
 b=I2T7xdo0NGWBOsDrCPMtF3kcpZzrI+Gp/0XelKJQAke5My9IXWsYa881sq41rS6ar5
 I5QI0nLPhSls1sICAjTUmdC0kjQt7zXT8rKKwbjiWF+PLGiAGK/fv1rrlEtNG3J5fUfL
 mcuP1ZU2bJZM/p2Hil5IVrftiksw/hNmqHCv+qsI7FXqeJ7w2nvDI7PvKsdQg2lUM4su
 KWj7xj4iMU0Zp7QB21DfLjTmq5l/NziDnBa549EL1Zg4Mc9IeWkVlUE1eYuk90WayYI8
 T6dB1Q45y4svkC1G8myc5bdr++RwTyjiT67Uzurn9HXMyM+HCXtMRRE3rbHQlKwAaL33
 2K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PDyxZQez69poaTeCS0qHlzzySskONvPAxl2nUBIaDiw=;
 b=QwbhjRgAgGPXsrJzAto5nqciOEUxgH10QbTg2uJMMKqHT2UlO5ib+nQzltrv/xF2uL
 ig8Q+eC1h7fgKp1vGJBP1jlnTJHLA0l9abmb0ttZJdga+oL+T3viYAcH6vv3UA3NfvRO
 bJIBdtN3/R7y34HsztHoSqdfF2EG0Rp6+3uof6MAGIK7tS7dMS/8bJrdgaE+Q1fWPNAU
 AVyyd/wHH24kcV6D4v7olgsC0xcZ16Y6/eVwEllCDCVruh8nbaCeMnBljXBwc/TGlI8B
 OP9gcEei52g5rI+JO0O21mixxlY6U2QFUYfNMY9eAU5oZYAqTtN1egeZwvXUsP78ZTuq
 hzuA==
X-Gm-Message-State: AHQUAuavZ5+BdZdUUAgBtYxe0gQjUqa8cxl/LcdRxoKQcgbyUqWynXRn
 kR7lK2edz3omWF8h2+ggT7+fqfXzja799XdSEipckw==
X-Google-Smtp-Source: AHgI3Ib8VcJBaKIDYqLflL+TBgTZ+UzWErLpmepkjsFM4MeivJf9N8w9cvtD4ABW8Z2p76z3fScOxgV3RzpnAu4O/+8=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr574765iop.258.1549383071140; 
 Tue, 05 Feb 2019 08:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
In-Reply-To: <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Feb 2019 17:11:00 +0100
Message-ID: <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_081112_318586_B88551AA 
X-CRM114-Status: GOOD (  13.78  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cG9uLiwgNCBsdXQgMjAxOSBvIDIyOjQ5IERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xvZ3ku
Y29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDEvMzEvMTkgNzozOCBBTSwgQmFydG9zeiBHb2xhc3pl
d3NraSB3cm90ZToKPiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBi
YXlsaWJyZS5jb20+Cj4gPgo+ID4gVGhpcyBzZXJpZXMgcG9ydHMgdGhlIGRhdmluY2kgcGxhdGZv
cm0gdG8gdXNpbmcgU1BBUlNFX0lSUSwgY2xlYW5zIHVwCj4gPiB0aGUgaXJxY2hpcCBkcml2ZXJz
IGFuZCBtb3ZlcyB0aGVtIG92ZXIgdG8gZHJpdmVycy9pcnFjaGlwLgo+ID4KPgo+IFRoaXMgaGFz
IGJlZW4gb24gbXkgdG9kbyBsaXN0IGZvciB5ZWFycywgYnV0IEkndmUgbmV2ZXIgaGFkIGVub3Vn
aAo+IHRpbWUgdG8gZmlndXJlIGl0IG91dC4gTmljZSB0byBzZWUgaXQgZmluYWxseSBnZXR0aW5n
IGRvbmUhCj4KPiBTZXJpZXMgdGVzdGVkIG9uIExFR08gTUlORFNUT1JNUyBFVjMgKGRhODUwLWxp
a2UpLiBJIGNhbiBub3cgdXNlCj4gSUlPIHRyaWdnZXJzIHdpdGhvdXQgaGF2aW5nIHRvIHBhdGNo
IHRoZSBrZXJuZWwgdG8gYWRkIGV4dHJhCj4gaW50ZXJydXB0cy4KPgo+IFRlc3RlZC1ieTogRGF2
aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5jb20+Cj4KPgoKV293IHRoYW5rcyBmb3IgdGFr
aW5nIHRoZSB0aW1lIHRvIHJldmlldyBpdCEKCkknbGwgYWRkcmVzcyBjZXJ0YWluIHJlbWFya3Mg
LSBmb3IgdGhvc2UgdW5hZGRyZXNzZWQgLSBJJ2xsIGZpeCB0aGVtIGluIHYyLgoKU2VraGFyOiBh
cmUgeW91IGZpbmUgd2l0aCBzZW5kaW5nIGJvdGggdGhlIGNsb2Nrc291cmNlIGFuZCBpbnRlcnJ1
cHQKc2VyaWVzIHRvZ2V0aGVyIG5leHQgdGltZSB3aXRoIGFkZGl0aW9uYWwgcGF0Y2hlcyBvbiB0
b3AgbWFraW5nCmRhdmluY2kgcGFydCBvZiBtdWx0aV92NV9kZWZjb25maWc/CgpCZXN0IHJlZ2Fy
ZHMsCkJhcnRvc3ogR29sYXN6ZXdza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
