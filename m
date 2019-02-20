Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87508C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:30:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F5B21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HF16yBFY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v4BH22Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F5B21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UurdTzXIz2Nio/o8f9dkkjxNvkGsf171YtQup7Vp2eo=; b=HF16yBFYoMu0jo
	pIfQCCC73gQvkGPdtIQbh+FFFfzGCU3QcK8ZEStEoNXtInvNpkiO/42NHTyKV46NWw3qawRetaExh
	VlejUPHzYxJr9Pm0/dY5t94t7BrniTd5ufTf2T7a+uobZwNjb1HsOs4BixtfYc0sDg93vYZtmw0df
	uKeH0vRC+Au5utt2SF00URIL+cOhkJXQ8fQrRBUIomVqlQiDw4a42Z0B0tjekqeBZGNVJqdfO70Av
	6HxOLVTyOcLYZ6rqlPDgF6q2gyEwBdK/2zzFYbUeDWa5oGNGCRl1uDzx51nVQby8cZxQ5A1JYbTtn
	9yggL/GRKUxHMGCC7BMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwNGj-0007ba-B0; Wed, 20 Feb 2019 08:30:17 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwNGc-0007DQ-4t
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 08:30:15 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1K8TxY8072151;
 Wed, 20 Feb 2019 02:29:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550651399;
 bh=HqNxmaXfLmHwriIKbefPT/fiSfmj40Ghm0LsIc0ktuY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=v4BH22JeKdeCScDEcDuXVwpGAWH+mkW2PWWbHB126uOCwX/SnWZXkaMhe2as5u1/k
 ULk2Ycc2zERAKVfiEq1GQww/y+/PZgyiIdoNHlbh1jRMRFgCCbXtZQXO6vFrpWIa8H
 bjr3PxIxeWfxMC88NWE2LtUeXFbtkwSdxQrQZfAc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1K8TwfN077366
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 02:29:58 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 02:29:58 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 02:29:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1K8TtBO027253;
 Wed, 20 Feb 2019 02:29:56 -0600
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
To: Tony Lindgren <tony@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
 <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
 <20190218162613.GH15711@atomide.com>
 <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
 <20190219165231.GK15711@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2543f0cd-f3d7-b958-785a-b24e37587d7f@ti.com>
Date: Wed, 20 Feb 2019 10:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190219165231.GK15711@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_003010_313646_CDB3950A 
X-CRM114-Status: GOOD (  18.08  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 marc.w.gonzalez@free.fr, netdev@vger.kernel.org, nsekhar@ti.com,
 vkoul@kernel.org, f.fainelli@gmail.com, bcousson@baylibre.com,
 niklas.cassel@linaro.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVG9ueSwKCk9uIDE5LzAyLzIwMTkgMTguNTIsIFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gKiBQ
ZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPiBbMTkwMjE5IDA4OjAyXToKPj4g
T24gMTgvMDIvMjAxOSAxOC4yNiwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPj4+IE9LIHNvIHNvdW5k
cyBsaWtlIHRoZXNlIGFyZSBPSyB0byB3YWl0IGZvciB2NS4xIG1lcmdlIHdpbmRvdwo+Pj4gdGhl
biBhcyB0aGUgZHRzIGNoYW5nZXMgYWxvbmUgd29uJ3QgZml4IGFueXRoaW5nPwo+Pgo+PiBJIHRo
aW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBzZW5kIHRoZXNlIHRvIDUuMCB0byBhdm9pZCB0aGUg
cmVncmVzc2lvbgo+PiBzaXRpbmcgaW4gbGludXgtbmV4dC4KPj4KPj4gVGhlIHBhdGNoZXMgYXJl
IGFjdHVhbGx5IGRvaW5nIHRvIHRoZSBjb3JyZWN0IHRoaW5nICh3ZSBuZWVkIHJnbWlpLWlkLAo+
PiBub3Qgcm1naWktdHhpZCBmb3IgdGhlc2UgYm9hcmRzKS4KPj4gSXQgd2FzIGp1c3QgYSBtYXR0
ZXIgb2YgbHVjayB0aGF0IGl0IHdvcmtlZCB3aXRoIHJnbWlpLXR4aWQgYXMgdGhlCj4+IGRyaXZl
ciB3YXMgYnJva2VuIGFuZCBkaWQgbm90IGRpc2FibGVkIHRoZSByeGlkIHdoZW4gaXQgc2hvdWxk
IGhhdmUuCj4gCj4gT0sgYXBwbHlpbmcgaW50byBvbWFwLWZvci12NS4wL2ZpeGVzLXYyLiBJJ2xs
IHNlbmQgYSBwdWxsCj4gcmVxdWVzdCBvbiBUaHVyc2RheSBtb3N0IGxpa2VseSB0aGVuLCBsZXQn
cyBzZWUgaWYgaXQgbWFrZXMKPiBpdCBmb3IgdjUuMC4KClRoYW5rIHlvdSEKCi0gUMOpdGVyCgpU
ZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxz
aW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2ls
ZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
