Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21013C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:44:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EEE20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KSwnkJfx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tsgrNi21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EEE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ff3vEVx/jKSl8ewtmNBK4P92TKtaCSPBgrNtQDZVdmU=; b=KSwnkJfxwC5nS4
	GVyG8SpJ4rWTf/Xw+1elfJn8XdQYfQe8gjinGt1a5/MxEcJPqMwmAcw5FViLIThvQJOba8kUdq9JT
	Iw3/LnJSDQjlfobtFhkpuIYosWtoZCIntbZMTeAmt9D9AyPIx2xBlOaE4NLw6xzi4B77m0fzwj+aB
	Jvx6jMosqjh4qA8BroatYHbuvkxJyUldSr3lzKUblIuc+z0/lSfjS0jV8FeUW6el2jDxdcdnnTh2H
	N+gM3JVn0YwxdUfDMDGJGL2DqjSEFIaiKkj7VxZbakWHYbSrv8rgHPJP3n2xabhB3dYbw1FpGmJpl
	b41In+1Wx/BPSX90SgGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX20R-0005ZW-Ki; Wed, 12 Dec 2018 10:44:43 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX20N-0005YX-En
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:44:41 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCAiOas092605;
 Wed, 12 Dec 2018 04:44:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544611464;
 bh=29+ey1wP6Gczj2n17144V2b4PvDztLDKpNT/a84XmDw=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=tsgrNi21dl2dLGPp5aokRen4ua/deiG7yT0UQkxTIhfVQMHrF4FjV7K1y+80niLeE
 6NfCk3ue0SFg+JeLh7tKKpragJypJNtVEgDQ0pc+1G+rPiWox1b+JZCeQyEqF/5I00
 B4YrgAFvLGTcmBTMVECXgvBvMo9Hj+ILLzSokCTU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCAiOTS006444
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Dec 2018 04:44:24 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 04:44:24 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 04:44:24 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCAiLFE002383;
 Wed, 12 Dec 2018 04:44:21 -0600
Subject: Re: [PATCH] ARM: dts: omap5: Add l4 interconnect hierarchy and
 ti-sysc data
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
References: <20181115224546.61475-1-tony@atomide.com>
 <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
Message-ID: <ebc7e271-8717-fe9d-d24f-ae406860b913@ti.com>
Date: Wed, 12 Dec 2018 12:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_024439_598720_F6FC8FEF 
X-CRM114-Status: GOOD (  15.22  )
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
 Dave Gerlach <d-gerlach@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi8xMi8yMDE4IDEyLjEyLCBQZXRlciBVamZhbHVzaSB3cm90ZToKPiBUb255LAo+IAo+
IE9uIDE2LzExLzIwMTggMC40NSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPj4gU2ltaWxhciB0byBj
b21taXQgOGY0MmNiN2Y2NGM3ICgiQVJNOiBkdHM6IG9tYXA0OiBBZGQgbDQgaW50ZXJjb25uZWN0
Cj4+IGhpZXJhcmNoeSBhbmQgdGktc3lzYyBkYXRhIiksIGxldCdzIGFkZCBwcm9wZXIgaW50ZXJj
b25uZWN0IGhpZXJhcmNoeQo+PiBmb3IgbDQgaW50ZXJjb25uZWN0IGluc3RhbmNlcyB3aXRoIHRo
ZSByZWxhdGVkIHRpLXN5c2MgaW50ZXJjb25uZWN0Cj4+IG1vZHVsZSBkYXRhIGFzIGluIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9idXMvdGktc3lzYy50eHQuCj4+Cj4+IFVzaW5n
IHRpLXN5c2MgZHJpdmVyIGJpbmRpbmcgYWxsb3dzIHVzIHRvIHN0YXJ0IGRyb3BwaW5nIGxlZ2Fj
eSBwbGF0Zm9ybQo+PiBkYXRhIGluIGFyY2gvYXJtL21hY2gtb21hcDIvb21hcCpod21vZCpkYXRh
LmMgZmlsZXMgbGF0ZXIgb24gaW4gZmF2b3Igb2YKPj4gdGktc3lzYyBkdHMgZGF0YS4KPj4KPj4g
VGhpcyBkYXRhIGlzIGdlbmVyYXRlZCBiYXNlZCBvbiBwbGF0Zm9ybSBkYXRhIGZyb20gYSBib290
ZWQgc3lzdGVtCj4+IGFuZCB0aGUgaW50ZXJjb25uZWN0IGFjY2VzIHByb3RlY3Rpb24gcmVnaXN0
ZXJzIGZvciByYW5nZXMuIFRvIGF2b2lkCj4+IHJlZ3Jlc3Npb25zLCB3ZSBpbml0aWFsbHkgdmFs
aWRhdGUgdGhlIGRldmljZSB0cmVlIHByb3ZpZGVkIGRhdGEKPj4gYWdhaW5zdCB0aGUgZXhpc3Rp
bmcgcGxhdGZvcm0gZGF0YSBvbiBib290Lgo+IAo+IFJldmVydGluZyB0aGlzIHBhdGNoIGluIGxp
bnV4LW5leHQtMjAxODEyMTAgd2lsbCBtYWtlIHRoZSBldGhlcm5ldAo+IHdvcmtpbmcgYWdhaW4u
Cj4gCj4gYm9vdGxvZyB3LyByZXZlcnQ6IGh0dHBzOi8vcGFzdGViaW4uY29tL2RwUmsxeFd2Cj4g
Ym9vdGxvZyB3L28gcmV2ZXJ0OiBodHRwczovL3Bhc3RlYmluLmNvbS9QV3JCdHR4ZAoKb24gb21h
cDUtdWV2bS4KCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2Fs
YW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEt
NC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
