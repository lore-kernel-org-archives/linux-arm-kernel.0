Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F02C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01BD20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKl3bbDr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="LCe1LfLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01BD20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Op+/gXcxZ2arWRERIyF/NfSN92xjtGCL/MIjA0VJNkg=; b=qKl3bbDrFjK8Z9
	UOb23jyMhBu+n4EQBcH4M3fzO6tizP9k2SHQW3tSWuB7bYEO1/KOSNrSeMlS5vwclLt3xuHfNkYA7
	2rWhHzQI9bwjbsBzyQbDyW0raqWn9NkXnxY81DFkGxZKWVPqQUPiJ/7b3+BCf9UJf/MMJVDjLdN2z
	0GsWaDk1W4XVTue08Aw9TbMzcBsw4l2kch8uDT41y34NOsz1YZQo9Q46X0jsbdaOQvbf+MkEUV+K7
	9/zzTOkhBdPL4+gCagHHYQxOSOnjk++moea0LZZgZ1O2IgAJtdr9Nu7Ka8IYVgrtpA/YOpIDqvD0v
	/znnS4JA+cIeadTIq7AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsjI-0007nT-Ll; Sat, 01 Dec 2018 00:01:52 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfB-0002Z9-T0
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:58 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so6487146ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tVLqHFr+D8qKqnOJ9/znNUdp79pLz7SRhILVPFSZg30=;
 b=LCe1LfLbGd+wUAZbJP+lxpJnHz5AMN31aU3UhsnTA1kF0aXPqxBhY2X8SGg7ZWXwF4
 3exdpQ0fXokdldT1dfCTF1NJXgCRGusjlKzQo2u7HqsCK51Ypv+kamNGDL8TvgBSSzUz
 R3I398U5IuMLWUlozCZMFfv6y898ZwpaRWcgcVyDOTui/QDc8fmBx3BltQ01aFV/ShJb
 cs4rCFNm1S2XiYyXUbpLyw9vO/bhzxR8ZW9+X97fRDW/4YL/Ls1gvkDYk7YZUsDYm01a
 mob9S4Kz6dl9fkYakEiOTa7eC8txaEfhLnugOudH37eOJRpDzqzKvKE85HBBsizJ3ERM
 t1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tVLqHFr+D8qKqnOJ9/znNUdp79pLz7SRhILVPFSZg30=;
 b=myxMCSt01YG+LKPahejt+632vZ37vocAZ4MBqxa1FS6ozYgOostClAMAWjfH7QsbCP
 eHQKT73/mRlzW6mR2tp8715TLP1dTa1NO+rYwIqMkbc1Is/lp7eFdUUJCwg9rINuNMtT
 bcsQ1usJTh9o5uwZJxpbUxs6yF8mV1s8NWqRFW4R1k7V/KrXBQ+0h0W5CBkmLMDdTCmu
 mXbDY9uodTMl8VQyYsPSvaJNUXS0ma7xEGbU847QlQJob+O/io+a7wGLB7UT6FiZ4GGs
 p0jTPIJSNoqKAkVbPsScUbuRxrI2nFaq8ahVXyiRM/O47OoGHoK1my1AUTfofAxylz7W
 XOaQ==
X-Gm-Message-State: AA+aEWafUd0pa0qYkTmKS+1bfqL+EiysvMu/M/emIaR7RfD2gZqsfX7G
 lHDp4WoM9vp32pym7n336VQ5fA==
X-Google-Smtp-Source: AFSGD/U79+7vx2l7Ck6m//i7NMxzc4BFDNmgnLzEHb1+1FTt4SeF5sOG6ghmyPYlb1dD8+xtDfGmQA==
X-Received: by 2002:a2e:2b11:: with SMTP id
 q17-v6mr4961964lje.25.1543622246000; 
 Fri, 30 Nov 2018 15:57:26 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id k21-v6sm1019794ljc.15.2018.11.30.15.57.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:25 -0800 (PST)
Date: Fri, 30 Nov 2018 15:50:08 -0800
From: Olof Johansson <olof@lixom.net>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] Amlogic SoC drivers for v4.21
Message-ID: <20181130235008.eo6vnggianvttrfv@localhost>
References: <7hwoov8vbu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hwoov8vbu.fsf@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155738_912163_0C721DD2 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 12:47:33PM -0800, Kevin Hilman wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers
> 
> for you to fetch changes up to 2b45ebef39a2caad409f70b22b4a2a41df9815b6:
> 
>   soc: amlogic: Add Meson Clock Measure driver (2018-11-28 16:55:35 -0800)
> 
> ----------------------------------------------------------------
> Amlogic SoC drivers for v4.21
> - new clock measurement driver and bindings
> - COMPILE_TEST fix
> 
> ----------------------------------------------------------------
> Maxime Jourdan (1):
>       drivers: soc: Allow building the amlogic drivers without ARCH_MESON
> 
> Neil Armstrong (2):
>       dt-bindings: amlogic: Add Internal Clock Measurer bindings
>       soc: amlogic: Add Meson Clock Measure driver

The patch description has a few typos, and it would sort of be nice to have
a better Kconfig description of the option (and maybe something at the top of the
driver too)?

The overall question to answer is the "why": What's this driver good
for? Debug to verify that the clock configuration is correct? Something
else? Etc.

Merged, since the above can be fixed incrementally. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
