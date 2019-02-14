Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6FA2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ApAJTJ7Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QZi7V+Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6FA2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mqF1d4/+Jd5m+HOa7seDIZGjlgQxPuphAEZ7Vrl3/is=; b=ApAJTJ7YHTPe4k
	7l+1JM0QFxXxHUjv3yonXc2Qa6snjS7EFxMibFWFo23+YnGq7bGp+Y8vorPXmckxYcQvo7U7QQ1cd
	hcMJ69PCsCZkTBV+E6z15s1+o2Mrjva0dm3MYxU+fgi1CWcMIilOHU81XKSmfrIiTdUVuU+qRP30x
	OefDwNOwnlfjIslO50bt60YZJ2bKzTtac7JKbFOco7Y8MrXEHTsiG2c6/lXFQmJL53qTWqZHnDt9D
	Iw/+gS4t7ixnQfrOofCXEQLd8K4A6ksqB4YOP989oSCvzmsHp6zjh0Q4ZsdPkU4ZSq41SZDbEq/V0
	CGf6PRk5AOR3wQpXNLRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGYw-0003iD-OR; Thu, 14 Feb 2019 12:56:22 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGYs-0003hc-Ta
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:56:20 +0000
Received: by mail-it1-x141.google.com with SMTP id l66so3987256itg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Naz9FCzf1rH5LzFaQw/O1btRmOdZ7nny+7TBXg4tchU=;
 b=QZi7V+FaORpgSTBl1SDpYJw1fLB9lo7PSNHv1iDB9VNCPRJ5DSftSdH/iK3BlC81YB
 Yc5qbMVnGYP35FQ6hOUD1rjr9ydZ8CErWyoIWH1/16DMHTMukZ0GbGnbSnJJzctTI6B6
 RSGtKu+9OnxpNDxLL1f96wHgRSGN0x0sflf6X4v41/WuJaEu/WVsnJAsnVX/UFMxSrX0
 SP8r3fAOVfrX60UeTzJc09KAKyXswvZmBeJPb2K5gw2TyFWKVaAxfmwqDkZCsAGTB7m4
 A9N59d8b8jRkVTDEy/7rb9KgJ4UiyFNk2/3ropa8MSeeQuKQ9yVvgHICDabYsCbLQK+r
 zrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Naz9FCzf1rH5LzFaQw/O1btRmOdZ7nny+7TBXg4tchU=;
 b=GhKQMJF3QuKHur41KtxIIRGyxXGwB846KGcPoCuZboAYRTN+0jERch5purFiofBYLh
 8TJmVgbbd7Dba/dApU8kxH61cj9AN9WAC4HfFJofTG4F263PUk2ZInxCcupNMXpSOIRf
 jab7dL3HrGQYMEC0lyZwECy1AQ/PUwOuuw8DJJG6k4bP8T7SY3J2LUVHv+Id/R97QGDH
 q6OfhMPJRFZxxHb+kur+UWtD/0HBbZGrc9a+hBsvTD0bol1v1MdwiytwoD2Zg5IZ8T2h
 1Q/tkAKQ5qdbDzEjC/eVNPP8Ic8jSSEsybgGOsjSyTzWbSQtB2WXquTfXuMEWRAzf/33
 Sh6Q==
X-Gm-Message-State: AHQUAubQz+C/WotO3+M+eBEgZnhcGyPVj+J4hjw/jurmwAhoLBKI3eYS
 ZZ7iaX9ztPSHW5ofmjX0MsisznWSjoDijqdnFejD7w==
X-Google-Smtp-Source: AHgI3IZH6WSDvcG0nUPTCHoLLcxaePz6qJAANdijsV4E1HiC6aMrDz0xevkm5SyOGdLJEjIaaU45vbb1KhABg4wyXKs=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1760175ite.74.1550148977354; 
 Thu, 14 Feb 2019 04:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20190212103835.7768-1-brgl@bgdev.pl>
 <20190212103835.7768-21-brgl@bgdev.pl>
 <86mumyskmg.wl-marc.zyngier@arm.com>
 <28ca2198-ebe9-43b8-fcd6-c6dbd2939987@ti.com>
In-Reply-To: <28ca2198-ebe9-43b8-fcd6-c6dbd2939987@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Feb 2019 13:56:06 +0100
Message-ID: <CAMRc=Md+SPxKvHPz63SW84eSVopTesQ-MhX_yeQZ1OEserptLA@mail.gmail.com>
Subject: Re: [PATCH v3 20/37] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_045619_018309_F3B05113 
X-CRM114-Status: GOOD (  21.05  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Y3p3LiwgMTQgbHV0IDIwMTkgbyAxMzo0NCBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5h
cGlzYcWCKGEpOgo+Cj4gT24gMTQvMDIvMTkgNDoyNyBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+
ID4gT24gVHVlLCAxMiBGZWIgMjAxOSAxMDozODoxOCArMDAwMCwKPiA+IEJhcnRvc3ogR29sYXN6
ZXdza2kgPGJyZ2xAYmdkZXYucGw+IHdyb3RlOgo+ID4+Cj4gPj4gRnJvbTogQmFydG9zeiBHb2xh
c3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiA+Pgo+ID4+IEkndmUgYmVlbiB1
bmFibGUgdG8gZmlndXJlIG91dCBleGFjdGx5IHdoeSwgYnV0IGl0IHNlZW1zIHRoYXQgdGhlCj4g
Pj4gSVJRX1RJTlQxX1RJTlQzNCBpbnRlcnJ1cHQgZm9yIHRpbWVyIDEgbmVlZHMgdG8gYmUgaGFu
ZGxlZCBhcyBhCj4gPj4gbGV2ZWwgaXJxLCBub3QgZWRnZSBsaWtlIGFsbCBvdGhlcnMuCj4gPj4K
PiA+PiBMZXQncyBtb3ZlIHRoZSBoYW5kbGVyIHNldHVwIG91dCBvZiB0aGUgYWludGMgZHJpdmVy
IHdoZXJlIGl0J3MgbGl2ZWQKPiA+PiBzaW5jZSB0aGUgYmVnaW5uaW5nIGFuZCBpbnRvIHRoZSBk
bSogU29DLXNwZWNpZmljIGZpbGVzIHdoZXJlIGl0Cj4gPj4gYmVsb25ncy4KPiA+Pgo+ID4+IFNp
Z25lZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5j
b20+Cj4gPj4gLS0tCj4gPj4gIGFyY2gvYXJtL21hY2gtZGF2aW5jaS9kbTM1NS5jICB8IDggKysr
KysrKysKPiA+PiAgYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RtMzY1LmMgIHwgOCArKysrKysrKwo+
ID4+ICBhcmNoL2FybS9tYWNoLWRhdmluY2kvZG02NDR4LmMgfCA4ICsrKysrKysrCj4gPj4gIGFy
Y2gvYXJtL21hY2gtZGF2aW5jaS9kbTY0NnguYyB8IDggKysrKysrKysKPiA+PiAgYXJjaC9hcm0v
bWFjaC1kYXZpbmNpL2lycS5jICAgIHwgMyAtLS0KPiA+PiAgNSBmaWxlcyBjaGFuZ2VkLCAzMiBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtZGF2aW5jaS9kbTM1NS5jIGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RtMzU1LmMK
PiA+PiBpbmRleCBjN2NkNzY1MTE0YWYuLmE3MzJmMmVhMWQ5YSAxMDA2NDQKPiA+PiAtLS0gYS9h
cmNoL2FybS9tYWNoLWRhdmluY2kvZG0zNTUuYwo+ID4+ICsrKyBiL2FyY2gvYXJtL21hY2gtZGF2
aW5jaS9kbTM1NS5jCj4gPj4gQEAgLTE1LDYgKzE1LDcgQEAKPiA+PiAgI2luY2x1ZGUgPGxpbnV4
L2RtYS1tYXBwaW5nLmg+Cj4gPj4gICNpbmNsdWRlIDxsaW51eC9kbWFlbmdpbmUuaD4KPiA+PiAg
I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KPiA+PiArI2luY2x1ZGUgPGxpbnV4L2lycS5oPgo+ID4+
ICAjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9pcnEtZGF2aW5jaS1haW50Yy5oPgo+ID4+ICAjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGF0YS9lZG1hLmg+Cj4gPj4gICNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kYXRhL2dwaW8tZGF2aW5jaS5oPgo+ID4+IEBAIC03NDQsNiArNzQ1LDEzIEBAIHZv
aWQgX19pbml0IGRtMzU1X2luaXRfdGltZSh2b2lkKQo+ID4+ICAgICAgcHNjID0gaW9yZW1hcChE
QVZJTkNJX1BXUl9TTEVFUF9DTlRSTF9CQVNFLCBTWl80Syk7Cj4gPj4gICAgICBkbTM1NV9wc2Nf
aW5pdChOVUxMLCBwc2MpOwo+ID4+Cj4gPj4gKyAgICAvKgo+ID4+ICsgICAgICogTm9ib2R5IGtu
b3dzIHdoeSBhbnltb3JlLCBidXQgdGhpcyBpbnRlcnJ1cHQgaGFzIGJlZW4gaGFuZGxlZCBhcwo+
ID4+ICsgICAgICogYSBsZXZlbCBpcnEgZnJvbSB0aGUgdmVyeSBiZWdpbm5pbmcgb2YgZGF2aW5j
aSBzdXBwb3J0IGluIG1haW5saW5lCj4gPj4gKyAgICAgKiBsaW51eC4KPiA+PiArICAgICAqLwo+
ID4+ICsgICAgaXJxX3NldF9oYW5kbGVyKERBVklOQ0lfSU5UQ19JUlEoSVJRX1RJTlQxX1RJTlQz
NCksIGhhbmRsZV9sZXZlbF9pcnEpOwo+ID4+ICsKPiA+Cj4gPiBJJ3ZlIHNhaWQgaXQgb24gdjIs
IEknbSByZXBlYXRpbmcgaXQgb24gdjMuIFRoZXJlIGlzIG5vIHBvaW50IGluCj4gPiBkdXBsaWNh
dGluZyB0aGlzIHBvaW50bGVzcyBoYWNrIG9uIGFuZCBvbiBhZ2Fpbi4gSWYgdGhlcmUgaXMgYSBk
cml2ZXIKPiA+IHVzaW5nIHRoaXMgaW50ZXJydXB0LCBtb3ZlIHRoZSBzZXR1cCB0aGVyZSwgYW5k
IGZpeCB0aGUgaXJxX3NldF90eXBlCj4gPiBjYWxsYmFjay4KPiA+Cj4gPiBJZiBub3RoaW5nIGlz
IHVzaW5nIGl0LCByZW1vdmUgaXQgYWx0b2dldGhlci4KPgo+IEFscmlnaHQsIGZpbmUgd2l0aCBt
ZSBhcyB3ZWxsLiBEcm9wcGluZyB0aGUgaGFjayBpcyBmaW5lLiBBbmQgSSB0aGluawo+IHRoYXQg
anVzdCBib2lscyBkb3duIHRvIGRpc2NhcmRpbmcgdGhpcyBwYXRjaC4KPgoKQWN0dWFsbHkgdGhp
cyBwYXRjaCBzaG91bGQgc2ltcGx5IHJlbW92ZSB0aGUgY2FsbCB0byBpcnFfc2V0X2hhbmRsZXIo
KQpmcm9tIHRoZSBkcml2ZXIuCgpCYXJ0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
