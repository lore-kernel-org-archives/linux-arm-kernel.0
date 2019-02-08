Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0424CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:30:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68C920857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vm+An4Dz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nuzz/y4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68C920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cZc1wSf60Yl+lxFf/S/TcagTQvLWN9z1RWZLxuYVl7I=; b=Vm+An4Dz9ZUfxw
	ZuuBi3tQKn+DRS5p3uzsWe6xrn5J5+ws2KCHVQaGwd/DJrscyADLEgkZpa79P30eJBaVtwSl/bs53
	E5BfQs/Uy/sAjLdoxpHoTQIMUNNzdoflH9GiuEgNVgRVGfmChVN8wX5JuyMA8P3uRibZs8vdd+IBr
	tytMtdciqY86uOIjci/LVmW4RLdJl1USyswpm3sH6ur5GtM659WqDWTdphYAdStB0YCFnv9I5DcJv
	hHmYpeeNQA22Ty2ktkQWFn/znnAWIRo2R5lKdmnVM4NP6cJNblNRsHezpgu67hB99FiRgvrwCyzjc
	myv4KRvs3OwzwOEOKD8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5IW-00049j-3Q; Fri, 08 Feb 2019 12:30:24 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5IS-00049O-S4
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:30:22 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18CTC6D004571;
 Fri, 8 Feb 2019 06:29:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549628952;
 bh=D5ta3hfxhZ7v174cvkVpIOjsg0s9Y9cf9WFazKjR38Q=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Nuzz/y4ngIywYVkm6QUWRRbtPGjvBZo63EXH8aBvDIQQbJKb14/fqDbdiFJy1eGtQ
 +zwAnjH+8TUM9+i376gBJ2+MkabIEHU6Hk6MDIoWYI85/PynT/gQq1qFLJuiXl5Qj5
 WhyYn9jo/Oqo4z6QGSE1LIyGNotaGzt+qN0trYKE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18CTCdk128372
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 06:29:12 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 06:29:11 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 06:29:11 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18CT80a011657;
 Fri, 8 Feb 2019 06:29:09 -0600
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
 <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
 <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
 <CAMRc=McNvvowdQG3zNhLpAuOL-Q_U1184mTwcJWJMRxto1LYbg@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <8314e494-c990-8c53-bd60-726b7ac795f2@ti.com>
Date: Fri, 8 Feb 2019 17:59:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=McNvvowdQG3zNhLpAuOL-Q_U1184mTwcJWJMRxto1LYbg@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043021_017878_FADF099C 
X-CRM114-Status: GOOD (  20.16  )
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

T24gMDgvMDIvMTkgNTo1NyBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiBwdC4sIDgg
bHV0IDIwMTkgbyAxMjo0MyBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5hcGlzYcWCKGEp
Ogo+Pgo+PiBPbiAwNS8wMi8xOSA5OjQxIFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+
Pj4gcG9uLiwgNCBsdXQgMjAxOSBvIDIyOjQ5IERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xv
Z3kuY29tPiBuYXBpc2HFgihhKToKPj4+Pgo+Pj4+IE9uIDEvMzEvMTkgNzozOCBBTSwgQmFydG9z
eiBHb2xhc3pld3NraSB3cm90ZToKPj4+Pj4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8Ymdv
bGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPj4+Pj4KPj4+Pj4gVGhpcyBzZXJpZXMgcG9ydHMgdGhl
IGRhdmluY2kgcGxhdGZvcm0gdG8gdXNpbmcgU1BBUlNFX0lSUSwgY2xlYW5zIHVwCj4+Pj4+IHRo
ZSBpcnFjaGlwIGRyaXZlcnMgYW5kIG1vdmVzIHRoZW0gb3ZlciB0byBkcml2ZXJzL2lycWNoaXAu
Cj4+Pj4+Cj4+Pj4KPj4+PiBUaGlzIGhhcyBiZWVuIG9uIG15IHRvZG8gbGlzdCBmb3IgeWVhcnMs
IGJ1dCBJJ3ZlIG5ldmVyIGhhZCBlbm91Z2gKPj4+PiB0aW1lIHRvIGZpZ3VyZSBpdCBvdXQuIE5p
Y2UgdG8gc2VlIGl0IGZpbmFsbHkgZ2V0dGluZyBkb25lIQo+Pj4+Cj4+Pj4gU2VyaWVzIHRlc3Rl
ZCBvbiBMRUdPIE1JTkRTVE9STVMgRVYzIChkYTg1MC1saWtlKS4gSSBjYW4gbm93IHVzZQo+Pj4+
IElJTyB0cmlnZ2VycyB3aXRob3V0IGhhdmluZyB0byBwYXRjaCB0aGUga2VybmVsIHRvIGFkZCBl
eHRyYQo+Pj4+IGludGVycnVwdHMuCj4+Pj4KPj4+PiBUZXN0ZWQtYnk6IERhdmlkIExlY2huZXIg
PGRhdmlkQGxlY2hub2xvZ3kuY29tPgo+Pj4+Cj4+Pj4KPj4+Cj4+PiBXb3cgdGhhbmtzIGZvciB0
YWtpbmcgdGhlIHRpbWUgdG8gcmV2aWV3IGl0IQo+Pj4KPj4+IEknbGwgYWRkcmVzcyBjZXJ0YWlu
IHJlbWFya3MgLSBmb3IgdGhvc2UgdW5hZGRyZXNzZWQgLSBJJ2xsIGZpeCB0aGVtIGluIHYyLgo+
Pj4KPj4+IFNla2hhcjogYXJlIHlvdSBmaW5lIHdpdGggc2VuZGluZyBib3RoIHRoZSBjbG9ja3Nv
dXJjZSBhbmQgaW50ZXJydXB0Cj4+PiBzZXJpZXMgdG9nZXRoZXIgbmV4dCB0aW1lIHdpdGggYWRk
aXRpb25hbCBwYXRjaGVzIG9uIHRvcCBtYWtpbmcKPj4+IGRhdmluY2kgcGFydCBvZiBtdWx0aV92
NV9kZWZjb25maWc/Cj4+Cj4+IEkgdGhpbmsgaXRzIGJldHRlciB0byBrZWVwIHRoZW0gc2VwYXJh
dGUuIFlvdSBjYW4gYmFzZSBib3RoIG9uIGxhdGVzdAo+PiBtYWlubGluZS4KPj4KPj4gVGhhbmtz
LAo+PiBTZWtoYXIKPiAKPiBJZiB5b3UgcHJlZmVyIEkgY2FuIGtlZXAgdGhlbSBzZXBhcmF0ZSwg
YWx0aG91Z2ggdGhlcmUgd2VyZSBhIGNvdXBsZQo+IGNvbmZsaWN0cyB3aGVuIEkgbWVyZ2VkIHRo
ZW0gaW4gbXkgdHJlZSwgd2hpY2ggYXJlIG5vdyByZXNvbHZlZC4KPiAKPiBMZXQncyBtYXliZSBz
dGFydCB3aXRoIHRoZSBpbnRlcnJ1cHRzIChJJ2xsIHNlbmQgYSB2MiB0b25pZ2h0IGlmIHlvdQo+
IGRvbid0IGhhdmUgYW55IG1vcmUgY29tbWVudHMpLCBhbmQgb25jZSB5b3UgaGF2ZSB0aGF0IGlu
IHlvdXIgdHJlZSwgSQo+IHdpbGwgcmViYXNlIHRoZSB0aW1lciBjb2RlIGFuZCB0aGVuIHRoZSBt
dWx0aV92NSBzZXJpZXMuCgpTb3VuZHMgZ29vZC4gSSBoYXZlIG5vIG1vcmUgY29tbWVudHMgb24g
dGhlIGludGVycnVwdCBzZXJpZXMuIFdlIHdpbGwKbmVlZCBhY2tzIGZyb20gaXJxY2hpcCBtYWlu
dGFpbmVycyBiZWZvcmUgbWVyZ2luZyB0aG91Z2guCgpUaGFua3MsClNla2hhcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
