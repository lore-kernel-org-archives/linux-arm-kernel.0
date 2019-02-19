Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48536C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:47:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B052146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LXcOx/Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B052146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Ej4F7axn8gMiw9rCEiCWdsZIp3ECq1N6cuONeCjKw0=; b=LXcOx/LuYWio2l
	CCINX+Rn/6a51bvYmQ4wvpLCLnwwNdOjC3/V+p0PdwEG7c/S8JVNdFnMTSVqjcN3+RRomjh4x/Zfq
	TzJRCgfIK5SZUbp9evsCqN7h6vP7EWdrBkZ2jbXOaf4F/s2KivgOe7Dqk3AipR3vsW6h9pVvnfiKG
	oytkkakht45zhwi5dQOSHwue/tmnTnoN5yCta8rAU50TEi/pWabeWyK04rwbUQrFzC1HB6xe69pyu
	JKAkSnQrFdhG4zdrRLe+9qugndlVtEZMtc8DNrAkQoImPhkujSZV/pVCcKx+lM/FyMh8xHd6yASnY
	Psu7daFZepY020fMs+nA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1zZ-0005gN-UU; Tue, 19 Feb 2019 09:47:09 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1zV-0005g1-Ox
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:47:08 +0000
Received: by mail-qt1-f195.google.com with SMTP id p25so22134411qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 01:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9GGmeYw9YuY9bypCABSkhaINx1v8ZhGcnbDdcZ9CFKg=;
 b=fyLd17paZIvKsUHX42kWkOzstUn806FNyyPYk7yaLc713yEFirNF2EWIJ7hnK3JNMK
 1h/evPWz6BlqOof9xGy8qgqsXQeIzibp6fHR/480rkiXXGXFTozo7OLHHOG+wy3SNyle
 rBI/tDTFRhv4lDvX6royPt5LKKqoKx8CQXu5Y8vinYtRZaDBbAAygNCJeBCPOVEVP10k
 euiPL6pS4k8MMXCawnVvFtAenraGBrCCzeSKRjMCSusUrxUUYlg5leGx1/pg+EYQILsJ
 vHQi9ArjjjV0zhoxo9qNZICVDTo8kbHUkf16+4LoAXksnaMj6MfXMPVbfCpGI0zwhgyF
 ycRQ==
X-Gm-Message-State: AHQUAuZkoGWCx5+51ga4fPxcMqMccCk8r7kvxvnuenOdSuKTkLCTY4te
 DImEU3pUh2NP7Ahq3TMbzWwg9L1k0wb3Og769Uo=
X-Google-Smtp-Source: AHgI3IYw6yCEn+sV3S2Jm8LztKD3iEqFbzTMPbQ6fpTyzQAcgLo1EamoAQWzOoDM/PC3mC9Vr5OkYtxzcNELT9/H/Nc=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr22007580qta.152.1550569624681; 
 Tue, 19 Feb 2019 01:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org> <m3k1hxvan4.fsf@t19.piap.pl>
 <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
 <CAK8P3a1Y2kLeDYKGMGpuLk8rxUxFwuPvjMRoLj-c2a8Bnwi56w@mail.gmail.com>
 <m3bm39uwvm.fsf@t19.piap.pl>
 <CAK8P3a0iubKdPrTO9ZxM+=0c3H8djpBw11KY-SO0Ai1Zgx3zHg@mail.gmail.com>
 <m37edwuv8m.fsf@t19.piap.pl>
In-Reply-To: <m37edwuv8m.fsf@t19.piap.pl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 10:46:47 +0100
Message-ID: <CAK8P3a10daNVCMOSKcLTG=0-YkK4sQ0p3Uu-wM3xM5TEimUzkQ@mail.gmail.com>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_014705_808484_B7567AAA 
X-CRM114-Status: GOOD (  22.47  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>,
 Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMTksIDIwMTkgYXQgNzo1MSBBTSBLcnp5c3p0b2YgSGHFgmFzYSA8a2hhbGFz
YUBwaWFwLnBsPiB3cm90ZToKPiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3cml0ZXM6
Cj4gPiAtIEkgaGF2ZSBhIHZhZ3VlIG1lbW9yeSB0aGF0IG9ubHkgc3BlY2lmaWMgcmV2aXNpb25z
IGFjdHVhbGx5IHJlcXVpcmUKPiA+ICAgdGhlIFBDSSBpbmRpcmVjdCBtb2RlLiBJcyBpdCB0aGUg
c2FtZSBjaGlwIHJldmlzaW9uIEEwIG9mIElYUDQyNQo+ID4gICB0aGF0IHJlcXVpcmVzIGJvdGgg
cGNpLWluZGlyZWN0IGFuZCBhZGRyZXNzLWNvaGVyZW50IG1vZGUsIG9yIGFyZQo+ID4gICB0aGVy
ZSBvdGhlciBjb21iaW5hdGlvbnM/Cj4KPiBJSVJDLCBhbGwgY2hpcHMgc3VwcG9ydCBpbmRpcmVj
dCBQQ0kuIFBlcmhhcHMgdGhlcmUgYXJlIHNvbWUgY2hhbmdlcwo+IGFib3V0IExFIG1vZGUgb24g
dGhlIFBDSSwgYnV0IHRoYXQncyBpdC4KPgo+IE1vc3QgYm9hcmRzIGRvbid0IG5lZWQgaW5kaXJl
Y3QgUENJLiBJdCdzIG9ubHkgbmVlZGVkIHdoZW4gdGhlcmUgaXMgbW9yZQo+IHRoYW4gNjQgTUIg
b2YgUENJIGFkZHJlc3Mgc3BhY2UgdG8gYmUgdXNlZCAtIElJUkMgSVhQNHh4IGhhdmUgNCBkaXJl
Y3QKPiBQQ0kgbWVtb3J5IGFjY2VzcyB3aW5kb3dzLCBhbmQgZWFjaCBpcyAxNiBNQiBpbiBzaXpl
Lgo+IEkgcmVtZW1iZXIgSSBuZWVkZWQgaW5kaXJlY3QgUENJIGZvciB1c2Ugd2l0aCBhIChTaVM/
KSBWR0EgY2FyZCwgaXQgaGFkCj4gKEkgZ3Vlc3MpIDEyOCBNQiBvZiBSQU0uIEkgdGhpbmsgaW5k
aXJlY3QgUENJIG1lYW5zIHRoZSBtZW1vcnkgY2FuJ3QgYmUKPiByZWFsbHkgbWFwcGVkLCBpdCBj
YW4gb25seSBiZSBhY2Nlc3NlZCB1c2luZyByZWFkbCgpIGFuZCBmcmllbmRzICh3aGljaAo+IGFy
ZSB0aGVuIGNvbnZlcnRlZCBpbnRvIHJlZ2lzdGVyIGFjY2Vzc2VzIHJlc3VsdGluZyBpbiB0aGUg
YWN0dWFsIE1NSU8pLgo+IEV2ZW4gd2l0aCBpbmRpcmVjdCBQQ0ksIDY0IE1CIGNhbiBiZSBhY2Nl
c3NlZCBkaXJlY3RseSAodGhvdWdoIEkgdGhpbmsKPiB3ZSBkb24ndCBzdXBwb3J0IGl0KS4KPgo+
IFRoaXMgaXMgZGlmZmVyZW50IGZyb20gdGhlIGJ1cyBtYXN0ZXJpbmcgYWNjZXNzIHRvIHRoZSBt
YWluIFJBTSAtIEkKPiB0aGluayBvbmx5IHRoZSBmaXJzdCA2NCBNQiBjYW4gYmUgdXNlZCBmb3Ig
UENJIEJNIERNQS4gVGhpcyBsaW1pdGF0aW9uLAo+IElJUkMsIGRvZXNuJ3QgYXBwbHkgdG8gaW50
ZXJuYWwgZGV2aWNlcyAoRXRoZXJuZXQgZXRjKS4KClRoYW5rcyBhIGxvdCBmb3IgdGhpcyBiYWNr
Z3JvdW5kLCB0aGF0IGhlbHBzIGEgbG90LiBXZSBhY3R1YWxseQpoYXZlIGEgbW9yZSBnZW5lcmFs
IGltcGxlbWVudGF0aW9uIG9mIHRoaXMgKGluZGlyZWN0IG1taW8gYW5kIHBpbykKaW4gYXJjaC9w
b3dlcnBjL2tlcm5lbC9pby13b3JrYXJvdW5kcy5jLCBhbmQgSSB3YXMgY29uc2lkZXJpbmcKd2hl
dGhlciB3ZSBjYW4gbWFrZSB0aGF0IGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudCBjb2RlIGFuZApy
ZXVzZSBpdCBoZXJlIGFzIHdlbGwuCgpMb29raW5nIGF0IHRoZSBwb3dlcnBjIGltcGxlbWVudGF0
aW9uIGhvd2V2ZXIsIEkgc2VlIHR3byBvdGhlcgpwcm9ibGVtczoKCi0gdGhlIHdheSBpdCBpcyBp
bXBsZW1lbnRlZCByZXF1aXJlcyB1c2luZyBzb21lIHNwYXJlIGFkZHJlc3MKICBiaXRzIG9uIGEg
NjQtYml0IHBvaW50ZXIsIHNvIHRoYXQgd291bGQgaGF2ZSB0byBiZSBjaGFuZ2UgYSBsb3QKICB0
byB3b3JrIG9uIGEgMzItYml0IGFyY2hpdGVjdHVyZQotIHRoZSBNTUlPIHdvcmthcm91bmRzIGRv
bid0IHJlYWxseSB3b3JrIGZvciBhIFZHQSBjYXJkCiAgaW4gZ2VuZXJhbCBzaW5jZSB5b3UgY2Fu
bm90IG1hcCB0aGUgZnJhbWUgYnVmZmVyIGludG8gdXNlcgogIHNwYWNlLCBzbyB0aGUgYXBwbGlj
YXRpb24gb2YgdGhhdCBpcyBzdGlsbCBhIGJpdCBsaW1pdGVkLiBJIHN1c3BlY3QKICB5b3Ugd291
bGQgaGF2ZSBoYWQgdGhlIHNhbWUgcHJvYmxlbSB3aXRoIHRoZSBleGlzdGluZwogIGl4cDR4eCBj
b2RlIGFzIHdlbGwsIGRlcGVuZGluZyBvbiBob3cgdGhlIGRyaXZlciBpbXBsZW1lbnRzCiAgdXNl
ciBzcGFjZSBncmFwaGljcy4KCldlIGNvdWxkIHN0aWxsIGNvbnNpZGVyIHVzaW5nIGl0IG9uIEFs
bHdpbm5lciBINiwgd2hpY2ggaXMgYSA2NC1iaXQKY2hpcCB0aGF0IGlzIGV2ZW4gbW9yZSBsaW1p
dGVkIChvbmx5IDY0IC9LQi8gY2FuIGJlIG1hcHBlZCBhdCBhCnRpbWUpLgoKPiA+IC0gSG93IG11
Y2ggd291bGQgaXQgaHVydCBhY3R1YWwgdXNlcnMgdG8gZHJvcCBzdXBwb3J0IGZvciBib3RoCj4g
PiAgIGZlYXR1cmVzPyBJLmUuIGRvIHdlIGtub3cgb2YgYW55b25lIHVzaW5nIHRoZSBhZmZlY3Rl
ZCBjaGlwcwo+ID4gICAoYW5kIHN0aWxsIGRvaW5nIHVwZGF0ZXMpLCBvciBhcmUgdGhlIHJlbWFp
bmluZyBpeHA0eHggc3lzdGVtcwo+ID4gICBnZW5lcmFsbHkgdXNpbmcgdGhlIGxhdGVyIGNoaXAg
cmV2aXNpb24/Cj4KPiBNb3N0IGNoaXBzIGFyZSBCMCssIHRob3VnaCB0aGVyZSBhcmUgKHdlcmUp
IGNlcnRhaW4gQTAgcGxhdGZvcm1zLgo+IEkgZG9uJ3QgaGF2ZSBhbnkgaWRlYSBhYm91dCB0aGVp
ciBjdXJyZW50IHVzZS4KCk9rLCBmYWlyIGVub3VnaC4KCiAgICAgQXJuZAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
