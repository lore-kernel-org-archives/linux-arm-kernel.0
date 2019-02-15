Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A0C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399F8222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GvmV8SdJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFe2uN8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399F8222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iDAUGT8K1fRAwLRByoij+n20VwZsreUXbv3+ZmZA/Vs=; b=GvmV8SdJUv92DR
	IZwk7YAH2MJzRuqIIU52GrpYQAkVAA5cZQuXRKfIfSZltaMP8eBgJTev6QOemeF6TTlcxDVESzerM
	oYxUV6u6Ofz2MdolbWZTr/nK9wZ0DAJcRIy8seJLEF0WpCjmhFZfr7FMez4ggJT+N7tD7zcWhZdUX
	bbQfiwh5Xph7p3aEEN5vmu1WarmugpaHJ+vbadrxDiVLiPfISz/i6mRuhoJjTXwcDCMrZ6UyHdZZY
	o1I6A8+/1ZOV90OVGpGIqu6SpWi2MtL5kqL3DpkxYITLcORw9t+Ee+NM5bOknWlwOL4flX3b6x4V9
	FV4+e+rOclne9u8byZpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugU1-0006Ln-DT; Fri, 15 Feb 2019 16:37:01 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugTy-0006Ky-Jv
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:37:00 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so7040347wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b50v4gkFnVmonWGqMazeGfYePiU2OL+eyb3iaY7R2HU=;
 b=aFe2uN8itO/fZ0aJEf7BGE1ZCCYRzwnYrg8B9xEJD/IDEaUL5nM4dNC0u9YIL9XdbP
 dLuO1oDhhBiOrue0bjnjuKfd/UlzGUvwrrm86QjlqeUG5iUC+q3zxiw1yQMNX75KTQOI
 ewuRdm1C4JN4EKHoxhQSdmHrSYDsoP3O40LfWv3k5T9QVZbm6YMngDpdsmKRol+rJUDk
 HgV6jgIczNcbu69u5UCXTBa2q03te9jPF1I761iSozfNmENbQpvG+UM2M/UVBFqfI81F
 cNFgeHYSg579SGem0cjtjP5yly+3OhTrsVRg7Vn4xUX8gjYH1arZbEiX022l10xwaQ7h
 PyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b50v4gkFnVmonWGqMazeGfYePiU2OL+eyb3iaY7R2HU=;
 b=ERXV5g67b3GL1kitzczwYNAolGDvc/HMTeYoepD9ru+LjoLrLlHJMoJ7fxGA1yW90s
 7qC7gxXhriSCr1cFwhKCqlDmhZZz3j0KDDZVIctQYQlL+TQ7c+usp5aH96PJc2lEZP3v
 FoLQXL5j77SZspjdyeHr+vz4SbKU5MLie77C8CdAoPnw6VuFBm29yTdFBsIMbN3YghWf
 z+BkGhHml+KJuMhh6+pxQwEOYrkKB+mhp1/s4Ted+ppSU7jmcRsrBZsHZ2SpppxgXhtE
 DZcSy6fmuL6FMl/0CnpiKLF1zf6o0Kt7syeQGInWK+i76iOai08xWIOHdXLhaopbS3De
 AJog==
X-Gm-Message-State: AHQUAuZYAGZxEojU11MbiKXsJkTJdKgwXipDM3MJEcUcUFw/lgNz411M
 w7vbdEhVNE21dN4rhLJKo2emtg==
X-Google-Smtp-Source: AHgI3IZCK9OcUMC7vP2g6ubQt42SY72+dyQdVq6JM7c33bjGUkXtAkJLR9a1b5Wfjrved8JiNEjgpg==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr7420326wmq.104.1550248617004; 
 Fri, 15 Feb 2019 08:36:57 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id o5sm19100299wrh.34.2019.02.15.08.36.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 08:36:56 -0800 (PST)
Subject: Re: [PATCH 0/5] Exynos SoCs: enable support for ARM Architected Timers
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <CGME20190215125238eucas1p2f56fe48600aedcec048bc378ed184419@eucas1p2.samsung.com>
 <20190215125229.30180-1-m.szyprowski@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ca4d33bf-aad8-5a6a-7ff5-0d6d1633045d@linaro.org>
Date: Fri, 15 Feb 2019 17:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215125229.30180-1-m.szyprowski@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_083658_656288_D9015843 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CkhpIE1hcmVrLAoKSSB3aWxsIHBpY2sgcGF0Y2ggMSBhbmQgMiBmb3IgNS4xCgpUaGFua3MKCiAg
LS0gRGFuaWVsCgoKT24gMTUvMDIvMjAxOSAxMzo1MiwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToK
PiBEZWFyIEFsbCwKPiAKPiBBUk0gQXJjaGl0ZWN0ZWQgVGltZXJzIGFyZSBwcmVzZW50IGluIGFs
bCBDb3J0ZXhBNy9BMTUgYmFzZWQgU2Ftc3VuZwo+IEV4eW5vcyBTb0NzLiBTbyBmYXIgdGhleSB3
ZXJlIG5vdCBlbmFibGVkLCBiZWNhdXNlIHRoZXJlIHdlcmUgc29tZSBpc3N1ZXMKPiByZWxhdGVk
IHRvIHRoZWlyIGluaXRpYWxpemF0aW9uLiBTYW1zdW5nIEV4eW5vcyBTb0NzIHVzZWQgY3VzdG9t
IHRpbWVyCj4gaGFyZHdhcmUgLSBFeHlub3MgTXVsdGlDb3JlIFRpbWVyLiBJdCB0dXJuZWQgb3V0
IHRoYXQgZW5hYmxpbmcgTUNUIGl0IGlzCj4gYWxzbyBuZWVkZWQgdG8gZ2V0IEFSTSBBcmNoaXRl
Y3RlZCBUaW1lcnMgd29ya2luZywgYmVjYXVzZSB0aGV5IGJvdGgKPiBzaGFyZSBzb21lIGNvbW1v
biBoYXJkd2FyZSBibG9ja3MgKGdsb2JhbCBzeXN0ZW0gY291bnRlcikuCj4gCj4gVGhpcyBwYXRj
aHNldCBlbmFibGVzIHN1cHBvcnQgZm9yIEFSTSBBcmNoaXRlY3RlZCBUaW1lciBkcml2ZXIgdG9n
ZXRoZXIKPiB3aXRoIGEgc3RhbmRhcmQgRXh5bm9zIE11bHRpQ29yZSBUaW1lciBkcml2ZXIsIHdo
aWNoIGlzIGtlcHQgYXMgYSBkZWZhdWx0Cj4gdGltZXIgc291cmNlIG9uIEFSTSAzMmJpdCBwbGF0
Zm9ybXMuIFN1cHBvcnQgZm9yIEFSTSBhcmNoaXRlY3RlZCB0aW1lcnMKPiBpcyBlc3NlbnRpYWwg
Zm9yIGVuYWJsaW5nIHByb3BlciBLVk0gc3VwcG9ydCBvbiB0aG9zZSBwbGF0Zm9ybXMuCj4gCj4g
U29tZSBvZiB0aGUgTUNUIGNsZWFudXAgcGF0Y2hlcyB3ZXJlIGVhcmxpZXIgYSBwYXJ0IG9mIHRo
ZSBzaW1pbGFyCj4gcGF0Y2hzZXQgZm9yIEFSTTY0LWJhc2VkIEV4eW5vczU0MzMgU29DLgo+IAo+
IEJlc3QgcmVnYXJkcwo+IE1hcmVrIFN6eXByb3dza2kKPiBTYW1zdW5nIFImRCBJbnN0aXR1dGUg
UG9sYW5kCj4gCj4gTWFyZWsgU3p5cHJvd3NraSAoNSk6Cj4gICBjbG9ja3NvdXJjZTogZXh5bm9z
X21jdDogUmVtb3ZlIGRlYWQgY29kZQo+ICAgY2xvY2tzb3VyY2U6IGV4eW5vc19tY3Q6IEZpeCBl
cnJvciBwYXRoIGluIHRpbWVyIHJlc291cmNlcwo+ICAgICBpbml0aWFsaXphdGlvbgo+ICAgY2xv
Y2tzb3VyY2U6IGV4eW5vc19tY3Q6IEluY3JlYXNlIHByaW9yaXR5IG92ZXIgQVJNIGFyY2ggdGlt
ZXIKPiAgIEFSTTogZHRzOiBleHlub3M6IEFkZCBzdXBwb3J0IEFSTSBhcmNoaXRlY3RlZCB0aW1l
cnMKPiAgIEFSTTogZXh5bm9zOiBFbmFibGUgc3VwcG9ydCBmb3IgQVJNIGFyY2hpdGVjdGVkIHRp
bWVycwo+IAo+ICBhcmNoL2FybS9ib290L2R0cy9leHlub3MzMjUwLmR0c2kgfCAxMCArKysrKysr
KysrCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczUyNTAuZHRzaSB8ICAxICsKPiAgYXJjaC9h
cm0vYm9vdC9kdHMvZXh5bm9zNTR4eC5kdHNpIHwgMTAgKysrKysrKysrKwo+ICBhcmNoL2FybS9t
YWNoLWV4eW5vcy9LY29uZmlnICAgICAgfCAgMSArCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvZXh5
bm9zX21jdC5jICB8IDI3ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICBpbmNsdWRlL2xp
bnV4L2NwdWhvdHBsdWcuaCAgICAgICAgfCAgMiArLQo+ICA2IGZpbGVzIGNoYW5nZWQsIDQwIGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJv
Lm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoK
Rm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZh
Y2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0
cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
