Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE929C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:05:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E4C2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hlkshWzR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cHGgM0S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E4C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMG+toyHGr+rMTVteUnWawwVdpWs1cx6UId4BJIHzIs=; b=hlkshWzRqzyvCS
	LEoGPgXNNLtRCAB27xJHWiU48XHVFbyLChMhz12dHSFi0uiIJFDJbDnpC0tN/+cmJ/E1dCzrKeeir
	EcF+rnrByj/3tSDrBcEnhHCb3yF0qQ1I/1/6e5Fbkn4XlT5oxKdP4driOblL/V7bahwS+PwYp53he
	iNhzopXTCyD41o0/Kqqqsw+k4IxAR/vEFuQKu7MefQKEjQ+O+Bj1m7m+tfHsIiGVyLsVNmAohXfwY
	o6jrgyNf5JObKzYcwENl9/UTissC11+BMimoHI9cGUtUmAthslc3zjA3VYLEjrFHkmj+Wh0Z3dwQk
	cy7WoGGo0xq9QOBLZWyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXn9X-00072P-Da; Fri, 14 Dec 2018 13:05:15 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXn9T-0005nY-Ey
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:05:13 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBED4mfe006648;
 Fri, 14 Dec 2018 07:04:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544792688;
 bh=jVcLY78JlaV/LfYRInGKLib2coYAdEt54PgqTV71GZI=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=cHGgM0S0gKV30y8UGDX17U7BRphowo4g2dAsr4UKRkAchTCn6a7TuUtHTBUx/dD+i
 wF6+evd1KR0IofPNbF11mhztFmchylH9jgCw7flo+OSlBN7u+ldkM+jfX6LSFC2II/
 a67p+aSNbQ2dR3xiNts+x1buPg/Fa9tKnfb16ijw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBED4mYD072028
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 07:04:48 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 07:04:46 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 07:04:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBED4iGU009661;
 Fri, 14 Dec 2018 07:04:44 -0600
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if booted
 with latest u-boot
To: Tony Lindgren <tony@atomide.com>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
 <20181213151703.GN6707@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0c53704e-2edd-8fe8-6fb4-f5865d62770b@ti.com>
Date: Fri, 14 Dec 2018 15:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213151703.GN6707@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_050511_546794_9B285425 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 linux@armlinux.org.uk, bcousson@baylibre.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMy8xMi8yMDE4IDE3LjE3LCBUb255IExpbmRncmVuIHdyb3RlOgo+ICogUGV0ZXIgVWpm
YWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4gWzE4MTIxMyAxMzo1N106Cj4+IEFmdGVyIHNv
bWUgZGVidWdnaW5nIEkgaGF2ZSBtYW5hZ2VkIHRvIGdldCB0aGUgZXRoZXJuZXQgd29ya2luZyB3
aXRoCj4+IG1haW5saW5lIHUtYm9vdCB3aGlsZSBub3QgYnJlYWtpbmcgdGhlIG5ldHdvcmtpbmcg
d2l0aCB0aGUgY2FzZSB3aGVuIHdlCj4+IGJvb3Qgd2l0aCB0aGUgbXlzdGVyaW91cyBiaW5hcnkg
dS1ib290Lgo+IAo+IEknbSBwcmV0dHkgc3VyZSB0aGlzIGlzIHRoZSBtb3N0IHJlY2VudCB2ZXJz
aW9uIG9mCj4gV0lQIHUtYm9vdCBTUEkgc3VwcG9ydCBmcm9tIE5pc2hhbnRoOgo+IAo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9ubWVub24vdS1ib290L3RyZWUvdjIwMTQuMDQtbW9kL3NkcDQ0MzAtZXRo
ZXJuZXQKCkNvb2wsIHRoYW5rcyEKCkl0IGZhaWxzIHRvIGNvbXBpbGUgc28gZmFyIHdpdGggYW55
IG9mIHRoZSB0b29sY2hhaW5zIEkgaGF2ZSB0cmllZCBzbyBmYXIgOigKCj4gRnJvbSB3aGF0IEkg
cmVjYWxsLCB0aGF0IGRpZCBub3Qgd29yayBmb3IgQmxhemUgdGhvdWdoCj4gZm9yIGVuYWJsaW5n
IEV0aGVybmV0IGZvciB0ZnRwIGJvb3RpbmcgYnV0IHdvcmtlZCBvbgo+IDQ0MzAtc2RwLiBNYXli
ZSBiZWNhdXNlIG9mIHRoZSBzYW1lIGlzc3VlcyBhcyB0aGVzZQo+IGtlcm5lbCBwYXRjaGVzIHRo
b3VnaC4KCk15IEJsYXplIGlzIHRoZSAnYmlnIHBob25lIHcvIHR3byBkaXNwbGF5JyBhbmQgbm90
IHRoZSB0YWJsZXQuIEFmYWlrIGl0CmlzIGEgc2hyaW5rIGRvd24gdmVyc2lvbiBvZiBzZHAuCgpB
bmQgdGhlIHUtYm9vdCBjb2RlIHN0aWxsIGxlYXZlcyBvcGVuIHRoZSBxdWVzdGlvbnMgcmVnYXJk
aW5nIHRvIHBpbm1peAphbmQgZ3Bpb18xMzguCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMg
RmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1
c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
