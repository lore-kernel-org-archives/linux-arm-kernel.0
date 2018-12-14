Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E99C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:06:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92BD2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IYJbnqur";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TYjmriTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92BD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=667BEEh2f2vNaKY8UEgdfY9xv7PRZwBqQwH8bu07++k=; b=IYJbnqur9QzlHA
	cwNCF1WJgplH22D8nZ1GbYEhsZa1u50uBZJVwYt8+ZSmrWw7W26ImzBpY0o9/9739YbMUH344N829
	pO2Z8gOtSArX64HKiWpegLy7mNweo8hWgTM1o6p2sUzaHw8kzSk5KMqh6jsMSFrNEsyVgg7CkCC16
	d+3VgyymWm08SZtizEKylskLbadw5D12c63CIwb8xtrgfa2Irp/FMB/rQ0VF+a8rBRvLLBjQtzNLy
	DbO9vuReZKcAvClMt+2lwfciaFfjHcr8hyYYHtsOvm1LJUqkhtDhwHEY3XwUg5nPQ6onotv+IHmJ9
	K08JodDMtUUxUCQ+L56g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnB1-0007UM-06; Fri, 14 Dec 2018 13:06:47 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnAx-0007Jr-BY
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:06:45 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBED6SJa007141;
 Fri, 14 Dec 2018 07:06:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544792788;
 bh=XuIH1sH8FluHPmAo4eIYhu4RFU14GShPutzmzcqpQxA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=TYjmriTvEiQ3cAGm8DYiHNr0hvTWQ5Kq/sBtp9iOlIRJt94P7pJ+wd6p/ig/V8nAr
 np+r7erIU70q8/sTwC1zGbEVTSmbHd2jutXlFGaDXhugPwoIig/cBiPVv+rG4Svhwj
 vugjXSkELPU2x8GMPvwlFRfbcN/PO655VMUnhZIM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBED6SWc086797
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 07:06:28 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 07:06:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 07:06:28 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBED6Qiq011685;
 Fri, 14 Dec 2018 07:06:26 -0600
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if booted
 with latest u-boot
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
 <20181213155054.GK9507@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f4961633-a151-145f-4337-dedbcafa64bd@ti.com>
Date: Fri, 14 Dec 2018 15:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213155054.GK9507@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_050643_487307_59F7D498 
X-CRM114-Status: GOOD (  21.23  )
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
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMy8xMi8yMDE4IDE3LjUwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggd3JvdGU6Cj4g
T24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMDM6NTg6NDVQTSArMDIwMCwgUGV0ZXIgVWpmYWx1c2kg
d3JvdGU6Cj4+IFRoZSBldGhlcm5ldCB3b3JrcyBpbiBrZXJuZWwgb25seSBpZiB3ZSB1c2Ugc29t
ZSBiaW5hcnkgdS1ib290IGZyb20gdGhlCj4+IHBhc3Qgd2hpY2ggaGF2ZSBzdXBwb3J0IGZvciBL
Uzg4NTEuCj4+Cj4+IFRoZSB1LWJvb3Qgc291cmNlcyBhcmUgbm90IGF2YWlsYWJsZSBmb3IgdGhp
cyBteXN0ZXJpb3VzIHUtYm9vdCBpbWFnZQo+PiBwZW9wbGUgdGVuZHMgdG8gaG9sZCBvbi4uLiBN
YWlubGluZSB1LWJvdHQgZG9lcyBub3QgaGF2ZSBldGhlcm5ldCBzdXBwb3J0Cj4+IGZvciBzZHA0
NDMwIGFuZCBpZiB3ZSB1c2UgdGhhdCB0aGUgZXRoZXJuZXQgaXMgbm90IHdvcmtpbmcuCj4+Cj4+
IEFmdGVyIHNvbWUgZGVidWdnaW5nIEkgaGF2ZSBtYW5hZ2VkIHRvIGdldCB0aGUgZXRoZXJuZXQg
d29ya2luZyB3aXRoCj4+IG1haW5saW5lIHUtYm9vdCB3aGlsZSBub3QgYnJlYWtpbmcgdGhlIG5l
dHdvcmtpbmcgd2l0aCB0aGUgY2FzZSB3aGVuIHdlCj4+IGJvb3Qgd2l0aCB0aGUgbXlzdGVyaW91
cyBiaW5hcnkgdS1ib290Lgo+Pgo+PiBCYXNpY2FsbHkgd2Ugd2VyZSBtaXNzaW5nIGJ1bmNoIG9m
IHBpbm11eCBzZXR0aW5ncyBhbmQgdGhlICdtYWdpYycKPj4gZ3Bpb18xMzggaGFuZGxpbmcgaW4g
a2VybmVsLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1
c2lAdGkuY29tPgo+IAo+IEhpIFBldGVyLAo+IAo+IERpZ2dpbmcgdXAgd2hlcmUgbXkgdS1ib290
IGNhbWUgZnJvbSwgSSBmb3VuZDoKPiAKPiAgIGh0dHBzOi8vcGx1cy5nb29nbGUuY29tLzEwMzg5
NTczMDgwNjg0ODcxNTg3MC9wb3N0cy9jQ3EyQ3hEb2dXOQo+IAo+IFVuZm9ydHVuYXRlbHksIGdp
dG9yaW91cyBubyBsb25nZXIgZXhpc3RzLCBidXQgSSBkbyBzdGlsbCBoYXZlIGEgY2xvbmUKPiBv
ZiB0aGF0IHRyZWUgbG9jYWxseSwgY29udGFpbmluZzoKPiAKPiA5ZjM4NDMwODMxOWUgT01BUDRT
RFA6IEFkZCBNaWNyZWwgS1M4ODUxIG5ldCBjaGlwIHN1cHBvcnQKPiBhZTYzMWIwOTVhODcgTkVU
OiBBZGQgZHJpdmVyIGZvciBNaWNyZWwgS1M4ODUxCj4gNzhlNDNmMmE4OTg3IEFSTVY3OiBPTUFQ
OiBBZGQgc3BpIGRyaXZlciBmb3IgT01BUDMvT01BUDQKPiBlNTc2YzZhOWNiYzkgb21hcDRfY29t
bW9uOiBjb25maWc6IHJlbW92ZSBJMkMgZm9yIFNQTCBtb2RlCj4gMTlkNTkzNGM0YjNiIEFSTTog
T01BUDQ6IE1vdmUgVEVYVF9CQVNFIGRvd24gdG8gbm9uLUhTIGxpbWl0Cj4gCj4gcGx1cyBzb21l
IG9mIG15IG93biBtb2RpZmljYXRpb25zIHRvIGZpeCB0aGUgcHJvYmxlbXMgc3RhdGVkIGluIHRo
YXQKPiBwb3N0LgoKSSBjZXJ0YWlubHkgaGF2ZSB0aGUgdmVyc2lvbiBvZiB1LWJvb3Qgd2hpY2gg
Y2FuIGRvIG9ubHkgb25lIHRmdHAgbG9hZAoob3IgZGhjcCByZXF1ZXN0KS4KCi0gUMOpdGVyCgpU
ZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxz
aW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2ls
ZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
