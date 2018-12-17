Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD38C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EA9206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOkm8BHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EA9206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j9BCt14lkTfJOgJnThXwEXPs4iXnIy2yNZ4X7jEZGYs=; b=qOkm8BHH/gBYV7
	tdxQVMDTNJrUTxdAhW1CY1jjqjYfga/QRdMxcJnpKVeV2PFP46XPWYVUt2EpOerQgvizM5V4rb2cH
	Ul584yXd3D3jUh3yv7cnqDeDgOR2h+6T6e8BLuvqCoagVxssF7xwDHl3PD/uRZA57UQQJjdDgUOOX
	q9up/1VgyJUFRYZOkH27vezuasCwxHtltMGHwUkWw8z0/jxNyy471x1NWK5mh4KaTJ5TkdIx4DvE0
	9Sz7DnZHJXWNEKyswEPtcgvXThVxuvwKBSGwOWvkTXMEYt516Gb/PswjBUsf4FA3TesMq66mzfCa4
	XcPLT4G/760orCdGbx1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYvyM-00031n-KV; Mon, 17 Dec 2018 16:42:26 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYvyJ-00030T-Nu
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 16:42:25 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gYvy4-0005sA-75; Mon, 17 Dec 2018 17:42:08 +0100
Message-ID: <1545064927.5874.18.camel@pengutronix.de>
Subject: Re: [GIT PULL] i.MX fixes for 4.19, round 2
From: Lucas Stach <l.stach@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Dec 2018 17:42:07 +0100
In-Reply-To: <CAK8P3a0d3C3gDi_Ozh1gBTVXiAOc67_8SOYh7tzWVpP8trO8-A@mail.gmail.com>
References: <20181001023923.GQ26692@dragon>
 <CAK8P3a1e8+HMwsFjE5AJW1E8M309dTkXHLqQb0Dne1gO_n61vg@mail.gmail.com>
 <f31c2fe8e753ba4c21e1c4b4ede270f88dddbf42.camel@pengutronix.de>
 <CAK8P3a0d3C3gDi_Ozh1gBTVXiAOc67_8SOYh7tzWVpP8trO8-A@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_084223_932052_0D8F97BB 
X-CRM114-Status: GOOD (  30.36  )
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
Cc: Sricharan R <sricharan@codeaurora.org>, arm-soc <arm@kernel.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQXJuZCwKCkFtIERpZW5zdGFnLCBkZW4gMDIuMTAuMjAxOCwgMTQ6MDkgKzAyMDAgc2Nocmll
YiBBcm5kIEJlcmdtYW5uOgo+IE9uIFR1ZSwgT2N0IDIsIDIwMTggYXQgMTo0MiBQTSBMdWNhcyBT
dGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPiB3cm90ZToKPiA+IEFtIERpZW5zdGFnLCBk
ZW4gMDIuMTAuMjAxOCwgMTE6NTkgKzAyMDAgc2NocmllYiBBcm5kIEJlcmdtYW5uOgo+ID4gPiBP
biBNb24sIE9jdCAxLCAyMDE4IGF0IDQ6MzkgQU0gU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPgo+ID4gPiB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiBUaGUgZm9sbG93aW5nIGNoYW5nZXMg
c2luY2UgY29tbWl0Cj4gPiA+ID4gNTczNjE4NDZiNTJiYzY4NjExMmRhNmNhNTM2OGQxMTIxMDc5
NjgwNDoKPiA+ID4gPiAKPiA+ID4gPiDCoCBMaW51eCA0LjE5LXJjMiAoMjAxOC0wOS0wMiAxNDoz
NzozMCAtMDcwMCkKPiA+ID4gPiAKPiA+ID4gPiBhcmUgYXZhaWxhYmxlIGluIHRoZSBnaXQgcmVw
b3NpdG9yeSBhdDoKPiA+ID4gPiAKPiA+ID4gPiDCoAo+ID4gPiA+IGdpdDovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zaGF3bmd1by9saW51eC5naQo+ID4gPiA+IHQK
PiA+ID4gPiB0YWdzL2lteC1maXhlcy00LjE5LTIKPiA+ID4gPiAKPiA+ID4gPiBmb3IgeW91IHRv
IGZldGNoIGNoYW5nZXMgdXAgdG8KPiA+ID4gPiA0ZDhkNDcxMmU0N2MwMjgzMDYxNDliZGEwNGI3
OWY3MDMyNWFlZmIwOgo+ID4gPiA+IAo+ID4gPiA+IMKgIHNvYzogaW14OiBncGM6IHNldCBETUEg
bWFzayBmb3IgUEQgcGxhdGZvcm0gZGV2aWNlcyAoMjAxOC0wOS0KPiA+ID4gPiAyNgo+ID4gPiA+
IDEwOjM4OjM4ICswODAwKQo+ID4gPiA+IAo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiAtLS0KPiA+ID4g
PiBpLk1YIGZpeGVzIGZvciA0LjE5LCByb3VuZCAyOgo+ID4gPiA+IMKgLSBUaGVyZSBhcHBlYXJz
IGFuIHVuaW5pdGlhbGl6ZWQgRE1BIG1hc2sgd2FybmluZyBvbiBpLk1YIEdQQwo+ID4gPiA+IGRy
aXZlcgo+ID4gPiA+IMKgwqDCoHdpdGggNC4xOS1yYyBrZXJuZWwuwqDCoFNldCB0aGUgRE1BIG1h
c2sgZm9yIHBvd2VyZG9tYWluCj4gPiA+ID4gcGxhdGZvcm0KPiA+ID4gPiDCoMKgwqBkZXZpY2Ug
dG8gZml4IHRoZSB3YXJuaW5nIGdpdmVuIGJ5IGRldmljZSBjb3JlLgo+ID4gPiAKPiA+ID4gSSBk
b24ndCB0aGluayB0aGlzIGlzIHRoZSByaWdodCBmaXgsIHdlIHNob3VsZCBnZW5lcmFsbHkgbm90
IGp1c3QKPiA+ID4gbWFrZSB1cCBhIGRtYQo+ID4gPiBtYXNrIHBvaW50ZXIuCj4gPiA+IAo+ID4g
PiBMdWNhcywgZG8geW91IGhhdmUgYW55IG1vcmUgaW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoYXQg
d2FybmluZz8KPiA+ID4gQXJlIHdlIHRyeWluZyB0byBkbyBETUEgb24gYSB2aXJ0dWFsIGRldmlj
ZT8gV2hhdCBvcGVyYXRpb24KPiA+ID4gY2F1c2VzIHRoYXQgd2FybmluZz8KPiA+IAo+ID4gVGhl
IHdhcm5pbmcgd2UgYXJlIHNpbGVuY2luZyBoZXJlIGlzIGdlbmVyYXRlZCBieQo+ID4gb2ZfZG1h
X2NvbmZpZ3VyZSgpIGlmCj4gPiB0aGUgZG1hX21hc2sgaXMgbm90IHNldCwgd2hpY2ggZ2V0cyBj
YWxsZWQgZm9yIGFsbCBkZXZpY2VzIHdpdGggYQo+ID4gT0YKPiA+IG5vZGUsIHJlZ2FyZGxlc3Mg
aWYgdGhlIGRldmljZSBpcyBhY3R1YWxseSBETUEgY2FwYWJsZS4KPiA+IEFzIHRoZSBwbGF0Zm9y
bSBidXMgY29kZSBjYWxscyB0aGlzIGZ1bmN0aW9uIHdpdGggZm9yY2VfZG1hID0gdHJ1ZSwKPiA+
IHRoZQo+ID4gYWJzZW50IGRtYS1yYW5nZXMgd29uJ3Qgc3RvcCB0aGlzIGZ1bmN0aW9uIGZyb20g
dHJ5aW5nIHRvIHNldCB1cAo+ID4gdGhlCj4gPiBkbWEgc3R1ZmYsIHNvIEkgZG9uJ3QgcmVhbGx5
IHNlZSBhbm90aGVyIGNsZWFuIHdheSB0byBnZXQgcmlkIG9mCj4gPiB0aGlzCj4gPiB3YXJuaW5n
Lgo+IAo+IE9rLCBJIHNlZS4gU28gSSB0aGluayB0aGUgd2FybmluZyBpcyB3cm9uZyBoZXJlLCBh
bmQgeW91ciBjaGFuZ2UKPiBhY3R1YWxseSBtYWtlcyBpdCB3b3JzZSwgYmVjYXVzZSB3ZSByZWFs
bHkgL2Rvbid0LyB3YW50IHRvIGRvIERNQQo+IG9uIHRoaXMgbm9kZS4KPiAKPiBGcm9tIHdoYXQg
SSBjYW4gdGVsbCwgdGhlIGNoYW5nZSB0aGF0IGludHJvZHVjZWQgdGhpcyBiZWhhdmlvcgo+IHdh
cyBjb21taXQgMDk1MTVlZjVkZGFkICgib2YvYWNwaTogQ29uZmlndXJlIGRtYSBvcGVyYXRpb25z
IGF0Cj4gcHJvYmUgdGltZSBmb3IgcGxhdGZvcm0vYW1iYS9wY2kgYnVzIGRldmljZXMiKSBpbiA0
LjEyLgo+IAo+IEJlZm9yZSB0aGF0LCB3ZSBkaWQgbm90IHRyeSB0byBjYWxsIG9mX2RtYV9jb25m
aWd1cmUoKSBvbiBhIG1hbnVhbGx5Cj4gYWRkZWQgZGV2aWNlLCB3aGljaCBJIHRoaW5rIHdhcyB0
aGUgY29ycmVjdCBiZWhhdmlvci4gRG9lcyB0aGF0Cj4gY29ycmVzcG9uZCB0byB3aGF0IHlvdSBh
cmUgc2VlaW5nPwo+IAo+IEZvciB0aGUgbW9tZW50LCBJJ2QgcHJlZmVyIHRvIGhvbGQgb2ZmIG9u
IHRoaXMgcGF0Y2gsIHVudGlsIHdlIGhhdmUKPiByZXNvbHZlZCB3aGF0IHRoZSBiZXN0IGZpeCBp
cyBnb2luZyB0byBiZS4gU2luY2UgdGhlcmUgaXMgbm8gRE1BCj4gb24gdGhlIGRldmljZSwgdGhl
IGJlaGF2aW9yIHdpbGwgYmUgY29ycmVjdCwgYXNpZGUgZnJvbSB0aGUKPiBhbm5veWluZyB3YXJu
aW5nLgoKRG8geW91IGhhdmUgYW4gaWRlYSBob3cgdG8gYmV0dGVyIGZpeCB0aGlzPyBUaGUgd2Fy
bmluZyBpcyBhbm5veWluZwooZXNwZWNpYWxseSBmb3IgcGVvcGxlIHRoYXQgYXJlbid0IGF3YXJl
IHRoYXQgdGhpcyBkZXZpY2UgZG9lc24ndCBuZWVkCmFueSBETUEgc2V0dXApLgoKSSBkb24ndCBy
ZWFsbHkgc2VlIGhvdyB3ZSBjb3VsZCBmaXggdGhpcyB3aXRob3V0IHJlZ3Jlc3NpbmcKZnVuY3Rp
b25hbGl0eSBmb3Igb3RoZXIgZHJpdmVycy4gVGhvdWdodHM/CgpSZWdhcmRzLApMdWNhcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
