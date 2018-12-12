Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A8C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:23:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82E020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ntr4RSI6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="uU1JrMPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82E020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AHL0P96x3hVER3a4SpBCvBTQXTQETUgKBjfa52JNGCI=; b=Ntr4RSI6LAC7hs
	I+DiNQGaMBSTEIhGoAXLAbGZIeQzbwcnaH2x5e6dlgJeiGgb8i1OJ4UGdcVjOH6/PQn3WsCeJv6MI
	xjD53QCeC2iJ7KPzNmfay3rXRacz2klF43wYjQ5O7MqYsYffrsh7SMh69ifDNI1lM1jw5+UmmySAM
	xRXZuNFZjdnQgpDGZN4J1S/VGyk08TM1u4jpJTNzPHo+M0770bVKI/HBz467OuAMzOfsnww4zBmUr
	zknlCv3gnPnZN93EVheQ+d7J9x9UkKsB0Nm2X4ph/P2SWCBj6/OisTKJC1cICd0mkUtICZNoencWh
	h9skCJ2zZQzRRoXdDVaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCuq-0005xE-Kb; Wed, 12 Dec 2018 22:23:40 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCtT-0004i3-M0
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:22:17 +0000
Received: by mail-lf1-x142.google.com with SMTP id z13so14769788lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=i9Uwm79Trqj3OISBKe/CrmuNTwnT9ZfJb8EeDFdqxk8=;
 b=uU1JrMPIkFk9VOiTp/y02o0/oJw4Oo49otaTKGnDU+K3uihKdDkCrrySEulcV6azpL
 Fzu1uaWYAx0VE542EworGk3qa/3wcWz2FXWZGVQDLb5fH3ISHqLHxRnWy5sSJuHy7/sa
 bofuu/kT8rc+zckZyt1kdqyFB5z/E4AHWu4pUt7o2bQU3ZZNx37icCY3wNk1qhnQNBQ6
 IzQmUojtF6LE/8yjklMiRN6TBlJuEZcgvN4aEolHH6NnTYT1g1MI/90BZXHXg/BclYm7
 Ht4Y1lw9Q9VbCtMDcIQdbrrVP4WlVqk3iNpkkJ+cCdWrzt2L+ZWmDwYIlIPgnz7a+BTI
 eMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=i9Uwm79Trqj3OISBKe/CrmuNTwnT9ZfJb8EeDFdqxk8=;
 b=jaufl4S8C48plPnZnS0Z8P49E3c7waiuh9WGVeyFEAF7x8+txe2S2h4fG1ZDYTgdtr
 1/GhQwN7JHB/x89pO0conMhH2PD5X2AbpXGn6eRd7DF1nCBeaR+hiFSv2IErtJhWfD+g
 SjhXnstlgVQL90TXoeMGWEkabMIDl7yo5PZcbh9q18jh7TWW1/7SkfkIXGjK9Sicwwm1
 fkKeb7DcOjvMLM1m2IXD4xg3nn1Mfo2JA1sz3O4Ioh7CDXhpMYDd4Lpnkq9MItCUZqT/
 Q5s3tCGQlxQJ9M+N+Uqjzposx2R8hODLeI06q80dchyityNHgwlAVTXveNmORomz3jP8
 O1ww==
X-Gm-Message-State: AA+aEWZwOTp1RJ97KoPgF77BbYOiGKtGu6fEQ+Y6mD8qlawBupzQGb/s
 xSyVtln6vRwE+lVVAQteptRWwg==
X-Google-Smtp-Source: AFSGD/We23GVbPBrB2jpvwemEO97b+Nt5VkV/5jXafRJrZH4qD2BxgsEFCQFTLLat8ABlTc1Y8Eb7Q==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr12546196lfd.90.1544653323716; 
 Wed, 12 Dec 2018 14:22:03 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id v5-v6sm1405lje.78.2018.12.12.14.22.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:22:02 -0800 (PST)
Date: Wed, 12 Dec 2018 14:19:54 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] few device fixes for omaps for v4.20-rc cycle
Message-ID: <20181212221954.sg3pfw7wyujckej4@localhost>
References: <pull-1544543892-150996@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1544543892-150996@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_142215_772942_934A63B0 
X-CRM114-Status: GOOD (  17.31  )
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 07:58:47AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 91e43395820baad80248987608216c35da9df65b:
> 
>   Merge branch 'fixes-dts' into omap-for-v4.20/fixes (2018-11-08 09:32:24 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/fixes-rc6
> 
> for you to fetch changes up to 84fb6c7feb1494ebb7d1ec8b95cfb7ada0264465:
> 
>   ARM: dts: Fix OMAP4430 SDP Ethernet startup (2018-12-07 09:10:49 -0800)
> 
> ----------------------------------------------------------------
> Few device fixes for omaps
> 
> Here's a collection of minor fixes for annoying usability issues
> people have noticed using various devices.
> 
> There are two regression fixes:
> 
> - A regression fix for omap5 usb3 dual role mode
> 
> - A regression fix to ams-delta audio being muted permanently
> 
> And two one-liners:
> 
> - Fix polarity for am335x-pdu001 SD card detection
> 
> - Fix non-working omap4-sdp Ethernet startup for rebind
> 
> It would be nice to get these merged during the -rc cycle if
> possible. Naturally these can all wait for the merge window too
> if we start running out of time.

Should be fine, merged into fixes.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
