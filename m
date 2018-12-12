Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3448C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:14:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CFA20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcB24DNo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kBU+pRG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CFA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o+Ek9Qqia+HXS5Db7jS6QJbX4iLNtKek03DJ15zx1RA=; b=gcB24DNoEI2aMz
	iHNuAFxP+PeB+R45Z4z32SeNvUSAvU5VuXZnJASxbJLP8/sGOasOeKfTulLsfB4wlDy2NY3oORcMO
	FqqPrVyPFnBQmC8f1tI+at+VT8Sqw9FmrKz8YPQ5ZgF9BnGBGkcKsSQmE8L0eCDJXohnwlMyTGqy/
	JyGfTOmCUflYJr+0H2EDycfyaEgmDUA9vuIieHrluHI6CNZLdsXyHwXnuvphTXjo6rQFnkcRV//q+
	n4zCMd1Wmk7KbjhT/ftjWxD/6RsEXEWunpKrHcCBYLc36GOSb1lO+FoS1zUmBwkQww9NSqB1g17nI
	8f+M9NmeOMFVrfvz/tyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3P7-0001Ro-LS; Wed, 12 Dec 2018 12:14:17 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3P5-0001Pt-Ao
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:14:16 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCCDmNk118634;
 Wed, 12 Dec 2018 06:13:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544616828;
 bh=EZTrOUTCYiE1l5prS1v7iw52PvkZU5oN5jN7RG1ofp0=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=kBU+pRG3l67N38tk24fhTDoM66gEI8dP0MDHFYXtVQRPzIzkaFpctAsjfh3ykwDIQ
 nCTTjhC/HxcbPuw7Wrq7ZMIzhgdnGu89BuwHndhDp/wQjIR+V/DVT7e3A2KFYv24fe
 6VSTMgBVBGr/1rzxxa8LnNzc1cN2lxux3hE4Pu2M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCCDm4J086498
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Dec 2018 06:13:48 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 06:13:48 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 06:13:48 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCCDkML011672;
 Wed, 12 Dec 2018 06:13:47 -0600
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <539f3dd5-93b7-e902-247b-93c6461e121f@ti.com>
Date: Wed, 12 Dec 2018 14:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181207135751.GZ6920@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_041415_474484_C67FF96F 
X-CRM114-Status: GOOD (  20.53  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UnVzc2VsbCwKCk9uIDA3LzEyLzIwMTggMTUuNTcsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3
cm90ZToKPiBPbiBGcmksIERlYyAwNywgMjAxOCBhdCAwMzo0MDoxM1BNICswMjAwLCBQZXRlciBV
amZhbHVzaSB3cm90ZToKPj4gUnVzc2VsbCwKPj4KPj4gT24gMDcvMTIvMjAxOCAxNC41MiwgUnVz
c2VsbCBLaW5nIC0gQVJNIExpbnV4IHdyb3RlOgo+Pj4gSXQgd2FzIG5vdGljZWQgdGhhdCB1bmJp
bmRpbmcgYW5kIHJlYmluZGluZyB0aGUgS1NaODg1MSBldGhlcm5ldAo+Pj4gcmVzdWx0ZWQgaW4g
dGhlIGRyaXZlciByZXBvcnRpbmcgImZhaWxlZCB0byByZWFkIGRldmljZSBJRCIgYXQgcHJvYmUu
Cj4+PiBQcm9iaW5nIHRoZSByZXNldCBsaW5lIHdpdGggYSAnc2NvcGUgd2hpbGUgcmVwZWF0ZWRs
eSBhdHRlbXB0aW5nIHRvCj4+PiBiaW5kIHRoZSBkcml2ZXIgaW4gYSBzaGVsbCBsb29wIHJldmVh
bGVkIHRoYXQgdGhlIEtTWjg4NTEgUlNUTiBwaW4gaXMKPj4+IGNvbnN0YW50bHkgaGVsZCBhdCB6
ZXJvLCBtZWFuaW5nIHRoZSBkZXZpY2UgaXMgaGVsZCBpbiByZXNldCwgYW5kCj4+PiBkb2VzIG5v
dCByZXNwb25kIG9uIHRoZSBTUEkgYnVzLgo+Pj4KPj4+IEV4cGVyaW1lbnRhdGlvbiB3aXRoIHRo
ZSBzdGFydHVwIGRlbGF5IG9uIHRoZSByZWd1bGF0b3Igc2V0IHRvIDUwbXMKPj4+IHNob3dzIHRo
YXQgdGhlIHJlc2V0IGlzIHBvc2l0aXZlbHkgcmVsZWFzZWQgYWZ0ZXIgMjBtcy4KPj4+Cj4+PiBT
Y2hlbWF0aWNzIGZvciB0aGlzIGJvYXJkIGFyZSBub3QgYXZhaWxhYmxlLCBhbmQgdGhlIHRyYWNl
cyBhcmUgYnVyaWVkCj4+PiBpbiB0aGUgaW5uZXIgbGF5ZXJzIG9mIHRoZSBib2FyZCB3aGljaCBt
YWtlcyB0cmFjaW5nIHdoZXJlIHRoZSBSU1ROIHBpbgo+Pj4gZXh0cmVtZWx5IGRpZmZpY3VsdC4g
IFdlIGNhbiBvbmx5IGd1ZXNzIHRoYXQgdGhlIFJTVE4gcGluIGlzIHdpcmVkIHRvIGEKPj4+IHJl
c2V0IGdlbmVyYXRvciBjaGlwIGRyaXZlbiBvZmYgdGhlIGV0aGVybmV0IHN1cHBseSwgd2hpY2gg
Zml0cyB0aGUKPj4+IG9ic2VydmVkIGJlaGF2aW91ci4KPj4KPj4gQmFzZWQgb24gdGhlIHNjaGVt
YXRpY3Mgb2YgdGhlIEJsYXplIGRldmljZSAod2hpY2ggc2hvdWxkIGJlIHZlcnkgY2xvc2UKPj4g
dG8gU0RQNDQzMCk6Cj4+Cj4+IFRQUzIyOTAyWUZQUiBpcyB1c2VkIGFzIHRoZSByZWd1bGF0b3Ig
c3dpdGNoIChncGlvNDggY29udHJvbGxlZCkKPj4gVGhlIFZPVVQgaXMgcm91dGVkIHRvICBUUFMz
ODA4RzAxREJWIChTQ0ggTm90ZTogVGhyZXNob2xkIHNldCBhdCA5MCUuCj4+IFZzZW5zZTogMC40
MDVWKS4KPj4KPj4gQWNjb3JkaW5nIHRvIHRoZSBUUFMzODA4IGRhdGEgc2hlZXQgdGhlIFJFU0VU
IGRlbGF5IHRpbWUgd2hlbiBDdCBpcyBvcGVuCj4+ICh0aGlzIGlzIHRoZSBjYXNlIGluIHRoZSBz
Y2hlbWEpOiBNSU4vVFlQL01BWDogMTIvMjAvMjggbXMuCj4+Cj4+IFRoZSAyMG1zIHlvdSBhcmUg
c2VlaW5nIGNvbmZpcm1zIHRoaXMgc2V0dXAuCj4gCj4gVGhhbmtzIGZvciB0aGUgY29uZmlybWF0
aW9uIGFuZCBpbmZvcm1hdGlvbi4gIFRoZSBCbGF6ZSBzY2hlbWF0aWNzCj4gYXJlIGFsc28gdW5h
dmFpbGFibGUgYWZhaWNzLgoKRXZlbiB3aXRoIHRoZSBkZWxheSBJIGNhbiBub3QgZ2V0IHRoZSBl
dGhlcm5ldCB3b3JraW5nIG9uIEJsYXplLiBJdApzdXBwb3NlZCB0byBiZSBtb3N0bHkgdGhlIHNh
bWUgSFcgYXMgc2RwICh3ZSBsb2FkIHRoZSBzYW1lIG9tYXA0LXNkcC5kdGIpLgoKWyAgICAyLjU3
NjU5OV0ga3M4ODUxIHNwaTAuMDogc3BpMC4wIHN1cHBseSB2ZGQtaW8gbm90IGZvdW5kLCB1c2lu
ZwpkdW1teSByZWd1bGF0b3IKWyAgICAyLjU4NDA0NV0ga3M4ODUxIHNwaTAuMDogTGlua2VkIGFz
IGEgY29uc3VtZXIgdG8gcmVndWxhdG9yLjAKWyAgICAyLjU4NDEzNl0ga3M4ODUxIHNwaTAuMDog
TGlua2VkIGFzIGEgY29uc3VtZXIgdG8gcmVndWxhdG9yLjQKWyAgICAyLjU5NTkxNl0ga3M4ODUx
IHNwaTAuMDogbWVzc2FnZSBlbmFibGUgaXMgMApbICAgIDIuNjAyNjYxXSBrczg4NTEgc3BpMC4w
OiBmYWlsZWQgdG8gcmVhZCBkZXZpY2UgSUQKWyAgICAyLjYwNzYwNF0ga3M4ODUxIHNwaTAuMDog
RHJvcHBpbmcgdGhlIGxpbmsgdG8gcmVndWxhdG9yLjQKWyAgICAyLjYwNzYwNF0ga3M4ODUxIHNw
aTAuMDogRHJvcHBpbmcgdGhlIGxpbmsgdG8gcmVndWxhdG9yLjAKCkkgY2FuIG5vdCByZWNhbGwg
d2hlbiB3YXMgdGhlIGxhc3QgdGltZSBpdCB3b3JrZWQsIGNvdWxkIGJlIHllYXJzIGFnby4KCi0g
UMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAw
MDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtr
YS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
