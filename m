Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC41C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:47:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA6320C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iEjiHj+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA6320C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/SHvKa+cTeaHyEZzxpCI2ancN4YQVy2uhxUIOc6leJs=; b=iEjiHj+e1QZ8xp
	ktHliWitX2RSFQQeQjBCdbkr37Fvx6CkCDt/AwAJasqwm24VNp5leOLO30NzOZbaSOOBi3Dm9/HqZ
	IxJ7sxq0HMVv2lytkdDJlps0WDE5w04qUhX6Jei7QuMh/DRXDPGyndK+FEctuVZ+dt+MbrjOmzT+I
	vsVUC8C2mAFTy6EiM1DB6VSQkGBIsn0i/w609vg6BHyaPWFWwl3R8CzppV+ot6obkP0nFrBN/I6pZ
	Ei3/WoRidRhFXKeb5QSwUPfRLzo8K/lAnXJxsuWk+rLozY0uUZr2y2wbF9IHub32jyU3OHA5xEhkc
	fwO/jnIkXGS+iZ71pD1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvl8K-0005AG-3K; Mon, 18 Feb 2019 15:47:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvl8C-00059e-LY
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:47:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C035680D;
 Mon, 18 Feb 2019 07:46:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE533F675;
 Mon, 18 Feb 2019 07:46:04 -0800 (PST)
Date: Mon, 18 Feb 2019 15:46:02 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 3/6] arm64: HWCAP: encapsulate elf_hwcap
Message-ID: <20190218154601.GB35031@e119886-lin.cambridge.arm.com>
References: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
 <1549459868-45992-4-git-send-email-andrew.murray@arm.com>
 <20190207114757.GG3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207114757.GG3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_074700_163057_0DBB1933 
X-CRM114-Status: GOOD (  20.08  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 11:47:59AM +0000, Dave Martin wrote:
> On Wed, Feb 06, 2019 at 01:31:05PM +0000, Andrew Murray wrote:
> > The introduction of elf_hwcap2 introduced accessors which ensure that
> > features are set/tested in the appropriate elf_hwcapX variable.
> > 
> > Let's now mandate access to elf_hwcapX via these accessors by making
> > elf_hwcapX static within cpufeature.c.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 19 ++++---------------
> >  arch/arm64/include/asm/hwcap.h      |  6 +++---
> >  arch/arm64/kernel/cpufeature.c      | 33 ++++++++++++++++++++++++++++-----
> >  3 files changed, 35 insertions(+), 23 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> > index 05ee9b9..ced87ad 100644
> > --- a/arch/arm64/include/asm/hwcap.h
> > +++ b/arch/arm64/include/asm/hwcap.h
> 
> [...]
> 
> > @@ -97,6 +98,5 @@ enum {
> >  #endif
> >  };
> >  
> > -extern unsigned long elf_hwcap, elf_hwcap2;
> >  #endif
> >  #endif
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index d10a455..5b9620d 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -35,11 +35,8 @@
> >  #include <asm/traps.h>
> >  #include <asm/virt.h>
> >  
> > -unsigned long elf_hwcap __read_mostly;
> > -EXPORT_SYMBOL_GPL(elf_hwcap);
> > -
> 
> Will this affect out-of-tree modules?
> 
> I also note an out-of-arch/ use in
> drivers/clocksource/arm_arch_timer.c, which this series doesn't appear
> to address (or I missed it).

It was in "arm64: HWCAP: add support for ELF_HWCAP2" - though due to it
being used by arm32 code I had to use #ifdef CONFIG_ARM64 as
cpu_set_feature doesn't exist there.

> 
> We are allowed to break EXPORT_SYMBOL_GPL()s in general so long as it's
> not done without any meaningful reason, so maybe this is not a huge
> concern so long as we catch all the in-tree users.

The benefit of removing the EXPORT_SYMBOL_GPL is that we can encapsulate
the elf_hwcap variables with getters/setters that ensure they are modified
correctly. This is only relevant now as we split bits between elf_hwcap and
elf_hwcap2.

My suggestion is to remove the EXPORT_SYMBOL_GPL and then also stick with
using just one elf_hwcap variable. As you previously suggested we can then
update the ELF_HWCAP{,2} marcos to produce the relevant bit fields. This
also has the added benefit of simplifying cpu_{have,set}_feature functions
as the number of hwcaps grow.

Thanks,

Andrew Murray

> 
> [...]
> 
> Cheers
> ---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
