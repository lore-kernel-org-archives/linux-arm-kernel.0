Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B65C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:07:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C6421927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeqLk36Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C6421927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4lHH0WgE4EPt727XhmKqBOvYw+VPdEmEe2hw4riRc4I=; b=BeqLk36YxJ/tao
	P+XXaUBe3Eyl35ZzzLQkv+KMG56t340zwt/siB6dmGJwnWnPA+Zz48L6mjbMQxKg65N2fCbUaPEs4
	WCfPBSdJooJAm2y8qV+xu/65hged4UkQd0voyJUQhYZlqLoLN2f84WM6Ygn3i3quxr2kyy64xJZcA
	uiPZ1zEDr7kN0rFbz8kWjfzFiCEPyRN7hGA1LmXXmwfiEOydLDO4GiwO1F+zTQ5b93ylxogW465/V
	Eo9EqiXfbcnQ1O/0Wc+WT1QuNr/5MQLI6bPUUQ9d0Ya48U+74Uxikbq/MUuWm59gZxo2C5L/Yc2jg
	LaPzreoZXm4equIGSy0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gug1W-00085j-I7; Fri, 15 Feb 2019 16:07:34 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gug1T-00082d-Ap
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:07:33 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D935C2001A;
 Fri, 15 Feb 2019 16:07:19 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Vladimir Zapolskiy <vz@mleia.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
In-Reply-To: <8bc7bfcf-ad04-0615-1735-c2bbf20b7861@mleia.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-3-gregory.clement@bootlin.com>
 <8bc7bfcf-ad04-0615-1735-c2bbf20b7861@mleia.com>
Date: Fri, 15 Feb 2019 17:07:19 +0100
Message-ID: <87o97d2fyg.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_080731_529247_8FBA9E18 
X-CRM114-Status: GOOD (  20.17  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVmxhZGltaXIsCiAKIE9uIHNhbS4sIGbDqXZyLiAwOSAyMDE5LCBWbGFkaW1pciBaYXBvbHNr
aXkgPHZ6QG1sZWlhLmNvbT4gd3JvdGU6Cgo+IEhpIEdyZWdvcnksCj4KPiBPbiAwMi8wOC8yMDE5
IDA2OjA5IFBNLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6Cj4+IEFzIG1vc3Qgb2YgdGhlIG90aGVy
IEFEQyB0aGUgbHBjMzJ4eCBvbmUgdXNlIGEgdnJlZi1zdXBwbHkgcHJvcGVydHk6Cj4+IGRvY3Vt
ZW50IGl0Lgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogR3JlZ29yeSBDTEVNRU5UIDxncmVnb3J5LmNs
ZW1lbnRAYm9vdGxpbi5jb20+Cj4+IC0tLQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvbHBjMzJ4eC1hZGMudHh0IHwgNSArKysrKwo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2xwYzMyeHgtYWRjLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2xwYzMyeHgtYWRjLnR4dAo+PiBpbmRleCBiMzYy
OWQzYTlhZGYuLjNhMWJjNjY5YmQ1MSAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbHBjMzJ4eC1hZGMudHh0Cj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2xwYzMyeHgtYWRjLnR4dAo+PiBAQCAt
Niw2ICs2LDEwIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4+ICAgIHJlZ2lvbi4KPj4gIC0gaW50
ZXJydXB0czogVGhlIEFEQyBpbnRlcnJ1cHQKPj4gIAo+PiArT3B0aW9uYWw6Cj4+ICsgLSB2cmVm
LXN1cHBseTogVGhlIHJlZ3VsYXRvciBzdXBwbHkgQURDIHJlZmVyZW5jZSB2b2x0YWdlLCBvcHRp
b25hbAo+PiArICAgZm9yIGxlZ2FjeSByZWFzb24sIGJ1dCBoaWdobHkgZW5jb3VyYWdpbmcgdG8g
dXMgaW4gbmV3IGRldmljZSB0cmVlCj4+ICsKPgo+IGhlcmUgdnJlZi1zdXBwbHkgdm9sdGFnZSBp
cyAzLjN2IG9ubHksIEkgdGhpbmsgdGhhdCBtaWdodCBiZSBhIHJlYXNvbiB3aHkKPiB0aGUgcHJv
cGVydHkgaXMgb21pdHRlZC4KClZERF9BRCBpcyBhbiBleHRlcm5hbCBwaW4gc28gaW4gdGhlcm95
IGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIHVzZSBhCmRpZmZlcmVudCB2b2x0YWdlLCBidXQgaW5k
ZWVkIHRoZSBkYXRhc2hlZXQgZGVzY3JpYmUgdGhpcyBwaW4gYXMgdGhlCjMuM1Ygc3VwcGx5IGZv
ciBBREMuCgo+Cj4gTXkgY29uY2VybiBpcyB0aGF0IHRoZSBkb2N1bWVudGF0aW9uIHNoYWxsIG5v
dCBjb250YWluIHNlY3Rpb25zIHdpdGgKPiBkZXNjcmlwdGlvbiBvZiBwcm9wZXJ0aWVzIGZvdW5k
IGluIHRoZSBwYXN0IGZvciAnbGVnYWN5IHJlYXNvbnMnLCBpZiB5b3UKPiBsaWtlIHRvIHN1cHBv
cnQgdGhlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgaW4gdGhlIGRyaXZlciwgcGxlYXNlIHVwZGF0
ZQo+IHRoZSBkb2N1bWVudGF0aW9uIHRvIHRoZSBleHBlY3RlZCBzdGF0ZSBhbmQgYWRkIGEgc3R1
YiB0byBjYXJlIGFib3V0Cj4gbGVnYWN5IERUQnMgaW4gdGhlIGRyaXZlciBvbmx5LgoKSSBzYXcg
YSBsb3Qgb2YgcmVmZXJlbmNlIGFib3V0IGxlZ2FjeSBwcm9wZXJ0aWVzIGluIHRoZSBiaW5kaW5n
LCBhbmQgSQpmb3VuZCBpdCBxdWl0ZSB1c2VmdWxsIHdoZW4gSSByZWFkIG9sZCBkZXZpY2UgdHJl
ZXMuCgo+Cj4gRldJVyBJIHBlcnNvbmFsbHkgZG9uJ3QgbWluZCBhYm91dCBicmVha2luZyB0aGUg
YmFja3dhcmQgY29tcGF0aWJpbGl0eQo+IGZvciBOWFAgTFBDMzJ4eCwgaXQgbWlnaHQgYmUgYSBj
b25jZXJuIHdoZW4gQ09ORklHX0FSTV9BVEFHX0RUQl9DT01QQVQ9eQo+IGlzIHJlbW92ZWQgZnJv
bSB0aGUgbHBjMzJ4eF9kZWZjb25maWcgdGhvdWdoLgo+Cj4+ICBFeGFtcGxlOgo+PiAgCj4+ICAJ
YWRjQDQwMDQ4MDAwIHsKPj4gQEAgLTEzLDQgKzE3LDUgQEAgRXhhbXBsZToKPj4gIAkJcmVnID0g
PDB4NDAwNDgwMDAgMHgxMDAwPjsKPj4gIAkJaW50ZXJydXB0LXBhcmVudCA9IDwmbWljPjsKPj4g
IAkJaW50ZXJydXB0cyA9IDwzOSAwPjsKPj4gKwkJdnJlZi1zdXBwbHkgPSA8JnZjYz47Cj4+ICAJ
fTsKPj4gCj4KPiBJIGtpbmRseSBhc2sgeW91IHRvIGluY2x1ZGUgbWUgdG8gVG86IGxpc3QsIGlm
IHlvdSBzZW5kIGFub3RoZXIgY2hhbmdlcyBmb3IKPiBOWFAgTFBDMzJ4eCBwbGF0Zm9ybS4KClll
cyBzdXJlISBJIHdyb25nbHkgb25seSB1c2UgdGhlIGZpcnN0IGxpbmVzIHByb3ZpZGVkIGJ5Ci4v
c2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCwgSSB3aWxsIGluY2x1ZGUgeW91IGluIHRoZSBuZXh0
IHZlcnNpb24uCgoKVGhhbmtzLAoKR3JlZ29yeQoKCgo+Cj4gVGhhbmsgeW91Lgo+Cj4gLS0KPiBC
ZXN0IHdpc2hlcywKPiBWbGFkaW1pcgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAoKLS0gCkdyZWdvcnkgQ2xlbWVu
dCwgQm9vdGxpbgpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9i
b290bGluLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
