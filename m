Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF12AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB042146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+GXY6Jy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nMBa1C5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB042146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rBct5WWnWRhx9+mBxi1JxECGD71ovC20yTH1Y5KHmgI=; b=I+GXY6JyT6iZww
	9/yVNv5GbBgXeEiiJFZn8OHlrmjjomdKB60NPyj5ZqHO4HtIBpU7ytNimFKRn2Xm56MOZZZXdZOE0
	jT3QeCoXh4l2mZJdnecmEzxXisJovJnAxF1ord3W4nh1Nv1UE7tuc/vlzM9o1Pzza5qRLnRg+zK0O
	rdoLRg9ufdQ30ju6YDzm/8QlcQzzhyN0NgEBBdPUi4zuQONVa9APBWas4iaGM32d41wseV3L1wEmt
	CjYK6qidePQ+0s3qGEOFfb71pIx7rh3ogiWi1CZB5VtJrjbLao+O93cu7gQ20pJqgR9dd4loQHflH
	aihr4FaV1bhHno91PQjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpgEn-0001wK-Um; Fri, 01 Feb 2019 21:20:37 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpgEk-0001vm-I0
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 21:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rtP/Y8I2gLOwMX2Cf9ITurn5G7lPfOu9o6Af40yui0I=; b=nMBa1C5GfJuKzzikvOTR3rcsD
 4Oqynw1fYkGjL8H8UVGWVJtUmOnYhdQrsrL+eI8VCDCrCFHKxuweQ5Wvku5wHCikQ65VxWP+LbpWX
 bfSBW2lEUw70H2lHXrUlWXpIJF1pisosjSbECozg/zHT/eIyAw+9y4T5Zq0s1O2aynTv4=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50820)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gpgEW-0000nb-3I; Fri, 01 Feb 2019 21:20:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gpgES-00019M-IG; Fri, 01 Feb 2019 21:20:16 +0000
Date: Fri, 1 Feb 2019 21:20:16 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190201212016.xnvllntopo6pg53h@shell.armlinux.org.uk>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190201101919.GA26637@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201101919.GA26637@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_132034_756979_60E1E0B8 
X-CRM114-Status: GOOD (  18.16  )
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
 linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Fri, Feb 01, 2019 at 10:19:19AM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Fri, Jan 25, 2019 at 09:03:57PM +0000, Russell King wrote:
> > Executing loops such as:
> > 
> > 	while (1)
> > 		cpu_relax();
> > 
> > with interrupts disabled results in a livelock of the entire system,
> > as other CPUs are prevented making progress.  This is most noticable
> > as a failure of crashdump kexec, which stops just after issuing:
> > 
> > 	Loading crashdump kernel...
> > 
> > to the system console.  A workaround for this is to use 10 nops in
> > cpu_relax().
> > 
> > We also use wfe() in while (1) loops to avoid burning cycles in a
> > tight loop, giving the CPU a hint that we're not doing anything
> > useful.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > It's been a while since this was posted, Will's suggestion was to use
> > 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> > these infinite-not-doing-anything-ever loops.
> > 
> >  arch/arm/include/asm/barrier.h   | 2 ++
> >  arch/arm/include/asm/processor.h | 6 +++++-
> >  arch/arm/kernel/machine_kexec.c  | 5 ++++-
> >  arch/arm/kernel/smp.c            | 4 +++-
> >  arch/arm/mach-omap2/prm_common.c | 4 +++-
> >  5 files changed, 17 insertions(+), 4 deletions(-)
> 
> Thanks, this looks good to me and your explanation later in the thread makes
> a lot of sense:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Feel free to put some of the erratum writeup that I shared in the commit
> message, if you like.

I think it may make more sense to use my writeup as a basis for a
better commit log that explains why we're doing what we're doing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
