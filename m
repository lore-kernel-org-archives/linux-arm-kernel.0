Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1C7C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67C120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="feD320kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67C120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/YhBbmzKgwIMf5pB8p7hM9WJG0lIvJUqD3W8JgcSmyA=; b=feD320kSw1obUc1VhCHXD4p9O
	/euo2LFMn1Qitr8tMr5tdqHDJXiOLadLgUrdqNY5Za8w/zKFOVtMXTh82Yus7YPbi7G0KzE8Ti0O3
	YxAsf9ynl05UnWc2OQNTtlTkLHHuw53Ol06dPODUirk3ZFChVzsT+Tc+pqnA+JsgSUS1vnDTJcLga
	RSdmIoj5izytYiZ0XofPZs3CTUF20GueeUMCGBVPWeZXCDwmN5EA9PBbOHvR8jeWF66eh/wzHittp
	STMnrDDAfuu3kGZeKMI2vjoM2Y0RfPdlh3xRCHwEIys1QNDSdlSo2XCPCRpfUP3AcMq5GSuDlnTSg
	vjaL55MJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gplfP-0008BU-65; Sat, 02 Feb 2019 03:08:27 +0000
Received: from mail5.windriver.com ([192.103.53.11] helo=mail5.wrs.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gplfH-0008B9-EX
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 03:08:26 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x1235Cuh002449
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Fri, 1 Feb 2019 19:05:53 -0800
Received: from [128.224.162.152] (128.224.162.152) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.435.0;
 Fri, 1 Feb 2019 19:05:10 -0800
Subject: Re: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
To: Marc Zyngier <marc.zyngier@arm.com>, Sun Ted <xulinsun@gmail.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <CACiNFG5r2Czfy_kXA2PPQa=xdyzq0vUgoQZ=XNME4d_h=O1oBw@mail.gmail.com>
 <b4594318-9ebf-91ce-b845-3fac92ba6476@arm.com>
From: Xulin Sun <xulin.sun@windriver.com>
Message-ID: <6f209705-dcc9-425b-d65c-db11f45e8096@windriver.com>
Date: Sat, 2 Feb 2019 11:05:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <b4594318-9ebf-91ce-b845-3fac92ba6476@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_190824_687338_1F745466 
X-CRM114-Status: GOOD (  26.64  )
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
Cc: Jason Cooper <jason@lakedaemon.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDIvMDEvMjAxOSAwNToxNSBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+IEhpIFh1bGluLAo+
Cj4gT24gMDEvMDIvMjAxOSAwNjoxMSwgU3VuIFRlZCB3cm90ZToKPj4gSGkgTWFyYywKPj4KPj4g
TWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbSA8bWFpbHRvOm1hcmMuenluZ2llckBh
cm0uY29tPj4g5LqOMjAxOAo+PiDlubQ55pyIMjLml6Xlkajlha0g5LiK5Y2INDowM+WGmemBk++8
mgo+Pgo+PiAgICAgIFRoZSBHSUN2MyBhcmNoaXRlY3R1cmUgaGFzIHRoZSByZW1hcmthYmxlIGZl
YXR1cmUgdGhhdCBvbmNlIExQSSB0YWJsZXMKPj4gICAgICBoYXZlIGJlZW4gYXNzaWduZWQgdG8g
cmVkaXN0cmlidXRvcnMgYW5kIHRoYXQgTFBJIGRlbGl2ZXJ5IGlzIGVuYWJsZWQsCj4+ICAgICAg
dGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgTFBJcyBjYW4gYmUgdHVybmVkIG9mZiAoYW5kIG1v
c3QKPj4gICAgICBpbXBsZW1lbnRhdGlvbnMgZG8gbm90IGFsbG93IGl0KSwgbm9yIGNhbiBpdCBi
ZSByZXByb2dyYW1tZWQgdG8gdXNlCj4+ICAgICAgb3RoZXIgdGFibGVzLgo+Pgo+PiAgICAgIFRo
aXMgaXMgYSBiaXQgb2YgYSBwcm9ibGVtIGZvciBrZXhlYywgd2hlcmUgdGhlIHNlY29uZGFyeSBr
ZXJuZWwKPj4gICAgICBjb21wbGV0ZWx5IGxvb3NlcyB0cmFjayBvZiB0aGUgcHJldmlvdXMgYWxs
b2NhdGlvbnMuIElmIHRoZSBzZWNvbmRhcnkKPj4gICAgICBrZXJuZWwgZG9lc24ndCBhbGxvY2F0
ZSB0aGUgdGFibGVzIGV4YWN0bHkgdGhlIHNhbWUgd2F5LCBubyBMUElzIHdpbGwKPj4gICAgICBi
ZSBkZWxpdmVyZWQgYnkgdGhlIEdJQyAod2hpY2ggY29udGludWVzIHRvIHVzZSB0aGUgb2xkIHRh
YmxlcyksIGFuZAo+PiAgICAgIG1lbW9yeSBwcmV2aW91c2x5IGFsbG9jYXRlZCBmb3IgdGhlIHBl
bmRpbmcgdGFibGVzIHdpbGwgYmUgc2xvd2x5Cj4+ICAgICAgY29ycnVwdGVkLCBvbmUgYml0IGF0
IGEgdGltZS4KPj4KPj4gICAgICBUaGUgd29ya2Fyb3VuZCBmb3IgdGhpcyBpcyBiYXNlZCBvbiBh
IHNlcmllc1sxXSBieSBBcmQgQmllc2hldXZlbCwKPj4gICAgICB3aGljaCBhZGRzIHRoZSByZXF1
aXJlZCBpbmZyYXN0cnVjdHVyZSBmb3IgbWVtb3J5IHJlc2VydmF0aW9ucyB0byBiZQo+PiAgICAg
IHBhc3NlZCBmcm9tIG9uZSBrZXJuZWwgdG8gYW5vdGhlciB1c2luZyBhbiBFRkkgdGFibGUuCj4+
Cj4+ICAgICAgVGhpcyBpbmZyYXN0cnVjdHVyZSBpcyB0aGVuIHVzZWQgdG8gcmVnaXN0ZXIgdGhl
IGFsbG9jYXRpb24gb2YgR0lDCj4+ICAgICAgdGFibGVzIHdpdGggRUZJLCBhbmQgYWxsb3cgdGhl
IEdJQyBkcml2ZXIgdG8gc2FmZWx5IHJldXNlIHRoZSBleGlzdGluZwo+PiAgICAgIHByb2dyYW1t
aW5nIGlmIGl0IGRldGVjdHMgdGhhdCB0aGUgdGFibGVzIGhhdmUgYmVlbiBjb3JyZWN0bHkKPj4g
ICAgICByZWdpc3RlcmVkLiBPbiBub24tRUZJIHN5c3RlbXMsIHRoZXJlIGlzIG5vdCBtdWNoIHdl
IGNhbiBkby4KPj4KPj4KPj4gU29ycnkgdG8gdHVybiB0aGlzIHF1ZXN0aW9uIG91dCBhZ2Fpbi4K
Pj4gRm9yIG90aGVycyBub24tRUZJIHN5c3RlbXMsIGp1c3QgYXMgeW91ciBzYWlkIHRpbGwgbm93
IHdlIGRpZCBkbwo+PiBhbnl0aGluZywgcmlnaHQ/Cj4gV2UgZGlkbid0IGRvIGFueXRoaW5nLCBi
ZWNhdXNlIHRoZXJlIGlzIG5vdGhpbmcgd2UgY2FuIGRvLgo+Cj4+IEkgZGlkIHNlZSB0aGUga2V4
ZWMgYm9vdGluZyBmYWlsdXJlIHNpbmNlIHJlLXNldHRpbmcKPj4gdGhlwqBHSUNSX0NUTFIuRW5h
YmxlTFBJIGZyb20gIjEiIHRvICIwIiB1bnN1Y2Nlc3NmdWwuCj4+Cj4+IFRoZcKgIGJlbG93IGNv
bW1pdCBhZGRzIHRoZcKganVkZ2VtZW50IGZvciBkaXNhYmxpbmcgTFBJcywgYW5kIHJldHVybmVk
Cj4+IGVycm9yLiBDYXVzZWQgImtleGVjIiBib290aW5nwqBmYWlsdXJlLgo+IEFuZCBJIGZ1bGx5
IGV4cGVjdGVkIHRoaXMuIFdoZW4gSSBzYWlkICJ3ZSBkb24ndCBkbyBhbnl0aGluZyIsIEkgbWVh
bnQKPiAid2UgZG9uJ3QgZG8gYW55dGhpbmcgdG8gbWFrZSBMUElzIHdvcmsiLgo+Cj4+IDZlYjQ4
NmI2NmEgKGlycWNoaXAvZ2ljLXYzOiBFbnN1cmUgR0lDUl9DVExSLkVuYWJsZUxQST0wIGlzIG9i
c2VydmVkCj4+IGJlZm9yZSBlbmFibGluZykuCj4+Cj4+IDxzbmlwIHBhdGNoPgo+PiAgwqBpbnQg
aXRzX2NwdV9pbml0KHZvaWQpCj4+ICDCoHsKPj4gIMKgIMKgIMKgIMKgIGlmICghbGlzdF9lbXB0
eSgmaXRzX25vZGVzKSkgewo+PiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWdpY19yZGlz
dHNfc3VwcG9ydHNfcGxwaXMoKSkgewo+PiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBwcl9pbmZvKCJDUFUlZDogTFBJcyBub3Qgc3VwcG9ydGVkXG4iLAo+PiBzbXBfcHJvY2Vz
c29yX2lkKCkpOwo+PiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
LUVOWElPOwo+PiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4+ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGludCByZXQ7Cj4+ICsKPj4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcmVk
aXN0X2Rpc2FibGVfbHBpcygpOwo+PiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KQo+
PiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Owo+PiArCj4g
QW5kIEkgbWFpbnRhaW4gdGhhdCB0aGlzIGlzIHRoZSByaWdodCB0aGluZyB0byBkby4gSWYgTFBJ
cyBhcmUgb24gYW5kCj4gdGhlIG1lbW9yeSBoYXMgbm90IGJlZW4gcmVzZXJ2ZWQsIGl0IGlzIHRo
ZW4gbGlrZWx5IHRoYXQgdGhpcyBtZW1vcnkgaXMKPiBub3cgYmVpbmcgdXNlZCBieSB0aGUga2Vy
bmVsIGZvciBzb21ldGhpbmcgZWxzZS4gVGhlIHN5c3RlbSBpcyB0aHVzCj4gZ29pbmcgdG8gc2Vl
IHNpbmdsZS1iaXQgY29ycnVwdGlvbiBpbiBzb21lIHJhbmRvbSBwbGFjZXMuCj4KPiBBdCB0aGF0
IHN0YWdlLCB5b3VyIHN5c3RlbSBpcyBob3JyaWJseSB1bnNhZmUsIGFuZCBJIHdpbGwgbm90IGxl
dCBpdAo+IGJvb3QgdW5kZXIgdGhlc2UgY29uZGl0aW9ucy4gSWYgaXQgd2FzIHdvcmtpbmcgYmVm
b3JlLCB0aGF0J3MgYmVjYXVzZQo+IHlvdSB3ZXJlIGx1Y2t5LCBhbmQgSSBwbGFjZSBubyBmYWl0
aCBpbiBsdWNrLgo+Cj4gTm93IHlvdSBoYXZlIHR3byBhbHRlcm5hdGl2ZXM6Cj4KPiAtIFlvdSBz
d2l0Y2ggdG8gYW4gRUZJLWJhc2VkIGZpcm13YXJlLiBUaGVzZSBkYXlzLCBldmVuIHUtYm9vdCBo
YXMgYW4KPiBFRkkgaW1wbGVtZW50YXRpb24uIENPbnNpZGVyIGRvaW5nIHRoYXQgaWYgeW91IGNh
bi4KPgo+IC0gSWYgdGhlcmUgaXMgbm8gRUZJIGltcGxlbWVudGF0aW9uIGZvciB5b3VyIFNvQywg
eW91IGNhbiBwYXNzIHRoZQo+ICJpcnFjaGlwLmdpY3YzX25vbHBpPTEiIG9wdGlvbiB0byB0aGUg
Zmlyc3Qga2VybmVsLiBUaGlzIHdpbGwga2VlcCBMUEkKPiBkaXNhYmxlZCwgYW5kIHlvdSdsbCBi
ZSBhYmxlIHRvIGtleGVjIGEgc2Vjb25kYXJ5IGtlcm5lbCAoYW5kIGdldAo+IHdvcmtpbmcgTFBJ
cyB0aGVyZSkuIFRoaXMgaXMgd2hhdCBJIGRvIG9uIG15IENocm9tZWJvb2suCgpIaSBNYXJjLAoK
VGhhbmtzIGZvciBkZXRhaWxlZCBleHBsYW5hdGlvbi4KClRoYW5rcwpYdWxpbgo+Cj4gVGhhbmtz
LAo+Cj4gCU0uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
