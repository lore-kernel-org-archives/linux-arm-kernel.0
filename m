Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84DC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:09:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E71F20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lNuSTKt7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmbqN2sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E71F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JGCiKGjFahEGI+7knp06EUnsAY+I0LtaqdSoO8WmIbs=; b=lNuSTKt7Mu1WzF
	Fhxg9M5yXUwZKwTfIWAtfQufOFAzKCQSwi5I5djfbdgwyFBYj6LpuG8ESb1DFm2T+hvf/o5ZJh8MX
	gT5O9nm1YglfdIWJpFA5fidSmbjvB+3pab6kp8b4MgB3jpcQNKvzYvLdGiW2xZurTATioOn9RM4V5
	66mdXADFer7orQW9HeedQ7TC1H+nG/AyqyXaOFoOJG1QsWPL/VxNbTt/49hIZUPFbt4hQ5HQQ4ZVq
	YB9Q+XAXcdxHkqKbJRAwD3nW9GSE9LEAAkkKnRQv7U/NN1sIL8dXIpEw2TlrSzmTubMnBgujT/wZk
	285tXikWf5U4zpFaMsUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmdpS-0001CI-Rf; Thu, 24 Jan 2019 12:09:54 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmdpN-0001Bm-IL
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 12:09:52 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OC9NPW064915;
 Thu, 24 Jan 2019 06:09:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548331763;
 bh=f5PVU+IUWZvcFkA+hQt3TkhQObXkhBmktE8Yz1JgR7g=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=AmbqN2sdyRBrS5POmU2Bp67Xv6appsIujc+6806lEU398TjZnVQFJ4lWn6dK28Jkt
 iSAaDid1J4nmM4tBBbP8m4Tz0rNczgn9RQ2qBTIgHcnyE3rOxNJfSQ5QNLzmvWFomS
 uDq7bAuAqwFpEcv5E1QGBHY3qBONRz8AAdWp2Jg0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OC9NcE089009
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Jan 2019 06:09:23 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 06:09:23 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 06:09:23 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OC9Jm9022276;
 Thu, 24 Jan 2019 06:09:20 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
 <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
 <d9bc1153-3b65-19a8-67ef-e131296cd8b1@ti.com>
 <CAMRc=McPCJxd7i7Ei+xOKOXYhYZgC=MYYFwyn2zAjStQov91fw@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <06da1719-26d6-19b0-97f5-ef4bb976e444@ti.com>
Date: Thu, 24 Jan 2019 17:39:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McPCJxd7i7Ei+xOKOXYhYZgC=MYYFwyn2zAjStQov91fw@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_040951_208818_9A06479B 
X-CRM114-Status: GOOD (  24.34  )
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

T24gMTcvMDEvMTkgNzozMSBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiBjencuLCAx
NyBzdHkgMjAxOSBvIDEzOjQyIFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gbmFwaXNhxYIo
YSk6Cj4+Cj4+IE9uIDE2LzAxLzE5IDI6NDggUE0sIFNla2hhciBOb3JpIHdyb3RlOgo+Pj4gT24g
MTQvMDEvMTkgMTA6MDkgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6Cj4+Pj4gcG9uLiwg
MTQgc3R5IDIwMTkgbyAxMzoyMCBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5hcGlzYcWC
KGEpOgo+Pj4+Pgo+Pj4+PiBIaSBCYXJ0b3N6LAo+Pj4+Pgo+Pj4+PiBPbiAxMS8wMS8xOSAxMDo1
MSBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPj4+Pj4+IEZyb206IEJhcnRvc3ogR29s
YXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gQ3VycmVu
dGx5IHRoZSBjbG9ja3NvdXJjZSBhbmQgY2xvY2tldmVudCBzdXBwb3J0IGZvciBkYXZpbmNpIHBs
YXRmb3Jtcwo+Pj4+Pj4gbGl2ZXMgaW4gbWFjaC1kYXZpbmNpLiBJdCBoYXJkLWNvZGVzIG1hbnkg
dGhpbmdzLCB1c2VkIGdsb2JhbCB2YXJpYWJsZXMsCj4+Pj4+PiBpbXBsZW1lbnRzIGZ1bmN0aW9u
YWxpdGllcyB1bnVzZWQgYnkgYW55IHBsYXRmb3JtIGFuZCBoYXMgY29kZSBmcmFnbWVudHMKPj4+
Pj4+IHNjYXR0ZXJlZCBhY3Jvc3MgbWFueSAob2Z0ZW4gdW5yZWxhdGVkKSBmaWxlcy4KPj4+Pj4+
Cj4+Pj4+PiBJbXBsZW1lbnQgYSBuZXcsIG1vZGVybiBhbmQgc2ltcGxpZmllZCB0aW1lciBkcml2
ZXIgYW5kIHB1dCBpdCBpbnRvCj4+Pj4+PiBkcml2ZXJzL2Nsb2Nrc291cmNlLiBXZSBzdGlsbCBu
ZWVkIHRvIHN1cHBvcnQgbGVnYWN5IGJvYXJkIGZpbGVzIHNvCj4+Pj4+PiBleHBvcnQgYSBjb25m
aWcgc3RydWN0dXJlIGFuZCBhIGZ1bmN0aW9uIHRoYXQgYWxsb3dzIG1hY2hpbmUgY29kZSB0bwo+
Pj4+Pj4gcmVnaXN0ZXIgdGhlIHRpbWVyLgo+Pj4+Pj4KPj4+Pj4+IFdlIGRvbid0IGNoZWNrIHRo
ZSByZXR1cm4gdmFsdWVzIG9mIHJlZ21hcCByZWFkcyBhbmQgd3JpdGVzIHNpbmNlIHdpdGgKPj4+
Pj4+IG1taW8gaXQncyBvbmx5IGxpa2VseSB0byBmYWlsIGR1ZSB0byBwcm9ncmFtbWVyJ3MgZXJy
b3JzLgo+Pj4+Pj4KPj4+Pj4+IFdlIGFsc28gZG9uJ3QgYm90aGVyIGZyZWVpbmcgcmVzb3VyY2Vz
IG9uIGVycm9ycyBpbgo+Pj4+Pj4gZGF2aW5jaV90aW1lcl9yZWdpc3RlcigpIGFzIHRoZSBzeXN0
ZW0gd29uJ3QgYm9vdCB3aXRob3V0IGEgdGltZXIgYW55d2F5Lgo+Pj4+Pj4KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+
Cj4+Pj4+Cj4+Pj4+IFdpdGggdGhpcyBzZXJpZXMsIERBODMwIGZhaWxzIHRvIGJvb3QuIFJlc3Qg
b2YgdGhlIGRldmljZXMgYXJlIG9rYXkgZnJvbQo+Pj4+PiBib290IHBlcnNwZWN0aXZlLgo+Pj4+
Pgo+Pj4+PiBEQTgzMCBpcyBwcmV0dHkgdW5pcXVlIGJlY2F1c2UgaXQgdXNlcyB0aGUgc2FtZSB0
aW1lci1oYWxmIGZvciBib3RoCj4+Pj4+IGNsb2Nrc291cmNlIGFuZCBjbG9ja2V2ZW50LiBNYXkg
YmUgeW91IGNhbiBzZXQgdGhlIHNhbWUgY29uZmlndXJhdGlvbiBvbgo+Pj4+PiB5b3VyIERBODUw
IHRvIHNlZSB0aGUgc2FtZSBpc3N1ZT8gRWxzZSwgSSB3aWxsIGVuYWJsZSBsb3ctbGV2ZWwgZGVi
dWcKPj4+Pj4gYW5kIHRyeSB0byBwcm92aWRlIG1vcmUgZGVidWcgZGF0YS4KPj4+Pj4KPj4+Pgo+
Pj4+IEkgY2FuJ3QgYm9vdCBkYTg1MCB3aXRoIHRoZSBzYW1lIGNvbmZpZyBhcyBkYTgzMCAoMHg2
MCBjb21wYXJlCj4+Pj4gcmVnaXN0ZXIsIGNvbXBhcmUgaXJxIDc0KSBldmVuIHdpdGggdGhlIG9s
ZCB0aW1lciBjb2RlLiBKdXN0IHRvIG1ha2UKPj4+PiBzdXJlOiBkb2VzIGRhODMwIGJvb3QgZmlu
ZSB3aXRoIG1haW5saW5lIHY1LjAtcmMyPwo+Pj4KPj4+IFllYWgsIEkgZGlkIGNoZWNrIHRoYXQg
d2l0aG91dCB0aGUgcGF0Y2ggREE4MzAgZG9lcyBib290Lgo+Pgo+PiBZb3UgYXJlIHJpZ2h0IHRo
YXQgREE4NTAgbGFja3MgY29tcGFyZSBpbnRlcnJ1cHRzIGZvciB0aW1lcnMgMCBhbmQgMS4KPj4g
U28sIHllcywgaXQgc2VlbXMgbGlrZSB3ZSB3aWxsIGhhdmUgdG8gc2hpZnQgdG8gdGltZXIyIHRv
IHRlc3QKPj4gY29tcGFyZSBpbnRlcnJ1cHRzIG9uIERBODUwLgo+Pgo+IAo+IFRpbWVycyAyIGFu
ZCAzIGFyZSBhIGJpdCBkaWZmZXJlbnQgb24gZGE4NTAgLSBmb3IgaW5zdGFuY2UgdGhleSBkb24n
dAo+IGhhdmUgc2VwYXJhdGUgaW50ZXJydXB0cyBmb3IgYm90dG9tIGFuZCB0b3AgaGFsZnMuCgpX
ZSBzaG91bGQgb25seSBiZSB1c2luZyB0aGUgY29tcGFyZSBmZWF0dXJlIHdoaWNoIGhhcyBhIGEg
c2VwYXJhdGUKaW50ZXJydXB0IChkaXN0aW5jdCBmcm9tIHRvcCBhbmQgYm90dG9tIGhhbGYgaW50
ZXJydXB0cykuIE9ubHkgdGltZXIgMgphbmQgMyBvZiBEQTg1MCBoYXZlIHRoZSBjb21wYXJlIGlu
dGVycnVwdHMgdGhvdWdoLiBTbyB5b3Ugd2lsbCBoYXZlIHRvCnVzZSB0aG9zZSB0aW1lcnMgdG8g
YmUgYWJsZSB0byB0ZXN0IGNvbXBhcmUgZmVhdHVyZSBvbiBEQTg1MC4KCj4gCj4gSSBjb25maWd1
cmVkIHRoZSBvbGQgY29kZSB0byB1c2UgdGltZXIgMiAtIGJvdHRvbSBoYWxmIG9ubHkgd2l0aAo+
IGNvbXBhcmUgcmVnaXN0ZXIgMHg2MCBhbmQgY29tcGFyZSBpbnR0ZXJ1cHQgNzQuIEl0IGJvb3Rz
IGFsdGhvdWdoIHZlcnkKPiBzbG93bHkgYW5kIHNvbWV0aGluZydzIGJyb2tlbiB3aXRoIHRpbWVr
ZWVwaW5nIGFzIHRoZSBjbG9jayBnb2VzCj4gYmFja3dhcmRzIGFuZCBmb3J3YXJkIChzZWVtaW5n
bHkpIHJhbmRvbWx5LgoKQWgsIG9rYXkuIFRpbWVyIDIvMyB1c2UgQVNZTkMzIGFzIGNsb2NrIGlu
cHV0IGluc3RlYWQgb2YgUExMMF9BVVhDTEsuCkRpZCB5b3UgbWFrZSBhZGp1c3RtZW50IGZvciB0
aGlzIHRvbz8KCj4gCj4gS2V2aW4gaGFzIGFuIE9NQVAtTDEzNyBzdGFydGVyIGtpdCAtIGlzIHRo
aXMgdGhlIHNhbWUgYXMgZGE4MzAtZXZtPyBJZgoKWWVzLgoKPiBzbywgdGhlbiBJIGNhbiBnZXQg
cmVtb3RlIGFjY2VzcyB0byBpdCBhbmQgd29yayBvbiB0aGlzIHByb2JsZW0uCj4gT3RoZXJ3aXNl
LCBJIGNhbiBwcmVwYXJlIHNvbWV0aGluZyB0aGF0IHdvcmtzIG9uIGRhODUwIHdpdGggYnJva2Vu
Cj4gdGltZWtlZXBpbmcgYW5kIGxldCB5b3Ugc2VlIGlmIGl0IHdvcmtzIGNvcnJlY3RseSBvbiBk
YTgzMC4KCkFscmlnaHQsIGhhcHB5IHRvIHRlc3QuCgpUaGFua3MsClNla2hhcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
