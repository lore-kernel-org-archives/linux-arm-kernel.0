Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97438C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:39:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673CB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ivIxcric";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Hs4YDnIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673CB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QlYIyfNNvFrlPmZKYiU7BHeMOA9Rj/JpNfa2VAfRBJA=; b=ivIxcriczgW+0X
	Jm8rcMC7CFfNSy3Z8jEtHkIVBX0zsucfvV85POvuygUi3ZDvWxneT576nkhD4mRzJEGMcoePPW2+5
	tx43CXJIgGRFEV8hoVdr5VDzLGotCgl/Id7kNTM+Q0NvFKB1YQcD3vuv55GDUSImS/xDqLAf06smE
	90mxLnCCfINCNmItZ0Oim7iW/hy5Box01zzj3wOjAI6Aqnv8bN4HUaj907UYFh9BWUdoYdss6BkBx
	bPBREF3wk+hF3p1wU/QeD/Zm8PvmWb0nFJskZDAouG8JpZmeJ/QWoLhn8a0LW/XOs0a5Db/DXGMsm
	CKQ9zJmPWVqajKD4ga4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5Gh-00050p-Lg; Mon, 14 Jan 2019 16:39:19 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Ge-00050G-06
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:39:17 +0000
Received: by mail-it1-x142.google.com with SMTP id c9so296311itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4eMAoM3dueu9tdN2alk+e9naC0qCTwzhI+dbVx9zeuM=;
 b=Hs4YDnINzRcBymtgkH1QjDkRRKyjvdS5hg31F7QmIex88RXSDaogmf35wwbz5GbqbL
 LJr0WBRI/oCxHhMswne/U0LVhC2gc8omHqgavlFzSJo2zl7ByYSUjSBEHfGbqVZwuffo
 BXD0sYbrDKSsB523hSAWzEgm1d06IBvOwmYpg8gODvSzOm53CFABMzFk4Dpevlz38jDO
 tVpstyf75J6/lim2xRvcxLKWIIHKI01Q46wW2J9KtR8Tok+7LgyVm0KqVaW/OMXez8v/
 dEDOtoT6SAYAzX2LtJIQnlSn7PmwEEgHfs3B5TcKQNjYcSJ2dL3Y3J2kTvrpIe6z/Z98
 HSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4eMAoM3dueu9tdN2alk+e9naC0qCTwzhI+dbVx9zeuM=;
 b=XTYG9mbWBrB/PE5NYXdmNQg7tnEdzc1JAFx5e8xAT6GKevY1AFfmHc7LiwjLTc69oU
 ptGv08D1TpLLFjijnnmw0/QVl2le6Oa6pVydEzL1oZbXrhL8vHxw6zHnjyIV1MgHSTF1
 MSSuHVy2e4+Usmwh6KjaQ8UtFVgjp4rcdyxKCnnnRqqjMMwsRF2RsuhQJHfjz6ia1xvc
 kqQhqzDEpg5u80cqbGIUqVnsFDCAvllSAK1Qwh1Urf0e2v5MtnYamNy45bpB6X7IFpfE
 OS8lD6+9nBth+9vfWuvHL2BL4HCq+LBROnZc7UinCD6vULxUlG3fjvAqT04xve0/palO
 Ir9g==
X-Gm-Message-State: AJcUukeJZJKZQyx856GcCfhCCFT8hYyPnwwbQvA0AsNPODv4GskUfbIT
 vnoPdMJYHrvZDIgIoRw7mE3z1H5y1pYBLZuESR+Cag==
X-Google-Smtp-Source: ALg8bN5tcnmDdiIhUssiiqYEaqTx2Ak6DZXtkaUHCjh/XhooSc7fj9HDS3Cld/xcZY5YqzyuojgR8k3Y8nZm5IB2h28=
X-Received: by 2002:a24:f909:: with SMTP id l9mr22116ith.74.1547483954668;
 Mon, 14 Jan 2019 08:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
In-Reply-To: <08200de1-fde5-c525-c874-c7872259067b@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Jan 2019 17:39:03 +0100
Message-ID: <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_083916_089887_3FA3FEE6 
X-CRM114-Status: GOOD (  24.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cG9uLiwgMTQgc3R5IDIwMTkgbyAxMzoyMCBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5h
cGlzYcWCKGEpOgo+Cj4gSGkgQmFydG9zeiwKPgo+IE9uIDExLzAxLzE5IDEwOjUxIFBNLCBCYXJ0
b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8Ymdv
bGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiA+Cj4gPiBDdXJyZW50bHkgdGhlIGNsb2Nrc291cmNl
IGFuZCBjbG9ja2V2ZW50IHN1cHBvcnQgZm9yIGRhdmluY2kgcGxhdGZvcm1zCj4gPiBsaXZlcyBp
biBtYWNoLWRhdmluY2kuIEl0IGhhcmQtY29kZXMgbWFueSB0aGluZ3MsIHVzZWQgZ2xvYmFsIHZh
cmlhYmxlcywKPiA+IGltcGxlbWVudHMgZnVuY3Rpb25hbGl0aWVzIHVudXNlZCBieSBhbnkgcGxh
dGZvcm0gYW5kIGhhcyBjb2RlIGZyYWdtZW50cwo+ID4gc2NhdHRlcmVkIGFjcm9zcyBtYW55IChv
ZnRlbiB1bnJlbGF0ZWQpIGZpbGVzLgo+ID4KPiA+IEltcGxlbWVudCBhIG5ldywgbW9kZXJuIGFu
ZCBzaW1wbGlmaWVkIHRpbWVyIGRyaXZlciBhbmQgcHV0IGl0IGludG8KPiA+IGRyaXZlcnMvY2xv
Y2tzb3VyY2UuIFdlIHN0aWxsIG5lZWQgdG8gc3VwcG9ydCBsZWdhY3kgYm9hcmQgZmlsZXMgc28K
PiA+IGV4cG9ydCBhIGNvbmZpZyBzdHJ1Y3R1cmUgYW5kIGEgZnVuY3Rpb24gdGhhdCBhbGxvd3Mg
bWFjaGluZSBjb2RlIHRvCj4gPiByZWdpc3RlciB0aGUgdGltZXIuCj4gPgo+ID4gV2UgZG9uJ3Qg
Y2hlY2sgdGhlIHJldHVybiB2YWx1ZXMgb2YgcmVnbWFwIHJlYWRzIGFuZCB3cml0ZXMgc2luY2Ug
d2l0aAo+ID4gbW1pbyBpdCdzIG9ubHkgbGlrZWx5IHRvIGZhaWwgZHVlIHRvIHByb2dyYW1tZXIn
cyBlcnJvcnMuCj4gPgo+ID4gV2UgYWxzbyBkb24ndCBib3RoZXIgZnJlZWluZyByZXNvdXJjZXMg
b24gZXJyb3JzIGluCj4gPiBkYXZpbmNpX3RpbWVyX3JlZ2lzdGVyKCkgYXMgdGhlIHN5c3RlbSB3
b24ndCBib290IHdpdGhvdXQgYSB0aW1lciBhbnl3YXkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
QmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPgo+IFdpdGgg
dGhpcyBzZXJpZXMsIERBODMwIGZhaWxzIHRvIGJvb3QuIFJlc3Qgb2YgdGhlIGRldmljZXMgYXJl
IG9rYXkgZnJvbQo+IGJvb3QgcGVyc3BlY3RpdmUuCj4KPiBEQTgzMCBpcyBwcmV0dHkgdW5pcXVl
IGJlY2F1c2UgaXQgdXNlcyB0aGUgc2FtZSB0aW1lci1oYWxmIGZvciBib3RoCj4gY2xvY2tzb3Vy
Y2UgYW5kIGNsb2NrZXZlbnQuIE1heSBiZSB5b3UgY2FuIHNldCB0aGUgc2FtZSBjb25maWd1cmF0
aW9uIG9uCj4geW91ciBEQTg1MCB0byBzZWUgdGhlIHNhbWUgaXNzdWU/IEVsc2UsIEkgd2lsbCBl
bmFibGUgbG93LWxldmVsIGRlYnVnCj4gYW5kIHRyeSB0byBwcm92aWRlIG1vcmUgZGVidWcgZGF0
YS4KPgoKSSBjYW4ndCBib290IGRhODUwIHdpdGggdGhlIHNhbWUgY29uZmlnIGFzIGRhODMwICgw
eDYwIGNvbXBhcmUKcmVnaXN0ZXIsIGNvbXBhcmUgaXJxIDc0KSBldmVuIHdpdGggdGhlIG9sZCB0
aW1lciBjb2RlLiBKdXN0IHRvIG1ha2UKc3VyZTogZG9lcyBkYTgzMCBib290IGZpbmUgd2l0aCBt
YWlubGluZSB2NS4wLXJjMj8KCj4gU29tZSBtaW5vciBjb21tZW50cyBiZWxvdyBmcm9tIHF1aWNr
IGxvb2s6Cj4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWRhdmlu
Y2kuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItZGF2aW5jaS5jCj4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi43MjgyYTFmZGE4MGYKPiA+IC0tLSAv
ZGV2L251bGwKPiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItZGF2aW5jaS5jCj4g
PiBAQCAtMCwwICsxLDQxNSBAQAo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wKwo+ID4gKy8qCj4gPiArICogVEkgRGFWaW5jaSBjbG9ja3NvdXJjZSBkcml2ZXIKPiA+ICsg
Kgo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAxOSBUZXhhcyBJbnN0cnVtZW50cwo+ID4gKyAqIEF1
dGhvcjogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiA+
ICsgKiAod2l0aCBzb21lIHBhcnRzIGFkb3B0ZWQgZnJvbSBjb2RlIGJ5IEtldmluIEhpbG1hbiA8
a2hpbG1hbkBiYXlsaWJyZS5jb20+KQo+Cj4gRGlkIHlvdSByZWFsbHkgaW50ZW5kIEdQTCB2MiBv
ciBsYXRlcj8gVGhlIG9yaWdpbmFsIGNvZGUgcmVmZXJyZWQgdG8KPiBhYm92ZSBpcyBtYXJrZWQg
Mi4wIG9ubHkuCj4KCkknbSBub3Qgc3VyZS4gU2hvdWxkIGl0IGJlIEdQTHYyIG9ubHk/IEknbSBu
b3Qgd2VsbCB2ZXJzZWQgd2l0aCBsaWNlbnNpbmcuCgpCYXJ0Cgo+ID4gKyAqLwo+ID4gKwo+ID4g
KyNpbmNsdWRlIDxsaW51eC9jbGsuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xvY2tjaGlwcy5o
Pgo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbG9ja3NvdXJjZS5oPgo+ID4gKyNpbmNsdWRlIDxsaW51
eC9lcnIuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4gPiArI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+Cj4gPiAr
I2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4K
PiA+ICsjaW5jbHVkZSA8bGludXgvc2NoZWRfY2xvY2suaD4KPiA+ICsKPiA+ICsjaW5jbHVkZSA8
Y2xvY2tzb3VyY2UvdGltZXItZGF2aW5jaS5oPgo+ID4gKwo+ID4gKyNkZWZpbmUgREFWSU5DSV9U
SU1FUl9SRUdfVElNMTIgICAgICAgICAgICAgICAgICAgICAgMHgxMAo+ID4gKyNkZWZpbmUgREFW
SU5DSV9USU1FUl9SRUdfVElNMzQgICAgICAgICAgICAgICAgICAgICAgMHgxNAo+ID4gKyNkZWZp
bmUgREFWSU5DSV9USU1FUl9SRUdfUFJEMTIgICAgICAgICAgICAgICAgICAgICAgMHgxOAo+ID4g
KyNkZWZpbmUgREFWSU5DSV9USU1FUl9SRUdfUFJEMzQgICAgICAgICAgICAgICAgICAgICAgMHgx
Ywo+ID4gKyNkZWZpbmUgREFWSU5DSV9USU1FUl9SRUdfVENSICAgICAgICAgICAgICAgICAgICAg
ICAgMHgyMAo+ID4gKyNkZWZpbmUgREFWSU5DSV9USU1FUl9SRUdfVEdDUiAgICAgICAgICAgICAg
ICAgICAgICAgMHgyNAo+ID4gKwo+ID4gKyNkZWZpbmUgREFWSU5DSV9USU1FUl9USU1NT0RFX01B
U0sgICAgICAgICAgIDB4MDAwMDAwMGMKPiA+ICsjZGVmaW5lIERBVklOQ0lfVElNRVJfUkVTRVRf
TUFTSyAgICAgICAgICAgICAweDAwMDAwMDAzCj4gPiArI2RlZmluZSBEQVZJTkNJX1RJTUVSX1RJ
TU1PREVfMzJCSVRfVU5DSEFJTkVEICAgICAgICAweDAwMDAwMDA0Cj4gPiArI2RlZmluZSBEQVZJ
TkNJX1RJTUVSX1VOUkVTRVQgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDAzCj4KPiBJ
IHRoaW5rIHRoZXNlIGFyZSBtb3JlIHJlYWRhYmxlIGlmIHVzaW5nIEJJVCgpIGFuZCBHRU5NQVNL
KCkKPgo+IFRoYW5rcywKPiBTZWtoYXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
