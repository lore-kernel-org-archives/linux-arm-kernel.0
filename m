Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE198C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:29:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789242190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WxA8cL2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789242190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1OekHSOywKcqPI1prv338j+478iYTk4UNnFEb7317U=; b=WxA8cL2m+2AMX7
	oWEDEM4DTMlj1j1ZkyT/t8Ackjmc+/XuxcjUywLuYwrVzJaeSvBQVvRGBBJhaNQwXFpraaGCJPFiM
	voAiBFd5xl/MTFdFDW1kQ6Fld0Mivijdz5ke9GvHjT+Oszi5YWrFTxwKY8I/QnrpNR7m5KdqyXBkA
	lMybu6MzpEqLpjAwtnIip88DXmievVLWf4ctN8epmdAZb6+tuJDQm/HWO1DJNQzd5FgxkOWNrbQmZ
	dz/qx1viEFCrIrbFo3aoAZ+Kf4WTU0nidiY6PHlJHAAeKy5iGBz7D55jcmUEGL7IOslpQsZgKrxXS
	wwE5ROuQnpvWjgsoZ8Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugN9-0001mq-Cj; Fri, 15 Feb 2019 16:29:55 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugN5-0001ho-E9
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:29:52 +0000
Received: by mail-qk1-f196.google.com with SMTP id p15so6024701qkl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nGq8Wn2fRGGja+894QKAGb9/iuj4uGbC8rMRmzQyRCo=;
 b=YaR7j5AwcNj1d6xxVMKIw06VqEY2Ff78Pq1ogFGbUPk6gueGl0DLs8yW8Q8AEXwkjV
 YsmaJ5SUhgXc9VyGMARvZx4b/fe1Wu8poDrcDpcUf0zyG5bjfZhxGo8/P4+q+zu6SBOZ
 ua/oq4c+ldzKcU0QTshNdPBt+m0WMBH2LFvwR18NkOvojlRSmHefVEb/PxfWUVY2c5gg
 5PWZ0MbWtVchH3QBxnIjRyCI4FJb56qcA69IKs7rM8rYLsfSePADEOUhq11ETEYIIeJ7
 NFI7pE94DEsYQqqThzaDscFdWNwzenCLH4Pt/XdkjaxXqH200HJxY1X/oTwYA/Jx5+TQ
 Ngvg==
X-Gm-Message-State: AHQUAubQWgSXiuYahIOOZPy0WhalMujvvLXXvtuWKyrW+l6CLjOIloMi
 AElayjjZ2qBuNnp5KWQIrC4ngZvk8nb2A6BtZik=
X-Google-Smtp-Source: AHgI3IYUnnyVuzK6IlQ7/ZXnjeWY9udH3aSlqMa2L/27c+ys74POegzyenO3qoLlOjleHq1ETJ0bmpcb8eWFNLW+6IQ=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr7482756qkf.330.1550248190218; 
 Fri, 15 Feb 2019 08:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-3-thierry.reding@gmail.com>
 <CAK8P3a0zEQ3oY8vYBxpnq3wg0pDfag66Y7FxZ1muvxHh+SwHyg@mail.gmail.com>
In-Reply-To: <CAK8P3a0zEQ3oY8vYBxpnq3wg0pDfag66Y7FxZ1muvxHh+SwHyg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:29:33 +0100
Message-ID: <CAK8P3a0kZFV=JHTSYGLVy5jXUFGp6zAUJ9350yLVFOQ3A+EmOw@mail.gmail.com>
Subject: Re: [GIT PULL 2/9] cpufreq: tegra: Add support for Tegra210
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082951_536718_828D98ED 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 5:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > Hi ARM SoC maintainers,
> >
> > The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> >
> >   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-cpufreq
> >
> > for you to fetch changes up to 43c36002b86d6027b48f7c68ac32245f73f29f6b:
> >
> >   cpufreq: dt-platdev: add Tegra210 to blacklist (2019-02-06 14:31:19 +0100)
> >
> > Thanks,
> > Thierry
> >
> > ----------------------------------------------------------------
> > cpufreq: tegra: Add support for Tegra210
> >
> > This uses the DFLL clock support to enable CPU frequency scaling on
> > Tegra210.
>
> I see the Ack from Viresh, but I don't see why you'd like to have them
> merged through the soc tree rather than the cpufreq tree.
>
> Could you clarify? It's no problem to do it, I just want to make sure
> there is a good reason for it.

Nevermind, I just found the 0/9 message that explains it all, pulled now
into arm/drivers.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
