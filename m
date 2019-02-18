Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42150C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117D7214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZXL2vHW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jH2fXfU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117D7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYkW90xZpFtM1OjYK2MqwNXroybspawhxdZ8USRGxyM=; b=TZXL2vHWSr7gR0
	ms+sZoycLiQVmyeVFZzcVEEnA+FBNY35mJ5GW6zF70PNQenk0cPNTxR4jp/tofgGdP2zdbO1R/K33
	RY15ZzltT/f2/Vt4Q+C6tFD6c0qKd9rv3QIHBLz9S542b2BsMCGZc+WAW/V8qarbDMZNLYqIfHry6
	e/4FeJNGi+eolO0IGX7+3EmjF5hizJ6E9CZOkWftZ1rTsYnPuuqMEdgz7GWu16m6Eiu9SCJHmbOxD
	stn00iVs5AMcVZd2fXCZFlWNyNAt47hJbDkRMZE1GLspBn5f1scC8XKjtCNLj+tyEc1CX5ubb7XR7
	x5PIDg2xr6ng0+yeLBXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlgP-0001SB-RO; Mon, 18 Feb 2019 16:22:17 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlgM-0001PT-5L
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 16:22:15 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IGM6q2090183;
 Mon, 18 Feb 2019 10:22:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550506926;
 bh=INLNfmfSwceeFyLka/80I1hvvHF700rywDdDnSZO+7M=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=jH2fXfU5zryRif580ii8Xd/2aWLvANHV75lOjCWq2Sn40wtBg71gWVJt2Eg9IJJNL
 Ep6bD7WsQSXWFrNt99UtWzLpHnD8Y6CQN/lQUuZJ9YG8gR3EMtzSIiSyLTJiekpBsJ
 oPssrZ17lShHxli99v+O59Lhl6CEsOaaWTxVY7kc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IGM6S3065590
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Feb 2019 10:22:06 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 10:22:06 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 10:22:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IGM36H017998;
 Mon, 18 Feb 2019 10:22:03 -0600
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
To: Tony Lindgren <tony@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
Date: Mon, 18 Feb 2019 18:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218144430.GE15711@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_082214_304884_48402C9B 
X-CRM114-Status: GOOD (  18.10  )
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

CgpPbiAxOC8wMi8yMDE5IDE2LjQ0LCBUb255IExpbmRncmVuIHdyb3RlOgo+ICogUGV0ZXIgVWpm
YWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4gWzE5MDIxOCAxNDozNl06Cj4+IEhpLAo+Pgo+
PiBjZDI4ZDFkNmU1MmU6ICgibmV0OiBwaHk6IGF0ODAzeDogRGlzYWJsZSBwaHkgZGVsYXkgZm9y
IFJHTUlJIG1vZGUiKSBicm9rZSB0aGUKPj4gZXRoZXJuZXQgbmV0d29ya2luZyBvbiBldm1zayAo
YW5kIG1vc3QgbGlrZWx5IG9uIHRoZSBldm0gYXMgd2VsbCk6Cj4+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lm96bGFicy5vcmcvcGF0Y2gvMTAyODUyNy8KPj4KPj4gdjEgcGF0Y2ggdG8gZml4IHRoZSBzaXR1
YXRpb246Cj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTA0MDYxNy8KPj4K
Pj4gSXQgdHVybmVkIG91dCB0aGF0IHRoZSBhdDgwM3ggZHJpdmVyIGlzIGFjdHVhbGx5IGJyb2tl
biBhbmQgbmVlZCB0byBiZSBmaXhlZAo+PiBhbG9uZyB3aXRoIHRoZSBEVCBkYXRhLgo+Pgo+PiBU
aGUgZm9sbG93aW5nIHNlcmllcyBpcyBwcm9wb3NlZCB0byBmaXggdGhlIGRyaXZlcjoKPj4gaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9saXN0Lz9zZXJpZXM9OTI2
MTEKPj4KPj4gYnV0IHRoZSBQSFQgbW9kZSBuZWVkcyB0byBiZSBzd2l0Y2hlZCB0byByZ21paS1p
ZCBmcm9tIHJnbWlpLXR4aWQ6Cj4+IFRoZSByeCBkZWxheSBpcyBlbmFibGVkIGJ5IGRlZmF1bHQg
YW5kIHRoZSBkcml2ZXIgbmV2ZXIgZGlzYWJsZWQgaXQgc28gd2hlbgo+PiBhc2tpbmcgcmdtaWkt
dHhpZCBpdCBhY3R1YWxseSBnb3QgcmdtaWktaWQuCj4+Cj4+IFRoZSBwYXRjaCBjYW4gYmUgYmFj
a3BvcnRlZCB0byBzdGFibGUsIEkgaGF2ZSB0ZXN0ZWQgdGhhdCBpdCBpcyBub3QgY2F1c2luZwo+
PiByZWdyZXNzaW9uIHdpdGggdGhlIG9sZCwgYnJva2VuIGRyaXZlci4KPiAKPiBDYW4gdGhlIGR0
cyBjaGFuZ2VzIGJlIG1lcmdlZCBiZWZvcmUgdGhlIGRyaXZlciBjaGFuZ2VzIG9yCj4gZG9lcyBp
dCBjYXVzZSB0aGUgcGh5IHRvIHN0b3Agd29ya2luZz8KClRoZSBwaHkgaXMgbm90IHdvcmtpbmcg
YXRtLCBidXQgdGhpcyBjaGFuZ2Ugd2lsbCBub3QgY2F1c2UgcmVncmVzc2lvbgpldmVuIGlmIGl0
IGlzIG1lcmdlZCBmaXJzdC4KCj4gCj4gUmVnYXJkcywKPiAKPiBUb255Cj4gCgotIFDDqXRlcgoK
VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVs
c2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNp
bGU6IEhlbHNpbmtpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
