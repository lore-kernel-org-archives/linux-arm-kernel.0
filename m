Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:12:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE92520867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SOBrsMcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE92520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qaxUyUsKctzia5Ym1lL5GEwtGrpUS/kAHQeQqYDAENw=; b=SOBrsMcGngXPWh
	dLKvf56lB6kPpQudHhIVQBcR5+JXk1ymwUMnK3PThX8xWny26DYP+Ar8KCm0nV+nsqkQgrAeE1ZNp
	F1QXuOXpJXCWsCdLi++DGilY2w5sWRgzbkBsHOvujlse5BmyhL8zZxTyhcxPlcrU7bbCbNv4LB/kx
	4UH2TBvY7AJqQkxiOXIx49P0qghHBi3f21Kqbws4bAFnTZqfP5gFZZtz3jrT0ouB6u01oApoRFSEm
	fPgnbjEvfOQ0orvOuzPpq67qdSlnh2XpIw3YuErw3wdmqGbBjU8RYcmJkjvzi5YZxoC8F0pYVkRTP
	FVFpRYOXzUwUmvioTnwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiao-0006d1-HV; Fri, 30 Nov 2018 13:12:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSial-0006aw-07
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:12:25 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5B232207B0; Fri, 30 Nov 2018 14:12:11 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id E32ED2037D;
 Fri, 30 Nov 2018 14:12:10 +0100 (CET)
Date: Fri, 30 Nov 2018 14:12:10 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/12] Bring suspend to RAM support to PCIe Aardvark driver
Message-ID: <20181130141210.2eba2eed@xps13>
In-Reply-To: <CAErSpo6WLc-OHGgGJdxVTrKwnPud+Kqpuswiz1zo7Yd8ruihEg@mail.gmail.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <CAErSpo6WLc-OHGgGJdxVTrKwnPud+Kqpuswiz1zo7Yd8ruihEg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_051223_313646_DD0E3D14 
X-CRM114-Status: GOOD (  24.95  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 antoine.tenart@bootlin.com, linux-pci@vger.kernel.org,
 gregory.clement@bootlin.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 maxime.chevallier@bootlin.com, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, thomas.petazzoni@bootlin.com,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmpvcm4sCgpBcyB5b3UgcHJvYmFibHkgbm90aWNlZCBhbHJlYWR5LCBJIGFkZGVkIHlvdSB0
byB0aGUgdGhyZWFkIG1vZGlmeWluZwp0aGUgQTM3MDAgcGVyaXBoIGNsb2NrIGRyaXZlciwgd2Ug
aGF2ZSBjb25jZXJucyBhYm91dCB0aGUgUENJZQpzcGVjaWZpY2l0aWVzLgoKQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4gd3JvdGUgb24gTW9uLCAyNiBOb3YgMjAxOCAwODo1MDo1
MQotMDYwMDoKCj4gT24gRnJpLCBOb3YgMjMsIDIwMTggYXQgODoxOCBBTSBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKPiA+Cj4gPiBIZWxsbywKPiA+Cj4g
PiBBcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0IHRv
IEFybWFkYSAzNzAwCj4gPiBTb0NzIChtYWluIHRhcmdldDogRVNQUkVTU09iaW4pLCB0aGlzIHNl
cmllcyBoYW5kbGVzIHRoZSB3b3JrIGFyb3VuZAo+ID4gdGhlIFBDSWUgSVAuCj4gPgo+ID4gRmly
c3QsIG1vcmUgY29uZmlndXJhdGlvbiBpcyBkb25lIGluIHRoZSAnc2V0dXAnIGhlbHBlciBhcyBp
bnNwaXJlZAo+ID4gZnJvbSB0aGUgVS1Cb290IGRyaXZlci4gVGhpcyBpcyBuZWVkZWQgdG8gZW50
aXJlbHkgaW5pdGlhbGl6ZSB0aGUgSVAKPiA+IGR1cmluZyBmdXR1cmUgcmVzdW1lIG9wZXJhdGlv
biAocGF0Y2ggMSkuCj4gPgo+ID4gVGhlbiwgcmVzZXQgR1BJTywgUEhZIGFuZCBjbG9jayBzdXBw
b3J0IGFyZSBpbnRyb2R1Y2VkIChwYXRjaCAyLTQpLiBBcwo+ID4gY3VycmVudCBkZXZpY2UgdHJl
ZXMgZG8gbm90IHByb3ZpZGUgdGhlIGNvcnJlc3BvbmRpbmcgcHJvcGVydGllcywgbm90Cj4gPiBm
aW5kaW5nIG9uZSBvZiB0aGVzZSBwcm9wZXJ0aWVzIGlzIG5vdCBhbiBlcnJvciBhbmQganVzdCBw
cm9kdWNlcyBhCj4gPiB3YXJuaW5nLiBIb3dldmVyLCBpZiB0aGUgcHJvcGVydHkgaXMgcHJlc2Vu
dCwgYW4gZXJyb3IgZHVyaW5nIFBIWQo+ID4gaW5pdGlhbGl6YXRpb24gd2lsbCBmYWlsIHRoZSBw
cm9iZSBvZiB0aGUgZHJpdmVyLgo+ID4KPiA+IE5vdGU6IFRvIGJlIHN1cmUgdGhlIGNsb2NrIHdp
bGwgYmUgcmVzdW1lZCBiZWZvcmUgdGhpcyBkcml2ZXIsIGEgZmlyc3QKPiA+IHNlcmllcyBhZGRp
bmcgbGlua3MgYmV0d2VlbiBjbG9ja3MgYW5kIGNvbnN1bWVycyBoYXMgYmVlbiBzdWJtaXR0ZWQs
Cj4gPiBzZWUgWzFdLgo+ID4KPiA+IFBhdGNoIDUgYWRkcyBzdXNwZW5kL3Jlc3VtZSBob29rcywg
cmUtdXNpbmcgYWxsIHRoZSBhYm92ZS4KPiA+Cj4gPiBGaW5hbGx5LCBiaW5kaW5ncyBhbmQgZGV2
aWNlIHRyZWVzIGFyZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhlIGhhcmR3YXJlCj4gPiAocGF0Y2gg
Ni0xMikuIFdoaWxlIHRoZSBjbG9jayBkZXBlbmRzIG9uIHRoZSBTb0MsIHRoZSByZXNldCBHUElP
IGFuZAo+ID4gdGhlIFBIWSBkZXBlbmRzIG9uIHRoZSBib2FyZCBzbyB0aGUgY2xvY2sgaXMgYWRk
ZWQgaW4gdGhlCj4gPiBhcm1hZGEtMzd4eC5kdHNpIGZpbGUgd2hpbGUgdGhlIHR3byBvdGhlciBw
cm9wZXJ0aWVzIGFyZSBhZGRlZCBpbgo+ID4gYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzLgo+
ID4KPiA+IFsxXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtYXJt
LWtlcm5lbC8yMDE4LU5vdmVtYmVyLzYxNDUyNy5odG1sCj4gPgo+ID4gVGhhbmtzLAo+ID4gTWlx
dcOobAo+ID4KPiA+Cj4gPiBNaXF1ZWwgUmF5bmFsICgxMik6Cj4gPiAgIFBDSTogYWFyZHZhcms6
IGNvbmZpZ3VyZSBtb3JlIHJlZ2lzdGVycyBpbiB0aGUgY29uZmlndXJhdGlvbiBoZWxwZXIKPiA+
ICAgUENJOiBhYXJkdmFyazogYWRkIHJlc2V0IEdQSU8gc3VwcG9ydAo+ID4gICBQQ0k6IGFhcmR2
YXJrOiBhZGQgUEhZIHN1cHBvcnQKPiA+ICAgUENJOiBhYXJkdmFyazogYWRkIGNsb2NrIHN1cHBv
cnQKPiA+ICAgUENJOiBhYXJkdmFyazogYWRkIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQKPiA+ICAg
ZHQtYmluZGluZ3M6IFBDSTogYWFyZHZhcms6IGRlc2NyaWJlIHRoZSByZXNldC1ncGlvcyBwcm9w
ZXJ0eQo+ID4gICBkdC1iaW5kaW5nczogUENJOiBhYXJkdmFyazogZGVzY3JpYmUgdGhlIGNsb2Nr
cyBwcm9wZXJ0eQo+ID4gICBkdC1iaW5kaW5nczogUENJOiBhYXJkdmFyazogZGVzY3JpYmUgdGhl
IFBIWSBwcm9wZXJ0eQo+ID4gICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZGVj
bGFyZSBQQ0llIHJlc2V0IHBpbgo+ID4gICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzcy
MC1lc3ByZXNzb2JpbjogZGVjbGFyZSBQQ0llIHJlc2V0IEdQSU8KPiA+ICAgQVJNNjQ6IGR0czog
bWFydmVsbDogYXJtYWRhLTM3eHg6IGRlY2xhcmUgUENJZSBjbG9jawo+ID4gICBBUk02NDogZHRz
OiBtYXJ2ZWxsOiBhcm1hZGEtMzcyMC1lc3ByZXNzb2JpbjogZGVjbGFyZSBQQ0llIFBIWSAgCj4g
Cj4gSGkgTWlxdcOobCwKPiAKPiBUaGFua3MgZm9yIHlvdXIgd29yayEgIElmL3doZW4geW91IHBv
c3QgYSB2MiwgcGxlYXNlIHJ1biAiZ2l0IGxvZwo+IC0tb25lbGluZSIgYW5kIGFkanVzdCB5b3Vy
IHN1YmplY3QgbGluZXMgdG8gbWF0Y2ggdGhlIGNhcGl0YWxpemF0aW9uCj4gY29udmVudGlvbnMs
IGkuZS4sIGZvciBQQ0ksIHN0YXJ0IHRoZSBkZXNjcmlwdGlvbiB3aXRoIGEgY2FwaXRhbAo+IGxl
dHRlcjogIlBDSTogYWFyZHZhcms6IEFkZCBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0Ii4KPiAKCkh1
bSBzb3JyeSwgSSBub3RpY2VkIHRoZSB1cHBlciBjYXNlICJQQ0k6IiBidXQgSSBtaXNzZWQgdGhl
IG90aGVyCmNhcGl0YWxpemF0aW9uLiBJIGhhZCBubyByZXZpZXcgeWV0IGJ1dCBJJ2xsIGNlcnRh
aW5seSBzZW5kIGEgdjIgd2l0aAp0aGlzIGZpeGVkLgoKPiBCVFcsIEkgbm90aWNlIHlvdSBjbG9z
ZWQgeW91ciBlbWFpbCB3aXRoICJNaXF1w6hsIiwgYnV0IHRoZSBwYXRjaGVzCj4gY29udGFpbiAi
TWlxdWVsIi4gIHlvdSAqc2hvdWxkKiBiZSBhYmxlIHRvIHVzZSB0aGUgY29ycmVjdGx5IGFjY2Vu
dGVkCj4gdmVyc2lvbiBvZiB5b3VyIG5hbWUgaW4gdGhlIFNpZ25lZC1vZmYtYnkgbGluZXMuICBJ
IGhhdmUgdHJpcHBlZCBvdmVyCj4gc29tZSB0b29sIGlzc3VlcywgYnV0IGlmIHdlIHBheSBhdHRl
bnRpb24sIHdlIHNob3VsZCBiZSBhYmxlIHRvIGdldCBpdAo+IHRvIHdvcmsuCgpJbmRlZWQsIEkn
bSBzdXJwcmlzZWQgdGhhdCB5b3Ugbm90aWNlZCBpdCEgRXZlbiBpbiBGcmFuY2Ugd2hlcmUgw6nD
qMOgw68KYXJlIHF1aXRlIGNvbW1vbiBJIHZlcnkgb2Z0ZW4gZ2V0IG15IGZpcnN0IG5hbWUgc2Ny
ZXdlZCBzbyBJIGdhdmUKdXAgdHdvIHllYXJzIGFnbyBhbmQgZGVjaWRlZCB0byBzd2l0Y2ggdG8g
YXNjaWktb25seSBjaGFyYWN0ZXJzIGluIG15CidkaWdpdGFsJyBsaWZlLiBOb3cgaXQncyBoYXJk
ZXIgdG8gc3dpdGNoIGFnYWluLCBmb3IgZXhhbXBsZSBnaXQgbG9nCi0tYXV0aG9yIHdvdWxkIG5v
dCByZWNvZ25pemUgIk1pcXXDqGwiIGFuZCAiTWlxdWVsIiB0byBiZSB0aGUgc2FtZQpwZXJzb24u
Li4KCj4gCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2FhcmR2YXJrLXBjaS50eHQg
IHwgICA5ICsKPiA+ICAuLi4vZHRzL21hcnZlbGwvYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRz
ICAgfCAgIDQgKwo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5k
dHNpICB8ICAgNSArCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsuYyAg
ICAgICAgIHwgMjE0ICsrKysrKysrKysrKysrKysrKwo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjMy
IGluc2VydGlvbnMoKykKPiA+Cj4gPiAtLQo+ID4gMi4xOS4xCj4gPiAgCgoKVGhhbmtzLApNaXF1
w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
