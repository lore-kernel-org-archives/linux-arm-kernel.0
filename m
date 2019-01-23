Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4DCC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F12C2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKrRI6s/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NbEBAxuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12C2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=19NmPWiJWZccSU+8L3cMtcblSYJWx+IP5ensh81SWTA=; b=oKrRI6s/Hw78MTViw5tUfIeg0
	osJfy0aSb4t87ajO+zBdKfaxn8Qkh3zsy76+hsr9wmmCuDn2Wt2L0UE+AALNyCYc5FaD53iQskr9v
	sC71OjJ7Kyoc82+g5xWye4c4GfSx3IeeWcyT27nvMoSoMh9h6yrn+6KkdyVDwnp7bMRcHSW63K1sj
	59NHA3SOL/RJ5jwXqV01FYF2WjEuunsBJCJIFS3EvtkPUeuz1rfF88kk9a+BvWZOLAiq0hly1hSFT
	WtkGDxiOKACbFY0EB510N7Ns7GrEFV6/wraMrsHf2+maQgf0KQhxR1JvPm29xUoBdFqrQcFfJ9bJf
	3c5TzlZdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLyG-00069d-A5; Wed, 23 Jan 2019 17:05:48 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLy1-00066Q-7A
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:05:36 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so1472976plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9kGPd+msbQEtf+/mpliwMm45Bffv6BgyFfK78q4Emdg=;
 b=NbEBAxuCGV8mVJp5AnFAZh3b7FGGsVP7v7iApo6vCCWbPhUeWcKfuPdF6fZiHXsgg+
 oNBhqfOcfBdakmYvaaKT5HaNqPl9DRyCw4/O9w7SXKm+tdBPdnZ/5/5R++vdh1Ps40mI
 x929V51TBBMlvN7cM48wWpdnZyf+Tby1qjSBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9kGPd+msbQEtf+/mpliwMm45Bffv6BgyFfK78q4Emdg=;
 b=lKPUmW0EF5K8RUhCUDWKDpZ9FNffOf3EblzCec9NFqa01ED+QLSY3Hvuwfpp5H68D8
 +mTNWaJeh88F16IWqEY8eJIObR1XVQO4LnL2aMOww78X7tTb93DTWto7n8d0cR6s/Ixd
 Qlfff28gckDBXhwFFWSE1uU3f6A9mTVx8juYoFdEh/uJPt1suGjhJAeobF/kI7DZ9U79
 uB9Ng+ebq4GJnVDSrOGfWxZMk9QY31dM/YqG1RG34R5Fj7v5lJTY2BLktnvJ3BCPkP85
 0y6ZfQoSN/tcXc0AFFw7CTt0h4NrxgMFrDecAOzreRrmc0f+lehYwwhJQANPf0NsJlE/
 9j6A==
X-Gm-Message-State: AJcUukfABKZ7wPaqtMZ45X8rkQQUP46GI7JytxO4LCnkcChxrG8Nbj1T
 5erK2+wIs1TYx/+wA63zP8xrFA==
X-Google-Smtp-Source: ALg8bN4BqkhisjHyc0ae/HfXZswtniSh6TUO1LrfpnNWSPDIp4eLPsB3yFih3ZsKRS0bjzLrQQa26A==
X-Received: by 2002:a17:902:ab84:: with SMTP id
 f4mr2891888plr.207.1548263132502; 
 Wed, 23 Jan 2019 09:05:32 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id c9sm40089382pfc.92.2019.01.23.09.05.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 09:05:31 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To: Mark Rutland <mark.rutland@arm.com>,
 Pramod Kumar <pramod.kumar@broadcom.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
Date: Wed, 23 Jan 2019 09:05:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123164801.GA55887@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_090533_426593_95E9A4EE 
X-CRM114-Status: GOOD (  19.90  )
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
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFyaywKCkhvcGVmdWxseSBJIGNhbiBzaGVkIHNvbWUgbGlnaHQgb24gdGhlIHVzZSBjYXNl
IGlubGluZS4KCk9uIDIwMTktMDEtMjMgODo0OCBhLm0uLCBNYXJrIFJ1dGxhbmQgd3JvdGU6Cj4g
T24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMTE6MzA6MDJBTSArMDUzMCwgUHJhbW9kIEt1bWFyIHdy
b3RlOgo+PiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCAxMToyOCBBTSBQcmFtb2QgS3VtYXIgPHBy
YW1vZC5rdW1hckBicm9hZGNvbS5jb20+Cj4+IHdyb3RlOgo+Pgo+PiAgICAgIE5lZWQgY29tZXMg
ZnJvbSBhIHNwZWNpZmljIHVzZSBjYXNlIHdoZXJlIG9uZSBBY2NlbGVyYXRvciBjYXJkKFNvQykg
aXMKPj4gICAgICBwbHVnZ2VkIGluIGEgc2V2ZXIgb3ZlciBhIFBDSWUgaW50ZXJmYWNlLiAgVGhp
cyBDYXJkIGdldHMgc3VwcGx5IGZyb20gYQo+PiAgICAgIGJhdHRlcnksIHdoaWNoIGNvdWxkIHBy
b3ZpZGUgdmVyeSBsZXNzIHBvd2VyIGZvciBhIHZlcnkgc21hbGwgdGltZSwgaW4gY2FzZQo+PiAg
ICAgIG9mIGFueSBwb3dlciBsb3NzLiBPbmNlIENhcmQgc3dpdGNoZXMgdG8gYmF0dGVyeSwgdGhp
cyBoYXMgdG8gcmVkdWNlIGl0cwo+PiAgICAgIHBvd2VyIGNvbnN1bXB0aW9uIHRvIGl0cyBsb3dl
c3QgcG9pbnQgYW5kIGJhY2stdXAgdGhlIEREUiBjb250ZW50cyBhc2FwCj4+ICAgICAgYmVmb3Jl
IGJhdHRlcnkgZ2V0cyBmdWxseSBkcmFpbmVkIG9mZi4KPiBJbiB0aGlzIGV4YW1wbGUgaXMgTGlu
dXggcnVubmluZyBvbiB0aGUgc2VydmVyLCBvciBvbiB0aGUgYWNjZWxlcmF0b3I/CkFjY2VsZXJh
dG9yCj4KPiBXaGF0IHByZWNpc2VseSBhcmUgeW91IHRyeWluZyB0byBiYWNrIHVwIGZyb20gRERS
LCBhbmQgd2h5PwpEYXRhIGluIEREUiBpcyBiZWluZyB3cml0dGVuIHRvIGRpc2sgYXQgdGhpcyB0
aW1lIChkaXNrIGlzIGNvbm5lY3RlZCB0byAKYWNjZWxlcmF0b3IpCj4KPiBXaGF0IGlzIHJlc3Bv
bnNpYmxlIGZvciBiYWNraW5nIHVwIHRoYXQgY29udGVudHM/CgpBIGxvdyBwb3dlciBNLWNsYXNz
IHByb2Nlc3NvciBhbmQgRE1BIGVuZ2luZSB3aGljaCBjb250aW51ZXMgbmVjZXNzYXJ5IApvcGVy
YXRpb25zIHRvIHRyYW5zZmVyIEREUiBtZW1vcnkgdG8gZGlzay4KClRoZSBoaWdoIHBvd2VyIHBy
b2Nlc3NvcnMgb24gdGhlIGFjY2VsZXJhdG9yIHJ1bm5pbmcgbGludXggbmVlZGVkIHRvIGJlIApo
YWx0ZWQgQVNBUCBvbiB0aGlzIHBvd2VyIGxvc3MgZXZlbnQgYW5kIE0wIHRha2Ugb3Zlci4gR3Jh
Y2VmdWwgc2h1dGRvd24gCm9mIGxpbnV4IGFuZCBvdGhlciBwZXJpcGhlcmFscyBpcyB1bm5lY2Vz
c2FyeSAoYW5kIHdlIGRvbid0IGhhdmUgdGhlIApwb3dlciBuZWNlc3NhcnkgdG8gZG8gc28pLgoK
Pgo+PiAgICAgIFNpbmNlIGJhdHRlcnkgY2FuIHByb3ZpZGUgbGltaXRlZCBwb3dlciBmb3IgYSB2
ZXJ5IHNob3J0IHRpbWUgaGVuY2UgbmVlZCB0bwo+PiAgICAgIHRyYW5zaXRpb24gdG8gbG93ZXN0
IHBvd2VyLiBBcyBwZXIgdGhlIHRyYW5zaXRpb24gcHJvY2VzcyAsIENQVXMgcG93ZXIKPj4gICAg
ICBkb21haW4gaGFzIHRvIGJlIG9mZiBidXQgYmVmb3JlIHRoYXQgaXQgbmVlZHMgdG8gZmx1c2gg
b3V0IGl0cyBjb250ZW50IHRvCj4+ICAgICAgc3lzdGVtIG1lbW9yeShMMykgc28gdGhhdCBjb250
ZW50IGNvdWxkIGJlIGJhY2tlZC11cCBieSBhIE1DVSwgYSBjb250cm9sbGVyCj4+ICAgICAgY29u
c3VtaW5nIHZlcnkgbGVzcyBwb3dlci4gU2luY2Ugd2UgY2FuIG5vdCBhZmZvcmQgcGx1Z2dpbmct
b3V0IGV2ZXJ5Cj4+ICAgICAgaW5kaXZpZHVhbCBDUFVzIGluIHNlcXVlbmNlIGhlbmNlIHVzZXMg
IGlwaV9jcHVfc3RvcCBmb3IgYWxsIG90aGVyIENQVXMKPj4gICAgICB3aGljaCB1bHRpbWF0ZWx5
IHN3aXRjaCB0byBBVEYgdG8gZmx1c2ggb3V0IGFsbCB0aGUgQ1BVcyBjYWNoZXMgYW5kIGNvbWVz
Cj4+ICAgICAgb3V0IG9mIGNvaGVyZW5jeSBkb21haW4gc28gdGhhdCBpdHMgcG93ZXIgcmFpbHMg
Y291bGQgYmUgc3dpdGNoZWQtb2ZmLgo+IElmIHlvdSdyZSBzdG9wcGluZyBDUFVzIGZyb20gY29t
cGxldGVseSBhcmJpdHJhcnkgc3RhdGVzLCB3aGF0IGlzIHRoZQo+IGJlbmVmaXQgb2Ygc2F2aW5n
IHRoZSBSQU0gY29udGVudHM/CgpTb21lIG9mIHRoZSBSQU0gY29udGFpbnMgZGF0YSB0aGF0IHdh
cyBpbiB0aGUgcHJvY2VzcyBvZiBiZWluZyB3cml0dGVuIAp0byBkaXNrIGJ5IHRoZSBhY2NlbGVy
YXRvci4KClRoaXMgZGF0YSBtdXN0IGJlIHNhdmVkIHRvIGRpc2sgYW5kIHRoZSBoaWdoIHBvd2Vy
IENQVXMgY29uc3VtZSB0b28gbXVjaCAKcG93ZXIgdG8gY29udGludWUgcGVyZm9ybWluZyB0aGlz
IG9wZXJhdGlvbi4KCj4KPiBDUFVzIG1pZ2h0IGJlIHJ1bm5pbmcgd2l0aCBJUlFzIGRpc2FibGVk
IGZvciBhbiBhcmJpdHJhcmlseSBsb25nIHRpbWUsCgpJbiBhbiBlbWJlZGRlZCBsaW51eCBzeXN0
ZW0gd2UgY29udHJvbCBldmVyeXRoaW5nIHJ1bm5pbmcuCgpCdXQgZ29vZCBwb2ludCAtIHdlJ2xs
IG5lZWQgdG8gZW5zdXJlIGludGVycnVwdHMgYXJlIG5vdCBkaXNhYmxlZCBmb3IgCnRvbyBsb25n
LgoKPiBzbyB0aGVyZSdzIG5vIGd1YXJhbnRlZSB0aGF0IGFsbCBvZiB0aGVtIHdpbGwgYmUgdHVy
bmVkIG9mZiBiZWZvcmUgcG93ZXIKPiBpcyBsb3N0Lgo+Cj4gSSdtIHZlcnkgY29uZnVzZWQgYXMg
dG8gd2hhdCB5b3UncmUgdHJ5aW5nIHRvIGFjaGlldmUgaGVyZS4KPgo+IFRoYW5rcywKPiBNYXJr
LgoKUmVnYXJkcywKCiDCoFNjb3R0CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
