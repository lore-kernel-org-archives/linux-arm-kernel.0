Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012FCC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:33:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F6020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WDzyoLqc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iSIkk6fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F6020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kSULQvIG4HBQw5T5+OGMS5fotUjlOzeIy5BzF/0VL64=; b=WDzyoLqcUC246j9WckM3a9e52
	oVeHGrRg00GlutakTgTyaT7C22MGFrNl5qrtOdJCR4fISjSxhzAExwgd81Xbq6iDHsK0/lfn2DVv9
	E05qeidfWwzcn2B6mPcxagrBks1Aew0SYg4T8E/vhGXjbT80YnMh2NBqItnF4oQFIuSs1qw7ST2PR
	HBTDXWemhX3xxfshpl6wP+1ILgnMtzZQD+gIl/33PJR0rhOVNtd51JbjKsp6TR3kxAMWGC29KJTlK
	7b9gxsiMaGV7DlOjZmOBAyOkaaSRAbkIF/JlKe34hNeW7rdS8ybTVhhXhEa1gVvACMVfnHOVdBfNt
	KAQhKiHOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMP0-00081N-Iz; Wed, 23 Jan 2019 17:33:26 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMOx-000810-Ea
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:33:24 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so1511598pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zLIen4CLcRcogVhE3JINq7XN+F9HlS+WGyrbfoPE9+8=;
 b=iSIkk6fls4FMiftKlByrSNryiR/oeWS/3YgsZlbrofxT0rKmp+R2We3gOC7YoM3Cz1
 D8FNVja6u3MDB8z0Np7MW8pb5u4Ointbx7h+rrwo5cFNZ0Lkz9cZHDTs5qa2gN+kOLLT
 CCwmBDmY/IA54Vu178gftZvtlBigjbqOgQMA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zLIen4CLcRcogVhE3JINq7XN+F9HlS+WGyrbfoPE9+8=;
 b=Ga/ncAxV6u4j8P9sD1mIfTNr/eQPUDnoBIOY0IYDTfrI8hmXXCb1xtKlEhGrvp5lJN
 anDFLS7BE1NdpjB8vVFIRXUap6ALDIUt5GE1QCRdrGWo2POyojEGpcroHujkSuWPPtCS
 /VjMMz9gsewwlGcNdlyW5G7k4uZ5ta1D4QYpYomSBRpzNgmcsggxYBDSlTSp0T4R7Ti2
 dg468I4a/ZnU+ndMqBPk810rl0CB5RbPywiyHVNSsZYzlLZ7JrjhtgXOQcaJwLJctqHY
 gMBA/0yQp5RajGU7f8QCcpq1ngN5ghJFyw83HvRetrQ//IBsiDlyIUFECjo18Uay/H92
 EP/w==
X-Gm-Message-State: AJcUukf0oWp28AIjmryk0I8eNxgDAMd8tXknL4Ch9GStCiI6YUc6i7G5
 hawHsym8Dh4kFOAmhNXMJkRCgQ==
X-Google-Smtp-Source: ALg8bN54lBhwtTYgUUckhBMWisULFMMjVEx2eWOp4yXXHUmJ4S+WxTrYph5+23iF88aV5rawBgCc6g==
X-Received: by 2002:a65:590b:: with SMTP id f11mr2785423pgu.60.1548264802463; 
 Wed, 23 Jan 2019 09:33:22 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id 128sm29989815pfu.129.2019.01.23.09.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 09:33:21 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To: Sudeep Holla <sudeep.holla@arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123172115.GA31694@e107155-lin>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <6a62b11d-420d-8e1c-b0d0-326963f17853@broadcom.com>
Date: Wed, 23 Jan 2019 09:33:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123172115.GA31694@e107155-lin>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_093323_490875_D6D0AD2A 
X-CRM114-Status: GOOD (  25.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Pramod Kumar <pramod.kumar@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3VkZWVwLAoKT24gMjAxOS0wMS0yMyA5OjIxIGEubS4sIFN1ZGVlcCBIb2xsYSB3cm90ZToK
PiBPbiBXZWQsIEphbiAyMywgMjAxOSBhdCAwOTowNToyNkFNIC0wODAwLCBTY290dCBCcmFuZGVu
IHdyb3RlOgo+PiBIaSBNYXJrLAo+Pgo+PiBIb3BlZnVsbHkgSSBjYW4gc2hlZCBzb21lIGxpZ2h0
IG9uIHRoZSB1c2UgY2FzZSBpbmxpbmUuCj4+Cj4+IE9uIDIwMTktMDEtMjMgODo0OCBhLm0uLCBN
YXJrIFJ1dGxhbmQgd3JvdGU6Cj4+PiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCAxMTozMDowMkFN
ICswNTMwLCBQcmFtb2QgS3VtYXIgd3JvdGU6Cj4+Pj4gT24gTW9uLCBKYW4gMjEsIDIwMTkgYXQg
MTE6MjggQU0gUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3VtYXJAYnJvYWRjb20uY29tPgo+Pj4+IHdy
b3RlOgo+Pj4+Cj4+Pj4gICAgICAgTmVlZCBjb21lcyBmcm9tIGEgc3BlY2lmaWMgdXNlIGNhc2Ug
d2hlcmUgb25lIEFjY2VsZXJhdG9yIGNhcmQoU29DKSBpcwo+Pj4+ICAgICAgIHBsdWdnZWQgaW4g
YSBzZXZlciBvdmVyIGEgUENJZSBpbnRlcmZhY2UuICBUaGlzIENhcmQgZ2V0cyBzdXBwbHkgZnJv
bSBhCj4+Pj4gICAgICAgYmF0dGVyeSwgd2hpY2ggY291bGQgcHJvdmlkZSB2ZXJ5IGxlc3MgcG93
ZXIgZm9yIGEgdmVyeSBzbWFsbCB0aW1lLCBpbiBjYXNlCj4+Pj4gICAgICAgb2YgYW55IHBvd2Vy
IGxvc3MuIE9uY2UgQ2FyZCBzd2l0Y2hlcyB0byBiYXR0ZXJ5LCB0aGlzIGhhcyB0byByZWR1Y2Ug
aXRzCj4+Pj4gICAgICAgcG93ZXIgY29uc3VtcHRpb24gdG8gaXRzIGxvd2VzdCBwb2ludCBhbmQg
YmFjay11cCB0aGUgRERSIGNvbnRlbnRzIGFzYXAKPj4+PiAgICAgICBiZWZvcmUgYmF0dGVyeSBn
ZXRzIGZ1bGx5IGRyYWluZWQgb2ZmLgo+Pj4gSW4gdGhpcyBleGFtcGxlIGlzIExpbnV4IHJ1bm5p
bmcgb24gdGhlIHNlcnZlciwgb3Igb24gdGhlIGFjY2VsZXJhdG9yPwo+PiBBY2NlbGVyYXRvcgo+
Pj4gV2hhdCBwcmVjaXNlbHkgYXJlIHlvdSB0cnlpbmcgdG8gYmFjayB1cCBmcm9tIEREUiwgYW5k
IHdoeT8KPj4gRGF0YSBpbiBERFIgaXMgYmVpbmcgd3JpdHRlbiB0byBkaXNrIGF0IHRoaXMgdGlt
ZSAoZGlzayBpcyBjb25uZWN0ZWQgdG8KPj4gYWNjZWxlcmF0b3IpCj4+PiBXaGF0IGlzIHJlc3Bv
bnNpYmxlIGZvciBiYWNraW5nIHVwIHRoYXQgY29udGVudHM/Cj4+IEEgbG93IHBvd2VyIE0tY2xh
c3MgcHJvY2Vzc29yIGFuZCBETUEgZW5naW5lIHdoaWNoIGNvbnRpbnVlcyBuZWNlc3NhcnkKPj4g
b3BlcmF0aW9ucyB0byB0cmFuc2ZlciBERFIgbWVtb3J5IHRvIGRpc2suCj4+Cj4+IFRoZSBoaWdo
IHBvd2VyIHByb2Nlc3NvcnMgb24gdGhlIGFjY2VsZXJhdG9yIHJ1bm5pbmcgbGludXggbmVlZGVk
IHRvIGJlCj4+IGhhbHRlZCBBU0FQIG9uIHRoaXMgcG93ZXIgbG9zcyBldmVudCBhbmQgTTAgdGFr
ZSBvdmVyLiBHcmFjZWZ1bCBzaHV0ZG93biBvZgo+PiBsaW51eCBhbmQgb3RoZXIgcGVyaXBoZXJh
bHMgaXMgdW5uZWNlc3NhcnkgKGFuZCB3ZSBkb24ndCBoYXZlIHRoZSBwb3dlcgo+PiBuZWNlc3Nh
cnkgdG8gZG8gc28pLgo+Pgo+IEl0IG1heSBiZSB1bm5lY2Vzc2FyeSBmb3IgeW91ciB1c2UtY2Fz
ZSwgYnV0IG5vdCByZWNvbW1lbmRlZC4KTm8gY2hvaWNlIC0gd2UgZG9uJ3QgaGF2ZSB0aGUgdGlt
ZS9wb3dlciBmb3IgYSBncmFjZWZ1bCBzaHV0ZG93bi4KPgo+Pj4+ICAgICAgIFNpbmNlIGJhdHRl
cnkgY2FuIHByb3ZpZGUgbGltaXRlZCBwb3dlciBmb3IgYSB2ZXJ5IHNob3J0IHRpbWUgaGVuY2Ug
bmVlZCB0bwo+Pj4+ICAgICAgIHRyYW5zaXRpb24gdG8gbG93ZXN0IHBvd2VyLiBBcyBwZXIgdGhl
IHRyYW5zaXRpb24gcHJvY2VzcyAsIENQVXMgcG93ZXIKPj4+PiAgICAgICBkb21haW4gaGFzIHRv
IGJlIG9mZiBidXQgYmVmb3JlIHRoYXQgaXQgbmVlZHMgdG8gZmx1c2ggb3V0IGl0cyBjb250ZW50
IHRvCj4+Pj4gICAgICAgc3lzdGVtIG1lbW9yeShMMykgc28gdGhhdCBjb250ZW50IGNvdWxkIGJl
IGJhY2tlZC11cCBieSBhIE1DVSwgYSBjb250cm9sbGVyCj4+Pj4gICAgICAgY29uc3VtaW5nIHZl
cnkgbGVzcyBwb3dlci4gU2luY2Ugd2UgY2FuIG5vdCBhZmZvcmQgcGx1Z2dpbmctb3V0IGV2ZXJ5
Cj4+Pj4gICAgICAgaW5kaXZpZHVhbCBDUFVzIGluIHNlcXVlbmNlIGhlbmNlIHVzZXMgIGlwaV9j
cHVfc3RvcCBmb3IgYWxsIG90aGVyIENQVXMKPj4+PiAgICAgICB3aGljaCB1bHRpbWF0ZWx5IHN3
aXRjaCB0byBBVEYgdG8gZmx1c2ggb3V0IGFsbCB0aGUgQ1BVcyBjYWNoZXMgYW5kIGNvbWVzCj4+
Pj4gICAgICAgb3V0IG9mIGNvaGVyZW5jeSBkb21haW4gc28gdGhhdCBpdHMgcG93ZXIgcmFpbHMg
Y291bGQgYmUgc3dpdGNoZWQtb2ZmLgo+Pj4gSWYgeW91J3JlIHN0b3BwaW5nIENQVXMgZnJvbSBj
b21wbGV0ZWx5IGFyYml0cmFyeSBzdGF0ZXMsIHdoYXQgaXMgdGhlCj4+PiBiZW5lZml0IG9mIHNh
dmluZyB0aGUgUkFNIGNvbnRlbnRzPwo+PiBTb21lIG9mIHRoZSBSQU0gY29udGFpbnMgZGF0YSB0
aGF0IHdhcyBpbiB0aGUgcHJvY2VzcyBvZiBiZWluZyB3cml0dGVuIHRvCj4+IGRpc2sgYnkgdGhl
IGFjY2VsZXJhdG9yLgo+Pgo+PiBUaGlzIGRhdGEgbXVzdCBiZSBzYXZlZCB0byBkaXNrIGFuZCB0
aGUgaGlnaCBwb3dlciBDUFVzIGNvbnN1bWUgdG9vIG11Y2gKPj4gcG93ZXIgdG8gY29udGludWUg
cGVyZm9ybWluZyB0aGlzIG9wZXJhdGlvbi4KPj4KPiBXaHkgd2lsbCBzdXNwZW5kIHRvIHJhbSBv
ciBpZGxlIG5vdCB3b3JrID8gSXQgd2lsbCBwb3dlciBvZmYgdGhlIHNlY29uZGFyaWVzCj4gd2hp
Y2ggdGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gYWNoaWV2ZSwgYnV0IGluIG1vcmUgc2FuZSB3YXkg
c28gdGhhdCBubwo+IGRhdGEvc3RhdGUgaXMgbG9zdC9jb3JydXB0ZWQgYXMgSSBzdGF0ZWQgZWFy
bGllci4KV2UgbmVlZCB0byB0YWtlIG92ZXIgY29udHJvbCBvZiB0aGUgZGlzayB3cml0ZSBvcGVy
YXRpb25zLsKgIFRoZXJlIGlzIG5vIAp0aW1lL3Bvd2VyIGF2YWlsYWJsZSB0byBsZWF2ZSBsaW51
eCBydW5uaW5nLgo+Cj4+PiBDUFVzIG1pZ2h0IGJlIHJ1bm5pbmcgd2l0aCBJUlFzIGRpc2FibGVk
IGZvciBhbiBhcmJpdHJhcmlseSBsb25nIHRpbWUsCj4+IEluIGFuIGVtYmVkZGVkIGxpbnV4IHN5
c3RlbSB3ZSBjb250cm9sIGV2ZXJ5dGhpbmcgcnVubmluZy4KPj4KPiBCeSB3aGljaCBJIGFzc3Vt
ZSB5b3UgaGF2ZSBwYXRjaGVzIHRvIGRvIGFsbCBzb3J0cyBvZiB0aGluZ3MgdG8gbWFrZSB0aGlz
Cj4gd29yayBhbmQgdGhpcyBwYXRjaCBzdGFuZGFsb25lIGlzIG9mIG5vIHVzZSA6KQoKSSBiZWxp
ZXZlIG90aGVyIHBhdGNoIGlzIGluIGEgc3RhbmRhbG9uZSBkcml2ZXIgdG8gYmUgdXBzdHJlYW1l
ZC4KClJlbWFpbmRlciBvZiBjb2RlIGlzIG9uIGEgc3RhbmRhbG9uZSBNMCBwcm9jZXNzb3Igbm90
IHJ1bm5pbmcgbGludXguCgo+Cj4gSSBkb24ndCBsaWtlIHRoaXMgYXMgaXQncyBub3Qgc2NhbGFi
bGUgdG8gYmlnIHN5c3RlbXMgYXMgdGhpcyBpcyBpbiB0aGUKPiBzYW1lIGNvZGUgcGF0aCBhcyBz
eXN0ZW0gb2ZmL3Jlc2V0LgpNYW55IHRoaW5ncyBhcmUgbm90IHVzZWQgYnkgYmlnIHN5c3RlbXMg
YW5kIHZpY2UgdmVyc2EuwqAgV2hhdCBkbyB5b3UgCnN1Z2dlc3QgaXMgZG9uZSBvdGhlcndpc2U/
Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gU3VkZWVwCgpSZWdhcmRzLAoKIMKgU2NvdHQKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
