Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0239BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:58:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C457120823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jV9rtcu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C457120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kt21q8U8knp5Ik0rxaVFo3rRfcU4aOWt6LPbBqSDA4o=; b=jV9rtcu91jyLxV
	JZZwc8fTgpv9x4kECJhUn3W/JQWqAb4JVezrqOzqjAGQcZfrFYFV1ixP5u75wVInHM8TnWi55Nidg
	Rp4z62Tm0xwlB5e8OFKiURvvEmRDAABoslIMLL/y8/lrZ3DB6C28h1s/zJFsGv3nwF95tGz7YdX3Z
	eDnsGIpYU5I/EE4vTyvXZDiMn6Ccb1tqjFXJ4/kqfUqgmrD7Kf9GVlg/Ma4uJtYAdYg4AkBrf4gSv
	11r21JOgpFSTK2qLv4/cCedZFoi3iVOq5lyZwGG7Ertl63k23tRaSpQEeK+nI2mDlPSeVFKh1NySX
	BYaNMD9yyPkZ23QuetMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJ1s-0002bh-2f; Wed, 06 Feb 2019 08:58:00 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJ1o-0002b9-8D
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:57:58 +0000
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C18C1E0009;
 Wed,  6 Feb 2019 08:57:44 +0000 (UTC)
Date: Wed, 6 Feb 2019 09:57:43 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper
 <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 0/7] Add Armada 3700 COMPHY support
Message-ID: <20190206095743.5eed3584@xps13>
In-Reply-To: <20190108163124.6409-1-miquel.raynal@bootlin.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_005756_586696_16436B8A 
X-CRM114-Status: GOOD (  25.24  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgS2lzaG9uLAoKTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4gd3Jv
dGUgb24gVHVlLCAgOCBKYW4gMjAxOQoxNzozMToxNyArMDEwMDoKCj4gSGVsbG8sCj4gCj4gVGhp
cyBzZXJpZXMgYWRkcyBhIG5ldyBkcml2ZXIgdG8gc3VwcG9ydCBBcm1hZGEgMzcwMCBDT01QSFkg
SVAuCj4gVGhlIHNlcmllcyBoYXMgYmVlbiB0ZXN0ZWQgb24gYW4gRVNQUkVTU09iaW4gd2l0aCBT
QVRBLCBQQ0llCj4gYW5kIFVTQjMgaG9zdC4gRm9yIHRoaXMgcHVycG9zZSwgcGF0Y2ggMSBlbnVt
ZXJhdGVzIHRoZSBTQVRBIFBIWQo+IG1vZGUuIFRoZSBTR01JSSBQSFkgbW9kZSB0aGF0IGlzIHN1
cHBvcnRlZCBieSB0aGUgSVAgaGFzIGJlZW4gd3JpdHRlbgo+ICh1c2VzIFNNQyBjYWxscyBhbnl3
YXkpIGJ1dCBjb3VsZCBub3QgYmUgdGVzdGVkIG9uIHRoaXMgcGxhdGZvcm0uCj4gCj4gVGhyZWUg
c2VyaWVzIHdpbGwgZm9sbG93IHRvIGFkZCBQSFkgc3VwcG9ydCAob3IgYXQgbGVhc3QgYSBQSFkg
bm9kZXMKPiBpbiB0aGUgQTM3MDAvRVNQUkVTU09iaW4gZGV2aWNlIHRyZWVzKSB0byB0aGUgTVZF
QlUgQUhDSSBkcml2ZXIsIHRoZQo+IEFhcmR2YXJrIFBDSSBjb250cm9sbGVyIGRyaXZlciBhbmQg
dGhlIE1WRUJVIHhIQ0kgZHJpdmVyLiBBbGwgdGhpcyBpcwo+IG5lZWRlZCBpbiBvcmRlciB0byBh
Y2hpZXZlIHN1c3BlbmQgdG8gUkFNIG9uIHRoaXMgcGxhdGZvcm0uCj4gCj4gVGhhbmtzLAo+IE1p
cXXDqGwKPiAKCkFueSBpbnB1dHMgb24gdGhpcyBzZXJpZXM/IEl0IGlzIGltcG9ydGFudCBmb3Ig
bWUgYmVjYXVzZSBpdCBpbXBhY3RzClNBVEEsIFBDSWUgYW5kIFVTQiBjaGFuZ2VzIEkgcGxhbiB0
byBnZXQgbWVyZ2UuCgpUaGFua3MsCk1pcXXDqGwKCj4gCj4gQ2hhbmdlcyBzaW5jZSB2NDoKPiA9
PT09PT09PT09PT09PT09PQo+ICogRml4ZWQgZXJyb3IgaW4gdGhlIGRyaXZlciBwcm9iZSB3aGVy
ZSBQSFlfSU5URVJGQUNFX01PREVfTkEgd2FzCj4gICBhc3NpZ25lZCB0byBsYW5lLT5tb2RlIGlu
c3RlYWQgb2YgbGFuZS0+c3VibW9kZS4KPiAqIENvbXBpbGUtaW4gdGhlIGRyaXZlciBieSBkZWZh
dWx0IChkZXBlbmRzIG9uIEFSQ0hfTVZFQlUpLgo+ICogQWRkIGRlcGVuZGVuY3kgb24gSEFWRV9B
Uk1fU01DQyBpbiBLY29uZmlnLgo+IAo+IENoYW5nZXMgc2luY2UgdjM6Cj4gPT09PT09PT09PT09
PT09PT0KPiAqIEFkZGVkIFJvYidzIFJldmlld2VkLWJ5IHRhZyBvbiBiaW5kaW5ncy4KPiAqIFJl
YmFzZWQgb24gdG9wIG9mIHBoeSAtbmV4dCBhcyBvZiB0aGUgMTJ0aCBvZiBEZWNlbWJlciwgMjAx
OC4KPiAqIEFkYXB0ZWQgdGhlIGRyaXZlciB0byBzdXBwb3J0IFNHTUlJLzEwMDBCQVNFWCBhbmQK
PiAgIEhTX1NHTUlJLzI1MDBCQVNFWC4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYyOgo+ID09PT09PT09
PT09PT09PT09Cj4gKiBSZW1vdmUgcmVkdW5kYW50IGNoZWNrIG9uIGxhbmUtPnBvcnQvYXJncy0+
YXJnWzBdIGF0IHRoZSBlbmQgb2YgdGhlCj4gICAtPnhsYXRlKCkgY2FsbGJhY2suIERvIGl0IG9u
IGJvdGggYXJtYWRhLWNwMTEwIGFuZCBhcm1hZGEtYTM3MDAgIAo+ICAgQ09NUEhZIGRyaXZlcnMu
Cj4gKiBQdXQgbXkgU29CIGFzIGF1dGhvciBvZiB0aGUgcGF0Y2ggZmlyc3Qgd2hlbiBhIHBhdGNo
IGlzIGNvLWRldmVsb3BlZC4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYxOgo+ID09PT09PT09PT09PT09
PT09Cj4gKiBGaXggd3JvbmcgY2hlY2sgaW4gLT54bGF0ZSgpLgo+ICogQXBwbHkgdGhlIHNhbWUg
Zml4IHRvIHRoZSBjcDExMCBjb21waHkgZHJpdmVyIGZyb20gd2hpY2ggdGhlIGEzNzAwCj4gICBk
cml2ZXIgaXMgYmFzZWQuCj4gKiBBZGRlZCBjcmVkaXQgdG8gR3JlZ29yeiBKYXN6Y3p5ayBmb3Ig
aGlzIHdvcmsuCj4gKiBBZGRlZCBTdWdnZXN0ZWQtYnkgdGFnIHRvIHRoZSBwYXRjaCBhZGRpbmcg
dGhlIENPTVBIWSBEVCBub2RlLgo+IAo+IAo+IEdyemVnb3J6IEphc3pjenlrICgxKToKPiAgIHBo
eTogZW51bWVyYXRlIFNBVEEgUEhZIG1vZGUKPiAKPiBNaXF1ZWwgUmF5bmFsICg2KToKPiAgIHBo
eTogbXZlYnUtY3AxMTAtY29tcGh5OiBmaXggcG9ydCBjaGVjayBpbiAtPnhsYXRlKCkKPiAgIHBo
eTogYWRkIEEzNzAwIENPTVBIWSBzdXBwb3J0Cj4gICBkdC1iaW5kaW5nczogcGh5OiBtdmVidS1j
b21waHk6IGV4dGVuZCB0aGUgZmlsZSB0byBkZXNjcmliZSBhMzcwMAo+ICAgICBiaW5kaW5ncwo+
ICAgTUFJTlRBSU5FUlM6IHBoeTogYWRkIGVudHJ5IGZvciBBcm1hZGEgMzcwMCBDT01QSFkgZHJp
dmVyCj4gICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZml4IFNBVEEgbm9kZSBz
Y29wZQo+ICAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3eHg6IGRlY2xhcmUgdGhlIENP
TVBIWSBub2RlCj4gCj4gIC4uLi9iaW5kaW5ncy9waHkvcGh5LW12ZWJ1LWNvbXBoeS50eHQgICAg
ICAgICB8ICA2NSArKystCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNiArCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4
eC5kdHNpICB8ICAzMSArLQo+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgfCAgMTIgKwo+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC1j
b21waHkuYyAgfCAzMTggKysrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvcGh5L21hcnZlbGwv
cGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5jICB8ICAgMiAtCj4gIGluY2x1ZGUvbGludXgvcGh5L3Bo
eS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCj4gIDggZmlsZXMgY2hhbmdlZCwgNDIx
IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtY29tcGh5LmMKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
