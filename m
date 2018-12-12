Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F34C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:43:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE60A20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWtnkOY6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y+qH2CzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE60A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0/nauh1+o0L+RaLh3uuxcYssaoes/pPueEF+Plk7qJk=; b=nWtnkOY6bSi2R2
	/xrUJGmxG/gvIANqE3a3wH7ois6I9XE+l6AE2pHZW9EkxR1URSEjkZmiU9Hb/1T35lzCgO0gwyGGl
	EudeDLoewPiNh+U1NL6U/rrw3V5M0SUKkLzzcvt7DAyf7W+ESgmnHvyYf7J/6KiggTX1Td8WYDJzJ
	392eNJWrIZH5cy224FdHxEeb+SpdlAFG1Y6tzhXmbWEdMufUpR0KfPt1Mttg83U2pge4fI2VsAEkM
	1uT0tuWK2sqbpzhyWCzckg0jAi9DMl4GztEpxE9AdK3TFA2sPE3tMGSymkTd9A0vCE8IgUPJxJXK4
	rhAPkKY0g8iPQCY8JoZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4mr-000788-MV; Wed, 12 Dec 2018 13:42:53 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4mo-00076t-4e
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 13:42:51 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCDgU39088119;
 Wed, 12 Dec 2018 07:42:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544622150;
 bh=e4EjKbfRP4gPP8UxttyWkX4y6Vc7phVnSJNNc2Y2h8k=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Y+qH2CzQofXRxTS9YLQOn1F3Use/G0bMvRsAR5fY+b7HLN2ycEKNRow9GvId6jDsm
 8nHRjNMrd45lkilLvUNUiu1tX671F3+jyEW3KVbUUHRusSgzItTzxB1syLX+W2GpXr
 +NYsrcDyQ6JM66OQX1mUSTwW3lVdVIXeJILY4tJ4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCDgUjW055778
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Dec 2018 07:42:30 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 07:42:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 07:42:29 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCDgRar017639;
 Wed, 12 Dec 2018 07:42:28 -0600
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
 <539f3dd5-93b7-e902-247b-93c6461e121f@ti.com>
 <20181212125011.GH9507@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <dfe405c5-ae7a-5511-9cd5-7bed6470b0c8@ti.com>
Date: Wed, 12 Dec 2018 15:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212125011.GH9507@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_054250_279629_BDD5FB64 
X-CRM114-Status: GOOD (  25.47  )
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

Ck9uIDEyLzEyLzIwMTggMTQuNTAsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3cm90ZToKPj4g
RXZlbiB3aXRoIHRoZSBkZWxheSBJIGNhbiBub3QgZ2V0IHRoZSBldGhlcm5ldCB3b3JraW5nIG9u
IEJsYXplLiBJdAo+PiBzdXBwb3NlZCB0byBiZSBtb3N0bHkgdGhlIHNhbWUgSFcgYXMgc2RwICh3
ZSBsb2FkIHRoZSBzYW1lIG9tYXA0LXNkcC5kdGIpLgo+Pgo+PiBbICAgIDIuNTc2NTk5XSBrczg4
NTEgc3BpMC4wOiBzcGkwLjAgc3VwcGx5IHZkZC1pbyBub3QgZm91bmQsIHVzaW5nCj4+IGR1bW15
IHJlZ3VsYXRvcgo+PiBbICAgIDIuNTg0MDQ1XSBrczg4NTEgc3BpMC4wOiBMaW5rZWQgYXMgYSBj
b25zdW1lciB0byByZWd1bGF0b3IuMAo+PiBbICAgIDIuNTg0MTM2XSBrczg4NTEgc3BpMC4wOiBM
aW5rZWQgYXMgYSBjb25zdW1lciB0byByZWd1bGF0b3IuNAo+PiBbICAgIDIuNTk1OTE2XSBrczg4
NTEgc3BpMC4wOiBtZXNzYWdlIGVuYWJsZSBpcyAwCj4+IFsgICAgMi42MDI2NjFdIGtzODg1MSBz
cGkwLjA6IGZhaWxlZCB0byByZWFkIGRldmljZSBJRAo+PiBbICAgIDIuNjA3NjA0XSBrczg4NTEg
c3BpMC4wOiBEcm9wcGluZyB0aGUgbGluayB0byByZWd1bGF0b3IuNAo+PiBbICAgIDIuNjA3NjA0
XSBrczg4NTEgc3BpMC4wOiBEcm9wcGluZyB0aGUgbGluayB0byByZWd1bGF0b3IuMAo+Pgo+PiBJ
IGNhbiBub3QgcmVjYWxsIHdoZW4gd2FzIHRoZSBsYXN0IHRpbWUgaXQgd29ya2VkLCBjb3VsZCBi
ZSB5ZWFycyBhZ28uCj4gCj4gSXQncyBhbHdheXMgYmVlbiBkZXRlY3RlZCBhdCBib290IHdpdGhv
dXQgcHJvYmxlbSBmb3IgbWUuICBFLmcuOgo+IAo+IGh0dHA6Ly93d3cuYXJtbGludXgub3JnLnVr
L2RldmVsb3Blci9idWlsZC9yZXN1bHQucGhwP3R5cGU9Ym9vdCZpZHg9MTE3MTYKClRoYW5rcyBm
b3IgdGhlIGxvZy4gSXQgbG9va3MgbGlrZSB5b3UgaGF2ZSB1LWJvb3Qgd2l0aCBrczg4NTEgc3Vw
cG9ydCwKYnV0IGl0IGlzIG5vdCB3b3JraW5nIHdpdGggbWFpbmxpbmUgdS1ib290IChldGggaXMg
bm90IHN1cHBvcnRlZCBhZmFpaykuCgo+IFRoaXMgcGF0Y2ggZml4ZXMgd2hhdCBoYXBwZW5zIHdo
ZW4geW91IHRyeSB0byB1bmJpbmQvcmViaW5kIHRoZSBkZXZpY2UuCj4gSSB0cmlwcGVkIG92ZXIg
dGhhdCB3aGlsZSBleHBlcmltZW50aW5nIHdpdGggdGhlIEdQSU8gaGFyZHdhcmUgLSBJJ2QKPiBp
bmFkdmVydGVudGx5IGRpc2FibGVkIHRoZSBkZXRlY3Rpb24gcmVnaXN0ZXJzIGZvciB0aGUgZXRo
ZXJuZXQgSVJRCj4gd2l0aCBkZXZtZW0yIG9uIE5GUywgYW5kIHdhbnRlZCB0byByZXByb2JlIHRo
ZSBkZXZpY2UgdG8gcmVjb3ZlciB0aGUKPiBzaXR1YXRpb24gd2l0aCB0aGUgbWluaW11bSBvZiBk
aXNydXB0aW9uLgo+IAo+IERvZXMgYSBsb25nZXIgZGVsYXkgbWFrZSBhbnkgZGlmZmVyZW5jZSBm
b3IgYmxhemU/CgpObywgaXQgZG9lcyBub3QgaGVscC4KCj4gCj4gWW91IGNvdWxkIHRyeSBzZXR0
aW5nIGl0IGZvciBhIHZlcnkgbG9uZyBkZWxheSAoNSBzZWNvbmRzPykgYW5kIGNoZWNrCj4gd2hl
dGhlciB5b3UgZ2V0IGFueSBsaW5rIGxpZ2h0cyAtIGlmIG5vdCwgaXQgcHJvYmFibHkgc3VnZ2Vz
dHMgZWl0aGVyCj4gdGhlIEtTODg1MSBpcyBub3QgZ2V0dGluZyBwb3dlciwgdGhlIEtTODg1MSBo
YXMgZGllZCwgb3IgdGhlcmUncyBhCj4gZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBTRFAgYW5kIEJs
YXplIGluIHRoaXMgYXJlYS4KPiAKPiBPbiB0aGUgU0RQLCB0aGUgcG93ZXIgaXMgcmVhZGlseSBp
ZGVudGlmeWFibGUgZnJvbSB0aGUgS1M4ODUxIHBpbm91dAo+IGFuZCB0aGUgbGFyZ2VyIHRyYWNr
cyB3aXRoIHRoZSBjZXJhbWljIGRlY291cGxpbmcgY2FwYWNpdG9ycywgYnV0IEknbQo+IHVuZmFt
aWxpYXIgd2l0aCBibGF6ZSB0byBrbm93IHdoZXRoZXIgaXQncyBhcyBvYnZpb3VzLCBhbmQgdGhl
cmVmb3JlCj4gd2hldGhlciB0aGUgc3VwcGxpZXMgdG8gdGhlIEtTODg1MSBjb3VsZCBiZSBlYXNp
bHkgY2hlY2tlZC4KCk15IGd1ZXNzIGlzIHRoZSBldGhlcm5ldCBqdXN0IGRlYWQgb24gbXkgYm9h
cmQuIElmIEkgaGF2ZSB0aW1lIEkgd2lsbAp0YWtlIGl0IGFwYXJ0IGFuZCBzZWUgaWYgSSBjYW4g
cHJvYmUgdGhlIG5lZWRlZCBwaW5zLgoKVGhhbmsgeW91LAotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1
bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVu
bnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtp
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
