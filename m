Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0303C20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TuftuC9F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2DQ30sR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0303C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+XfMODwZeq/kQltO52GLnaPlcrEJW5bj4LyVEH3RHQw=; b=TuftuC9Fklz2M6
	thsGW34SWD6F2lyFfh3XjDae7KY7EJNPIHgRQbzgeAuHC3+unvnn2K+FAIpeXtyQawgMD1CdmG88J
	8ZQEQIdx7ONuKpQEI4Un73IZXLugbavjFIHoAxA6Ke+nZ4GutzTRsuo0pvccTNL0US0nuKL1V6SNh
	PQ/UWIQCq7uLIzPfXOxDb9vCBJALVtlvdC//5I6BjetZnRB2fs+vbXpE3ptrfGpsbNaJwxEIY6yrX
	KUI7yTGQgJOrOijgjovIX3agc/0BZ+KQTYi1DIhY0hDzF63l6c7OVGq/3b1ZaZX5Any1E4oQL5+T5
	9QvSXxxBgo9hCnA/uGzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8Xp-0005aY-H5; Thu, 03 Jan 2019 19:20:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8Wa-0003Je-AI
 for linux-arm-kernel@bombadil.infradead.org; Thu, 03 Jan 2019 19:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TTnlFRMC/tE2y0XboP30PxCpwrUWxCmg8uvckIQqldo=; b=r2DQ30sR3iQDc7p0BkFhdHEqJ
 c1u0bSzaUvm0FI3DeTkoRGZwfyb4x6sGD0SeUBHEggDMr3ApZgqp5+pP9zPeT71XuzJKGzOatDLoA
 jGZnZpoRYObv7gVeVl6bvDMMXkx3tEPpjWB+5bWlVv5Acvft5siALPX22TbOFCjWtGUTdY9HzKTkp
 urhmjJ6K5Q877uc9YGUmtI3SopxBmKj9VgFvu17OjtXXH4gi547Lj+h//tCyrPKVI5Thw5YNzka70
 ELJPWRuA5M45bvQRIKBO4GnVRpDTy9a8OTLR8MjW3/my55ZwfcPh9OxZhTLx3tdbfR4RjBsjl8/ij
 psvBNk0Ew==;
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8WX-0007eR-BZ
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:19:22 +0000
Received: by mail-it1-f196.google.com with SMTP id w18so46784553ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 11:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TTnlFRMC/tE2y0XboP30PxCpwrUWxCmg8uvckIQqldo=;
 b=V8ZwiEALTQ4gTigSbB+2OOuG2XtsnlmoGw4J/es0JBbnpl7OsHMd4UW1YHWwcn5ZmK
 Df+sSdzk18cQOL+ZFNGqGEF3XgmKnb/e/y/0616DZVPogLU9uvzjtAEo42Q+PectBTly
 /V8okT5LAp9HRI2Wdf7pSRo3pSOHYKWcabKsEwrWJvOCZhoelg8k8pFG75I5gx/8uQz6
 E2jfoCbG/diLyS8Jv10OaD6j509A5ffUluyhnEu+TkYV0Jp+E8np1/9/r2JorGM8sYj0
 DvDjn+XdYNnFWYbQ8oLAIKj0FGH1BRCOt23ymklUNNI9Xo70G+hSpl9NolFXq6Byvq9Y
 u0NQ==
X-Gm-Message-State: AA+aEWa+wrQWImSUPwmrFW8BaWUYVaz/hZ37MC4y+1EAaGK1njyhaVLG
 DzQbhePaeJSFvywFaq5GMA==
X-Google-Smtp-Source: AFSGD/UZEMhiT87aOENfaKWdNgM8dBWqIqypxNoZvZL5hB4KxZ576H7iGUkjGYuBCQHbvaAodjKt3w==
X-Received: by 2002:a02:b093:: with SMTP id v19mr34616129jah.64.1546543159424; 
 Thu, 03 Jan 2019 11:19:19 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id t11sm6652270iop.88.2019.01.03.11.19.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 11:19:18 -0800 (PST)
Date: Thu, 3 Jan 2019 13:19:15 -0600
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Message-ID: <20190103191915.GB6613@bogus>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
 <20190103174117.GA6613@bogus>
 <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_191921_412504_ED383C98 
X-CRM114-Status: GOOD (  29.83  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, p.zabel@pengutronix.de,
 linux-kernel@vger.kernel.org,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 10:53:25AM -0800, Florian Fainelli wrote:
> On 1/3/19 9:41 AM, Rob Herring wrote:
> > On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
> >> Add a binding document for the Broadcom STB reset controller, also known
> >> as SW_INIT-style reset controller.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >> new file mode 100644
> >> index 000000000000..6e5341b4f891
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >> @@ -0,0 +1,27 @@
> >> +Broadcom STB SW_INIT-style reset controller
> >> +===========================================
> >> +
> >> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> >> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> >> +reset lines.
> >> +
> >> +Please also refer to reset.txt in this directory for common reset
> >> +controller binding usage.
> >> +
> >> +Required properties:
> >> +- compatible: should be brcm,brcmstb-reset
> >> +- reg: register base and length
> >> +- #reset-cells: must be set to 1
> >> +
> >> +Example:
> >> +
> >> +	reset: reset-controller@8404318 {
> >> +		compatible = "brcm,brcmstb-reset";
> >> +		reg = <0x8404318 0x30>;
> > 
> > Based on this address, should this be a sub-node of something else? Or 
> > not even a sub-node and just make the parent be a reset provider?
> 
> The reset controller is part of a larger "sundry" node which has a
> collection of functionality, from pinmux/pinctrl, reset controller,
> spare bits, chicken bits, anything the designers forgot to put somewhere
> else and decided to put there.
> 
> If there is one thing consistent though is that given a set of 32-bit
> register groups, they have a self contained functionality such that you
> can break up the larger "sundry" space into smaller sub-blocks which
> have one an only one functionality. Do you think this warrants a
> different representation in Device Tree?

With pinctrl in the mix, you're going to need sub-nodes anyways. So just 
define what this is a sub-node of.

Also, I'd prefer to have complete example for the "sundry" node and 
child nodes than partial examples spread across the tree.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
