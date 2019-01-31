Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C368A218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHGwk2CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368A218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mMCt3LbMLr1VoS5sk2zWmLfVSLM4ey0IuV3t5wqvDnQ=; b=KHGwk2CSN7FCAT
	C5rc9PVMSFB3kVbEhnQcj5awjjf2xb+tpzK18K4cVHspyNocqdmNl09CbGjADZylPbrJiiGqhumbX
	vAHvyl3ztFDzJgK8eZb8V8xtVpRyG0MxShYyQLZ3bfkehjxTEZJQdxePVuhsB3Y1DSvHa4Wrjw1eq
	xiJ+wbO5ImKeHqDLn6Rkob1Zr7Q/bTnm4lD5ph9feftZIu3FImO+9tiOOCa/VdGZ07blypjO/2quk
	+LWfRk6kS4alVZo14Hxqma2d0l8H7uVFWB9Gmn4/h8YLe0aIk9rd2f2Pjts03POUVRh5mHfZ2OAr8
	zu1cmBH3z08CDuh3WpmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCL1-0005nA-GC; Thu, 31 Jan 2019 13:25:03 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCKw-0005kM-ND
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:25:00 +0000
Received: by mail-lf1-f68.google.com with SMTP id a8so2312391lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=e1Bd1cCVqTtCOw27nTYpAu2mxybnfDj+re/fe+Iiy0g=;
 b=jNeuRh5wfcrP5klFi0eyZYxrV99NJwbDTXjHgU5aAXV21jRJXenniBsJyjET0BeKA1
 xmVu2G8RlzztYfv4xmyzVr3oTYO19BNeXUeDngD7vnKGgBN2ubRQSHXOd4rgpsN/+MJe
 DKBzVccmmMVXLGwWqHcgakdZYF5iowileB7gU8HAsqDC4Dq4xoe9yogYRA2vtRn1fTqM
 CkPhYmpUtfeR/KXkTHroh+SYfWrtmVpTG7ek2lUszHLLWaiLxT1DI7PP0GZRFVPAcS0z
 XF7tSbdOXtMMCbaLu9syisvIXXAdqoNv7VELSThOdUD2ObTI6EK+7cnIToL0MEISIoLy
 MnDQ==
X-Gm-Message-State: AJcUukez0SmBfcMEo3YD72jUVPG6oAngVoujnPRNBGW23bh2W7/ikpqR
 rCNj5AaIHK+uIsWjA+7Ecig=
X-Google-Smtp-Source: ALg8bN4efzqtBk1zd7HtH/kCne6U5aCoxdZyUXqayOQqlVDcECcmH/i/TG1Cqmbq+QuGZ7JWafBieA==
X-Received: by 2002:a19:e601:: with SMTP id d1mr29038753lfh.71.1548941096383; 
 Thu, 31 Jan 2019 05:24:56 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id a2-v6sm803332lji.13.2019.01.31.05.24.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 05:24:55 -0800 (PST)
Date: Thu, 31 Jan 2019 15:24:52 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, corbet@lwn.net, cw00.choi@samsung.com,
 krzk@kernel.org, b.zolnierkie@samsung.com, mturquette@baylibre.com,
 sboyd@kernel.org, linux@armlinux.org.uk, pombredanne@nexb.com,
 sre@kernel.org, vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz,
 sjhuang@iluvatar.ai, andrew.smirnov@gmail.com, djkurtz@chromium.org,
 akshu.agrawal@amd.com, rafael.j.wysocki@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <20190131132452.GD23791@localhost.localdomain>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_052458_773393_E4FD1E9E 
X-CRM114-Status: GOOD (  16.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello All,

On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> Series adds managed clkdev lookup interfaces and cleans few drivers
> 
> Few clk drivers appear to be leaking clkdev lookup registrations at
> driver remove. The patch series adds devm versions of lookup
> registrations and cleans up few drivers. Driver clean-up patches have
> not been tested as I lack the HW. All testing and comments if
> driver/device removal is even possible for changed drivers is highly
> appreciated. If removal is not possible I will gladly drop the patches
> from series - although leaking lookups may serve as bad example for new
> developers =)
> 
> Changed drivers are:
> clk-max77686 and clk-st
> 
> Please note that the patch #2 requires this change to work correctly:
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570

I guess the dependency mentioned abowe is already in (most) of the
trees. (I can't say for sure as I don't know what is the correct tree
for clkdev - is it linux-arm.git as Russel is maintaining clkdev? If
yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
"clk: of-provider: look at parent if registered device has no
provider info" seems to be sitting in maser branch).

So should I rebase this series to some other tree and resend? Or is this
something that is not wanted?

Br,
	Matti Vaittinen

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
