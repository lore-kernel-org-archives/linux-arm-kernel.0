Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE1C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60DD20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mI+/gmOg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JL2dF2r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60DD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uxQ3j3ToeuyvU6r0Q9bDf50YO3mbc9Mo+v/w5odN1hs=; b=mI+/gmOgtkL7Fv
	SjX3yX3iJWuoU1SuD/scr6+4m4MallAEgSfLekU9HJr53umc9PRfuVq7+ZSORp7i30VgWClOIhcnX
	IN3cOZCWDjTm0XVqNfVI+m3ORWWOrQbZj97J47iFue1Nf2rjDlVEfndFqd/sHVM6TrA6pGosqnu+i
	YyAw0b8iK9hi57nRip+fvf7EHbEKHGrHqt4NHax/MZVAsx+R4OMY7g3+Kguy/147kG0tuae/7saps
	79Ewp95UMz5UzgurnVP76tSmfiD5sieAxQ6uyidmuDTv+PH29z9g+3jqyoSCfrodX8M0S2IrlMXl4
	9++hGpwHKZfZ84JuIYtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBqP-00051c-RV; Wed, 12 Dec 2018 21:15:01 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqM-00050L-Ml
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:00 +0000
Received: by mail-lf1-x143.google.com with SMTP id a16so14679063lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZhsdFHisOfvS/XFIwZg86JpS2l402ol8oG7QKrGx8PM=;
 b=JL2dF2r6ijCKmk6PBLWyDgeCCjb7dmWekRIde9sP04vHOeL0lM1v7hfitNmTD3PiBp
 WeqTxdYrDHK/HR1WhZ7HbhewQsWQsPwJIsIJeEI3qykceE2G1EJTmzf03S+Uj1TelOgy
 7mqjsRzI7J7iSXNY1AZxsBhBYuej3fKQ6lIOxUJmuxXkx4UwCGVwz+uycSfhorzeMW+/
 LJ5EzrKHRgrlDcIRPud3MGaRYT+pVAkId7W2i7CdKOFsKfMOJZnPj+cWmzsJr2F/lG+k
 dXck1UYbZtQk+W/KhZU0ztXa6dF8YPvYfdrKPU3x7bTOwk7/InMzl/norlP1ByFLUAiP
 qrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZhsdFHisOfvS/XFIwZg86JpS2l402ol8oG7QKrGx8PM=;
 b=szfDMtht8lfVFbfA8V7SImjvWPZJlwVW4h0ul4NmnMT3I81BBsA5PR0hu3hZyMkXbf
 gzeSVHs8HW/cNckqsGCXbDRUqcNhRCyqm/+4hof4ci7A1+8BX2yiloHtXFRUvATNiLue
 sc4Z/wB3VvoBTdlaz2IpNsD4wBDuXY/cWpbiFB9somyZ0nQhK4x268/rWvGrL8PDB8zv
 74f6jyUAPBarwBmJ7MDjVdOlYN6kPap8+z5cOEiE1VX916ACjVBdkSDLqgxkEaQ20CAd
 1pO+M8awQvKuzgRJXzNJEcvSr8lU8gCcog/ndaEqe5CZfJehKnh07Opazy69TeFEbijg
 2zwA==
X-Gm-Message-State: AA+aEWb1ZT9N0Ae/hYc64/B1Jb1J/eHMW4ZF8brcRqSckR1612RFH1FM
 GILHW4pxWEhWel/4loqUfDb+gg==
X-Google-Smtp-Source: AFSGD/VmO2+Q0KuLRawRlRVnmlFYD6KLNSDYY+YWdw5uyJwr/jOPmkVfF7NinNx7AT+vioyzck+mZg==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr13327820lfb.132.1544649284823; 
 Wed, 12 Dec 2018 13:14:44 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e94sm3456870lfi.23.2018.12.12.13.14.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:43 -0800 (PST)
Date: Wed, 12 Dec 2018 12:49:47 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner DT changes for 4.21
Message-ID: <20181212204947.vycnz6mciy343cps@localhost>
References: <20181207143848.m4ti5c3ulxpjz5pf@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207143848.m4ti5c3ulxpjz5pf@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131458_878551_6B17315D 
X-CRM114-Status: GOOD (  18.44  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:38:48PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.21
> 
> for you to fetch changes up to 5719ac19fc32d892434939c1756c2f9a8322e6ef:
> 
>   ARM: dts: sunxi: Fix PMU compatible strings (2018-12-07 15:34:24 +0100)
> 
> ----------------------------------------------------------------
> Allwinner DT changes for 4.21
> 
> This is a quite big pull request this time, with a huge number of changes
> (and patches) due to us fixing the vast majority of the DTC warnings our DT
> had.
> 
> We also have a bunch of other good, more meaningful, changes:
>   - Support for the new Allwinner T3 (rebranded R40) and f1c100s (armv5)
>     SoCs
>   - AXP803 PMIC AC Power supply support
>   - Rework of the oscillators tree
>   - Two new boards: the t3-cqa3t-bv3 and Lichee Pi Nano
> 
> Plus a few enhancements here and there.

Thanks, mered!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
