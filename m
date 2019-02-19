Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6B9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:02:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCDD21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNMaNPFt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VyGB364P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCDD21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bU4FePAT2prQ3/BGnJ685gKClpiBDTkZtEt6jnuMprs=; b=MNMaNPFtJtJM1W
	6M1n0BveFTwRInhHj8fNsfio1dvx2+0VUWUeKSqF3LvIZpqg4zaFdDDQpkZcIQym+T1rurKcC57bf
	f9ge2eLvZzVxOvobQMYQy1HDDtBH4FBu9MIT/P0jlZbmWF5178bKDVTkqIYpvA7iVp8+n5RdIvtB9
	LAt6eITR5P0XoJ5SpIlU8brq0hC3VoEPGSRAZ3CdIlHBcC9KFKpPSChHMtM8jB4tk13VW1dg1oYZp
	k7ZjJxVOhggpVnp+LoSjN1YsUWmqpLvyOll97ILs0OHXOF6xW9nwvfHfvIDb2uuKuy6BZtsgyp/SY
	L5tl3Zjl9M48vrdJr2nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0M3-0005LA-Qw; Tue, 19 Feb 2019 08:02:15 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0Lz-0005Kd-7i
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 08:02:14 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1J822Ww118677;
 Tue, 19 Feb 2019 02:02:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550563322;
 bh=Xtb5h3if5MbpYARRSPAipUC/4gUHrFXWyOCqOWBXtZw=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=VyGB364PM6BpAjbhFk7WL8A7simT/W/b8Sz80ec3UJznrpEQz4zJ1hAxB0eBmihV1
 GgMBd4Tbm3Nb3h2GngHFKI3RTRWwH+MLh78Ycb4x/N5tyyvTOS7LbsF/8eg3bxWn5c
 OhffdqLg579oFf9NeWx6ACFZglSTRv8INSqjBzto=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1J822Am003234
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Feb 2019 02:02:02 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 02:02:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 02:02:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1J81wTt011373;
 Tue, 19 Feb 2019 02:01:59 -0600
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
To: Tony Lindgren <tony@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
 <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
 <20190218162613.GH15711@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
Date: Tue, 19 Feb 2019 10:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218162613.GH15711@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_000211_378825_0A07525E 
X-CRM114-Status: GOOD (  21.80  )
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

SGkgVG9ueSwKCk9uIDE4LzAyLzIwMTkgMTguMjYsIFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gKiBQ
ZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPiBbMTkwMjE4IDE2OjIyXToKPj4K
Pj4KPj4gT24gMTgvMDIvMjAxOSAxNi40NCwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPj4+ICogUGV0
ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4gWzE5MDIxOCAxNDozNl06Cj4+Pj4g
SGksCj4+Pj4KPj4+PiBjZDI4ZDFkNmU1MmU6ICgibmV0OiBwaHk6IGF0ODAzeDogRGlzYWJsZSBw
aHkgZGVsYXkgZm9yIFJHTUlJIG1vZGUiKSBicm9rZSB0aGUKPj4+PiBldGhlcm5ldCBuZXR3b3Jr
aW5nIG9uIGV2bXNrIChhbmQgbW9zdCBsaWtlbHkgb24gdGhlIGV2bSBhcyB3ZWxsKToKPj4+PiBo
dHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwMjg1MjcvCj4+Pj4KPj4+PiB2MSBw
YXRjaCB0byBmaXggdGhlIHNpdHVhdGlvbjoKPj4+PiBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3BhdGNoLzEwNDA2MTcvCj4+Pj4KPj4+PiBJdCB0dXJuZWQgb3V0IHRoYXQgdGhlIGF0ODAz
eCBkcml2ZXIgaXMgYWN0dWFsbHkgYnJva2VuIGFuZCBuZWVkIHRvIGJlIGZpeGVkCj4+Pj4gYWxv
bmcgd2l0aCB0aGUgRFQgZGF0YS4KPj4+Pgo+Pj4+IFRoZSBmb2xsb3dpbmcgc2VyaWVzIGlzIHBy
b3Bvc2VkIHRvIGZpeCB0aGUgZHJpdmVyOgo+Pj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC9uZXRkZXYvbGlzdC8/c2VyaWVzPTkyNjExCj4+Pj4KPj4+PiBidXQgdGhlIFBI
VCBtb2RlIG5lZWRzIHRvIGJlIHN3aXRjaGVkIHRvIHJnbWlpLWlkIGZyb20gcmdtaWktdHhpZDoK
Pj4+PiBUaGUgcnggZGVsYXkgaXMgZW5hYmxlZCBieSBkZWZhdWx0IGFuZCB0aGUgZHJpdmVyIG5l
dmVyIGRpc2FibGVkIGl0IHNvIHdoZW4KPj4+PiBhc2tpbmcgcmdtaWktdHhpZCBpdCBhY3R1YWxs
eSBnb3QgcmdtaWktaWQuCj4+Pj4KPj4+PiBUaGUgcGF0Y2ggY2FuIGJlIGJhY2twb3J0ZWQgdG8g
c3RhYmxlLCBJIGhhdmUgdGVzdGVkIHRoYXQgaXQgaXMgbm90IGNhdXNpbmcKPj4+PiByZWdyZXNz
aW9uIHdpdGggdGhlIG9sZCwgYnJva2VuIGRyaXZlci4KPj4+Cj4+PiBDYW4gdGhlIGR0cyBjaGFu
Z2VzIGJlIG1lcmdlZCBiZWZvcmUgdGhlIGRyaXZlciBjaGFuZ2VzIG9yCj4+PiBkb2VzIGl0IGNh
dXNlIHRoZSBwaHkgdG8gc3RvcCB3b3JraW5nPwo+Pgo+PiBUaGUgcGh5IGlzIG5vdCB3b3JraW5n
IGF0bSwgYnV0IHRoaXMgY2hhbmdlIHdpbGwgbm90IGNhdXNlIHJlZ3Jlc3Npb24KPj4gZXZlbiBp
ZiBpdCBpcyBtZXJnZWQgZmlyc3QuCj4gCj4gT0sgc28gc291bmRzIGxpa2UgdGhlc2UgYXJlIE9L
IHRvIHdhaXQgZm9yIHY1LjEgbWVyZ2Ugd2luZG93Cj4gdGhlbiBhcyB0aGUgZHRzIGNoYW5nZXMg
YWxvbmUgd29uJ3QgZml4IGFueXRoaW5nPwoKSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
c2VuZCB0aGVzZSB0byA1LjAgdG8gYXZvaWQgdGhlIHJlZ3Jlc3Npb24Kc2l0aW5nIGluIGxpbnV4
LW5leHQuCgpUaGUgcGF0Y2hlcyBhcmUgYWN0dWFsbHkgZG9pbmcgdG8gdGhlIGNvcnJlY3QgdGhp
bmcgKHdlIG5lZWQgcmdtaWktaWQsCm5vdCBybWdpaS10eGlkIGZvciB0aGVzZSBib2FyZHMpLgpJ
dCB3YXMganVzdCBhIG1hdHRlciBvZiBsdWNrIHRoYXQgaXQgd29ya2VkIHdpdGggcmdtaWktdHhp
ZCBhcyB0aGUKZHJpdmVyIHdhcyBicm9rZW4gYW5kIGRpZCBub3QgZGlzYWJsZWQgdGhlIHJ4aWQg
d2hlbiBpdCBzaG91bGQgaGF2ZS4KClRlc3RlZCB0aGUgcGF0Y2ggb24gdG9wIG9mIG1haW5saW5l
CihiNTM3MmZlNWRjODQyMzVkYmUwNDk5OGVmZGVkZTNjNGRhYTg2NmE5KSB3YXMgdGhlIHRvcG1v
c3QgY29tbWl0IGFmdGVyCnRoZSByYzcgdGFnLgoKLSBQw6l0ZXIKClRleGFzIEluc3RydW1lbnRz
IEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9C
dXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
