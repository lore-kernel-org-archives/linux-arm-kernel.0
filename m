Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEBFC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:07:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39B320B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BQ14+xzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBxNqqId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39B320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sNdopbghHC8DXEIgdJPhgWDKcAfh0zmH1RA6AvmRaB0=; b=BQ14+xzhagCUF6
	7z/E1zUMlTvJXh0arxVwJt97SBd4PydpTzWxDOKMDKXPH9Fr5eMz7HBUs8hne/0pR8wNBiLxXDKuk
	j+bJFo37ASETWNQOx/gFWfBWc3gXkZJW/KU3JBhBCAjqVSdj1BE7WcomfwjmMe9paNblacmP9GYqZ
	VP1AOeQEspZtVNVzCdp6O/LEOV/hp1lb7FpkfgitUr8BXuLZo7mMtvhHr4dcuVW/RONFODOlgipOO
	IKvgRFkuKU8+L+vildOWTEoJYDefbOBJAmKq6FvO8xOXuEezdAOgmhrsovsiDvZGgXnTF9SAuyj88
	AamQRT/jHoqphT/mrBKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTqp-00034S-6r; Fri, 01 Feb 2019 08:07:03 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTql-00033v-Rz
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:07:01 +0000
Received: by mail-wr1-x442.google.com with SMTP id t6so5961387wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 00:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=A7ouruIygAxaRuQcQBC19h0+UQR2acPO+AXiWBuS1EY=;
 b=eBxNqqIdZvw0oICUIyFMFZAwE0FDwDORyPZS08aoghy/gyEImfEL19CEi35dPheyMu
 1qAFiI55wPxvULYOOjVkgEl1t8PSA+xr5EonV1Pau1OYyk3mfUgMcTUJOFWupNC5gtQg
 E/zGjuRBMv6BJbRjOVRRGsBuT7YjHU52zwpOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=A7ouruIygAxaRuQcQBC19h0+UQR2acPO+AXiWBuS1EY=;
 b=dQfWwrm8XaHGEhfZhgc1ze/sBvFYrA1zsbam85fuHfQwg+nRK3VRRrTouC5NeYolh6
 PuH+YGcbxKLUw0/Wpard1wboPOnU0Th28DvQuhDBGaka/WEYFM5vldHdjMLrr4PospOk
 QHPM79PvEowKyzJYDRjh9Qzrtotbzt+uNeooUI3QQpUADqXTtViehTJPbPqcBWSwDcuv
 8LkT3QNPQdP01d1/dFXB7bD4GArGkPrOoWX9/BZkj6MNJWJP7XOBjRWmGaBCiD8zHyNN
 nT2ENPmn4eTLUMe8xtM91K73ONBMrGD/UatqAux3D+iyNcWRHxM4SwfZUdeBW+C1SpQZ
 VsVQ==
X-Gm-Message-State: AJcUukcxvpyD9pR9yG6XexNfrpU75iB4Xt7FZYprbPD3W8zd2JnvnWzH
 4gK9f6yrI6K5xRfIfuzkJArEDg==
X-Google-Smtp-Source: ALg8bN55zNtMkZ15sAj1MVls8B6g1tjUup5tAHUodWEF9QlV0rkzDTtBCWOIL3OyebAaX4zUSKoRGQ==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr35341696wrb.167.1549008416777; 
 Fri, 01 Feb 2019 00:06:56 -0800 (PST)
Received: from dell ([2.27.35.198])
 by smtp.gmail.com with ESMTPSA id n124sm2241984wmd.15.2019.02.01.00.06.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 00:06:56 -0800 (PST)
Date: Fri, 1 Feb 2019 08:06:52 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
Message-ID: <20190201080652.GA783@dell>
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_000659_910654_36709B72 
X-CRM114-Status: GOOD (  20.05  )
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
Cc: mark.rutland@arm.com, linux-efi@vger.kernel.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, will.deacon@arm.com,
 Alexander Graf <agraf@suse.de>, Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCAyNiBKYW4gMjAxOSwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cgo+IFRoZSBVRUZJIHNw
ZWMgcmV2aXNpb24gMi43IGVycmF0YSBBIHNlY3Rpb24gOC40IGhhcyB0aGUgZm9sbG93aW5nIHRv
Cj4gc2F5IGFib3V0IHRoZSB2aXJ0dWFsIG1lbW9yeSBydW50aW1lIHNlcnZpY2VzOgo+IAo+ICAg
IlRoaXMgc2VjdGlvbiBjb250YWlucyBmdW5jdGlvbiBkZWZpbml0aW9ucyBmb3IgdGhlIHZpcnR1
YWwgbWVtb3J5Cj4gICBzdXBwb3J0IHRoYXQgbWF5IGJlIG9wdGlvbmFsbHkgdXNlZCBieSBhbiBv
cGVyYXRpbmcgc3lzdGVtIGF0IHJ1bnRpbWUuCj4gICBJZiBhbiBvcGVyYXRpbmcgc3lzdGVtIGNo
b29zZXMgdG8gbWFrZSBFRkkgcnVudGltZSBzZXJ2aWNlIGNhbGxzIGluIGEKPiAgIHZpcnR1YWwg
YWRkcmVzc2luZyBtb2RlIGluc3RlYWQgb2YgdGhlIGZsYXQgcGh5c2ljYWwgbW9kZSwgdGhlbiB0
aGUKPiAgIG9wZXJhdGluZyBzeXN0ZW0gbXVzdCB1c2UgdGhlIHNlcnZpY2VzIGluIHRoaXMgc2Vj
dGlvbiB0byBzd2l0Y2ggdGhlCj4gICBFRkkgcnVudGltZSBzZXJ2aWNlcyBmcm9tIGZsYXQgcGh5
c2ljYWwgYWRkcmVzc2luZyB0byB2aXJ0dWFsCj4gICBhZGRyZXNzaW5nLiIKPiAKPiBTbyBpdCBp
cyBwcmV0dHkgY2xlYXIgdGhhdCBjYWxsaW5nIFNldFZpcnR1YWxBZGRyZXNzTWFwKCkgaXMgZW50
aXJlbHkKPiBvcHRpb25hbCwgYW5kIHNvIHRoZXJlIGlzIG5vIHBvaW50IGluIGRvaW5nIHNvIHVu
bGVzcyBpdCBhY2hpZXZlcwo+IGFueXRoaW5nIHVzZWZ1bCBmb3IgdXMuCj4gCj4gVGhpcyBpcyBu
b3QgdGhlIGNhc2UgZm9yIDY0LWJpdCBBUk0uIFRoZSBuYXRpdmUgbWFwcGluZyB1c2VkIGJ5IHRo
ZSBPUwo+IGlzIGFyYml0cmFyaWx5IGNvbnZlcnRlZCBpbnRvIGFub3RoZXIgcGVybXV0YXRpb24g
b2YgdXNlcmxhbmQgYWRkcmVzc2VzCj4gKGkuZS4sIGJpdHMgWzYzOjQ4XSBjbGVhcmVkKSwgYW5k
IHRoZSBydW50aW1lIGNvZGUgY291bGQgZWFzaWx5IGRlYWwKPiB3aXRoIHRoZSBvcmlnaW5hbCBs
YXlvdXQgaW4gZXhhY3RseSB0aGUgc2FtZSB3YXkgYXMgaXQgZGVhbHMgd2l0aCB0aGUKPiBjb252
ZXJ0ZWQgbGF5b3V0LiBIb3dldmVyLCBkdWUgdG8gY29uc3RyYWludHMgcmVsYXRlZCB0byBwYWdl
IHNpemUKPiBkaWZmZXJlbmNlcyBpZiB0aGUgT1MgaXMgbm90IHJ1bm5pbmcgd2l0aCA0ayBwYWdl
cywgYW5kIHJlbGF0ZWQgdG8KPiBzeXN0ZW1zIHRoYXQgbWF5IGV4cG9zZSB0aGUgaW5kaXZpZHVh
bCBzZWN0aW9ucyBvZiBQRS9DT0ZGIHJ1bnRpbWUKPiBtb2R1bGVzIGFzIGRpZmZlcmVudCBtZW1v
cnkgcmVnaW9ucywgY3JlYXRpbmcgdGhlIHZpcnR1YWwgbGF5b3V0IGlzIGEKPiBiaXQgZmlkZGx5
LCBhbmQgcmVxdWlyZXMgdXMgdG8gc29ydCB0aGUgbWVtb3J5IG1hcCBhbmQgcmVhc29uIGFib3V0
Cj4gYWRqYWNlbnQgcmVnaW9ucyB3aXRoIGlkZW50aWNhbCBtZW1vcnkgdHlwZXMgZXRjIGV0Yy4K
PiAKPiBTbyB0aGUgb2J2aW91cyBmaXggaXMgdG8gc3RvcCBjYWxsaW5nIFNldFZpcnR1YWxBZGRy
ZXNzTWFwKCkgYWx0b2dldGhlcgo+IG9uIGFybTY0IHN5c3RlbXMuIEhvd2V2ZXIsIHRvIGF2b2lk
IHN1cnByaXNlcywgd2hpY2ggYXJlIG5vdG9yaW91c2x5Cj4gaGFyZCB0byBkaWFnbm9zZSB3aGVu
IGl0IGNvbWVzIHRvIE9TPC0+ZmlybXdhcmUgaW50ZXJhY3Rpb25zLCBsZXQncwo+IHN0YXJ0IGJ5
IG1ha2luZyBpdCBhbiBvcHQtb3V0IGZlYXR1cmUsIGFuZCBpbXBsZW1lbnQgc3VwcG9ydCBmb3Ig
dGhlCj4gJ2VmaT1ub3ZhbWFwJyBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlciBvbiBBUk0g
YW5kIGFybTY0IHN5c3RlbXMuCj4gCj4gKE5vdGUgdGhhdCAzMi1iaXQgQVJNIGdlbmVyYWxseSBk
b2VzIHJlcXVpcmUgU2V0VmlydHVhbEFkZHJlc3NNYXAoKSB0byBiZQo+IHVzZWQsIGdpdmVuIHRo
YXQgdGhlIHBoeXNpY2FsIG1lbW9yeSBtYXAgYW5kIHRoZSBrZXJuZWwgdmlydHVhbCBhZGRyZXNz
Cj4gbWFwIGFyZSBub3QgZ3VhcmFudGVlZCB0byBiZSBub24tb3ZlcmxhcHBpbmcgbGlrZSBvbiBh
cm02NC4gSG93ZXZlciwKPiBoYXZpbmcgc3VwcG9ydCBmb3IgZWZpPW5vdmFtYXAsbm9ydW50aW1l
IG9uIDMyLWJpdCBBUk0sIGNvbWJpbmVkIHdpdGgKPiB0aGUgcmVjZW50bHkgcHJvcG9zZWQgc3Vw
cG9ydCBmb3IgZWFybHljb249ZWZpLCBpcyBsaWtlbHkgdG8gYmUgdXNlZnVsCj4gdG8gZGlhZ25v
c2UgYm9vdCBpc3N1ZXMgb24gc3VjaCBzeXN0ZW1zIGlmIHRoZXkgaGF2ZSBubyBhY2Nlc3NpYmxl
IHNlcmlhbAo+IHBvcnQpCj4gCj4gQ2M6IEFsZXhhbmRlciBHcmFmIDxhZ3JhZkBzdXNlLmRlPgo+
IENjOiBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+Cj4gQ2M6IEFLQVNI
SSBUYWthaGlybyA8dGFrYWhpcm8uYWthc2hpQGxpbmFyby5vcmc+Cj4gQ2M6IExlaWYgTGluZGhv
bG0gPGxlaWYubGluZGhvbG1AbGluYXJvLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hl
dXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4KClRlc3RlZC1ieTogTGVlIEpvbmVzIDxs
ZWUuam9uZXNAbGluYXJvLm9yZz4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNl
cnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
