Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA8C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AC52064A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbtIOjdR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lbGkUY+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AC52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ujgbXir6AXAyAoOaVtdXdZM3BUwOiI48fwWJVDlczVU=; b=fbtIOjdRP7jnZd
	s/L6bZhIgxH/6eseuQKxnHXmUMkeUp+PLaBx5f4e7CC0+0h965OwDMl6S6Qjq4mTD4BWh7/4vIrKT
	Lpd3PCiY2rbzgH2k0mfuC2Z98ZWqDusXoMVkFQM3xh6pbAoiGKqicBUSUKk4VAkKHRgxcBwHGh5as
	8DvWnZbQLENfg1/sWLEySUtulWtEyJWc/8EtBcx5CfNi9JVmjagA0EJsMTrBwHWnogeQskCJE8fMj
	4Xb73MtFmRTfTL9iFnMJn7z3klyPVdwvYMCEy8THpSmxbgwDjdC2qOikNVJWwf65SFg36VqqhBFrp
	j4D0QjMS6j8MoGlu7B1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvc1-0003F7-S7; Mon, 03 Dec 2018 21:18:41 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvan-0001kz-Ti
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:30 +0000
Received: by mail-lj1-x242.google.com with SMTP id g11-v6so12814739ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=p/PebisCQwZyCXIyFTWO4qzYTwOqjEpdSW67FIz4N1E=;
 b=lbGkUY+VZXXMTdSPEoE/SVmzPtHjkPYoeJI7/Az8OmINB17igOKXHVYrhYLKDBgFsm
 AdytGWcqHfSOXlVyHpF+VGri6qXR7zqqWrdfItLec79K5+i2XKx6YmT1m57MusZrUdMA
 JwRZCM9h91doFb4rG7nHg0zc0nvxqscQxOAPUF8hp67niQCN3Ks9oRaUS6ZWbxBQ0oiJ
 v4lEDWIHKs+ATqGZF4G3AnRR6JEFt/lKz8x6Bs6/WMrvXCQC+h+mNIBkVWUXvhzPIpnd
 6cJFcEsamPeNLNT9sBXV4Y0A2QOdN0Aq9CHv9DTH9Nw656Bo1fszHViBilct20OW8dBm
 gY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=p/PebisCQwZyCXIyFTWO4qzYTwOqjEpdSW67FIz4N1E=;
 b=rLdAOY2iat+7UmL0SSIJNC7lNdJn8zWovWP2g4MwJMOm3L8Rez+S5bEa4nJIF5vcwv
 YAllHlycX+UQCrJZH8qhFW1YVgKDqsd3g1b4Trq00gEhuEol4qMv0GlUD0yyDYjIoc/u
 AaG5Luv/WaNmuRcK1IuQEU1e2yB3cUqKxW/MRyYTu7qSa6d9XZrgGmTBJvsVBKM3uOAj
 R9YixTVjF6qh4H+8XXbwvcDI8vvOtH5pKv2+vD3nW93zUzrCgiUw5fkU1HSuCyMaoKfL
 dqCMKroHm4UOL/wOqPOHKOIvua+LPhMMx35tzyZ8pDpYakRbH4qwoqih+2vU22Zj7Zp0
 56tg==
X-Gm-Message-State: AA+aEWZkeyeCJ6HRzLVDGXFrOWAZDBUWcDbHrAFdHYMWGCLi8owSZXOk
 nPgoV+ppMa93kmWEY3Y8JKAC2g==
X-Google-Smtp-Source: AFSGD/XRPKHA2YZ/PLzPG2j18mCv1SdeYtqGQkb4vse9IF3BZmC0WF3AQu53cHsXJBBoihPuXEVYbw==
X-Received: by 2002:a2e:974a:: with SMTP id
 f10-v6mr12588836ljj.61.1543871834135; 
 Mon, 03 Dec 2018 13:17:14 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q21-v6sm2684700ljc.5.2018.12.03.13.17.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:13 -0800 (PST)
Date: Mon, 3 Dec 2018 13:05:03 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [GIT PULL] Qualcomm Device Tree updates for 4.21
Message-ID: <20181203210503.h5mefq3zcguxh4dn@localhost>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
 <1543865944-3591-4-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543865944-3591-4-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131726_360973_4E39568C 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm@kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 01:39:04PM -0600, Andy Gross wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.21
> 
> for you to fetch changes up to 972910948fb6f555e83f37bc6172f51984d738a9:
> 
>   ARM: dts: qcom: Remove Arrow SD600 eval board (2018-11-28 17:36:41 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm Device Tree Changes for v4.21
> 
> * Add entry for Qualcomm TSENS thermal drivers
> * Update msm8974 thermal entries
> * Fix msm8974 Hammerhead magnetometer gpios
> * Add SoC specific compatibles for SDHC nodes
> * Remove Arrow SD600 eval board

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
