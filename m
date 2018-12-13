Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13111C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:52:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D3D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mnueBKhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D3D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OB4IYhNlvoPP0S2XHTnGXlaIiBYGBaXTUPHS3uP7tH8=; b=mnueBKheLW12ty
	3zKoZ3MVlMvdRBGkzpMNA9cfoxSClzorCLrOT3J/mlAYTxkOFqSwI+4YBXWtHWKLnQJHAa0hXak8c
	XidVeDbBt0xaDoU7FkVa6vxAfBlDYnF84CWcHO8hL85nxHx5EWTtt8Mg6suDDfAaM3uhzwOuk+Ruz
	DKyquxD9+SvZ8WjoJAVFIs9b+OLnp5cnnVI1OIy4anARowknTKhKli/X1CxrqL9BskxtqcWf6XBKZ
	EMJwFiQ/y2XbSB18C88WoPSrdaN+dwmkTHTDeQkvN5j5w+c09gvMv1GcC+KF4XI4EcWoQlvUlkZyz
	txWZL8h4p0kcJLik2hrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQTx-0000a0-LT; Thu, 13 Dec 2018 12:52:49 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQRm-0006hJ-OO
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:50:48 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXQRZ-0007n2-3n; Thu, 13 Dec 2018 13:50:21 +0100
Message-ID: <1544705420.3137.30.camel@pengutronix.de>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
From: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Thu, 13 Dec 2018 13:50:20 +0100
In-Reply-To: <20181213123401.GA26763@red-moon>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <1544692768.3137.25.camel@pengutronix.de>
 <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <1544695636.3137.27.camel@pengutronix.de> <20181213123401.GA26763@red-moon>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045035_385566_9BB88062 
X-CRM114-Status: GOOD (  22.73  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDEzLjEyLjIwMTgsIDEyOjM0ICswMDAwIHNjaHJpZWIgTG9yZW56
byBQaWVyYWxpc2k6Cj4gT24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMTE6MDc6MTZBTSArMDEwMCwg
THVjYXMgU3RhY2ggd3JvdGU6Cj4gPiBBbSBEb25uZXJzdGFnLCBkZW4gMTMuMTIuMjAxOCwgMDk6
NTcgKzAwMDAgc2NocmllYiBSaWNoYXJkIFpodToKPiA+ID4gSGkgTHVjYXM6Cj4gPiA+IAo+ID4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+ID4gPiA+IEZyb206IEx1Y2FzIFN0
YWNoIFttYWlsdG86bC5zdGFjaEBwZW5ndXRyb25peC5kZV0KPiA+ID4gPiAKPiA+ID4gPiBTZW50
OiAyMDE45bm0MTLmnIgxM+aXpSAxNzoxOQo+ID4gPiA+ID4gPiA+ID4gVG86IFJpY2hhcmQgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207Cj4gPiA+ID4gCj4g
PiA+ID4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgYW5kcmV3LnNtaXJub3ZAZ21haWwuY29t
Cj4gPiA+ID4gPiA+ID4gPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOwo+ID4gPiA+IAo+ID4gPiA+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiBTdWJqZWN0OiBSZTogW3YyXSBQQ0k6IGlteDogbWFr
ZSBtc2kgd29yayB3aXRob3V0IHBjaWVwb3J0YnVzCj4gPiA+ID4gCj4gPiA+ID4gSGkgUmljaGFy
ZCwKPiA+ID4gPiAKPiA+ID4gPiBBbSBEb25uZXJzdGFnLCBkZW4gMTMuMTIuMjAxOCwgMDg6MDIg
KzAwMDAgc2NocmllYiBSaWNoYXJkIFpodToKPiA+ID4gPiA+IE1TSV9FTiBvZiBpTVggUENJZSBS
QyB3b3VsZCBiZSBhc3NlcnRlZCB3aGVuIFBDSUVQT1JUQlVTIGRyaXZlciBpcwo+ID4gPiA+ID4g
c2VsZWN0ZWQuCj4gPiA+ID4gPiBUaHVzLCB0aGUgTVNJIHdvcmtzIGZpbmUgb24gaU1YIFBDSWUg
YmVmb3JlLgo+ID4gPiA+ID4gQXNzZXJ0IGl0IHVuY29uZGl0aW9uYWxseSB3aGVuIE1TSSBpcyBz
dXBwb3J0ZWQuCj4gPiA+ID4gPiBPdGhlcndpc2UsIHRoZSBNU0kgd291bGRuJ3QgYmUgdHJpZ2dl
cmVkIGFsdGhvdWdoIHRoZSBFUCBpcyBwcmVzZW50Cj4gPiA+ID4gPiBhbmQgdGhlIE1TSXMgYXJl
IGFzc2lnbmVkLgo+ID4gPiA+IAo+ID4gPiA+IFRoYW5rcyBmb3IgZGlnZ2luZyBpbnRvIHRoaXMg
aXNzdWUuIFRoaXMgc2VlbXMgbGlrZSB0aGUgcmlnaHQgd2F5IGZvcndhcmQuCj4gPiA+ID4gSG93
ZXZlciwgZGlkIHlvdSB0ZXN0IHRoaXMgd2l0aCBkZXZpY2VzIHVzaW5nIGxlZ2FjeSBJUlFzPwo+
ID4gPiA+IEkuZS4gYm9vdGluZyB3aXRoICJub21zaSIgb24gdGhlIGtlcm5lbCBjb21tYW5kIGxp
bmUgdG8gc2VlIGlmIGxlZ2FjeSBJUlFzIHN0aWxsCj4gPiA+ID4gd29yayBpZiB0aGlzIGJpdCBp
cyBzZXQsIG9yIGlmIHdlIG5lZWQgdG8gYXZvaWQgc2V0dGluZyB0aGlzIHdoZW4gdGhlIHVzZXIK
PiA+ID4gPiBleHBsaWNpdGx5IHJlcXVlc3RzIHRvIGRpc2FibGUgTVNJcz8KPiA+ID4gPiAKPiA+
ID4gPiBSZWdhcmRzLAo+ID4gPiA+IEx1Y2FzCj4gPiA+ID4gCj4gPiA+IAo+ID4gPiBbUmljaGFy
ZCBaaHVdIFRoYW5rcyBmb3IgeW91ciByZXZpZXcuCj4gPiA+IFRoZSBMZWdhY3kgSU5UeCBpcyBi
cm9rZW4uCj4gPiA+IFRoZSBNU0lfRU4gYml0IHNob3VsZG4ndCBiZSBhc3NlcnRlZCB3aGVuIHRo
ZSB1c2VyIGV4cGxpY2l0bHkgcmVxdWVzdHMgdG8gZGlzYWJsZSBNU0lzLgo+ID4gCj4gPiBPa2F5
LCBzbyB0aGlzIHBhdGNoIHNob3VsZCBiZSBleHRlbmRlZCB3aXRoIGEgY2hlY2sgZm9yCj4gPiBw
Y2lfbXNpX2VuYWJsZWQoKSB0byBzZWUgaWYgdGhlIHVzZXIgZXhwbGljaXRseSB3YW50IGxlZ2Fj
eSBJUlFzLgo+ID4gCj4gPiA+IEJUVywgcmVnYXJkaW5nIHRvIEJhcnVjaCdzIGNvbW1lbnRzLCBp
dCBzZWVtcyB0aGF0IGFsbCB0aGUgKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpIGNoZWNrIGlu
Cj4gPiA+IMKgdGhlIGR3YyBob3N0IGRyaXZlcnMgYXJlIG5vdCByZXF1aXJlZCBhbnltb3JlLCBz
aW5jZSB0aGUgZGVwZW5kcyBvbiBQQ0lfTVNJX0lSUV9ET01BSU4sIHJpZ2h0Pwo+ID4gCj4gPiBU
aGF0J3MgY29ycmVjdC4gVGhpcyBpcyBtb3N0bHkgYSBoaXN0b3JpY2FsIGFydGlmYWN0IGZyb20g
dGhlIHRpbWUgd2hlbgo+ID4gwqB3ZSB3ZXJlIGFibGUgdG8gYnVpbGQgd2l0aG91dCBNU0kgc3Vw
cG9ydC4gVGhvc2UgY2hlY2tzIGNvdWxkIGJlCj4gPiBjbGVhbmVkIHVwIG5vdyB0aGF0IHdlIGRl
cGVuZCBvbiB0aGUgTVNJIG9wdGlvbnMuCj4gCj4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgd2Ug
c2hvdWxkIHJlYWxseSBkZXBlbmQgb24gUENJX01TSV9JUlFfRE9NQUlOCj4gb3B0aW9uLCBzaG91
bGQgd2UgPwoKSXQgY2VydGFpbmx5IGN1dHMgZG93biBvbiB0aGUgY29tYmluYXRvcmlhbCBzcGFj
ZSB3aGVuIHRlc3RpbmcgdGhvc2UKY2hhbmdlcy4gSU1ITyB0aGlzIGlzIGEgZ29vZCB0aGluZywg
c28gYXMgbG9uZyBhcyB0aGVyZSBpcyBubwpjb21wZWxsaW5nIHJlYXNvbiBmb3IgbWFraW5nIHRo
aXMgZGVwZW5kZW5jeSBjb25maWd1cmFibGUgSSdtIHRvdGFsbHkKZmluZSB3aXRoIGtlZXBpbmcg
aXQgdGhlIHdheSBpdCBpcyBub3cuCgpSZWdhcmRzLApMdWNhcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
