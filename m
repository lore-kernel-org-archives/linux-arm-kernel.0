Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:57:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4892F218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JUi8in6Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hfEVSyJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892F218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AV49xF3EkqLdEO69PlORy94NEJitObWRjRKWyhqU2NQ=; b=JUi8in6ZCkPWh3
	XrsWARhEm7Mx0Od7BSdBPEtlRS1MvUGhF6HQHVQENkaeRC7+YcmpZfsQvlec1wSE9wM3+ycspSF0D
	Y5dflJLKzH/NH0724J0xjRnUGFJJ6QMedRXkU96eenNW0FASee1QQLUHQV8whU4Zfyd73aV2pLmXm
	zvncO3/M1+jBOefJGLhaMBTk2l90yMT6H95DU+u1Okqe97pKnu9QC2ifjQ/ZJwzPou/m8TJMyZaqt
	k1PoZhJWElktp/A37SQ1ep1zJwekKA2Ef9XHFQnhr4akjIBuFXLDs412PgLEo1CwUrKruq48o+94C
	NBH1ZR9n7xjyrt3QohXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gef95-00074l-28; Wed, 02 Jan 2019 11:57:11 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gef90-0006yU-I0
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 11:57:08 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x02BujgU013169;
 Wed, 2 Jan 2019 05:56:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546430205;
 bh=ekHGi9G6FERg1Fv2mQi03caXGXaIhZBiZ8Gp+bhHbVc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=hfEVSyJQyN8oYkMUbkLm9jOhBgBRRmj+SQqee93REvY8dbc3/e2oR70x3I87XMzek
 /hJSmwtdrIOWvsRY0HwZvQe9DaMTrT1kPCTXioGVBIH5UL9ygHCYasvrDUuBMZcegS
 JMJtfvA1Fa2AAEqTpKZw0e2TGz6k2HsSVbIwqiic=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x02BujF6123473
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 2 Jan 2019 05:56:45 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 2
 Jan 2019 05:56:44 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 2 Jan 2019 05:56:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x02BufNq012045;
 Wed, 2 Jan 2019 05:56:42 -0600
Subject: Re: [PATCH v4 00/13] Add support for TISCI irqchip drivers
To: Lokesh Vutla <lokeshvutla@ti.com>, <marc.zyngier@arm.com>, Nishanth Menon
 <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cd50afd7-f093-b2a3-e567-f76af91db76c@ti.com>
Date: Wed, 2 Jan 2019 13:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181227060829.5080-1-lokeshvutla@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_035706_680317_16FA11F0 
X-CRM114-Status: GOOD (  23.55  )
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
Cc: Tero Kristo <t-kristo@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAyNy8xMi8yMDE4IDguMDgsIExva2VzaCBWdXRsYSB3cm90ZToKPiBUSSBBTTY1eCBTb0Mg
YmFzZWQgb24gSzMgYXJjaGl0ZWN0dXJlLCBpbnRyb2R1Y2VkIHN1cHBvcnQgZm9yIEV2ZW50cwo+
IHdoaWNoIGFyZSBtZXNzYWdlIGJhc2VkIGludGVycnVwdHMgd2l0aCBtaW5pbWFsIGxhdGVuY3ku
IFRoZXNlIGV2ZW50cwo+IGFyZSBub3QgY29tcGF0aWJsZSB3aXRoIHJlZ3VsYXIgaW50ZXJydXB0
cyBhbmQgYXJlIHZhbGlkIG9ubHkgdGhyb3VnaAo+IGFuIGV2ZW50IHRyYW5zcG9ydCBsYW5lLiBB
biBJbnRlcnJ1cHQgQWdncmVnYXRvcihJTlRBKSBpcyBpbnRyb2R1Y2VkCj4gdG8gY29udmVydCB0
aGVzZSBldmVudHMgdG8gaW50ZXJydXB0cy4gSU5UQSBjYW4gYWxzbyBncm91cCA2NCBldmVudHMK
PiBpbnRvIGEgc2luZ2xlIGludGVycnVwdC4gTm93IHRoZSBTb0MgaGFzIG1hbnkgcGVyaXBoZXJh
bHMgYW5kIGEgbGFyZ2UKPiBudW1iZXIgb2YgZXZlbnQgc291cmNlcyAodGltZSBzeW5jIG9yIERN
QSksIHRoZSB1c2Ugb2YgZXZlbnRzIGlzCj4gY29tcGxldGVseSBkZXBlbmRlbnQgb24gYSB1c2Vy
J3Mgc3BlY2lmaWMgYXBwbGljYXRpb24sIHdoaWNoIGRyaXZlcyBhCj4gbmVlZCBmb3IgbWF4aW11
bSBmbGV4aWJpbGl0eSBpbiB3aGljaCBldmVudCBzb3VyY2VzIGFyZSB1c2VkIGluIHRoZQo+IHN5
c3RlbS4gSXQgaXMgYWxzbyBjb21wbGV0ZWx5IHVwIHRvIHNvZnR3YXJlIGNvbnRyb2wgYXMgdG8g
aG93IHRoZQo+IGV2ZW50cyBhcmUgc2VydmljZWQuCj4gCj4gQmVjYXVzZSBvZiB0aGUgaHVnZSBm
bGV4aWJpbGl0eSB0aGVyZSBhcmUgY2VydGFpbiBzdGFuZGFyZCBwZXJpcGhlcmFscwo+IChsaWtl
IEdQSU8gZXRjKXdoZXJlIGFsbCBpbnRlcnJ1cHRzIGNhbm5vdCBiZSBkaXJlY3RseSBjb3JyZWN0
ZWQgdG8gaG9zdAo+IGludGVycnVwdCBjb250cm9sbGVyLiBGb3IgdGhpcyBwdXJwb3NlLCBJbnRl
cnJ1cHQgUm91dGVyKElOVFIpIGlzCj4gaW50cm9kdWNlZCBpbiB0aGUgU29DLiBJTlRSIGp1c3Qg
ZG9lcyBhIGNsYXNzaWMgaW50ZXJydXB0IHJlZGlyZWN0aW9uLgo+IAo+IFNvIHRoZSBTb0MgaGFz
IDMgdHlwZXMgb2YgaW50ZXJydXB0IGNvbnRyb2xsZXJzOgo+IC0gR0lDNTAwCj4gLSBJbnRlcnJ1
cHQgUm91dGVyCj4gLSBJbnRlcnJ1cHQgQWdncmVnYXRvcgo+IAo+IEJlbG93IGlzIGEgZGlhZ3Jh
bW1hdGljIHZpZXcgb2YgaG93IFNvQyBpbnRlZ3JhdGlvbiBvZiB0aGVzZSBpbnRlcnJ1cHQKPiBj
b250cm9sbGVyczooaHR0cHM6Ly9wYXN0ZWJpbi51YnVudHUuY29tL3AvOW5nVjNqZEdqMi8pCj4g
Cj4gRGV2aWNlIEluZGV4LXggICAgICAgICAgICAgICBEZXZpY2UgSW5kZXgteQo+ICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8Cj4gICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgIHwKPiAgICAgICAgICAgICAgICAgICAgICAgLi4uLgo+ICAgICAgICAgICAg
IFwgICAgICAgICAgICAgICAgICAgICAgIC8KPiAgICAgICAgICAgICAgXCAgICAgICAgICAgICAg
ICAgICAgIC8KPiAgICAgICAgICAgICAgIFwgIChnbG9iYWwgZXZlbnRzKSAgLwo+ICAgICAgICAg
ICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICstLS0tLS0tLS0rCj4gICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgfCAgICAgICAgIHwKPiAgICAgICAgICAg
fCAgICAgICAgICAgICBJTlRBICAgICAgICAgIHwgICB8ICBHUElPICAgfAo+ICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIHwgICAgICAgICB8Cj4gICAgICAgICAgICst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAgKy0tLS0tLS0tLSsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICh2aW50KSAgICAgICAgICAgIHwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICBc
fC8gICAgICAgICAgICAgICAgICAgIHwKPiAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSsgICAgICAgIHwKPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
IHw8LS0tLS0tLSsKPiAgICAgICAgICAgfCAgICAgICAgICAgSU5UUiAgICAgICAgICAgIHwKPiAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKPiAgICAgICAgICAgKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICB8Cj4gICAgICAgICAgICAgICAgICAgICAgICAgXHwvIChn
aWMgaXJxKQo+ICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+ICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+ICAgICAgICAgICB8ICAgICAgICAg
ICAgIEdJQyAgICAgICAgICAgfAo+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfAo+ICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+IAo+IFdoaWxl
IGF0IGl0LCBUSVNDSSBhYnN0cmFjdHMgdGhlIGhhbmRsaW5nIG9mIGFsbCBhYm92ZSBJUlEgcm91
dGVzIHdoZXJlCj4gaW50ZXJydXB0IHNvdXJjZXMgYXJlIG5vdCBkaXJlY3RseSBjb25uZWN0ZWQg
dG8gaG9zdCBpbnRlcnJ1cHQgY29udHJvbGxlci4KPiBUaGF0IHdvdWxkIGJlIGNvbmZpZ3VyYXRp
b24gb2YgSW50ZXJydXB0IEFnZ3JlZ2F0b3IgYW5kIEludGVycnVwdCBSb3V0ZXIuCj4gCj4gVGhp
cyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvcjoKPiAtIFRJU0NJIGNvbW1hbmRzIG5lZWRlZCBmb3Ig
SVJRIGNvbmZpZ3VyYXRpb24KPiAtIEludGVycnVwdCBSb3V0ZXIoSU5UUikgYW5kIEludGVycnVw
dCBBZ2dyZWdhdG9yKElOVEEpIGRyaXZlcnMKCldpdGggdGhlIGNvbXBpbGF0aW9uIGZpeCB0byBk
cml2ZXJzL2lycWNoaXAvaXJxLXRpLXNjaS1pbnRhLmMgZG1hdGVzdAphbmQgYXVkaW8gd29ya3Mg
d2l0aCB0aGUgc2VyaWVzOgoKVGVzdGVkLWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1
c2lAdGkuY29tPgoKPiBDaGFuZ2VzIHNpbmNlIHYzOgo+IC0gRml4IGRvY3VtZW50YXRpb24gZm9y
IEludGVycnVwdCBSb3V0ZXIgZHJpdmVyCj4gLSBSZWJhc2VkIG9uIHRvcCBvZiBsYXRlc3QgbmV4
dC4KPiAtIEZ1bGx5IHRlc3RlZCB3aXRoIERNQSh1c2luZyBvdXQgb2YgdHJlZSBwYXRjaGVzKQo+
IC0gRml4ZWQgYSBidWlsZCBlcnJvciB3aXRoIGFsbG1vZGNvbmZpZwo+IAo+IEdyeWdvcmlpIFN0
cmFzaGtvICgxKToKPiAgIGZpcm13YXJlOiB0aV9zY2k6IEFkZCBzdXBwb3J0IHRvIGdldCBUSVND
SSBoYW5kbGUgdXNpbmcgb2ZfcGhhbmRsZQo+IAo+IExva2VzaCBWdXRsYSAoMTEpOgo+ICAgZmly
bXdhcmU6IHRpX3NjaTogQWRkIHN1cHBvcnQgZm9yIFJNIGNvcmUgb3BzCj4gICBmaXJtd2FyZTog
dGlfc2NpOiBBZGQgc3VwcG9ydCBmb3IgSVJRIG1hbmFnZW1lbnQKPiAgIGZpcm13YXJlOiB0aV9z
Y2k6IEFkZCBoZWxwZXIgYXBpcyB0byBtYW5hZ2UgcmVzb3VyY2VzCj4gICBkdC1iaW5kaW5nczog
aXJxY2hpcDogSW50cm9kdWNlIFRJU0NJIEludGVycnVwdCByb3V0ZXIgYmluZGluZ3MKPiAgIGly
cWNoaXA6IHRpLXNjaS1pbnRyOiBBZGQgc3VwcG9ydCBmb3IgSW50ZXJydXB0IFJvdXRlciBkcml2
ZXIKPiAgIGdlbmlycS9tc2k6IEFkZCBzdXBwb3J0IGZvciBhbGxvY2F0aW5nIHNpbmdsZSBNU0kg
Zm9yIGEgZGV2aWNlCj4gICBnZW5pcnEvbXNpOiBBZGQgc3VwcG9ydCBmb3IgLm1zaV91bnByZXBh
cmUgY2FsbGJhY2sKPiAgIHNvYzogdGk6IEFkZCBNU0kgZG9tYWluIHN1cHBvcnQgZm9yIEszIElu
dGVycnVwdCBBZ2dyZWdhdG9yCj4gICBkdC1iaW5kaW5nczogaXJxY2hpcDogSW50cm9kdWNlIFRJ
U0NJIEludGVycnVwdCBBZ2dyZWdhdG9yIGJpbmRpbmdzCj4gICBpcnFjaGlwOiB0aS1zY2ktaW50
YTogQWRkIHN1cHBvcnQgZm9yIEludGVycnVwdCBBZ2dyZWdhdG9yIGRyaXZlcgo+ICAgc29jOiB0
aTogYW02OiBFbmFibGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgZHJpdmVycwo+IAo+IFBldGVyIFVq
ZmFsdXNpICgxKToKPiAgIGZpcm13YXJlOiB0aV9zY2k6IEFkZCBSTSBtYXBwaW5nIHRhYmxlIGZv
ciBhbTY1NAo+IAo+ICAuLi4vYmluZGluZ3MvYXJtL2tleXN0b25lL3RpLHNjaS50eHQgICAgICAg
ICAgfCAgIDMgKy0KPiAgLi4uL2ludGVycnVwdC1jb250cm9sbGVyL3RpLHNjaS1pbnRhLnR4dCAg
ICAgIHwgIDc0ICsrCj4gIC4uLi9pbnRlcnJ1cHQtY29udHJvbGxlci90aSxzY2ktaW50ci50eHQg
ICAgICB8ICA4NSArKwo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDQgKwo+ICBkcml2ZXJzL2Zpcm13YXJlL3RpX3NjaS5jICAgICAgICAgICAgICAg
ICAgICAgfCA4NDggKysrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvZmlybXdhcmUvdGlfc2Np
LmggICAgICAgICAgICAgICAgICAgICB8IDEwMiArKysKPiAgZHJpdmVycy9pcnFjaGlwL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgIHwgIDIzICsKPiAgZHJpdmVycy9pcnFjaGlwL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKPiAgZHJpdmVycy9pcnFjaGlwL2lycS10
aS1zY2ktaW50YS5jICAgICAgICAgICAgIHwgNTYxICsrKysrKysrKysrKwo+ICBkcml2ZXJzL2ly
cWNoaXAvaXJxLXRpLXNjaS1pbnRyLmMgICAgICAgICAgICAgfCAzMTAgKysrKysrKwo+ICBkcml2
ZXJzL3NvYy90aS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKwo+ICBkcml2
ZXJzL3NvYy90aS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICBkcml2
ZXJzL3NvYy90aS9rM19pbnRhX21zaS5jICAgICAgICAgICAgICAgICAgfCAxOTMgKysrKwo+ICBp
bmNsdWRlL2xpbnV4L2lycWRvbWFpbi5oICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICBp
bmNsdWRlL2xpbnV4L21zaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKwo+ICBp
bmNsdWRlL2xpbnV4L3NvYy90aS9rM19pbnRhX21zaS5oICAgICAgICAgICAgfCAgMjIgKwo+ICBp
bmNsdWRlL2xpbnV4L3NvYy90aS90aV9zY2lfcHJvdG9jb2wuaCAgICAgICAgfCAxNjkgKysrKwo+
ICBrZXJuZWwvaXJxL21zaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNzIgKy0K
PiAgMTggZmlsZXMgY2hhbmdlZCwgMjQ3MCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkK
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci90aSxzY2ktaW50YS50eHQKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci90
aSxzY2ktaW50ci50eHQKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXJxY2hpcC9pcnEt
dGktc2NpLWludGEuYwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pcnFjaGlwL2lycS10
aS1zY2ktaW50ci5jCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy90aS9rM19pbnRh
X21zaS5jCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3NvYy90aS9rM19pbnRh
X21zaS5oCj4gCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2th
bGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIx
LTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
