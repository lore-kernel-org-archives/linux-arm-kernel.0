Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28222081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EyK0mfBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28222081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V8Oh3I+X1hSkkTzGjhxE39MqVJBTRbshYqSuU2xv4Tc=; b=EyK0mfBKpjWZqv
	WfgKk34IU607KllNen6myFwystqhrumX4uAldQnzp729I+9XFT/jipgaevIQLtn8Nm+voGkJpsyUP
	2vH2QZKHirQHk8XvhHwnqd9fvdtaCDoaRty/PCrtgkjqs3QbYrH3SZE6Y5NM976WlJa1S7joCZcyR
	OdnnbcB08kPnhGAJt9iD254Y2qLKi4HwYGujHeoZ9OZQs0Arq9ugScQ/a+7RFWPe8Dnhlzvwn9WvH
	lMjB6b8NPWCnIED1T0Mrnfe+CDkgP5q4oVa1vkPljPPnTzQ92+9STsyYowBkyhPFqrjAcJx4y0J+b
	B+o6bclV9aFVazFsOS6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeym-0004hr-Id; Tue, 11 Dec 2018 10:09:28 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeyh-0004TS-FP
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:09:26 +0000
Received: by mail-qk1-f196.google.com with SMTP id w204so8255094qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VDSdrMM5bBz6Iqfcx8J9M/ABMO6lf3JX9eobabQHXUw=;
 b=V4TdJnKlJb79H+FQAhNeGNkjkObjCpky7VqfOexh7vh7FG9S/tOF4cDqaqQrlTXPuq
 hsWos4hTBwYxmgoo7b2kR7d8jGO1Wnqa4B2oec7SkNj5HKLHJk4bPX5DARcjE3cDd18h
 h7//5Isc4W75wV4kV4hMp3p1XMautkiUkxf1reFOQAIoLz67GhS11yKdZIaQ1orZrTeT
 pgj7VZZZ1oat8BZrekwPzawaCUnupMLSuII4InF+62au3U1BSBoWAz/ooX1BCgWlNrl/
 ajvEG4KeYNjeWebII4eSOTvlZU03Yt8EYTpVpedjZpZbaw92/Wip7c/XhxFoV8VJ1gJO
 ih8w==
X-Gm-Message-State: AA+aEWZ+spMTYzLwIbeu5su+I60viBQWN2vTqYngk8HRBOIE1VxFSsVt
 RwnVmKvWoGocfeU3F5cvwVxAcKmzFWGSRRqRU8w=
X-Google-Smtp-Source: AFSGD/XqaoKboLmI7ss0whDbYHdUl3wq+V09AJ5WV+WAnEJnoc1+eBQaDI9nZ1TqR4V+zO4Bkd2hkiMB7cuI0mFsYg0=
X-Received: by 2002:a37:bdc6:: with SMTP id
 n189mr13682397qkf.330.1544522950912; 
 Tue, 11 Dec 2018 02:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
 <20181211100550.GD14426@ulmo>
In-Reply-To: <20181211100550.GD14426@ulmo>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 11:08:53 +0100
Message-ID: <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020924_164660_15BD7CF5 
X-CRM114-Status: GOOD (  15.39  )
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
 arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 11:05 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> > WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the function tegra114_gic_cpu_pm_registration() to the (unknown reference) .init.rodata:(unknown)
> > The function tegra114_gic_cpu_pm_registration() references
> > the (unknown reference) __initconst (unknown).
> > This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
> > annotation or the annotation of (unknown) is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mach-tegra/irq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I'm not seeing these. Do I need to enable any special options to trigger
> these? Or are these just so new that I haven't run into them yet?

My guess would be that this is a result of the CONFIG_NO_AUTO_INLINE
option that is now available in linux-next.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
