Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD9FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:32:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177DB217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gIMd72PK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177DB217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ck7CCnAhsPJD8kTYxTBRWlUfLZEVqnIGru49ZKmbQ2g=; b=gIMd72PK9fdUdr
	saAZCtklv0VftnMTToX+EJUN3Ahd0FObPJTai5M7wj7P3AmLtAbCwHE1N4Wy34osQlOBxql9pUSan
	EvIcEGgsizVLuZ+10TwhXswXIp96yTlVGzK84XgbJRRp5QN0BvbxAacqu93qbBdZzM1/VHUVqWH7a
	JVZvjli3OguKRm6CWjEyCNo+AI6VP8rUY9YFUCTc23JFwiIdEiKMr8OOcg3VtN4qx/BdPukardfh5
	kT91AvCSfubwQG1K+FPc1k0KDCTPPgDTx2qpIAAGimE1aelvJyTUdSwW7MV2IZ71wdGVHFtKvr/jZ
	RU+ulA4XEHzSqeuOzilA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybtr-0001Bb-Rj; Tue, 26 Feb 2019 12:31:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybto-0001Aq-6a
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:31:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02DC580D;
 Tue, 26 Feb 2019 04:31:50 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356193F703;
 Tue, 26 Feb 2019 04:31:48 -0800 (PST)
Date: Tue, 26 Feb 2019 12:31:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 05/26] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
Message-ID: <20190226123145.GB17422@lakrids.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-6-git-send-email-Dave.Martin@arm.com>
 <20190220152349.GE4763@lakrids.cambridge.arm.com>
 <20190226120616.GG3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226120616.GG3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_043152_239600_FA214424 
X-CRM114-Status: GOOD (  21.30  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMjYsIDIwMTkgYXQgMTI6MDY6MTZQTSArMDAwMCwgRGF2ZSBNYXJ0aW4gd3Jv
dGU6Cj4gT24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgMDM6MjM6NTBQTSArMDAwMCwgTWFyayBSdXRs
YW5kIHdyb3RlOgo+ID4gT24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMDc6NTI6MThQTSArMDAwMCwg
RGF2ZSBNYXJ0aW4gd3JvdGU6Cj4gPiA+IGt2bV9ob3N0LmggdXNlcyBERUNMQVJFX0JJVE1BUCgp
IHRvIGRlY2xhcmUgdGhlIGZlYXR1cmVzIG1lbWJlciBvZgo+ID4gPiBzdHJ1Y3QgdmNwdV9hcmNo
LCBidXQgdGhlIGNvcnJlc3BvbmRpbmcgI2luY2x1ZGUgZm9yIHRoaXMgaXMKPiA+ID4gbWlzc2lu
Zy4KPiA+ID4gCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIHN1aXRhYmxlICNpbmNsdWRlIGZvciA8
bGludXgvYml0bWFwLmg+LiAgQWx0aG91Z2gKPiA+ID4gdGhlIGhlYWRlciBidWlsZHMgd2l0aG91
dCBpdCB0b2RheSwgdGhpcyBzaG91bGQgaGVscCB0byBhdm9pZAo+ID4gPiBmdXR1cmUgc3VycHJp
c2VzLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogRGF2ZSBNYXJ0aW4gPERhdmUuTWFydGlu
QGFybS5jb20+Cj4gPiA+IFJldmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+Cj4gPiA+IC0tLQo+ID4gPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9z
dC5oIHwgMSArCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiA+ID4gCj4g
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKPiA+ID4gaW5kZXggNzczMmQwYi4uODQwNTZh
NCAxMDA2NDQKPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4g
PiA+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+ID4gPiBAQCAtMjIs
NiArMjIsNyBAQAo+ID4gPiAgI2lmbmRlZiBfX0FSTTY0X0tWTV9IT1NUX0hfXwo+ID4gPiAgI2Rl
ZmluZSBfX0FSTTY0X0tWTV9IT1NUX0hfXwo+ID4gPiAgCj4gPiA+ICsjaW5jbHVkZSA8bGludXgv
Yml0bWFwLmg+Cj4gPiA+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KPiA+ID4gICNpbmNsdWRl
IDxsaW51eC9rdm1fdHlwZXMuaD4KPiA+ID4gICNpbmNsdWRlIDxhc20vY3B1ZmVhdHVyZS5oPgo+
ID4gCj4gPiBGcm9tIGEgcXVpY2sgc2NhbiBvZiB0aGUgZmlsZSwgd2UncmUgYWxzbyBtaXNzaW5n
Ogo+ID4gCj4gPiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4KPiAKPiBbLi4uXQo+IAo+ID4gI2lu
Y2x1ZGUgPGxpbnV4L2p1bXBfbGFiZWwuaD4KPiA+ICNpbmNsdWRlIDxsaW51eC9wZXJjcHUuaD4K
PiAKPiBEb25lIGZvciB0aG9zZSB0aHJlZS4KCkdyZWF0LgoKPiA+ICNpbmNsdWRlIDxsaW51eC90
aHJlYWRfaW5mby5oPgo+IAo+IFNpbmNlIGNvbW1pdCBlNmI2NzNiNzQxZWEgKCJLVk06IGFybTY0
OiBPcHRpbWlzZSBGUFNJTUQgaGFuZGxpbmcgdG8KPiByZWR1Y2UgZ3Vlc3QvaG9zdCB0aHJhc2hp
bmciLCB3ZSBkbyBoYXZlIDxhc20vdGhyZWFkX2luZm8uaD4uCj4gCj4gU2luY2UgdGhpcyBoZWFk
ZXIgaXMgbm90IGdlbmVyaWMsIHRoaXMgc2VlbXMgcmVhc29uYWJsZS4gIElzIHRoZXJlCj4gc29t
ZXRoaW5nIGZyb20gPGxpbnV4L3RocmVhZF9pbmZvLmg+IHVzZWQgaGVyZSB0aGF0IEknbSBtaXNz
aW5nPwoKSSB0aGluayBJIGp1c3QgY29uZnVzZWQgbXlzZWxmOyA8YXNtL3RocmVhZF9pbmZvLmg+
IHNlZW1zIHN1ZmZpY2llbnQuCgpUaGFua3MsCk1hcmsuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
