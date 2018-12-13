Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77910C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451DC20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dLoTDZwi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="MGw0v0/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451DC20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MheXkD5PJ1aauQPGtx4HtTVxutji4eYXKVeVnRWklr0=; b=dLoTDZwiX1JTvJcnV3lhEt9v1
	47tSighwZ7bKiBWot0ArpoezQujFAhyFmirOLLvWyHYnF9Zxndqxfr0Ea2JqKgYsviV+ddHfQ8CY/
	8GtBPGq5+aDB2d2QInJsGL9Hfb/d0jtFcmPBhIcvsMKJ4wLz0cyLlwwwpEg8qpJALcjbkWZkoGgs9
	UY9Leok1y+S492nLWy2TntKxnXYAXmZCH+TomHuOJN4gmDAH6qy5Ftut8GZwYsww+S8Tg4V4IaoDJ
	wok08B0DIPnYjr1BxLKXotu+0pGXnr2XQwpPNfj5f7DrhDZrYRHx+BB2r6p8Akf604QXAyp/1SXny
	x1K9HYQhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPOJ-0002fo-5b; Thu, 13 Dec 2018 11:42:55 +0000
Received: from mail.micronovasrl.com ([212.103.203.10])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPOF-0002f4-3t
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:42:52 +0000
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
 by mail.micronovasrl.com (Postfix) with ESMTP id C25B3B01A2E
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 12:42:27 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
 h=content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:to:subject:subject; s=dkim; t=
 1544701346; x=1545565347; bh=kgZqYC9vikjAoU9wQs5xBoiKv1EX/ne2dvN
 mwNodLs4=; b=MGw0v0/nSnFcY8rG8N8gGx76SkKh6FGcg52xU6AjIQW864UJUBB
 0+MwSUQ4jyQfYzM076ztKMLDeABsbv4u2SI1/lJzVCKARdag0a17ggXVGUXw/7bB
 IGTvKyQUzpiSGWmv6+QrtPbcmhvYuIX98kTsSN9ScBQtQ6AAFA0c7/P4=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
 by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id dG4COEflaCKg for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 12:42:26 +0100 (CET)
Received: from [192.168.178.33]
 (host180-21-dynamic.5-87-r.retail.telecomitalia.it [87.5.21.180])
 by mail.micronovasrl.com (Postfix) with ESMTPSA id 6480DB002CF;
 Thu, 13 Dec 2018 12:42:25 +0100 (CET)
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Jonathan Liu <net147@gmail.com>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
 <e3307630-7ae7-2bd4-4933-a31419a0cc3a@micronovasrl.com>
 <CANwerB2GGLT6fOZk7Q8RXhmiEb7KYnQrx-Rj5AgGn-YPCiMH4g@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <cf5ac5cc-3696-a4fc-ae64-4f0304ab7df3@micronovasrl.com>
Date: Thu, 13 Dec 2018 12:42:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CANwerB2GGLT6fOZk7Q8RXhmiEb7KYnQrx-Rj5AgGn-YPCiMH4g@mail.gmail.com>
Content-Language: it
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_034251_340067_CCBCF595 
X-CRM114-Status: GOOD (  38.02  )
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSm9uYXRoYW4sCgpJbCAxMy8xMi8yMDE4IDAzOjU1LCBKb25hdGhhbiBMaXUgaGEgc2NyaXR0
bzoKPj4gQ2FuIHlvdSBwcmVjaXNlbHkgcG9pbnQgbWUgdGhlIHNvdXJjZXMgb2Y6Cj4+IC0gdS1i
b290Cj4+IC0ga2VybmVsCj4+IC0gZHRzCj4+Cj4+IHlvdSdyZSB1c2luZz8KPj4KPj4gVGhhbmtz
Cj4gCj4gVS1Cb290IC0gZ2l0IHRhZyB2MjAxNy4wMwo+IExpbnV4IC0gZ2l0IHRhZyB2NC4xOS42
Cj4gRFRTIC0gc2VlIGRldmljZSB0cmVlIGNoYW5nZXMgaW4KPiBodHRwczovL2dpdGh1Yi5jb20v
bmV0MTQ3L2xpbnV4L3RyZWUvc3VuN2ktZHJtLXdpcCBidXQgY2hhbmdlIHRoZQo+IGNvbXBhdGli
bGUgdG8gImlubm9sdXgsYXQwNzB0bjkyIgoKV2l0aCBMaW51eCB2NC4xOS42ICJpbm5vbHV4LGF0
MDcwdG45MiIgZG9lc24ndCBldmVuIHdvcmsgYW5kIEkgc3VzcGVjdCAKaXQgaXMgYmVjYXVzZSBv
ZiBjbG9jayBmcmVxdWVuY3kgdG9sZXJhbmNlIGNoZWNrIGZvciBwbGwgc2V0dGluZywgc28gaXQg
CmdldHMgZGlzY2FyZGVkIGZyb20gZHJtIHJlc3VsdGluZyBpbiBub3QgaGF2aW5nIGEgY3J0Yy4K
CkFueXdheSBJJ3ZlIGp1c3QgcmUtY2hlY2tlZCB0aGUgc2lnbmFscyB1c2luZyBhbm90aGVyIGRp
c3BsYXk6CiJpbm5vbHV4LGF0MDQzdG4yNCIgdGhhdCBoYXMgYSBtb3JlIHJvdW5kZWQgY2xvY2sg
ZnJlcXVlbmN5LCBzbyBpdCdzIAphY2NlcHRlZCBieSBkcm0gYW5kICoqc2lnbmFscyBhcmUgY29y
cmVjdCoqLgpVbmZvcnR1bmF0ZWx5IEkgZG9uJ3QgaGF2ZSB5b3VyIHNhbWUgZGlzcGxheSBoZXJl
IHRvIHRlc3QsIHNvIEkgY2FuJ3QgCmhlbHAgeW91IGFib3V0IHRoYXQgcHJlY2lzZSBwYW5lbC4K
ClNvcnJ5LgpCZXN0IHJlZ2FyZHMKLS0gCkdpdWxpbyBCZW5ldHRpCkNUTwoKTUlDUk9OT1ZBIFNS
TApTZWRlOiBWaWEgQS4gTmllZGRhIDMgLSAzNTAxMCBWaWdvbnphIChQRCkKVGVsLiAwNDkvODkz
MTU2MyAtIEZheCAwNDkvODkzMTM0NgpDb2QuRmlzY2FsZSAtIFAuSVZBIDAyNjYzNDIwMjg1CkNh
cGl0YWxlIFNvY2lhbGUg4oKsIDI2LjAwMCBpLnYuCklzY3JpdHRhIGFsIFJlZy4gSW1wcmVzZSBk
aSBQYWRvdmEgTi4gMDI2NjM0MjAyODUKTnVtZXJvIFIuRS5BLiAyNTg2NDIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
