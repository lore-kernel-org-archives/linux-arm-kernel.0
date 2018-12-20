Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D27DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9AE21741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lOT3T+5m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6iAi/Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9AE21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dUVs5336tKyN76Lin25s9HSt0iuFxx4B+jPYujAPqr8=; b=lOT3T+5mYDCGBg
	MTyBEZp0Qms1hoWSrIRMmwcWL3eD4SMgWJd66zYyVTDI/UjIy9uTrEbgOzJBXeNqSToE/1EdBotKE
	DNNhVFXSj/SrZiKZ7SaSRkQlVfyqpmFVwUF0e2Gq0ZZXvUmINug42hN1Wa4ZUPeGjHyK7H9MVNC/+
	+mMoZA7NxNUAMO3ScgRdXfk21Oi6cKVvKkvfHNxyvcJZ91lORD9zgdRhJ2BAxs9IWOq1lBWc62t8g
	wgqHiHKuD4g92LYtNqbk+EzrIfD13DLoWH/UqJhYy3XfqLGb2ddXfUxHijx8iErB3jENjDvBfNfro
	rQyqnQs3HvgjWHnecegA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZvVR-0001bg-B2; Thu, 20 Dec 2018 10:24:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZvV8-0001Al-3V
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 10:24:26 +0000
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8431E2177E
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545301450;
 bh=U8gviF3vXS0nlgPZT1hJddGuSPNbxXn5Oyy4dXAhAc4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=m6iAi/OqHUYRjV4W4ExpXAWwaVjHTrZmxdwPeyWIUj37DVJu0XTdE82r5g6fZFICk
 VtRPe3zYdoLNkAaTGiULxUUHrm0wMRivX6FYPj6loBmQKzefBdhZRExSjsZBFF6JXN
 WQFc/65X8ApTnYeNPbSAXAFor7bToPNUZq9ptxio=
Received: by mail-lf1-f48.google.com with SMTP id e26so918333lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 02:24:10 -0800 (PST)
X-Gm-Message-State: AA+aEWborPVyCM1MIMG4HkYTbSNQ+hm11WPkWQnXRRj/EdJUsLS8u9V8
 c2q0eFLGFdIZCsxV51BIgz/p3twIxfOXo6cRrxg=
X-Google-Smtp-Source: AFSGD/VyJ4OoC6hHpJXdGuRe8mYsjs+scqnMmgb/9/uf0BdwaV5d8mlH3dPfcaohcfR9BmJ/B5v+Lhk5jPkdo4a+2Bc=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr15873501lfe.87.1545301448662; 
 Thu, 20 Dec 2018 02:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <20181220101044.GN9507@n2100.armlinux.org.uk>
In-Reply-To: <20181220101044.GN9507@n2100.armlinux.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 20 Dec 2018 11:23:57 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdkebh8P4u=uqAxuoh_xxsdSfKeyy3ccDEiScstb_J_pg@mail.gmail.com>
Message-ID: <CAJKOXPdkebh8P4u=uqAxuoh_xxsdSfKeyy3ccDEiScstb_J_pg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Clean up ARM SMP/CPU hotplug implementations
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_022422_619360_4E557D32 
X-CRM114-Status: GOOD (  36.19  )
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
Cc: Barry Song <baohua@kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Patrice Chotard <patrice.chotard@st.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 David Brown <david.brown@linaro.org>, linux-omap@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kukjin Kim <kgene@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 linux-oxnas@groups.io, linux-soc@vger.kernel.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 20 Dec 2018 at 11:11, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> Since almost no one has responded, my intention is to queue up
> patches 1-3,5-8 for the Christmas-time merge window through my
> tree.  They will be in linux-next tonight.

AFAIU, the patch 9 (or entire patchset) was not build tested, did not
compile and therefore was not in linux-next. Sending something, which
was not building, to linux-next just few days before Christmas merge
window makes the schedule really tight. Especially that during
Christmas some people might be offline.

I think it should sit in linux-next for few weeks... it should sit
there already so the auto-testers would try it. At least if it were in
linux-next, the booting and few simple tests were already done, e.g.
by my boards, without any additional effort.

So please give it a time after putting it into next.

Best regards,
Krzysztof



>
> On Thu, Dec 13, 2018 at 05:59:52PM +0000, Russell King - ARM Linux wrote:
> > There is a lot of apparent copied code in arch/arm for handling SMP/
> > CPU hotplug, much of which is inappropriate or plain buggy.  This
> > seems to be a topic that occasionally comes up.
> >
> > The "pen_release" thing was created for ARM Ltd development platforms
> > where there was no way to individually control secondary CPUs leaving
> > the boot loader - they all jumped to whatever physical code address
> > was supplied at the same time.  This made it necessary for _these_
> > platforms to have a "holding pen" for the CPUs while the kernel
> > initialised.
> >
> > The "boot_lock" thing was also created for ARM Ltd development
> > platforms which had restricted bus bandwidth, and which used the
> > loops_per_jiffy delay mechanism, which was calibrated for each
> > secondary CPU.  With the restricted bus bandwidth, activity from the
> > boot CPU would affect the delay calibration adversely.
> >
> > Lastly, the Versatile CPU hotplug implementation is an entirely
> > ficticious one - these platforms do _not_ support CPU hotplug as
> > there is no way to actually disable any of the secondary CPUs, or
> > reset them.  Such an implementation is not acceptable when supporting
> > features such as suspend or kexec.  As the Versatile platforms are
> > ARM development platforms which do not have suspend support, this is
> > acceptable there, but not for production hardware.
> >
> > None of these three facilities/implementations should be used on
> > modern production hardware, yet we have a number of copies of this
> > code.
> >
> > This series addresses that by removing the inappropriate copies of
> > some Realview/Versatile Express specific workarounds, and makes it
> > (hopefully) more clear that introducing this code is really not
> > acceptable.
> >
> > To discourage copying the Versatile code, further comments are added
> > and the functions renamed for CPU hotplug to be "immitation" to make
> > it clear that it's not a real implementation.
> >
> > We tried reducing the duplication in the past with ideas around
> > consolidating the pen_release/boot_lock/immitation hotplug stuff,
> > but I nacked that because it's not an acceptable implementation for
> > production hardware.  However, we did decide to consolidate the
> > "pen_release" definition.  In hind sight, that was a mistake,
> > because that gave more credence to that way of doing things, and
> > also gave rise to buggy implementations which only read from that
> > variable - meaning it served no useful purpose.
> >
> > There are some rather complex cases that remain, and those need the
> > SoC folk to fix.
> >
> > I have left the Actions Semi patch in place since following patches
> > depend on it, but there is a five-patch series from Linus Walleij
> > that address this platform which should replace this patch - with
> > the patch concerned marked as "RFT" - request for testing.
> >
> >  arch/arm/include/asm/smp.h                         |   1 -
> >  arch/arm/kernel/smp.c                              |   6 --
> >  arch/arm/mach-actions/platsmp.c                    |  15 ---
> >  arch/arm/mach-exynos/headsmp.S                     |   2 +-
> >  arch/arm/mach-exynos/platsmp.c                     |  31 +++---
> >  arch/arm/mach-omap2/omap-smp.c                     |  20 ----
> >  arch/arm/mach-oxnas/Makefile                       |   1 -
> >  arch/arm/mach-oxnas/hotplug.c                      | 109 --------------------
> >  arch/arm/mach-oxnas/platsmp.c                      |   4 -
> >  arch/arm/mach-prima2/common.h                      |   2 +
> >  arch/arm/mach-prima2/headsmp.S                     |   2 +-
> >  arch/arm/mach-prima2/hotplug.c                     |   3 +-
> >  arch/arm/mach-prima2/platsmp.c                     |  17 ++--
> >  arch/arm/mach-qcom/platsmp.c                       |  26 -----
> >  arch/arm/mach-realview/Makefile                    |   1 -
> >  arch/arm/mach-realview/hotplug.c                   | 111 ---------------------
> >  arch/arm/mach-realview/hotplug.h                   |   1 -
> >  arch/arm/mach-realview/platsmp-dt.c                |   8 +-
> >  arch/arm/mach-spear/generic.h                      |   2 +
> >  arch/arm/mach-spear/headsmp.S                      |   2 +-
> >  arch/arm/mach-spear/hotplug.c                      |   4 +-
> >  arch/arm/mach-spear/platsmp.c                      |  27 +++--
> >  arch/arm/mach-sti/Makefile                         |   2 +-
> >  arch/arm/mach-sti/headsmp.S                        |  43 --------
> >  arch/arm/mach-sti/platsmp.c                        |  62 +-----------
> >  arch/arm/mach-vexpress/Makefile                    |   1 -
> >  arch/arm/mach-vexpress/core.h                      |   2 -
> >  arch/arm/mach-vexpress/platsmp.c                   |   7 ++
> >  arch/arm/plat-versatile/Makefile                   |   1 +
> >  arch/arm/plat-versatile/headsmp.S                  |   2 +-
> >  .../{mach-vexpress => plat-versatile}/hotplug.c    |  47 ++++-----
> >  arch/arm/plat-versatile/include/plat/platsmp.h     |   2 +
> >  arch/arm/plat-versatile/platsmp.c                  |  47 ++++++---
> >  33 files changed, 132 insertions(+), 479 deletions(-)
> >  delete mode 100644 arch/arm/mach-oxnas/hotplug.c
> >  delete mode 100644 arch/arm/mach-realview/hotplug.c
> >  delete mode 100644 arch/arm/mach-realview/hotplug.h
> >  delete mode 100644 arch/arm/mach-sti/headsmp.S
> >  rename arch/arm/{mach-vexpress => plat-versatile}/hotplug.c (56%)
> >
> > --
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> > According to speedtest.net: 11.9Mbps down 500kbps up
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
