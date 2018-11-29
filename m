Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F8C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87E820868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nx11JyNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kz1bLfiyT0QwMrg3ar5iXZo3i6Efa5r0WLnlARGem5Q=; b=nx11JyNHUVYVSY
	FmjihVMT2zeJ1Si3zB1LhkG82E+fJL3mlE37fRIP92cl432kgevxxRTsfVQWPJvzRjT762HXECgZB
	TUHLdMjf3Hc40k78JbM+MlkLvTg8XAVk6vt0Aj9EQybHsCV7GBpMT2GVwChAouTQ00tu38joUXysD
	vm1LmgsSpJIpQfyF5LsDW6SSJmxWPQmaHbChN0pNM11yLGXYUzEZkCgz1r/rIOAo1JXKpkjA/LtBw
	EeMJ4VJuTDUFoSLP8xIQc3emjCLKfoDfHHhlwAkeY97U3PomVK9ccopZ43L4vELEkjaqzgH4RhuEZ
	cRtqDYwd+xuUPQg4nu7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOwa-0006SD-2e; Thu, 29 Nov 2018 16:13:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOvx-0005oy-CH
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:13:03 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C2E99207AD; Thu, 29 Nov 2018 17:12:45 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4034B207AB;
 Thu, 29 Nov 2018 17:12:45 +0100 (CET)
Date: Thu, 29 Nov 2018 17:12:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper
 <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/6] phy: add A3700 COMPHY support
Message-ID: <20181129171245.4f683045@xps13>
In-Reply-To: <20181122210420.14861-3-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
 <20181122210420.14861-3-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081258_296019_C3AC2AD6 
X-CRM114-Status: GOOD (  18.07  )
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
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Evan Wang <xswang@marvell.com>, "Nadav
 Haklai \(Marvell\)" <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZSBv
biBUaHUsIDIyIE5vdiAyMDE4CjIyOjA0OjE2ICswMTAwOgoKPiBBZGQgYSBkcml2ZXIgdG8gc3Vw
cG9ydCBDT01QSFksIGEgaGFyZHdhcmUgYmxvY2sgcHJvdmlkaW5nIHNoYXJlZAo+IHNlcmRlcyBQ
SFlzIG9uIE1hcnZlbGwgQXJtYWRhIDM3MDAuIFRoaXMgZHJpdmVyIHVzZXMgU01DIGNhbGxzIGFu
ZAo+IHJlbHkgb24gaGF2aW5nIGFuIHVwLXRvLWRhdGUgZmlybXdhcmUuCj4gCj4gU0FUQSwgUENp
ZSBhbmQgVVNCMyBob3N0IG1vZGUgaGF2ZSBiZWVuIHRlc3RlZCBzdWNjZXNzZnVsbHkgd2l0aCBh
bgo+IEVTUFJFU1NPYmluLiBTR01JSSBtb2RlIGNhbm5vdCBiZSB0ZXN0ZWQgd2l0aCB0aGlzIHBs
YXRmb3JtLgo+IAo+IENvLURldmVsb3BlZC1ieTogRXZhbiBXYW5nIDx4c3dhbmdAbWFydmVsbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogRXZhbiBXYW5nIDx4c3dhbmdAbWFydmVsbC5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiAt
LS0KClsuLi5dCgo+ICtzdGF0aWMgc3RydWN0IHBoeSAqbXZlYnVfYTM3MDBfY29tcGh5X3hsYXRl
KHN0cnVjdCBkZXZpY2UgKmRldiwKPiArCQkJCQkgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJncyAq
YXJncykKPiArewo+ICsJc3RydWN0IG12ZWJ1X2EzNzAwX2NvbXBoeV9sYW5lICpsYW5lOwo+ICsJ
c3RydWN0IHBoeSAqcGh5Owo+ICsKPiArCWlmIChXQVJOX09OKGFyZ3MtPmFyZ3NbMF0gPj0gTVZF
QlVfQTM3MDBfQ09NUEhZX1BPUlRTKSkKPiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiAr
Cj4gKwlwaHkgPSBvZl9waHlfc2ltcGxlX3hsYXRlKGRldiwgYXJncyk7Cj4gKwlpZiAoSVNfRVJS
KHBoeSkpCj4gKwkJcmV0dXJuIHBoeTsKPiArCj4gKwlsYW5lID0gcGh5X2dldF9kcnZkYXRhKHBo
eSk7Cj4gKwlpZiAobGFuZS0+cG9ydCA+PSAwKQo+ICsJCXJldHVybiBFUlJfUFRSKC1FQlVTWSk7
CgpUaGlzIGlzIG5vdCB2YWxpZC4gSXQgd29ya3Mgb25seSB0aGUgZmlyc3QgdGltZSB0aGUgY29u
c3VtZXIgZ2V0cwphIFBIWSBmb3IgdGhpcyBsYW5lLiBJZiB0aGUgY29uc3VtZXIgcHV0IHRoZSBQ
SFkgKG1vZHVsZSBpcyB1bmxvYWRlZCkKYW5kIHRoZW4gZ2V0cyB0aGUgUEhZIGFnYWluIChtb2R1
bGUgaXMgcmUtbG9hZGVkIGEgc2Vjb25kIHRpbWUpLCB0aGUKcG9ydCBpcyBhbHJlYWR5IHNldCB0
byAhPSAtMSBhbmQgdGhpcyB3aWxsIGV4aXQgd2l0aCBhbiBlcnJvciBhbmQKcHJldmVudCB0aGUg
bW9kdWxlIHRvIHByb2JlLgoKPiArCj4gKwlsYW5lLT5wb3J0ID0gYXJncy0+YXJnc1swXTsKCkkg
d2lsbCByZW1vdmUgdGhlIGFib3ZlIGNoZWNrIGFuZCB0cmFuc2Zvcm0gaXQgaW50byBhIHZhbGlk
ICJwb3J0Igp2YWx1ZSByaWdodCBoZXJlLgoKTm90ZTogdGhlIHNhbWUgYXBwbGllcyB0byB0aGUg
Y3AxMTAgY29tcGh5IGRyaXZlciBvbiB3aGljaCB0aGUgZHJpdmVyCnN0cnVjdHVyZSBpcyBiYXNl
ZC4KCj4gKwo+ICsJcmV0dXJuIHBoeTsKPiArfQo+ICsKPiArc3RhdGljIGludCBtdmVidV9hMzcw
MF9jb21waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiArewo+ICsJc3Ry
dWN0IHBoeV9wcm92aWRlciAqcHJvdmlkZXI7Cj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxk
Owo+ICsKPiArCWZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlKHBkZXYtPmRldi5vZl9u
b2RlLCBjaGlsZCkgewo+ICsJCXN0cnVjdCBtdmVidV9hMzcwMF9jb21waHlfbGFuZSAqbGFuZTsK
PiArCQlzdHJ1Y3QgcGh5ICpwaHk7Cj4gKwkJaW50IHJldDsKPiArCQl1MzIgbGFuZV9pZDsKPiAr
Cj4gKwkJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIoY2hpbGQsICJyZWciLCAmbGFuZV9pZCk7
Cj4gKwkJaWYgKHJldCA8IDApIHsKPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LCAibWlzc2luZyAn
cmVnJyBwcm9wZXJ0eSAoJWQpXG4iLAo+ICsJCQkJcmV0KTsKPiArCQkJY29udGludWU7Cj4gKwkJ
fQo+ICsKPiArCQlpZiAobGFuZV9pZCA+PSBNVkVCVV9BMzcwMF9DT01QSFlfTEFORVMpIHsKPiAr
CQkJZGV2X2VycigmcGRldi0+ZGV2LCAiaW52YWxpZCAncmVnJyBwcm9wZXJ0eVxuIik7Cj4gKwkJ
CWNvbnRpbnVlOwo+ICsJCX0KPiArCj4gKwkJbGFuZSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2
LCBzaXplb2YoKmxhbmUpLCBHRlBfS0VSTkVMKTsKPiArCQlpZiAoIWxhbmUpCj4gKwkJCXJldHVy
biAtRU5PTUVNOwo+ICsKPiArCQlwaHkgPSBkZXZtX3BoeV9jcmVhdGUoJnBkZXYtPmRldiwgY2hp
bGQsCj4gKwkJCQkgICAgICAmbXZlYnVfYTM3MDBfY29tcGh5X29wcyk7Cj4gKwkJaWYgKElTX0VS
UihwaHkpKQo+ICsJCQlyZXR1cm4gUFRSX0VSUihwaHkpOwo+ICsKPiArCQlsYW5lLT5kZXYgPSAm
cGRldi0+ZGV2Owo+ICsJCWxhbmUtPm1vZGUgPSBQSFlfTU9ERV9JTlZBTElEOwo+ICsJCWxhbmUt
PmlkID0gbGFuZV9pZDsKPiArCQlsYW5lLT5wb3J0ID0gLTE7Cj4gKwkJcGh5X3NldF9kcnZkYXRh
KHBoeSwgbGFuZSk7Cj4gKwl9Cj4gKwo+ICsJcHJvdmlkZXIgPSBkZXZtX29mX3BoeV9wcm92aWRl
cl9yZWdpc3RlcigmcGRldi0+ZGV2LAo+ICsJCQkJCQkgbXZlYnVfYTM3MDBfY29tcGh5X3hsYXRl
KTsKPiArCXJldHVybiBQVFJfRVJSX09SX1pFUk8ocHJvdmlkZXIpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdmVidV9hMzcwMF9jb21waHlfb2ZfbWF0Y2hf
dGFibGVbXSA9IHsKPiArCXsgLmNvbXBhdGlibGUgPSAibWFydmVsbCxjb21waHktYTM3MDAiIH0s
Cj4gKwl7IH0sCj4gK307Cj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG12ZWJ1X2EzNzAwX2Nv
bXBoeV9vZl9tYXRjaF90YWJsZSk7Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZl
ciBtdmVidV9hMzcwMF9jb21waHlfZHJpdmVyID0gewo+ICsJLnByb2JlCT0gbXZlYnVfYTM3MDBf
Y29tcGh5X3Byb2JlLAo+ICsJLmRyaXZlcgk9IHsKPiArCQkubmFtZSA9ICJtdmVidS1hMzcwMC1j
b21waHkiLAo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG12ZWJ1X2EzNzAwX2NvbXBoeV9vZl9tYXRj
aF90YWJsZSwKPiArCX0sCj4gK307Cj4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIobXZlYnVfYTM3
MDBfY29tcGh5X2RyaXZlcik7Cj4gKwo+ICtNT0RVTEVfQVVUSE9SKCJNaXF1w6hsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4iKTsKPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJDb21t
b24gUEhZIGRyaXZlciBmb3IgQTM3MDAiKTsKPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwoK
ClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
