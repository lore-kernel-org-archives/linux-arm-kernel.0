Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD393C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:46:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9A721874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H9GziD/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9A721874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wATK5xGzabxFTFgY4MMgKw9SdyBDiVxtlXy2cKKjeTY=; b=H9GziD/UlrB7Zz
	sLyyAo2ajgaVBGlKbr3tQ2jSd97nQ0NOeOddiMvKpwhFIBKhZObnJbo7F9rCnKzSriVAxMz2TTk7E
	FrhzA9th4KHBFrOB/upykQc4axTd1O7ednnKBTzY0CK25s+AyaiDuCZCZxv7sALYMms2OxVuoZP7M
	AmlKMHi0qO2aQuF7gA1B52Y36EdxxI6PeGZXnbQ7oBIkYus5w5n0jx3I56tIpK4X2hSkrmOnfYQUB
	xKT6pGd7QM96TGmqaFoNhWff20Q8GiX2bucCJI1tsUCUQBeJLsNuA+SBUzVhs8uoDrJMB/sn9uJRn
	YwDE09kFrHD90Cn4zwkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0to-0004SZ-PB; Fri, 28 Dec 2018 22:46:36 +0000
Received: from mail-it1-f194.google.com ([209.85.166.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0tl-0004Rn-AR
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:46:34 +0000
Received: by mail-it1-f194.google.com with SMTP id g85so30117826ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 14:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=bia1DSQJOJtVsO3fjOIR2z0ks7WB4P2eqHofdaYMR8Y=;
 b=hPYEUUNCD/QSnBz/VCsyKPsCIuuznRpgqxXXyHGDRlXLIcXx+miRuNRXXNslH1geOf
 DHaDKAVf3eud1GZpIe9zfFKs524wk9qt3V0uN/TokyjnM21yoiXDxiJl0X/ThJXQ3l5P
 LWs4dIwE1i+T3PkDeA1OT9rgWkTRB+VfIa4BO6BUkq6uhEbAyVlvUu1rdicVi4qCSd8H
 y5nscg49HaM/qSlU5tPRhCy7Svx+Ti6+zc5pbIlfSjWb9a+WO6eOEM1S3jszNXnVUTDF
 iUePLdP1tyfr98zhTmxMs2SdJH1pPZuzmqwSDWYhytIa8ZxXH92QmovYTcstlLvREHTB
 yBxA==
X-Gm-Message-State: AA+aEWb6LN5DJJZE/qegbwowjtHlA7JkiAOiUmh4e1YFNDIzYwumFuVy
 YzqUOk8mjKa0384Le5pRZA==
X-Google-Smtp-Source: AFSGD/Vc6uu/sxiqUaz5m02XBHlOfHdh3n8LA/AbXPeLvsuLFQh8jTX5SOqyObWvP8JdGhK+1WFz1Q==
X-Received: by 2002:a02:49c9:: with SMTP id p70mr19366347jad.40.1546037182185; 
 Fri, 28 Dec 2018 14:46:22 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id i201sm19802030ioa.1.2018.12.28.14.46.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 14:46:21 -0800 (PST)
Date: Fri, 28 Dec 2018 16:46:20 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: gpu: samsung-rotator: Document
 s5pv210 support
Message-ID: <20181228224620.GA5490@bogus>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_144633_361931_3DE30692 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, airlied@linux.ie,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, krzk@kernel.org,
 inki.dae@samsung.com, robh+dt@kernel.org, kyungmin.park@samsung.com,
 kgene@kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyOCBEZWMgMjAxOCAxNjoxOTowMyArMDEwMCwgPT9VVEYtOD9xP1Bhd2U9QzU9ODI9
MjBDaG1pZWw/PSB3cm90ZToKPiBUaGlzIGNvbW1pdCBkb2N1bWVudHMgbmV3IGNvbXBhdGlibGUg
Zm9yIHM1cHYyMTAgc29jLAo+IHdoaWNoIHdpbGwgYmUgYWxzbyBzdXBwb3J0ZWQgYnkgdGhpcyBk
cml2ZXIuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5j
aG1pZWxAZ21haWwuY29tPgo+IC0tLQo+IENoYW5nZXMgZnJvbSB2MToKPiAgIC0gUmVtb3ZlZCBs
aXN0IGVudW1lcmF0aW9uCj4gICAtIFBsYWNlZCBzNXB2MjEwIGF0IGJlZ2lubmluZyBvZiBsaXN0
IChpdCdzIHRoZSBvbGRlc3QgY2hpcHNldCkKPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwdS9zYW1zdW5nLXJvdGF0b3IudHh0IHwgNyArKysrLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCgpSZXZpZXdlZC1i
eTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
