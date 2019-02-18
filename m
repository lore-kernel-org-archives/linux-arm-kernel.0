Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF507C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0EE2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cUXWW13n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sc15G7BW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rYhlZ03V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0EE2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6/IJIVI4PObNJhBfbD1WvGWH7GhPwa8pL2/kEsvCH0g=; b=cUXWW13nRD6ZTw
	0ccJ7EibwOK0EYQ8NeATYg03XjgFn8QPNdddKfXZLl/Hnjpq+CViBeFa20QPab2ffxP4BM8CgAgp4
	DslKyEnYRFkJ6ZHa3HyR53zhUNS3HP5K7vNEgdWCta4hGdIFOx2LvijbNFU5y3SUHs8rLxRHcJRWM
	mdXDDEl09nrXVbSXP3Ai1LpA3S9aDyEtViC3SFZnPvT/Wx9U1u1uy/veKUhF3l19FBGQhQRppOVUG
	BoKUJZg+x69fynNBWszyDmI0e7bKt8pniUI/9D+lHk5Q6ZdmKj780/KBGIRDPEK+WU3v3I4x4/qmf
	lRc2lfR3J+eSbVp5+9Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfrN-00043d-TB; Mon, 18 Feb 2019 10:09:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfrL-0003tq-4l; Mon, 18 Feb 2019 10:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7uSAy2SuOQBOFcmGGzEeUxw4F42Wkz6Q4MRCL20hS7w=; b=Sc15G7BWNW+zq3pjijo16OwbHn
 V5RL9/CeQ4WcnZqRXXSqCoq8Cj39T2nMg/o6Dd5PoEZ6/heem4D3cxoBzIVnV0IX7Npikikz1DqwA
 1kxiqi7pAvaTHO9UZ8mjrt/0lXPuI71n8oFjgF7prLpxHG3KrOrkvfid1LTpB00i3giXk6Hsq0Ott
 6MSYPFSyCjMJeKAvm4iNiD2mk2u1Ncez6tnVughmF3wDXELFEmctNv8JQGn2ineMcXJC4pZEXwGd/
 GeaZB0cI+cEmw6b3m13QqIP0hv1dg+YEe4ad7u2T5OAUaG6Zqi7U7T8Bbd5zPCE65KOTdamRZryGJ
 mBET2tcg==;
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfeT-0008Vr-3Y; Mon, 18 Feb 2019 09:55:55 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6a812a0000>; Mon, 18 Feb 2019 01:55:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 18 Feb 2019 01:55:48 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 01:55:48 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:55:45 +0000
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
To: Chanwoo Choi <cw00.choi@samsung.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>, <heiko@sntech.de>,
 <thierry.reding@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com>
 <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
Date: Mon, 18 Feb 2019 09:55:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550483754; bh=7uSAy2SuOQBOFcmGGzEeUxw4F42Wkz6Q4MRCL20hS7w=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=rYhlZ03VoCxnd3Kzo80BdBR5ZVR990+NlU4FGnCmj+PadjrqTGZ1W2p8XqTFThKF2
 Gx6FsT1Ra8EzcqiF0LK8AgmpK20o/LPqAd6nChDDJhHFOeRCbdIZqziHWp3SMca8qR
 /Tps2D31qoEUXWuhorAzhhIPUJYPUTXAILI1fi3/Fdn+56qTlHgq9JPgAMcUNDMgp3
 hNzaB3rBtPRXFxE5oOAL1NNoxVVNwwS58HweNDcmIyQd78HX/o0/rtVElBdWHCltrM
 JSe9SQfuDxTWyxYNeGAxr/so6pmcB/jYQFLlGGIDEg1xIBRk6xsq6QnnWilo3J/UmT
 SpNT49hCbMlMQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_095553_481190_4B07BD09 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDE4LzAyLzIwMTkgMDA6MzgsIENoYW53b28gQ2hvaSB3cm90ZToKPiBPbiAxOS4gMi4gMTcu
IOyYpOyghCAxMjoxOCwgWWFuZ3RhbyBMaSB3cm90ZToKPj4gVGhpcyB2YXJpYWJsZSBpcyBub3Qg
dXNlZCBhZnRlciBpbml0aWFsaXphdGlvbiwgc28KPj4gcmVtb3ZlIGl0LiBBbmQgaW4gb3JkZXIg
dG8gdW5pZnkgdGhlIGNvZGUgc3R5bGUsCj4+IG1vdmUgdGhlIGxvY2F0aW9uIHdoZXJlIHRoZSBk
ZXZfZ2V0X2RydmRhdGEgaXMgY2FsbGVkCj4+IGJ5IHRoZSB3YXkuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IFlhbmd0YW8gTGkgPHRpbnkud2luZHp6QGdtYWlsLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJz
L2RldmZyZXEvdGVncmEtZGV2ZnJlcS5jIHwgNyArKy0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kZXZmcmVxL3RlZ3JhLWRldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS90ZWdyYS1kZXZmcmVx
LmMKPj4gaW5kZXggYzU5ZDJlZWU1ZDMwLi5jODliYTdiODM0ZmYgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZGV2ZnJlcS90ZWdyYS1kZXZmcmVxLmMKPj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL3Rl
Z3JhLWRldmZyZXEuYwo+PiBAQCAtNTczLDEwICs1NzMsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2dv
dmVybm9yX2dldF90YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4+ICBzdGF0aWMgaW50
IHRlZ3JhX2dvdmVybm9yX2V2ZW50X2hhbmRsZXIoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4+
ICAJCQkJCXVuc2lnbmVkIGludCBldmVudCwgdm9pZCAqZGF0YSkKPj4gIHsKPj4gLQlzdHJ1Y3Qg
dGVncmFfZGV2ZnJlcSAqdGVncmE7Cj4+IC0JaW50IHJldCA9IDA7Cj4+IC0KPj4gLQl0ZWdyYSA9
IGRldl9nZXRfZHJ2ZGF0YShkZXZmcmVxLT5kZXYucGFyZW50KTsKPj4gKwlzdHJ1Y3QgdGVncmFf
ZGV2ZnJlcSAqdGVncmEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2ZnJlcS0+ZGV2LnBhcmVudCk7Cj4+
ICAKPj4gIAlzd2l0Y2ggKGV2ZW50KSB7Cj4+ICAJY2FzZSBERVZGUkVRX0dPVl9TVEFSVDoKPj4g
QEAgLTYwMCw3ICs1OTcsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2dvdmVybm9yX2V2ZW50X2hhbmRs
ZXIoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4+ICAJCWJyZWFrOwo+PiAgCX0KPj4gIAo+PiAt
CXJldHVybiByZXQ7Cj4+ICsJcmV0dXJuIDA7Cj4+ICB9Cj4+ICAKPj4gIHN0YXRpYyBzdHJ1Y3Qg
ZGV2ZnJlcV9nb3Zlcm5vciB0ZWdyYV9kZXZmcmVxX2dvdmVybm9yID0gewo+Pgo+IAo+IFJldmll
d2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPiAKCkFja2VkLWJ5
OiBKb24gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4KClRoYW5rcyEKSm9uCgotLSAKbnZw
dWJsaWMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
