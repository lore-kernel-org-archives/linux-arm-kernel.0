Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6071C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:17:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF3F217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QLdOJmX8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U8N1OMsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF3F217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LYsWOWy/ynFhMoJWC08Sm7SCuV+qpt+YZQrvc6aliY0=; b=QLdOJmX8aIug+2
	dJodAVob66HELTAN/4WkpiTRGka8q/Zuac5PdKuQTfoMW6Z04pIfadaHSDP8K44JXicXXaGcaebnN
	I89hy85sx3ecsWNEipPDa264OoElIU+C25pqEf4rR0AJ6u4xg7g+0NhdX6EgP8OKQ+aDYtMMWiQ+Y
	ZBgZKTLe1uBBhbR8U40NJWqljnPU6iL6L+0RxvnARZr16h+bQ8bhNZmU1dHixF6jYYOIpG6q9CGuT
	mQsJOlRaftkbC3c8JeBepi65EPw00D1DRSus9PQt3Y1r8LdhArcJ3s5lHz++gR/hxUiaP0lBcnR+B
	lyfm7s3oGsBHgz6Pj50w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3PV-0007r6-5f; Tue, 05 Feb 2019 16:17:21 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3PR-0007ql-Tp
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:17:19 +0000
Received: by mail-it1-x141.google.com with SMTP id p197so9603469itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bWb0pTnxhTUoywQeJFRJm0IcTK2TaI60KgoBc9nmwE4=;
 b=U8N1OMsOPN6G4pTD4KAVeKdHbThz2yJ6CbvowqBc13Qr60A0YCJCYtwEmeKqlsuRms
 vOE8Sl2bxyfLQdOYHcMWciYcgLUdDvUPtPnzTR6E9S2auZNbflrSUhNRNXwUPr7uCZlY
 2IZm4Hb8Qb5k2jOgle2GmFrmT4sue0TbOAmE2WLH2uei/HsnfDrF9PaU5rgI3AAVNiTW
 KxNGCb/yvqXZfblr1fuAdG4AoAjhSG4+IDK9dGyJ0kppMry0ItSZE3vag0zLhQTManFI
 SDji2+PdoZ23slIpEJwnBzNNH5jtPNndf5BZAntZ8wV9lUgEp7cwFweh3KP0XCx6ZUSQ
 MvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bWb0pTnxhTUoywQeJFRJm0IcTK2TaI60KgoBc9nmwE4=;
 b=bGAkGHzNW6c3VurBXhmRlf09O2PyZZhKzZUnxakxM5OxsH4v85BPrONds3AHM4mk6q
 Os+TCAKTB0GhNgn5nrfMarp/7XTst0vup6mz9elVEDgKSzfxeWYecb0pCszvFJkIDKG3
 w0BT+XbcIkOcdit5psG5gywLvCiLleJfU+myVXZPha8LYIHM/m20Z3yhZ1Qpcd591GHW
 2on1+04aCPXOL/ty3hcAm7R+BNDY9qhZE3sjpF56TOfcosAl0rJ+xukGmrnhZeechBLn
 bo+RTZ1BI1On2aKV3ApMQT7eR1iOv1ntgCKOjt/WL1TiCNqIR78zxkBGnRCgHRi6qufT
 GTog==
X-Gm-Message-State: AHQUAuZX4U3oMPydW14Lpk4uBTPQ3nKa20zdNjyC5Me1QeleFNLlh3lx
 C0AZrxQZYF2BMiXdbTdeIEEof8sgtEbha7G6lKwJCA==
X-Google-Smtp-Source: AHgI3IbdOB8y/dhjA5XybzsPChOIGqtI0ow010aYaynTBzpSZxB30d59gG55hQT0MWOh3xvTN9ICw2F2u8ufatCT0UQ=
X-Received: by 2002:a24:9d1:: with SMTP id 200mr3386013itm.53.1549383437227;
 Tue, 05 Feb 2019 08:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-7-brgl@bgdev.pl>
 <b06cd3b4-b960-15cb-1bf4-f389e18248ac@lechnology.com>
In-Reply-To: <b06cd3b4-b960-15cb-1bf4-f389e18248ac@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Feb 2019 17:17:06 +0100
Message-ID: <CAMRc=MefvcH3HXp4dpnD6D6m9vnPSJLtLmt7LFG+i0dLSfSmgg@mail.gmail.com>
Subject: Re: [PATCH 06/35] ARM: davinci: wrap interrupt definitions with a
 macro for SPARSE_IRQ
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_081717_957582_F3BB082B 
X-CRM114-Status: GOOD (  13.89  )
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

cG9uLiwgNCBsdXQgMjAxOSBvIDIzOjMyIERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xvZ3ku
Y29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDEvMzEvMTkgNzozOCBBTSwgQmFydG9zeiBHb2xhc3pl
d3NraSB3cm90ZToKPiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBi
YXlsaWJyZS5jb20+Cj4gPgo+ID4gVGhpcyBpcyBkb25lIGluIHByZXBhcmF0aW9uIGZvciBzZWxl
Y3RpbmcgQ09ORklHX1NQQVJTRV9JUlEuIFRoZQo+ID4gaW50ZXJydXB0IG51bWJlcnMgd2lsbCB0
aGVuIHN0YXJ0IGF0IHRoZSBwcmVkZWZpbmVkIE5SX0lSUVMgb2Zmc2V0Lgo+ID4KPiA+IEZvciBu
b3cgd3JhcCBhbGwgaW50ZXJydXB0IG51bWJlcnMgd2l0aCBhIG1hY3JvIGFuZCBkZWZpbmUKPiA+
IERBVklOQ0lfSU5UQ19TVEFSVCB0byAwLiBMb2dpY2FsbHkgbm90aGluZyBjaGFuZ2VzIGZvciBu
b3cuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3
c2tpQGJheWxpYnJlLmNvbT4KPiA+IC0tLQo+Cj4gUmV2aWV3ZWQtYnk6IERhdmlkIExlY2huZXIg
PGRhdmlkQGxlY2hub2xvZ3kuY29tPgo+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1k
YXZpbmNpL2luY2x1ZGUvbWFjaC9pcnFzLmggYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvaW5jbHVk
ZS9tYWNoL2lycXMuaAo+ID4gaW5kZXggMDNjNDQ2NjM1MzAxLi4xNGZhNjY4ZDRlOGQgMTAwNjQ0
Cj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvaW5jbHVkZS9tYWNoL2lycXMuaAo+ID4g
KysrIGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2luY2x1ZGUvbWFjaC9pcnFzLmgKPiA+IEBAIC0z
MCwzNzEgKzMwLDM3NCBAQAo+ID4gICAvKiBCYXNlIGFkZHJlc3MgKi8KPiA+ICAgI2RlZmluZSBE
QVZJTkNJX0FSTV9JTlRDX0JBU0UgMHgwMUM0ODAwMAo+ID4KPiA+ICsjZGVmaW5lIERBVklOQ0lf
SU5UQ19TVEFSVCAgICAgICAgICAgMAo+ID4gKyNkZWZpbmUgREFWSU5DSV9JTlRDX0lSUShfaXJx
bnVtKSAgICAoREFWSU5DSV9JTlRDX1NUQVJUICsgKF9pcnFudW0pKQo+Cj4gQWxtb3N0IG5vdCB3
b3J0aCBtZW50aW9uaW5nLCBidXQgREFWSU5DSV9JTlRDX1NUQVJUIGlzIG9ubHkKPiBldmVyIHVz
ZWQgb25jZSwgc28gaXQgY291bGQgYmUgb21pdHRlZC4KCkknZCBsaWtlIHRvIGxlYXZlIGl0IGhl
cmUgLSBpdCdzIG1vcmUgcmVhZGFibGUgdGhhdCB3YXkuCgpCYXJ0CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
