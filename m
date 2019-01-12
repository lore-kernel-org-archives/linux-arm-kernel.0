Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DECC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:04:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39602086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JwapBe12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39602086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vDFQrmWbh4p+2NPB4mL3phjEL7II9egBA46cP9L4FeU=; b=JwapBe12J65BB8
	s3z+mjGRxy+l4TDhXxeW1DanPOw20HwC62B5DLZ6rukPIMlfw0rFhYRwLrHmF2FoMkf+z3lwRoKeP
	mDw8r08h2DQFi+/P9n4hi//gN0eHT6JHR6gjuO1fZROHvOyROLoife4CHWorp67rzzhvEhJq7fuyJ
	tBq4Thek+RM1RxxwfmmD9hM0ua+wEM+4DuULE0ggoshZLEHDIcYE23NICzWj0roRrDUmOHw4ezUdE
	Q2NVTidHNi/aI6oQAzkKlMDuqe4NFN4cFAnm9AUzOEBNsDnZ2gMGAn9llsT41XjajTXSY/VBbW0IJ
	3epjJ4XO40BuzFC6/+XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giI16-000167-Eh; Sat, 12 Jan 2019 12:03:56 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giI12-00015g-4X
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 12:03:53 +0000
Received: by mail-qt1-f196.google.com with SMTP id k12so21781335qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 04:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qr211SFiX8kQO8e9rZZmxFtNnfVop3fh/HW5lSawqjU=;
 b=hOAceta/rsO/mwRqPqJsCA9jbbUMkr/r8V4wuLzoFx8xMVFq7IOJ6CwDLORBA7H/sW
 NL8uahgPJMqdgBNJU5eylqr4IgZGpM0NrHeX8oLHM5ZkP1LHdGIuSAXku7zk9aY1oRlX
 pg9CTAfy/WaO4Le4SY8xbVUS5pMmRH8zZGTnh8hI0evQU117URvsoBThtsCvGNDN3LIo
 QgJbhiZNFuhZkvGRSJ+F/a76da4R5s4WKhgEHBBPyubDzc9RMSuNT24ZukSb3eoGgMrA
 rP/QjoOFkkZMhnMPpiYtVO7UTdSoJ/mZMsbO/oxJFb40VikHhixTX09qf0MBUM/+wXkq
 r19w==
X-Gm-Message-State: AJcUukd0VjjlV2/YA/qbAI8MjCj4G87owOkdm1w6TBPlMHqRTsdVXFfD
 5htw8eqeRMqfySILZAp/FVpjIv9N5UIZ4HYxgWQ=
X-Google-Smtp-Source: ALg8bN6ExVHlO7cKD52ElQJ84TWXuLU7nBZLMcN/1TxVyt1erzIPjdkj94dFkdvx8+CXH5Aw6PdV+F0nFd5QhjpTf6w=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16464637qtm.96.1547294630274; 
 Sat, 12 Jan 2019 04:03:50 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
In-Reply-To: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 12 Jan 2019 13:03:33 +0100
Message-ID: <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
Subject: Re: Hilscher NetX mach-netx refactorings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_040352_177375_0DC1472C 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Olof Johansson <olof@lixom.net>,
 Robert Schwebel <r.schwebel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Sascha, Robert,
>
> I am looking at refactoring mach-netx to use the new PL11x
> DRM driver for the graphics.
>
> I need to make sure that patches get tested on the hardware
> and just want to ascertain that there is an active maintainer that
> will be able to test patches I make for this and work on getting
> it migrated to DRM before I start spending time on it.
>
> Are you/pengutronix still actively maintaining this machine and
> testing new kernels on netx?
>
> I guess the second question is whether you have plans to migrate
> it to device tree and multiplatform, but I'm mainly thinking about
> my own little patches now.


On a related note, there does appear to be active work on
newer netx machines that were never upstreamed, see
https://github.com/Hilscher/netx4000-linux/commits/v4.9-netx4000-stable

I wonder if anyone has contacts into the company so we can
work together with them to include them into mainline Linux.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
