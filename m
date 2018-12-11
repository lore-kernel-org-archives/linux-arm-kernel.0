Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C092FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:16:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFD720849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nrJA05No"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFD720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rAa86uqE5KgEMTAPm+yWHiSJBtQl6iIl/USXk61KMb8=; b=nrJA05No0QtScB
	uKyyGJi/4rqzT+LaNksIDI+o8xDtVvnGOHL5HdmfKO73jT9bAcYseKi/HeJy0+WByk1z0+Bx+MXiy
	SSfT3FMk5Synp8eGuKUacwFoed8ATtv1AAFCjAVEZ0RsGIjNK3XDJVpdLjiJ4Cx/YvNoA6DtHjG8U
	qvKYsQO4uMGBw4XRV77ZcCeK4C9G6yX8kDgtW0SLQloDi/3rGlakKKhxy8QGQ2DVMuRRr7cSBTjDD
	hRb4ZbwYpfAmc5ycCGHk4HGVFCOgyXDEvKuVpM954/1KP1iOZk34Pfu3j4VkUXojojE/j/i3FiX6X
	qrlYpau2uLywR+ryJuzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWipH-0007X4-NI; Tue, 11 Dec 2018 14:15:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWipE-0007Vj-LE
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:15:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC64A15AB;
 Tue, 11 Dec 2018 06:15:41 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC113F59C;
 Tue, 11 Dec 2018 06:15:39 -0800 (PST)
Subject: Re: [PATCH v2 24/28] arm: Add support for generic vDSO
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-25-vincenzo.frascino@arm.com>
 <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <496b17ae-c6b1-92f4-201b-8420005ad6c6@arm.com>
Date: Tue, 11 Dec 2018 14:15:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_061552_703974_D3928EC0 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFyYywKCnRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRlc3RpbmcgdGhpcyBzZXQuIEkgcmVh
bGx5IGFwcHJlY2lhdGUgaXQuCgpPbiAxMC8xMi8yMDE4IDIyOjEzLCBNYXJrIFNhbHl6eW4gd3Jv
dGU6Cj4gT24gMTEvMjkvMjAxOCAwOTowNSBBTSwgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6Cj4+
IFRoZSBhcm0gdkRTTyBsaWJyYXJ5IHJlcXVpcmVzIHNvbWUgYWRhcHRhdGlvbnMgdG8gdXNlIHRv
IHRha2UgYWR2YW50YWdlCj4+IG9mIHRoZSBuZXdseSBpbnRyb2R1Y2VkIGdlbmVyaWMgdkRTTyBs
aWJyYXJ5Lgo+IFRlc3RlZC1ieT8gV291bGQgbGlrZSB0byBub3RlIHRoYXQgdGhpcyBwYXRjaCBz
ZXJpZXMgdXAgdG8gMjQvMjggd2FzIAo+IGJhY2stcG9ydGVkIHRvIGFuZHJvaWQtNC45IGFuZCB3
b3JrZWQgc3VjY2Vzc2Z1bGx5IG9uIGEgSGlrZXkgYXJtNjQgZGV2aWNlLgo+IAoKSSB3aWxsIGFk
ZCB5b3UgYXMgVGVzdGVkLWJ5IGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoZXMuIEkg
YW0gZ29pbmcgdG8KcmUtaXNzdWUgYSB2MyBiYXNlZCBvbiB0aGUgY29tbWVudHMgdGhhdCBBcm5k
IGFuZCBUaG9tYXMgcHJvdmlkZWQuIFdvdWxkIHlvdSBiZQppbnRlcmVzdGVkIGluIHRlc3Rpbmcg
aXQgYXMgd2VsbD8gSWYgc28gSSBjYW4gaW50ZWdyYXRlIHRoZSBzdXBwb3J0IGZvciBjbGFuZwpi
YXNlZCBvbiB3aGF0IHlvdXIgYXJlIHN1Z2dlc3RpbmcgYmVsb3cgdG8gbWFrZSBpdCBtb3JlIHN0
cmFpZ2h0IGZvcndhcmQgZm9yCnlvdS4gTGV0IG1lIGtub3cuCgo+IE9ubHkgc2lnbmlmaWNhbnQg
Y2hhbmdlIHdhcyB0byBhZGQgYmFjayBzdXBwb3J0IGZvciBjbGFuZyBpbiAKPiBhcmNoL2FybTY0
L01ha2VmaWxlIChwc2V1ZG8gcGF0Y2gpOgo+IAo+ICDCoGlmZXEgKCQoQ09ORklHX0dFTkVSSUNf
Q09NUEFUX1ZEU08pLCB5KQo+ICDCoMKgIENST1NTX0NPTVBJTEVfQVJNMzIgPz0gJChDT05GSUdf
Q1JPU1NfQ09NUElMRV9DT01QQVRfVkRTTzoiJSI9JSkKPiAKPiAgwqDCoCBpZmVxICgkKENST1NT
X0NPTVBJTEVfQVJNMzIpLCkKPiAgwqDCoCDCoCAkKGVycm9yIENST1NTX0NPTVBJTEVfQVJNMzIg
bm90IGRlZmluZWQgb3IgZW1wdHksIHRoZSBjb21wYXQgdkRTTyAKPiB3aWxsIG5vdCBiZSBidWls
dCkKPiArwqDCoCBlbHNlIGlmZXEgKCQoY2MtbmFtZSksY2xhbmcpCj4gK8KgwqAgwqAgZXhwb3J0
IENMQU5HX1RSSVBMRV9BUk0zMiA/PSAkKENST1NTX0NPTVBJTEVfQVJNMzIpCj4gK8KgwqDCoMKg
IGV4cG9ydCBDTEFOR19UQVJHRVRfQVJNMzIgOj0gLS10YXJnZXQ9JChub3RkaXIgCj4gJChDTEFO
R19UUklQTEVfQVJNMzI6JS09JSkpCj4gK8KgwqDCoMKgIGV4cG9ydCBDT05GSUdfQ09NUEFUX1ZE
U08gOj0geQo+ICvCoMKgwqDCoCBjb21wYXRfdmRzbyA6PSAtRENPTkZJR19DT01QQVRfVkRTTz0x
Cj4gLSsgwqAgZWxzZSBpZmVxICgkKHNoZWxsIHdoaWNoICQoQ1JPU1NfQ09NUElMRV9BUk0zMikk
KGNjLW5hbWUpIDI+IAo+IC9kZXYvbnVsbCksKQo+IC0rIMKgIMKgICQoZXJyb3IgJChDUk9TU19D
T01QSUxFX0FSTTMyKSQoY2MtbmFtZSkgbm90IGZvdW5kLCBjaGVjayAKPiBDUk9TU19DT01QSUxF
X0FSTTMyKQo+ICDCoMKgIGVsc2UKPiAgwqDCoCDCoCBleHBvcnQgQ1JPU1NfQ09NUElMRV9BUk0z
Mgo+ICDCoMKgwqDCoCBleHBvcnQgQ09ORklHX0NPTVBBVF9WRFNPIDo9IHkKPiAgwqDCoMKgwqAg
Y29tcGF0X3Zkc28gOj0gLURDT05GSUdfQ09NUEFUX1ZEU089MQo+ICDCoMKgIGVuZGlmCj4gIMKg
ZW5kaWYKPiAKPiAtLSBNYXJrCj4gCgotLSAKUmVnYXJkcywKVmluY2Vuem8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
