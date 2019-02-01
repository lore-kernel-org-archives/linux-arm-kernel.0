Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72DCC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:40:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B350D21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YV1ebyuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B350D21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P6N8faf2ZpjB11oCt5iQgUaHRs3O2rhB8BkM58LzMqI=; b=YV1ebyuFtIGS3Y
	lt2cblfsMaEOJG6I6mSo7J5V/rJf1T4hVpnc56RAMj6bcCDzZtEG0m3Wuzwf9n5xT9u0mE1B+rlxE
	I2FQq0A7hj0mizBw87jjn2LaLVcg9RH/9+Mo5CXqdm69C+JNV+NyxGhRyUlhvVHrd15FnMYrYcYlx
	hFd8mJVINXp3mmZhpHLTtlUaLpnvYwZUqGrYdWHBHr4IuUx1FgwfQkIQtz93EwdFpgIF3rJs0EZvD
	Mve+hezSdy1ucNtcPbVv1RfixpX5l5PnWFbpJtmOwjDb9XD1Eyr20Od0HcYLggH9kpsZYpHXPsVUI
	LKB9hDA4WBCzbv9HqXtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUNW-0005lq-Ui; Fri, 01 Feb 2019 08:40:50 +0000
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUNT-0005lX-62
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:40:49 +0000
Received: by mail-lf1-f65.google.com with SMTP id a16so4455211lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 00:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g8Nn8cm8MH4bDwP0jLK8AviReQWhxX4FZpgV/LsFZsY=;
 b=kMraq1p0cmYmCLQpok5JyTUxB/LJj0eEe8n22NNKQfnEWMc+LqPI724nAeojvwnjyc
 6Z4kKeIhzLX3LvU6IkKFkNYJFOknYjY366WM07Nywb3W1oUl4KMaBIuI4Ly92sNyzzPR
 8/nCv3zQkGGrd3RzKMoONUiakg045Qr2mTblcVny5ryxZ6PY15bmOr5iGvRQOsDcLbIv
 yzVjJo0Ibc8zctQQ1jjEbHDn0JRmTxL4I9TzzFRD0wjoAYwat9PcFu76lHrl53i3kF/6
 XLEds1FVKQpJlhWWEEinecPdfK8hee23aJxv3QAlLi6/ipVKWMuey4Nm/Zj+zroFz1J3
 WpCQ==
X-Gm-Message-State: AJcUukc9/s9eYKnWh/+scoLArt9wSG8Je1JtQEkkKkkpiGmbQJBQ38au
 RnR5jVf1jX5e+8GwMMXl/Ow=
X-Google-Smtp-Source: ALg8bN6Nmz3lHJ3DhKu3nfxwFSM037ts91UOX9a13vuzSYgmR/ABG3bePWR9SNQOS/MbFSRajryeow==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr31727905lfg.13.1549010444341; 
 Fri, 01 Feb 2019 00:40:44 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id y23-v6sm1177586ljk.95.2019.02.01.00.40.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 00:40:43 -0800 (PST)
Date: Fri, 1 Feb 2019 10:40:40 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <20190201084040.GE23791@localhost.localdomain>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
 <20190131132452.GD23791@localhost.localdomain>
 <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
 <154896351763.169292.2557542540041822337@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154896351763.169292.2557542540041822337@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004047_228802_87A4FF9F 
X-CRM114-Status: GOOD (  31.06  )
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
Cc: linux-arm-kernel@lists.infradead.org, djkurtz@chromium.org,
 rafael.j.wysocki@intel.com, linux-clk@vger.kernel.org,
 b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com, corbet@lwn.net,
 linux-doc@vger.kernel.org,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>, krzk@kernel.org,
 sre@kernel.org, cw00.choi@samsung.com, vkoul@kernel.org, linux@roeck-us.net,
 pavel@ucw.cz, pombredanne@nexb.com, akshu.agrawal@amd.com, sjhuang@iluvatar.ai,
 mazziesaccount@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 11:38:37AM -0800, Stephen Boyd wrote:
> Quoting Russell King - ARM Linux admin (2019-01-31 07:21:47)
> > On Thu, Jan 31, 2019 at 03:24:52PM +0200, Matti Vaittinen wrote:
> > > Hello All,
> > > 
> > > On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> > > > Series adds managed clkdev lookup interfaces and cleans few drivers
> > > > 
> > > > Few clk drivers appear to be leaking clkdev lookup registrations at
> > > > driver remove. The patch series adds devm versions of lookup
> > > > registrations and cleans up few drivers. Driver clean-up patches have
> > > > not been tested as I lack the HW. All testing and comments if
> > > > driver/device removal is even possible for changed drivers is highly
> > > > appreciated. If removal is not possible I will gladly drop the patches
> > > > from series - although leaking lookups may serve as bad example for new
> > > > developers =)
> > > > 
> > > > Changed drivers are:
> > > > clk-max77686 and clk-st
> > > > 
> > > > Please note that the patch #2 requires this change to work correctly:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > > 
> > > I guess the dependency mentioned abowe is already in (most) of the
> > > trees. (I can't say for sure as I don't know what is the correct tree
> > > for clkdev - is it linux-arm.git as Russel is maintaining clkdev?
> > 
> > Yes, I'm supposed to be maintaining clkdev, but I'm busy with other
> > stuff (such as reorganising my network, helping people with SFP issues,
> > I'm supposed to be replying to Arend over a brcmfmac issue that has been
> > on-going since Christmas which I haven't yet been able to doing the next
> > test...)
> > 
> > > If yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > > "clk: of-provider: look at parent if registered device has no
> > > provider info" seems to be sitting in maser branch).
> > 
> > It's there because it's part of the mainline kernel and has been
> > since v5.0-rc1.  So, if you depend on that commit, basing off
> > v5.0-rc1 is probably sane, unless there's something else that
> > conflicts.
> > 
> 
> I can pick up the patches in the clk tree. Clk drivers will be the users
> so it's probably simplest to merge the clkdev patch in clk tree and then
> consumers can be updated at the same time in a patch stack on top of
> that.

This sounds good to me if it is Ok to Russel. Please just let me know if
you want me to rebase (to clk-next?) and resend the series.

> Otherwise, if I can get a stable branch/tag to pile the clk driver
> patches on I can apply them that way and then the clkdev patch can go
> via Russell.

I can for sure go with this approach as well if it has some advantages
to you. Again, please just let me know if I should resend series and if
I should use something else but clk-next as a base.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
