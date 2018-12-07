Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2144C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808F020837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A7UflSDx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrQw3MD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808F020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h5ckYKaMGsJWP4u9EOKXJeNFar1DlNSOOoAyuLm9ryI=; b=A7UflSDxoZDGnh
	aMBswKSP5vrCA8DNbVBZkg7oPMpIGfpUjJyhMnc2icceVITUA8YP2X0KlPx5h6tWkTg4O3GxTy6J7
	H75c0JcuhPeZDvue6nDzF9W5y3ElwSx+t0ffVxISek5GPTAaZNNzUuGWSPmnEFG8907d9tbISHqK7
	tCPceJwZ2I9YZQ5hzickm4noZYbDY0aDvcFIeQPxg0FY6wMx+XsweGj2G0QvQEolqb4QnKGFafibh
	xvgTECoqu4lWrJt4S7aMizvHNM5EkMtRNPrYiPM8fTb+A5QVbMAUqMxxmqKVzJVqwolJZq2lHoQnD
	mI29rqwkjwMGQaztR/nA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLiA-0006ZL-M3; Fri, 07 Dec 2018 19:22:54 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLi7-0006Wf-Oh
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:22:53 +0000
Received: by mail-wr1-x442.google.com with SMTP id r10so4789521wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ysP7s+sex9xFiYQskl1NZKqHcv3pRjBZq4JZULgpbZQ=;
 b=HrQw3MD3mSftAp84C823mWhToMqauyVqPok5egsGDyx1yWD5uKLcZ2VjnXP3vttp50
 PIxv6ZkOEEoHmY/JJhRomsoa+vIm5IMz6C8tphPp9wWJYClfAdUUxTG/mNU0gF6YP2sU
 fDKeMVGL5+S8FvOjs3MEQtXK3FUmTlxMcPgIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ysP7s+sex9xFiYQskl1NZKqHcv3pRjBZq4JZULgpbZQ=;
 b=huPuMQPZk9br7xymQcdeF013ss6hI9rgCHUiWXL+ZvWN9j9eO8HU5bU4oRUkhqBW0p
 SfU3Xlp0XgS/OI9rXw/OtmsSiqzEQQAI8swHI3bdnxCnsOCaAnOCpCe5g2EVHyiiyVQp
 Cq/xCVNxCGEmGi07cM4K1oUZwKNMxRXz+D3hpzmX93A/W7hxitC6KE2Ek7R+1L2idwPf
 jGkL5GA9MFmiLmhWUKZMDtEnTdlbbCpHZDWy18MwKKosF9gSkZHpADgXJWZWM7uNRpvT
 MLYksLH+SlOd4+dZgFqkN+E3DJ4V9y2w5ruCeXxpPj+nJLNpz+xr6VZpGN4SE4d6NHDK
 uQtQ==
X-Gm-Message-State: AA+aEWY3ug4rpfhmev7FRdX+zl9wN3kTufh9Dw3xEO3qQLnN4NjWqRSK
 7ssM2OhV6m0yqvYsK+2TYW4XTA==
X-Google-Smtp-Source: AFSGD/XgSLJ+aPCRJ1vvPs+V/kvW2Yaar9W232+gzsv5CllYbD3Ay/+B+tprZ72fnwUOxTYWyFzr/Q==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr2799896wrg.183.1544210559924; 
 Fri, 07 Dec 2018 11:22:39 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id p6sm2997172wrx.50.2018.12.07.11.22.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 11:22:39 -0800 (PST)
Date: Fri, 7 Dec 2018 19:22:37 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181207192237.GK26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_112251_815777_64CA7B76 
X-CRM114-Status: GOOD (  14.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, quentin.schulz@bootlin.com,
 linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAwNyBEZWMgMjAxOCwgVmFzaWx5IEtob3J1emhpY2sgd3JvdGU6Cgo+IE9uIEZyaSwg
RGVjIDcsIDIwMTggYXQgODo0MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3
cm90ZToKPiAKPiA+IE15IE9DRC1kYXIgaXMgZ29pbmcgY3JhenkuCj4gPgo+ID4gV2h5IGhhdmVu
J3QgeW91IHVzZWQgdGhlIHNhbWUgYWxpZ25tZW50IGFzIGlzIGFscmVhZHkgdGhlcmU/Cj4gPgo+
ID4gSWYgaXQgc3RhcnRzIHRvIHJ1biBvdmVyIDgwLWNoYXJzIHRoZW4gYnJpbmcgdGhlIG90aGVy
cyBiYWNrLgo+ID4KPiA+IEFsc28gd2h5IGlzIHRoZXJlIGEgc2luZ2xlIGxpbmVyIHNob3ZlZCBp
biB0aGUgbWlkZGxlIG9mIHRoZQo+ID4gbXVsdGktbGluZSBlbnRyaWVzPyAgUGxlYXNlIG1vdmUg
dGhlIHNpbmdsZXMgdG8gdGhlIHRvcCBvciB0aGUKPiA+IGJvdHRvbS4KPiAKPiBIaSBMZWUsCj4g
Cj4gQ291bGQgeW91IHBsZWFzZSByZWZvcm1hdCBpdCBpbiB0aGUgd2F5IHRoYXQgbWFrZXMgeW91
ciBPQ0QtZGFyIGhhcHB5Pwo+IEl0IHdvdWxkIGJlIHJlYWxseSBuaWNlIHRvIGdldAoKSSdtIGFm
cmFpZCBub3QsIGZvciBhIG11bHRpdHVkZSBvZiByZWFzb25zLgoKVGhlIG1vc3QgaW1wb3J0YW50
IG9mIHdoaWNoIHN1cnJvdW5kIHRlc3RpbmcuCgo+IEFDIGFuZCBiYXR0ZXJ5IHN1cHBvcnQgZm9y
IEFQWDh4MyBtZXJnZWQgLS0gaXQnbGwgbWFrZSBQaW5lYm9vayBhbmQKPiBUZXJlcy1JIHByZXR0
eSB3ZWxsIHN1cHBvcnRlZCBieSBtYWlubGluZSBrZXJuZWwuCgpUaGF0J3MgZ3JlYXQuICBBIHdv
cnRoeSBjYXVzZSBpbmRlZWQuICBTbyBJJ20gc3VyZSB5b3UgZ3V5cyB3aWxsIHdhbnQKdG8gdHVy
biB0aGUgcGF0Y2ggYXJvdW5kIGluIHNob3J0IG9yZGVyIHNvIHRoYXQgaXQncyBhcHBsaWVkIGlu
IHRpbWUKZm9yIHRoZSBuZXh0IG1lcmdlIHdpbmRvdy4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaW
r10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0
ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
