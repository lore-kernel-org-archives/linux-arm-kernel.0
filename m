Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:08:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7982080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DSF03L44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7982080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HA8X1jYglpH2hwkNZ14n6Fj6I1tbvAoKob5ZzVfEUKY=; b=DSF03L44cKX4Ag
	eng9QiXVcXWwS5Uw2uEKQPl0zwHGhyLg/neS210JgdgPMBVA+XqISVYH98WQIfRI+7AGXbZ6VbZuf
	mftOMaJD2jbziwRcS0f5HU5ETnkwrBj/syGDSmeH51qUbd+CNbu+tnSZYVGBWQIArESmqzbEJPK2e
	ZMtgfvN+8M+tDQ3PHLeuNiikr+B5H9Wql5K1yQeWhSstewwzsYWEonGNygcVbgqWuYqgxPRBoAEgT
	T6yrk7219OSiynNeFaWjEoKOZnf+weCbBRHHRlIYGUxnlXP+mrEcMzDYpZjD+nPsvVwcjDtaj5BlB
	pW7RAsdJiokE3kAVOTuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTQXq-0000Rr-KW; Sun, 02 Dec 2018 12:08:18 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTQXl-00072Z-67
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 12:08:15 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id D067CC7E48;
 Sun,  2 Dec 2018 13:07:59 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AIXGf2VCgmwL; Sun,  2 Dec 2018 13:07:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id D65DBC7E49;
 Sun,  2 Dec 2018 13:07:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 8BKPUDjRjWDg; Sun,  2 Dec 2018 13:07:56 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
 by zimbra.v3.sk (Postfix) with ESMTPSA id D74E7C7E48;
 Sun,  2 Dec 2018 13:07:55 +0100 (CET)
Message-ID: <dc775f9fd360ecbd3e4c00c02c9ff6e655502d0a.camel@v3.sk>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
From: Lubomir Rintel <lkundrak@v3.sk>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Date: Sun, 02 Dec 2018 13:07:54 +0100
In-Reply-To: <20181130234424.vx5y46wqvziywbk2@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
 <20181130234424.vx5y46wqvziywbk2@localhost>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_040813_514814_9B267836 
X-CRM114-Status: GOOD (  20.02  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-11-30 at 15:44 -0800, Olof Johansson wrote:
> Hi,
> 
> On Wed, Nov 28, 2018 at 10:39:06PM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 28, 2018 at 6:53 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > Hi,
> > > 
> > > this series contains contains a bunch of MMP2 platform fixes.
> > > 
> > > Previous spins of the patch set were sent out over the course of last
> > > three months to the MMP platform maintainers, with Arnd and
> > > linux-arm-kernel@lists.infradead.org on copy.
> > > 
> > > Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> > > seem to respond anymore. That's a shame, because the MMP2 support seems to
> > > in need for some love. The DT/multiplatform kernels can't even boot without
> > > 14/20, 15/20 and perhaps more.
> > > 
> > > I'm wondering if this cat gen in via the arm-soc tree? Would it be
> > > appropriate if I followed up with a MAINTAINERS update in that case?
> > 
> > Yes, sounds good to me. I looked through the series again, and
> > found one patch that seems wrong to me. Everything else should
> > just go in.
> 
> I've applied the DT patches and the ones that touch only arch/arm/mach-*.
> There are a few driver patches here that should be reviewed/acked by the
> corresponding maintainers as well, so I didn't apply most of them yet.

Thank you.

> > > The patch set has been tested on an OLPC XO-1.75 laptop.
> > 
> > Excellent!
> 
> OOooh, I have one of those... somewhere.

I'm working on adjusting the machine's OFW to provide a devicetree that
matches what mainline Linux expects. I'll follow up with a boot script
in a few days -- once it's good enough to be actually useful.

There also seems to be a good chance that we'll get an updated firmware
image at some point.

Until then, CONFIG_ARM_APPENDED_DTB can be used, though a zImage header
needs to be modified to account for the DTB at the end:

https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75

> -Olof

Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
