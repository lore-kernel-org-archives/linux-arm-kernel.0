Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4940DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8FC20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SL4GVzn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8FC20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bCvUufUHCJnTciFKAL6GpJBvBpTlR3iZh3JwRqSrVJ8=; b=SL4GVzn+8Csip2
	CLOLU+5B89QDQeahF+CH0zyhzGZG95QSDgq+UcSd8JmbGO8Kzj8ttnBjTjOe/mwTWwF8zWjxxrmPS
	HPbn9VpW4cIkVc2U45vK1P+defv8AhYbl8Nq6moGo4FWoDpFhcoSPRgXPnmdqKDgHwXISFZKKSYGN
	TwUQyOa2JodMuOVxPF4KUQ2YXTbK/VDpqQ/OjvrbNfd0HdkVS8H4JBbSaIt1dKJbAWkkQQVNS69UA
	uocRtEE03QK84+ZiLcDj4D3fzR9kzfWWEjw3rSk6gEJOH5Ey4ZJi79H1hq0mY9VdWJPrtJSg9r8ef
	dRjrmCJHLd+pySu13Fig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjl7W-0008Mh-LW; Wed, 16 Jan 2019 13:20:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjl7T-0008MC-Hn
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:20:37 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8DFD4207B2; Wed, 16 Jan 2019 14:20:32 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 197CD2078F;
 Wed, 16 Jan 2019 14:20:22 +0100 (CET)
Date: Wed, 16 Jan 2019 14:20:21 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190116142021.41faac8b@xps13>
In-Reply-To: <20190115214429.GA21758@bogus>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-7-miquel.raynal@bootlin.com>
 <20190115214429.GA21758@bogus>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_052035_856393_A17E785C 
X-CRM114-Status: GOOD (  22.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGUgb24gVHVlLCAxNSBK
YW4gMjAxOSAxNTo0NDoyOSAtMDYwMDoKCj4gT24gRnJpLCBKYW4gMTEsIDIwMTkgYXQgMDI6MzE6
MjlQTSArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IEFkZCBiaW5kaW5ncyBmb3IgTWFy
dmVsbCBBcm1hZGEgMzcwMCBVU0IyIFVUTUkrIFBIWS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTog
TWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiA+IC0tLQo+ID4gIC4u
Li9iaW5kaW5ncy9waHkvcGh5LW12ZWJ1LXV0bWkudHh0ICAgICAgICAgICB8IDM3ICsrKysrKysr
KysrKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3Bo
eS1tdmVidS11dG1pLnR4dAo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXZlYnUtdXRtaS50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdmVidS11dG1pLnR4dAo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNGFkZTA1Y2U1ZDUxCj4gPiAtLS0gL2Rl
di9udWxsCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3Bo
eS1tdmVidS11dG1pLnR4dAo+ID4gQEAgLTAsMCArMSwzNyBAQAo+ID4gK01WRUJVIEEzNzAwIFVU
TUkgUEhZCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICsKPiA+ICtVU0IyIFVUTUkrIFBI
WSBjb250cm9sbGVycyBjYW4gYmUgZm91bmQgb24gdGhlIGZvbGxvd2luZyBNYXJ2ZWxsIE1WRUJV
IFNvQ3M6Cj4gPiArKiBBcm1hZGEgMzcwMAo+ID4gKwo+ID4gK09uIEFybWFkYSAzNzAwLCB0aGVy
ZSBhcmUgdHdvIFVTQiBjb250cm9sbGVycywgb25lIGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgVVNC
Mgo+ID4gK2FuZCBVU0IzIHNwZWNpZmljYXRpb25zIGFuZCBzdXBwb3J0cyBPVEcuIFRoZSBvdGhl
ciBvbmUgaXMgVVNCMiBjb21wbGlhbnQgYW5kCj4gPiArb25seSBzdXBwb3J0cyBob3N0IG1vZGUu
IEJvdGggb2YgdGhlc2UgY29udHJvbGxlcnMgY29tZSB3aXRoIGEgVVRNSSBQSFkuICAKPiAKPiBU
aGlzIHBhcmFncmFwaCBzYXlzIHRoZSBjb250cm9sbGVycyBhcmUgZGlmZmVyZW50LCBidXQgYXJl
IHRoZSBQSFlzIAo+IGRpZmZlcmVudD8KClllcyB0aGV5IGFyZS4gSSB3aWxsIG1ha2UgaXQgYXBw
ZWFyIGNsZWFybHkgaW4gdGhlIHYzLgoKPiAKPiA+ICsKPiA+ICtSZXF1aXJlZCBQcm9wZXJ0aWVz
Ogo+ID4gKwo+ID4gKy0gY29tcGF0aWJsZTogU2hvdWxkIGJlIG9uZSBvZjoKPiA+ICsJICAgICAg
KiAibWFydmVsbCxhMzcwMC11dG1pLWhvc3QtcGh5IiBmb3IgdGhlIFBIWSBjb25uZWN0ZWQgdG8K
PiA+ICsJICAgICAgICB0aGUgVVNCMiBob3N0LW9ubHkgY29udHJvbGxlci4KPiA+ICsJICAgICAg
KiAibWFydmVsbCxhMzcwMC11dG1pLW90Zy1waHkiIGZvciB0aGUgUEhZIGNvbm5lY3RlZCB0bwo+
ID4gKwkgICAgICAgIHRoZSBVU0IzIGFuZCBVU0IyIE9URyBjYXBhYmxlIGNvbnRyb2xsZXIuCj4g
PiArLSByZWc6IFBIWSBJUCByZWdpc3RlciByYW5nZS4KPiA+ICstIG1hcnZlbGwsdXNiLW1pc2Mt
cmVnOiBoYW5kbGUgb24gdGhlICJVU0IgbWlzY2VsbGFuZW91cyByZWdpc3RlcnMiIHNoYXJlZAo+
ID4gKwkJCXJlZ2lvbiBjb3ZlcmluZyByZWdpc3RlcnMgcmVsYXRlZCB0byBib3RoIHRoZSBob3N0
Cj4gPiArCQkJY29udHJvbGxlciBhbmQgdGhlIFBIWS4KPiA+ICstICNwaHktY2VsbHM6IFN0YW5k
YXJkIHByb3BlcnR5IChEb2N1bWVudGF0aW9uOiBwaHktYmluZGluZ3MudHh0KSBTaG91bGQgYmUg
MC4KPiA+ICsKPiA+ICsKPiA+ICtFeGFtcGxlOgo+ID4gKwo+ID4gKwl1c2IyX3V0bWlfaG9zdF9w
aHk6IHBoeUA1ZjAwMCB7Cj4gPiArCQljb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3MDAt
dXRtaS1ob3N0LXBoeSI7Cj4gPiArCQlyZWcgPSA8MHg1ZjAwMCAweDgwMD47Cj4gPiArCQltYXJ2
ZWxsLHVzYi1taXNjLXJlZyA9IDwmdXNiMl9zeXNjb24+Owo+ID4gKwkJI3BoeS1jZWxscyA9IDww
PjsKPiA+ICsJfTsKPiA+ICsKPiA+ICsJdXNiMl9zeXNjb246IHN5c3RlbS1jb250cm9sbGVyQDVm
ODAwIHsKPiA+ICsJCWNvbXBhdGlibGUgPSAic3lzY29uIiwgInNpbXBsZS1tZmQiOyAgCj4gCj4g
VGhpcyBpcyBub3QgdmFsaWQgYmVjYXVzZSB0aGVyZSdzIG5vdCBhIHNwZWNpZmljIGNvbXBhdGli
bGUgc3RyaW5nIGFuZCAKPiAnc2ltcGxlLW1mZCcgaW1wbGllcyB0aGVyZSBhcmUgY2hpbGQgbm9k
ZXMuCgpXaGF0IGRvIHlvdSBzdWdnZXN0PyBJcyBjb21wYXRpYmxlID0gInN5c2NvbiI7IGVub3Vn
aD8gVGhpcyBpcyBqdXN0IGFuCmFyZWEgd2l0aCBhIGZldyByZWdpc3RlcnMgdGhhdCBkbyBub3Qg
YmVsb25nIHRvIGFueSBzcGVjaWZpYyBJUC4gVGhlcmUKYXJlIHJlZ2lzdGVycyB0aGF0IGFyZSBy
ZWxhdGVkIHRvIHRoZSBjb250cm9sIG9mIHRoZSBVU0IgY29udHJvbGxlciwKYW5kIHJlZ2lzdGVy
cyB0aGF0IGFyZSByZWxhdGVkIHRvIHRoZSBQSFkuIEl0J3MgcXVpdGUgY2hhbGxlbmdpbmcgdG8K
ZmluZCBhIG1lYW5pbmdmdWwgc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJpbmcuIElzIGl0IG1hbmRh
dG9yeSB0byBhZGQKb25lPyBJZiB5ZXMsIHdvdWxkICJtYXJ2ZWxsLGFybWFkYS0zNzAwLXVzYi11
dG1pLXtob3N0LG90Z30tbWlzYyIgZml0PwoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
