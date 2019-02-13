Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:04:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA00222CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q20OLz52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA00222CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ii7Jrl66QvsGE0xBGXj65m8VOI+6EB3XxFheRdieDbM=; b=q20OLz52s0a53L
	TnQ1gLZljc4er/nltleKfU7Z8oK3k/AqV6oPPbqsPjbIrxuUdM9+Kanqk1jBGtiL/Vb/THF26tDr2
	21zUEul3vbvrtFthA0UeUwc0aVQ3FqYnKu42fI+DGoXtVJT8XW5pfBuq476N0jc4BlX54LxrIIDuo
	htd8quwvcZD4j3+PSx96sGSa6r/YW4lkjePmjs+GVbvSLQ8023C4cDPPIzAPRC6RyDdRLflU68BAa
	bfg/VembXvdSpXKEHyxYKcqG9YXjNl03jF9iten3D1xpQ8Q08dUmP3bxN2lmjb+ADE/We+meHKe7f
	sYTS2kVtZWNakBqV3M4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtxxU-0005gM-0E; Wed, 13 Feb 2019 17:04:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtxxQ-0005f8-94
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:04:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2E6A78;
 Wed, 13 Feb 2019 09:04:22 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1793F675;
 Wed, 13 Feb 2019 09:04:18 -0800 (PST)
Date: Wed, 13 Feb 2019 17:04:14 +0000
From: Will Deacon <will.deacon@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Message-ID: <20190213170413.GE6346@brain-police>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
 <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
 <20190208173539.GD24375@fuggles.cambridge.arm.com>
 <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1902082029240.1662@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902082029240.1662@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_090424_328380_0ABFE470 
X-CRM114-Status: GOOD (  18.25  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Marc for the arch timer]

On Fri, Feb 08, 2019 at 08:30:25PM +0100, Thomas Gleixner wrote:
> On Fri, 8 Feb 2019, Thomas Gleixner wrote:
> > On Fri, 8 Feb 2019, Will Deacon wrote:
> > > On Fri, Dec 07, 2018 at 05:53:21PM +0000, Will Deacon wrote:
> > > > Anyway, moving the counter read into the protected region is a little fiddly
> > > > because the memory barriers we have in there won't give us the ordering we
> > > > need. We'll instead need to do something nasty, like create a dependency
> > > > from the counter read to the read of the seqlock:
> > > > 
> > > > Maybe the untested crufty hack below, although this will be a nightmare to
> > > > implement in C.
> 
> How is the in kernel ktime_get() correctness guaranteed then?

Luck.

I think we'll have to introduce a dummy dependent stack read into our
counter accessor so that it's ordered by the smp_rmb(). Example diff
below, which I'll roll into a proper patch series later on.

Will

--->8

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index f2a234d6516c..bd55b4373700 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -150,8 +150,24 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 
 static inline u64 arch_counter_get_cntpct(void)
 {
+	u64 cnt, tmp;
+
 	isb();
-	return arch_timer_reg_read_stable(cntpct_el0);
+	cnt = arch_timer_reg_read_stable(cntpct_el0);
+
+	/*
+	 * This insanity brought to you by speculative, out-of-order system
+	 * register reads, sequence locks and Thomas Gleixner.
+	 *
+	 * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
+	 */
+	asm volatile("eor	%0, %1, %1\n"
+		     "add	%0, sp, %0\n"
+		     "ldr	xzr, [%0]"
+		     : "=r" (tmp)
+		     : "r" (cnt)
+		     : "memory");
+	return cnt;
 }
 
 static inline u64 arch_counter_get_cntvct(void)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
