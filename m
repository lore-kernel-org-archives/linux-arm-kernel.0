Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA43BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11662175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cL5iJSSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11662175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8NeELK//llgbceiu5PggYaFRQeVoXYys3sFuaUGhTFg=; b=cL5iJSSWM0Egu1
	guPV4WfyCP9dME1hvXwsKUJSZ+bu0UJioONSOLtmox/izQBloSkjfIXjcIW68t+6ikRatdwRdWKEd
	5uspUvFHuTKr5iF4P+xoy6qiHTP0YX92RZKr0rRX122QPL8bH7T8R1wMSS70663BMLC+B51Nk8DhV
	v1NZYNHqTb8760IcwJ3DsRu50H/8xU7dT2I8FAdYCX3a3NHi5/c7AZ0kiiQDm/C9CwYdu50bWK3ma
	KQfem4R85l/UPgqUjqkBBIkwFJNptybVcpASf0mW8tLGlhUqq8KF5sjsFZxIzW4XV6lyxGzQwez37
	V7XKELrWVw3/4tQf45gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJSp-0006Sa-DA; Wed, 06 Feb 2019 09:25:51 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJSi-0006SB-As
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:25:49 +0000
X-Originating-IP: 109.213.13.254
Received: from localhost (alyon-652-1-30-254.w109-213.abo.wanadoo.fr
 [109.213.13.254]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4FEDCE0005;
 Wed,  6 Feb 2019 09:25:38 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 0/6] Add hw overheat IRQ support to Marvell thermal
 driver
In-Reply-To: <20181212093645.14752-1-miquel.raynal@bootlin.com>
References: <20181212093645.14752-1-miquel.raynal@bootlin.com>
Date: Wed, 06 Feb 2019 10:25:37 +0100
Message-ID: <87bm3p8e0e.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_012547_278528_5EC1463E 
X-CRM114-Status: GOOD (  24.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAogCiBPbiBtZXIuLCBkw6ljLiAxMiAyMDE4LCBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gSGVsbG8sCj4KPiBUaGlzIGlzIHRoZSBs
YXN0IGJhdGNoIG9mIHBhdGNoZXMgYWJvdXQgdGhlIHRoZXJtYWwgZHJpdmVyIHRoYXQgd2FzCj4g
c3VzcGVuZGVkLCB3YWl0aW5nIGZvciB0aGUgSUNVL1NFSSBzZXJpZXMgdG8gYmUgbWVyZ2VkLiBO
b3cgdGhhdAo+IGV2ZXJ5dGhpbmcgaXMgcmVhZHkgaW4gbWFpbmxpbmUsIGxldCdzIGFkZCBoYXJk
d2FyZSBvdmVyaGVhdCBpbnRlcnJ1cHQKPiBzdXBwb3J0IHRvIHRoaXMgZHJpdmVyLgo+Cj4gQmlu
ZGluZ3MgYW5kIERUIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5LiBUaGUgaW50ZXJydXB0IHdpbGwg
b25seSBiZQo+IHRyaWdnZXJlZCBpZiB0aGUgcGxhdGZvcm0gZ29lcyBhYm92ZSB+MTAywrBDICh0
aHJlc2hvbGQgc2V0IHRvIDEwMMKwQywKPiBoeXN0ZXJlc2lzIHRvID4gMsKwQykuIFRoZSBpbnRl
cnJ1cHQgcHJvcGVydHkgaXMgb2YgY291cnNlIG5vdAo+IG1hbmRhdG9yeS4KPgo+IEluIHRoZSBt
ZWFuIHRpbWUsIEkgYWRkIG15c2VsZiB0byB0aGUgTUFJTlRBSU5FUlMgZmlsZSB0byByZWNlaXZl
IGFuZAo+IHJldmlldyBwb3NzaWJsZSBmaXhlcy9uZXcgZmVhdHVyZXMuCj4KPiBUaGFua3MsCj4g
TWlxdcOobAo+Cj4gQ2hhbmdlcyBzaW5jZSB2MzoKPiA9PT09PT09PT09PT09PT09PQo+ICogQWRk
ZWQgUm9iJ3MgUmV2aWV3ZWQtYnkgb24gY3AxMTAgYmluZGluZ3MuCj4gKiBBZGRyZXNzZWQgUm9i
IGNvbW1lbnQgb24gYXA4MDYgYmluZGluZ3MgYnkgcmVtb3ZpbmcgdGhlIHJlZmVyZW5jZSB0bwo+
ICAgdGhlIGludGVycnVwdCBwYXJlbnQuCj4KPiBDaGFuZ2VzIHNpbmNlIHYyOgo+ID09PT09PT09
PT09PT09PT09Cj4gKiBSZW1vdmUgdXNlbGVzcyBnb3RvIHN0YXRlbWVudC4KPiAqIE1vdmUgdGhl
IGh5c3RlcmVzaXMgYXJyYXkgb3V0IG9mIHRoZSBmdW5jdGlvbiB1c2luZyBpdCBhbmQgZGVjbGFy
ZQo+ICAgdGhlIGFycmF5IHN0YXRpY2FsbHkgaW5zdGVhZCB0aGF0IGRvaW5nIHNvIG9uIHRoZSBz
dGFjay4KPiAqIFJlbW92ZSB1bm5lY2Vzc2FyeSBjYXN0Lgo+ICogT24gZXJyb3IsIGF2b2lkIHJl
dHVybmluZyBhIHZhbHVlIG5vdCBjb21wYXRpYmxlIHdpdGggaXJxcmV0dXJuX3QgaW4KPiAgIHRo
ZSBJUlEgaGFuZGxlciAoYW5kIHdoZW4gZG9pbmcgc28sIHJlLWVuYWJsZSBpbnRlcnJ1cHRzCj4g
ICBmaXJzdCkuIFRoaXMgaXMgc2ltcGx5IGhhbmRsZWQgd2l0aCBhIGdvdG8gc3RhdGVtZW50Lgo+
ICogMCBpcyBub3QgYSB2YWxpZCBpbnRlcnJ1cHQsIHRha2UgdGhpcyBpbnRvIGFjY291bnQgZHVy
aW5nIHZhcmlhYmxlcwo+ICAgdmFsaWRhdGlvbi4KPgo+IENoYW5nZXMgKm5vdCogYWRkcmVzc2Vk
IHNpbmNlIHYyOgo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gKiBPdmVyaGVh
dCBpbnRlcnJ1cHQgY29uZmlndXJhdGlvbiBoYXMgY2VydGFpbiBsaW1pdGF0aW9ucyBvbiB3aGlj
aAo+ICAgTWFyYyBhc2tlZCBxdWVzdGlvbnMuIEkgZG9uJ3Qga25vdyBpZi93aGF0IEkgbmVlZCB0
byBjaGFuZ2Ugc28KPiAgIGtlZXBpbmcgaXQgbGlrZSB0aGlzIGZvciB0aGlzIHZlcnNpb24uCj4g
KiBFZHVhcmRvIHBvaW50ZWQgdGhhdCBvbmNlIGEgY3JpdGljYWwgbGV2ZWwgaGFzIGJlZW4gcmVh
Y2hlZCwgdGhlcmUKPiAgIGlzIG5vIHdheSBiYWNrLCB0aGUgc3lzdGVtIHdpbGwgc2h1dGRvd24u
IEkgZGVzaWduZWQgdGhlIGhhbmRsZXIgdG8KPiAgIHJlY292ZXIgZnJvbSB0aGF0IGFuZCB0byBl
bmFibGUgdGhlIElSUSBhZ2FpbiBpZiBuZWVkZWQsIGJ1dCBtYXliZQo+ICAgdGhpcyBpcyB1c2Vs
ZXNzIGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4gV2hpbGUgd2FpdGluZyBmb3IgaGlzIGFuc3dlciwK
PiAgIEkgYW0gc2VuZGluZyBhbm90aGVyIHZlcnNpb24gYW5kIHdpbGwgY29ycmVjdCBpbiBhIHY0
IGlmIG5lZWRlZC4KPgo+IENoYW5nZXMgc2luY2UgdjE6Cj4gPT09PT09PT09PT09PT09PT0KPiAq
IFVzZSBhIHRocmVhZGVkIElSUSBoYW5kbGVyIHRvIGF2b2lkIGEgcG90ZW50aWFsIGxvY2sgZGVw
ZW5jeSB3aGVuCj4gICBub3RpZnlpbmcgdGhlIGNvcmUgb2YgYW4gb3ZlcmhlYXQgc2l0dWF0aW9u
Lgo+Cj4KPiBNaXF1ZWwgUmF5bmFsICg2KToKPiAgIHRoZXJtYWw6IGFybWFkYTogYWRkIG92ZXJo
ZWF0IGludGVycnVwdCBzdXBwb3J0Cj4gICBNQUlOVEFJTkVSUzogdGhlcm1hbDogYWRkIGVudHJ5
IGZvciBNYXJ2ZWxsIE1WRUJVIHRoZXJtYWwgZHJpdmVyCj4gICBkdC1iaW5kaW5nczogYXA4MDY6
IGRvY3VtZW50IHRoZSB0aGVybWFsIGludGVycnVwdCBjYXBhYmlsaXRpZXMKPiAgIGR0LWJpbmRp
bmdzOiBjcDExMDogZG9jdW1lbnQgdGhlIHRoZXJtYWwgaW50ZXJydXB0IGNhcGFiaWxpdGllcwoK
Cj4gICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBhZGQgaW50ZXJydXB0IHN1cHBvcnQgdG8gYXA4MDYg
dGhlcm1hbCBub2RlCj4gICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBhZGQgaW50ZXJydXB0IHN1cHBv
cnQgdG8gY3AxMTAgdGhlcm1hbCBub2RlCkJvdGggcGF0Y2hlcyBhcHBsaWVkIHRvIG12ZWJ1L2R0
NjQKClRoYW5rcywKCkdyZWdvcnkKCgo+Cj4gIC4uLi9hcm0vbWFydmVsbC9hcDgwNi1zeXN0ZW0t
Y29udHJvbGxlci50eHQgICB8ICAgNyArCj4gIC4uLi9hcm0vbWFydmVsbC9jcDExMC1zeXN0ZW0t
Y29udHJvbGxlci50eHQgICB8ICAgOSArCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNSArCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtYXA4MDYuZHRzaSB8ICAxOCArLQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwv
YXJtYWRhLWNwMTEwLmR0c2kgfCAgMTUgKy0KPiAgZHJpdmVycy90aGVybWFsL2FybWFkYV90aGVy
bWFsLmMgICAgICAgICAgICAgIHwgMjcwICsrKysrKysrKysrKysrKysrLQo+ICA2IGZpbGVzIGNo
YW5nZWQsIDMxNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gLS0gCj4gMi4xOS4x
Cj4KCi0tIApHcmVnb3J5IENsZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5l
bCBlbmdpbmVlcmluZwpodHRwOi8vYm9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
