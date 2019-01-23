Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C95C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47FF21874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ww+DK4bQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TgCFpBnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47FF21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s4Y+5vyBjjB28eIta3Y2Zv3C8vCPKHx+PbTxAa1L+8c=; b=Ww+DK4bQ4Bn1vmXCxe2kSoqcj
	4bEODStgqxAHLtPN1OIBNz6EtJp5IvR/3jIWu14hYw/G/4GYtW65RLJ9Oevs84ErPowdsYPToA8D4
	k7nr4BuNnZA2LDQXCSJn4SRY3s3VIOLHjVo9Ljn2U+YVxM7BdG0jK8C2rtnVG+fMNb1Rn3XItIfHv
	6dyXDy9+bbDzSiUmzyjzOcciFBDH/JMN9jJpaiekLtN0GT3+rFAwZpv478w2RYNhqW7OU0+YHC2zy
	l4eoBKdlKKZwJ8oKCKpeNCHdlkjwfrc4PNbY9b4RYiLzde/S7U9sn9RGMHfvkIjnEAcEiF0TC8TJm
	UKf+e5QJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMbi-0005Jv-En; Wed, 23 Jan 2019 17:46:34 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMbd-0005G8-BL
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:46:32 +0000
Received: by mail-pg1-x542.google.com with SMTP id w6so1386292pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6BfjCEBHdc6MrV1GJr/8ErQBlsGnUrVqtYH4hEsBMPg=;
 b=TgCFpBnxUFosCS4bJWEzl88RhZromeZA50eDtC3pu2842zZvPGmCc7QMGNIhLAyyE8
 Gq0QU3xikuG5KYBKmjA/DqDQl22QNhc+me8IkSRmVJsO6+5p3aNJnqlRt1slubBF1ohv
 7ueD+aqhewfIFeyFi3QZLLtl3almTulVfQDiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6BfjCEBHdc6MrV1GJr/8ErQBlsGnUrVqtYH4hEsBMPg=;
 b=gVVgW0XnEax0UsUHLe4ZyF/p9e27cpAoqGDYNU9D1dKtCB8qbHgKq/uCZ3zq9Ejsjp
 nUyXN3M05/JWZXDP39HE39VXpjbb66FOWthpEoCrX4ul0JbjGy8vfOK1jqC0etTD1ZHi
 VspG8exS9qiwPf+fqbdykUc/0Ui62lYjLD0QSOtq1IMpIwpBDluEfViOhd826QPO3xQk
 L2V5u3bIBIeVR7Odai687LNblcBHekH/uBEXFhlxxYZO7WBzZLVLpT0cRzVm+2Z0W7tC
 ey9zInxvSZ40Iv9ocM7tuqXFzu3y5K2vpmo+1Dv9t2pRp5XwofkbGE7dkic126YG+Qu+
 7oIg==
X-Gm-Message-State: AJcUukdFtJYTaBix4wykw38+5kjts5muqYsur7gYT1MQaHD57984eIMg
 DJVzZ1Q7gLR84C9d9HUou5bGRAmqczRYbqNR
X-Google-Smtp-Source: ALg8bN41gsntqWMTOGaOJ4QFEgr0GQtFY2tujN8Eo46QbtDZkoVaRWjfkqghBMuLVi9Vq9jN7K2otw==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr3010059pfh.228.1548265588026; 
 Wed, 23 Jan 2019 09:46:28 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id q187sm28696057pfq.128.2019.01.23.09.46.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 09:46:27 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To: Mark Rutland <mark.rutland@arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123173343.GC55887@lakrids.cambridge.arm.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <90ba929c-362b-a561-1099-5887fc5f6286@broadcom.com>
Date: Wed, 23 Jan 2019 09:46:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123173343.GC55887@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_094629_935113_23146E07 
X-CRM114-Status: GOOD (  23.54  )
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
 Pramod Kumar <pramod.kumar@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0yMyA5OjMzIGEubS4sIE1hcmsgUnV0bGFuZCB3cm90ZToKPiBPbiBXZWQsIEph
biAyMywgMjAxOSBhdCAwOTowNToyNkFNIC0wODAwLCBTY290dCBCcmFuZGVuIHdyb3RlOgo+PiBI
aSBNYXJrLAo+Pgo+PiBIb3BlZnVsbHkgSSBjYW4gc2hlZCBzb21lIGxpZ2h0IG9uIHRoZSB1c2Ug
Y2FzZSBpbmxpbmUuCj4+Cj4+IE9uIDIwMTktMDEtMjMgODo0OCBhLm0uLCBNYXJrIFJ1dGxhbmQg
d3JvdGU6Cj4+PiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCAxMTozMDowMkFNICswNTMwLCBQcmFt
b2QgS3VtYXIgd3JvdGU6Cj4+Pj4gT24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMTE6MjggQU0gUHJh
bW9kIEt1bWFyIDxwcmFtb2Qua3VtYXJAYnJvYWRjb20uY29tPgo+Pj4+IHdyb3RlOgo+Pj4+Cj4+
Pj4gICAgICAgTmVlZCBjb21lcyBmcm9tIGEgc3BlY2lmaWMgdXNlIGNhc2Ugd2hlcmUgb25lIEFj
Y2VsZXJhdG9yIGNhcmQoU29DKSBpcwo+Pj4+ICAgICAgIHBsdWdnZWQgaW4gYSBzZXZlciBvdmVy
IGEgUENJZSBpbnRlcmZhY2UuICBUaGlzIENhcmQgZ2V0cyBzdXBwbHkgZnJvbSBhCj4+Pj4gICAg
ICAgYmF0dGVyeSwgd2hpY2ggY291bGQgcHJvdmlkZSB2ZXJ5IGxlc3MgcG93ZXIgZm9yIGEgdmVy
eSBzbWFsbCB0aW1lLCBpbiBjYXNlCj4+Pj4gICAgICAgb2YgYW55IHBvd2VyIGxvc3MuIE9uY2Ug
Q2FyZCBzd2l0Y2hlcyB0byBiYXR0ZXJ5LCB0aGlzIGhhcyB0byByZWR1Y2UgaXRzCj4+Pj4gICAg
ICAgcG93ZXIgY29uc3VtcHRpb24gdG8gaXRzIGxvd2VzdCBwb2ludCBhbmQgYmFjay11cCB0aGUg
RERSIGNvbnRlbnRzIGFzYXAKPj4+PiAgICAgICBiZWZvcmUgYmF0dGVyeSBnZXRzIGZ1bGx5IGRy
YWluZWQgb2ZmLgo+Pj4gSW4gdGhpcyBleGFtcGxlIGlzIExpbnV4IHJ1bm5pbmcgb24gdGhlIHNl
cnZlciwgb3Igb24gdGhlIGFjY2VsZXJhdG9yPwo+PiBBY2NlbGVyYXRvcgo+Pj4gV2hhdCBwcmVj
aXNlbHkgYXJlIHlvdSB0cnlpbmcgdG8gYmFjayB1cCBmcm9tIEREUiwgYW5kIHdoeT8KPj4gRGF0
YSBpbiBERFIgaXMgYmVpbmcgd3JpdHRlbiB0byBkaXNrIGF0IHRoaXMgdGltZSAoZGlzayBpcyBj
b25uZWN0ZWQgdG8KPj4gYWNjZWxlcmF0b3IpCj4+PiBXaGF0IGlzIHJlc3BvbnNpYmxlIGZvciBi
YWNraW5nIHVwIHRoYXQgY29udGVudHM/Cj4+IEEgbG93IHBvd2VyIE0tY2xhc3MgcHJvY2Vzc29y
IGFuZCBETUEgZW5naW5lIHdoaWNoIGNvbnRpbnVlcyBuZWNlc3NhcnkKPj4gb3BlcmF0aW9ucyB0
byB0cmFuc2ZlciBERFIgbWVtb3J5IHRvIGRpc2suCj4+Cj4+IFRoZSBoaWdoIHBvd2VyIHByb2Nl
c3NvcnMgb24gdGhlIGFjY2VsZXJhdG9yIHJ1bm5pbmcgbGludXggbmVlZGVkIHRvIGJlCj4+IGhh
bHRlZCBBU0FQIG9uIHRoaXMgcG93ZXIgbG9zcyBldmVudCBhbmQgTTAgdGFrZSBvdmVyLiBHcmFj
ZWZ1bCBzaHV0ZG93biBvZgo+PiBsaW51eCBhbmQgb3RoZXIgcGVyaXBoZXJhbHMgaXMgdW5uZWNl
c3NhcnkgKGFuZCB3ZSBkb24ndCBoYXZlIHRoZSBwb3dlcgo+PiBuZWNlc3NhcnkgdG8gZG8gc28p
Lgo+IElmIGdyYWNlZnVsIHNodXRkb3duIG9mIExpbnV4IGlzIG5vdCByZXF1aXJlZCAoYW5kIGlz
IGluIGZhY3QKPiB1bmRlc2lyZWFibGUpLCB3aHkgaXMgTGludXggaW52b2x2ZWQgYXQgYWxsIGlu
IHRoaXMgc2h1dGRvd24gcHJvY2Vzcz8KPgo+IEZvciBleGFtcGxlLCB3aHkgaXMgdGhpcyBub3Qg
YSBzZWN1cmUgaW50ZXJydXB0IHRha2VuIHRvIEVMMywgd2hpY2ggY2FuCj4gKGdyYWNlZnVsbHkp
IHNodXQgZG93biB0aGUgQ1BVcyByZWdhcmRsZXNzPwpXaWxsIG5lZWQgUHJhbW9kIHRvIGV4cGxh
aW4gdGhlIGRldGFpbGVkIHJhdGlvbmFsZSBoZXJlLgo+Pj4+ICAgICAgIFNpbmNlIGJhdHRlcnkg
Y2FuIHByb3ZpZGUgbGltaXRlZCBwb3dlciBmb3IgYSB2ZXJ5IHNob3J0IHRpbWUgaGVuY2UgbmVl
ZCB0bwo+Pj4+ICAgICAgIHRyYW5zaXRpb24gdG8gbG93ZXN0IHBvd2VyLiBBcyBwZXIgdGhlIHRy
YW5zaXRpb24gcHJvY2VzcyAsIENQVXMgcG93ZXIKPj4+PiAgICAgICBkb21haW4gaGFzIHRvIGJl
IG9mZiBidXQgYmVmb3JlIHRoYXQgaXQgbmVlZHMgdG8gZmx1c2ggb3V0IGl0cyBjb250ZW50IHRv
Cj4+Pj4gICAgICAgc3lzdGVtIG1lbW9yeShMMykgc28gdGhhdCBjb250ZW50IGNvdWxkIGJlIGJh
Y2tlZC11cCBieSBhIE1DVSwgYSBjb250cm9sbGVyCj4+Pj4gICAgICAgY29uc3VtaW5nIHZlcnkg
bGVzcyBwb3dlci4gU2luY2Ugd2UgY2FuIG5vdCBhZmZvcmQgcGx1Z2dpbmctb3V0IGV2ZXJ5Cj4+
Pj4gICAgICAgaW5kaXZpZHVhbCBDUFVzIGluIHNlcXVlbmNlIGhlbmNlIHVzZXMgIGlwaV9jcHVf
c3RvcCBmb3IgYWxsIG90aGVyIENQVXMKPj4+PiAgICAgICB3aGljaCB1bHRpbWF0ZWx5IHN3aXRj
aCB0byBBVEYgdG8gZmx1c2ggb3V0IGFsbCB0aGUgQ1BVcyBjYWNoZXMgYW5kIGNvbWVzCj4+Pj4g
ICAgICAgb3V0IG9mIGNvaGVyZW5jeSBkb21haW4gc28gdGhhdCBpdHMgcG93ZXIgcmFpbHMgY291
bGQgYmUgc3dpdGNoZWQtb2ZmLgo+Pj4gSWYgeW91J3JlIHN0b3BwaW5nIENQVXMgZnJvbSBjb21w
bGV0ZWx5IGFyYml0cmFyeSBzdGF0ZXMsIHdoYXQgaXMgdGhlCj4+PiBiZW5lZml0IG9mIHNhdmlu
ZyB0aGUgUkFNIGNvbnRlbnRzPwo+PiBTb21lIG9mIHRoZSBSQU0gY29udGFpbnMgZGF0YSB0aGF0
IHdhcyBpbiB0aGUgcHJvY2VzcyBvZiBiZWluZyB3cml0dGVuIHRvCj4+IGRpc2sgYnkgdGhlIGFj
Y2VsZXJhdG9yLgo+IE9rLCBzbyB0aGlzIGlzbid0IGFjdHVhbGx5IGFib3V0IGJhY2tpbmcgdXAg
UkFNIGNvbnRlbnRzOyBpdCdzIGFib3V0Cj4gY29tcGxldGluZyBwZW5kaW5nIEkvTy4KPgo+IEkn
bSBzdGlsbCBjb25mdXNlZCBhcyB0byBob3cgdGhhdCB3b3Jrcy4gSG93IGRvIHlvdSBhdm9pZCBs
ZWF2aW5nIHRoZQo+IGRpc2sgaW4gc29tZSBjb3JydXB0IHN0YXRlIGlmIGRhdGEgcnVucyBvdXQg
cGFydHdheSB0aHJvdWdoPwoKU29tZSBhZGRpdGlvbmFsIGZsYWdzIGFuZCBkZXRhaWxzIGFyZSBz
YXZlZCB0byBkaXNrIHdpdGggdGhlICJwZW5kaW5nIGkvbyIuCgpPbiBuZXh0IHBvd2VyIHVwIGFu
IGFwcCBydW5zIHdoaWNoIHJlY292ZXJzIHRoZSBkYXRhIGFuZCByZWNvdmVycyBpdCBhbmQgCmNv
bXBsZXRlcyBwcm9jZXNzaW5nLgoKT2YgY291cnNlLCBpZiB0aGUgc3RvcmUgZG9lc24ndCBzdWNj
ZWVkIHByb3Blcmx5IHBvcnRpb25zIG9mIHRoZSAKcmVjb3ZlcnkgYXJlIGRpc2NhcmRlZC4KCj4K
Pj4gVGhpcyBkYXRhIG11c3QgYmUgc2F2ZWQgdG8gZGlzayBhbmQgdGhlIGhpZ2ggcG93ZXIgQ1BV
cyBjb25zdW1lIHRvbyBtdWNoCj4+IHBvd2VyIHRvIGNvbnRpbnVlIHBlcmZvcm1pbmcgdGhpcyBv
cGVyYXRpb24uCj4+Cj4+PiBDUFVzIG1pZ2h0IGJlIHJ1bm5pbmcgd2l0aCBJUlFzIGRpc2FibGVk
IGZvciBhbiBhcmJpdHJhcmlseSBsb25nIHRpbWUsCj4+IEluIGFuIGVtYmVkZGVkIGxpbnV4IHN5
c3RlbSB3ZSBjb250cm9sIGV2ZXJ5dGhpbmcgcnVubmluZy4KPiBTdXJlLCBhbmQgdGhhdCBjb21w
bGV0ZSBjb250cm9sIGFsbG93cyB5b3UgdG8gZG8gc29tZXRoaW5nIGJldHRlciB0aGFuCj4gdGhp
cyBSRkMsIEFGQUlDVC4KSWYgcG9zc2libGUgdGhhdCB3b3VsZCBiZSBncmVhdC7CoCBOZWVkIFBy
YW1vZCB0byBjb21tZW50IHdoZXRoZXIgdGhlIApkaXJlY3QgRUwzIHdpbGwgc29sdmUgYWxsIGlz
c3Vlcy4KPgo+IFRoYW5rcywKPiBNYXJrLgoKVGhhbmtzIGZvciBpbnB1dCBNYXJrLgoKU2NvdHQK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
