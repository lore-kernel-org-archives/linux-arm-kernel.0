Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D997C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:57:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E2620834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYKzZl99";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zUffdoHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E2620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rk39j5AyMW7H2EGayTlD7fVaLYhjKioMlt59BGHgotw=; b=gYKzZl99RuGjZi
	vUh7PGtTK9+88oIDmax/t0SiJmtDditjM36uEhhhUheJwW+C3QOofvnlKAyhtHaIgN3ie0MSCockE
	RU2nrI4KeFc40n9f4psdWt1vws80+1JI4IOkpsg/5ms60tzWtVKL16w+4Y1ZGBzrDbOZ/OJGDf7sX
	/WHbkzcPEqTISe8dKNa7Het1Jr5hJeOKwGVqkX3IstBeTglMQGWI/RggnVZaGr4y8/AuRbNV0DTYo
	6GZrs97Xpc9nQv8h+TWQ7IGb1dkf2Cs0rAaxN7TBzG4IEwiStrHudallL8hS283KlICrKRhWj3BUe
	SyP/BdGM4XFNjOfEakPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrjL-0004du-FQ; Fri, 30 Nov 2018 22:57:51 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriC-0003wM-SU
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:43 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so5229174lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dv+lFKbCmAybQ6mDm/SRDl5Vm6n7gtGnGhyHJ5O1ng4=;
 b=zUffdoHcGL2t1dzZPFdVjWs5avw+Uu/D95qytE3Jl+gpHHHwI/x5Tsj2dc0q21E0bn
 WEcKXFVJffCe0Nx/zKJFlB3yFxDGlfAVXlDe2CsKoJmSMVyLsHsMYWVDhvde84dYCHfB
 MuCRJjjIuZpfNsafsTDctnvrdX+FMLCbtW8OAhVZg48qJCTROQAZ5bcKV2c0mlnlR20y
 Scgc0elm/YyJFJcQgmu1LosUpACDTagnuoJjILDfwwgCav7sdfuIPm8jRScvO1vepOYU
 WF9hNZUzbRTt29Y8tofVr2wagSwCEty1m4fZpgSgD6Vdu/+ZqLD6d42cKPkNRV1f+EG4
 c7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dv+lFKbCmAybQ6mDm/SRDl5Vm6n7gtGnGhyHJ5O1ng4=;
 b=lcUFmPI2SIkQMBUcRmy6zbViOoTnjli4u64cYklDHqI/zQoMsmyCReCdSUkW91nrce
 8oHVp0nXLSNBsniqbVSssW1tNoVkJWWwQlzfYH7A310ynXT8IJxQ3+zvzsQPvhKnvV61
 trLVY9+dJfCCjFpIg5eB6JOBqslRKx2RP9QLVUcme9EZ+whkIGGnweSPMII87Gn0nBKi
 ECzY7W7WWCJd8aRROO9XFts2jDZ+w//3k4TRaOZaBYIV2EMvDnh4NLNQQn1FofJRjD5I
 UMsmtoWBwOeONDcvUOV6NI5Bl3x2fQZEHT/wUWCNolMs3/3lgUuCx8pT1q4mGbWEctRM
 g1Cg==
X-Gm-Message-State: AA+aEWYSCu2CIfoRFD/lQUs8CPIejpUPCuy+7n4ZTrFAiFYnR60TSiw4
 P7Ui1LuxNRkRqbROwt810jCBOA==
X-Google-Smtp-Source: AFSGD/VWFJFoOEZfPmBUIwLblwdD1e8D9XSJL/v5kV3EjjvBw0ZBh/Honpl31O7EIU2EPL/esbLJ8A==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr4489306lfb.121.1543618595457; 
 Fri, 30 Nov 2018 14:56:35 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id k63sm1035993lfe.13.2018.11.30.14.56.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:34 -0800 (PST)
Date: Fri, 30 Nov 2018 11:57:04 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] few minor fixes for omaps for v4.20-rc cycle
Message-ID: <20181130195704.rsgp7ytvvsz5uich@localhost>
References: <pull-1543518110-786840@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1543518110-786840@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145641_265004_0F10CC1A 
X-CRM114-Status: GOOD (  14.32  )
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

On Thu, Nov 29, 2018 at 11:03:07AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/fixes-rc4
> 
> for you to fetch changes up to 91e43395820baad80248987608216c35da9df65b:
> 
>   Merge branch 'fixes-dts' into omap-for-v4.20/fixes (2018-11-08 09:32:24 -0800)
> 
> ----------------------------------------------------------------
> Few minor fixes for omaps for v4.20-rc cycle
> 
> This set of fixes contains minor regression fixes for LogicPD dts files
> for MMC pinctrl and interrupts. There is also one section annotation fix
> that shows up with Clang, and a fix for an unitialized field for omap1.

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
