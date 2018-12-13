Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B520BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:00:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0FD20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NriMyyIM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XCLNhu4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0FD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FX3+Wjc7h8Gr2gRx0pWluntkqUhAqSbRQRMX1k5oUnU=; b=NriMyyIMTr2xca
	a1Z0MAlw6S+vQkxdCOcUh9x3F8KZv9xUXSJICzHKlWjnM7JZTTvIyhxbff/0yCdZ/9wngZ6t7hGLj
	4fNW5iRe5FvgXFbx+yP4DlI/K+Mgv40gkMIv6Mpqx7XK6iQ2lpbNY/oVBxTtT91BqUHSAFgb4Ta2M
	7ghMqsV4IK8VEsnpFGQl5f926Yqq07/gvyX3ZzNjSaqLK/MlG6SjkoxLY3ElnI4tQppqbTcQEzmB+
	yic3kWrXjiyhAzSFqdtz7aaUoajU2s+XSzL325Lv2EwGTVl/1zoJzBlJY4WfN9hWu2GrlNt7uXFWY
	J3JUipgGWNPFAj3Ch0Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVHd-0005oB-Gn; Thu, 13 Dec 2018 18:00:25 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVHZ-0005nH-NG
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IVB28Db9ZKXqdHKKo03v707cx3bqKns8Z36Y8D2nxKo=; b=XCLNhu4n9w/9bFuyRnjjDuhdS
 1/0Qiy+5ruIfFQs4mkW7H7lqpSBUXBc+NnrE4hgmCj+LqYBw8nITtieuKU+gc6xun1xT2zeZNQLLY
 LfiA+3S7VCuMDmw8PGxxBoK3zDWPcI6IaTg60GUClM/qEzaKmQbB5bVfB8SQ8rifQx9AY=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:37583)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXVHA-0003rL-NP; Thu, 13 Dec 2018 17:59:56 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXVH8-0000ku-58; Thu, 13 Dec 2018 17:59:54 +0000
Date: Thu, 13 Dec 2018 17:59:52 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 0/9] Clean up ARM SMP/CPU hotplug implementations
Message-ID: <20181213175952.GC26090@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_100021_915022_A6A9FBD6 
X-CRM114-Status: GOOD (  21.59  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Patrice Chotard <patrice.chotard@st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, David Brown <david.brown@linaro.org>,
 Kukjin Kim <kgene@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is a lot of apparent copied code in arch/arm for handling SMP/
CPU hotplug, much of which is inappropriate or plain buggy.  This
seems to be a topic that occasionally comes up.

The "pen_release" thing was created for ARM Ltd development platforms
where there was no way to individually control secondary CPUs leaving
the boot loader - they all jumped to whatever physical code address
was supplied at the same time.  This made it necessary for _these_
platforms to have a "holding pen" for the CPUs while the kernel
initialised.

The "boot_lock" thing was also created for ARM Ltd development
platforms which had restricted bus bandwidth, and which used the
loops_per_jiffy delay mechanism, which was calibrated for each
secondary CPU.  With the restricted bus bandwidth, activity from the
boot CPU would affect the delay calibration adversely.

Lastly, the Versatile CPU hotplug implementation is an entirely
ficticious one - these platforms do _not_ support CPU hotplug as
there is no way to actually disable any of the secondary CPUs, or
reset them.  Such an implementation is not acceptable when supporting
features such as suspend or kexec.  As the Versatile platforms are
ARM development platforms which do not have suspend support, this is
acceptable there, but not for production hardware.

None of these three facilities/implementations should be used on
modern production hardware, yet we have a number of copies of this
code.

This series addresses that by removing the inappropriate copies of
some Realview/Versatile Express specific workarounds, and makes it
(hopefully) more clear that introducing this code is really not
acceptable.

To discourage copying the Versatile code, further comments are added
and the functions renamed for CPU hotplug to be "immitation" to make
it clear that it's not a real implementation.

We tried reducing the duplication in the past with ideas around
consolidating the pen_release/boot_lock/immitation hotplug stuff,
but I nacked that because it's not an acceptable implementation for
production hardware.  However, we did decide to consolidate the
"pen_release" definition.  In hind sight, that was a mistake,
because that gave more credence to that way of doing things, and
also gave rise to buggy implementations which only read from that
variable - meaning it served no useful purpose.

There are some rather complex cases that remain, and those need the
SoC folk to fix.

I have left the Actions Semi patch in place since following patches
depend on it, but there is a five-patch series from Linus Walleij
that address this platform which should replace this patch - with
the patch concerned marked as "RFT" - request for testing.

 arch/arm/include/asm/smp.h                         |   1 -
 arch/arm/kernel/smp.c                              |   6 --
 arch/arm/mach-actions/platsmp.c                    |  15 ---
 arch/arm/mach-exynos/headsmp.S                     |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |  31 +++---
 arch/arm/mach-omap2/omap-smp.c                     |  20 ----
 arch/arm/mach-oxnas/Makefile                       |   1 -
 arch/arm/mach-oxnas/hotplug.c                      | 109 --------------------
 arch/arm/mach-oxnas/platsmp.c                      |   4 -
 arch/arm/mach-prima2/common.h                      |   2 +
 arch/arm/mach-prima2/headsmp.S                     |   2 +-
 arch/arm/mach-prima2/hotplug.c                     |   3 +-
 arch/arm/mach-prima2/platsmp.c                     |  17 ++--
 arch/arm/mach-qcom/platsmp.c                       |  26 -----
 arch/arm/mach-realview/Makefile                    |   1 -
 arch/arm/mach-realview/hotplug.c                   | 111 ---------------------
 arch/arm/mach-realview/hotplug.h                   |   1 -
 arch/arm/mach-realview/platsmp-dt.c                |   8 +-
 arch/arm/mach-spear/generic.h                      |   2 +
 arch/arm/mach-spear/headsmp.S                      |   2 +-
 arch/arm/mach-spear/hotplug.c                      |   4 +-
 arch/arm/mach-spear/platsmp.c                      |  27 +++--
 arch/arm/mach-sti/Makefile                         |   2 +-
 arch/arm/mach-sti/headsmp.S                        |  43 --------
 arch/arm/mach-sti/platsmp.c                        |  62 +-----------
 arch/arm/mach-vexpress/Makefile                    |   1 -
 arch/arm/mach-vexpress/core.h                      |   2 -
 arch/arm/mach-vexpress/platsmp.c                   |   7 ++
 arch/arm/plat-versatile/Makefile                   |   1 +
 arch/arm/plat-versatile/headsmp.S                  |   2 +-
 .../{mach-vexpress => plat-versatile}/hotplug.c    |  47 ++++-----
 arch/arm/plat-versatile/include/plat/platsmp.h     |   2 +
 arch/arm/plat-versatile/platsmp.c                  |  47 ++++++---
 33 files changed, 132 insertions(+), 479 deletions(-)
 delete mode 100644 arch/arm/mach-oxnas/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.h
 delete mode 100644 arch/arm/mach-sti/headsmp.S
 rename arch/arm/{mach-vexpress => plat-versatile}/hotplug.c (56%)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
