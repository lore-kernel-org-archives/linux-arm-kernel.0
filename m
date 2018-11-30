Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521EA20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BoQQwIOM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pGnmcXez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521EA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=20r+BbMLBA+GJr7zyR3OPszWprpphV94HJX4J1E5D+s=; b=BoQQwIOM7bcAG9
	ppEGWJzV5qX5kJ1nM8ip1fGjPIciM4vTjMX8oDTO3mMSShyqLIPjtoM8sO2ybiUdIKyW/7GhDHaJm
	x6rDSPg+QXJIXdnGNic5DkK+3WTMneKZDEYupgtB5iOvclZJ/pNwZEsnSY9nU0YHl8EcXJePqlE6+
	F2NfnZ/+dXBQSZax2TDmBTcVkybCuwDUSwDEPQTRma1v/dxVmb0+Rk3ENgpbCxOOey5gkL+llhUXN
	TvYf9H5Y+NNUAMhP+r8nWAwFQKeteL3tNw0ziQKAkedeHcaK/emL5pTVK4PLiK+EAR+HA3dFde9IV
	/PFscVy8qbFvttxihKzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsfr-0003Ou-Vl; Fri, 30 Nov 2018 23:58:20 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseg-00025u-Qe
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:09 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so6470500ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5TsFCodeO/xalrAQ1MKFeXfgx98HEQr+Za7lCNzItHs=;
 b=pGnmcXezM/oS3TA18Jsv3LaL8Bd4vwywi438BgPNns9oyKjt9CRyiR9F1KzTUVKeKG
 PelCHnHF9/78SaD8YNgUqPMKfUHMqIwRIGDNWMimRODlYZC1/9tgvtMe81LJEoXiDlzZ
 oX2Q8etH58TPYsLzAHeUFiLUM18tIfLXe0E7oBWaYtSEfqF8fz9BvpKhlJSicsFbvgoz
 4k/ArnQn143pEhzkzKFjBmxSsorM+mAK4rfE62Sy1OotXKSRO1Oo2vnodTo1ixzGCWTG
 Q//waLVx/XkV7lf8kUEHj1r0cxqFJOpIzep6uDFDTuE/K39hH3CRSZpuqsOctNL3P7do
 ip2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5TsFCodeO/xalrAQ1MKFeXfgx98HEQr+Za7lCNzItHs=;
 b=WaIyOa4+bz5OkxELEYD/XnCBtfn2uCmGNKAWuuRfXveAQjxyo1gG2p2c/PkKi5NYro
 eWnKlHLVSyDGCRulLjEDCrIhUlNKbdZrD4JMD4Cq4QhefSmNqTP5T4K8ujkSuJZvL1Cz
 gIf5Xz5mf+xvcqQIRsrF63QxtwOueqWr4rYLzNqbS82b8jRFURMl8MVD77W7Z9NZbHbC
 Rs5dYbJx/eHKP/4Qv77FcXScJ6W/NoNhTJMHKHVAYxfal9mmwP//Em9nn1se39/B0vkR
 /WrNlRFUURjeLppjz6eYeVm77rSvR7UsfTI83YYxRcJIDwAA0zPYs7aGUQLU0tivlQmZ
 MUTw==
X-Gm-Message-State: AA+aEWYEgS3B1/tnrdNysRZ8YPg/fYs/slCFraE1b8QfqIkTwJPySHnS
 WPoK0M6pofI+gC/VR2np4KD8xw==
X-Google-Smtp-Source: AFSGD/WP4EicExFcbyXQtL0eqgctNPPtIetJf0IV32B1y7dZz6Wy0T6ZEiZG9gKktbm82Yvt+WLizQ==
X-Received: by 2002:a2e:8449:: with SMTP id
 u9-v6mr5526756ljh.121.1543622215065; 
 Fri, 30 Nov 2018 15:56:55 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id m63-v6sm1143895lje.81.2018.11.30.15.56.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:54 -0800 (PST)
Date: Fri, 30 Nov 2018 15:17:05 -0800
From: Olof Johansson <olof@lixom.net>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] Versatile Express DTS updates
Message-ID: <20181130231705.vvmyim2a75hpkzay@localhost>
References: <CACRpkdZY8bybYjZ2zZfgWDLfd0o8zkhrpScAQ+z9xTgzsf0=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdZY8bybYjZ2zZfgWDLfd0o8zkhrpScAQ+z9xTgzsf0=FA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155707_681647_81513CC0 
X-CRM114-Status: GOOD (  17.30  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, arm-soc <arm@kernel.org>,
 Liviu Dudau <Liviu.Dudau@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 08:43:44AM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> I agreed with Liviu Dudau (ARM Versatile Express maintainer)
> that I will send the Versatile Express updates to ARM SoC.
> 
> This is an update of the DTS files (based on my v7 patch set)
> that forms the base changes for switch Versatile Express reference
> design family over to using DRM with the PL11x driver.
> 
> Please pull it in to ARM SoC DTS changes for v4.21!
> 
> A corresponding defconfig update activating the new DRM
> driver is coming in a few minutes.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/vexpress-drm-arm-soc
> 
> for you to fetch changes up to f1fe12c8bf33241e04c57a0fc5b25b16ba77ba2d:
> 
>   ARM: dts: Modernize the Vexpress PL111 integration (2018-11-29 08:31:41 +0100)
> 
> ----------------------------------------------------------------
> Versatile Express DTS update for DRM:
> This updates the Versatile Express family DTS files to
> contain the correct and detailed information required
> for the PL11x DRM driver to work properly.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
