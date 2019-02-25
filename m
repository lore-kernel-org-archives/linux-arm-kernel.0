Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:54:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7027F2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cuzX4X7J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="myvRVxl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7027F2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n0obFEjBj3BGtPowzu+HyNQttjA7HosCxXIbXZffNdQ=; b=cuzX4X7JRaAv02
	elJsux83bE5665751t4uQKDK2pxcaSFPAlimCcCT9PPR4SyAVHuXz1YYXckDqzBwqKxNB519UCDUp
	9/sCM0MRfZSBkADJMKriWc+fHDwIm5CMQgiQGhWsnNGCLgRawa8Im1XhvyReZNm87Z6Fw7KtS4ken
	yKFwHvTCheyKUficY0bsuFr/bGqqxAaXkarcaSz1LYkFP1syc6pffMp70/+YGiBYLqIjLEZQ5ltGN
	WPwsEzYx77TjAQp6dJ3ubNvHHiG7gFpCwCy2PGxeJJvJ+B9ojlPEEVWBd0TGdAu24fJP4owzkR9Zw
	s47zdwhFBtddsUmpXKkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyEpW-0003yF-V2; Mon, 25 Feb 2019 11:53:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyEpV-0003y6-5r
 for linux-arm-kernel@bombadil.infradead.org; Mon, 25 Feb 2019 11:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mg7F+Gj7bABkuk+sVE0bvI/VnzutyyN+PvP4NL/YIsI=; b=myvRVxl9Bwv8g+ywa0fVOsNEE
 ao92UMarOZllMdDNbG7JB7RK3r5bGiJd96lM7XWehPxITq3UE0jfhqPvvayo/+6w381RNqvcrJCBp
 8H1vQ6jqsT87CJRUeP4OZvRMHfgaQywL+quOcLzJFW/uFD0bd0vtvYob5Ddd+OWZ0yoFYx4OIiGep
 lon51z/4JDYbjf95OVLSQYeL3P0xZjpadUQcJeoqCCigRsuFhHnt1zbcQETLHydWdYOHKvfo+5PPX
 rPrmOcynnDCBsEDO/5TQGrCS/EtD5LuLCocfKAr0GVgRi0hbsaqJj1RO47je+OzgIJ9Km9MyWpynJ
 K7kppV8Pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyEpO-0006A1-TI; Mon, 25 Feb 2019 11:53:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 443BE2026BE91; Mon, 25 Feb 2019 12:53:44 +0100 (CET)
Date: Mon, 25 Feb 2019 12:53:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190225115344.GA32534@hirez.programming.kicks-ass.net>
References: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
 <20190225105144.GJ32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190225105144.GJ32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 11:51:44AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 22, 2019 at 03:55:25PM -0800, Andy Lutomirski wrote:
> > I'm wondering if we can just change the code that does getreg() and
> > load_gs_index() so it doesn't do it with AC set.  Also, what about
> > paravirt kernels?  They'll call into PV code for load_gs_index() with
> > AC set.
> 
> Paravirt can go bugger off. There's no sane way to fix that.

> I don't fully understand that code at all; I also have no clue why GS
> has paravirt bits on but the other segments do not. 

*sigh* SWAPGS

> *thought*... we could delay the actual set_user_seg() thing until after
> the get_user_catch(), would that work?


How horrible / broken is this?

---

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 321fe5f5d0e9..67c866943102 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -60,17 +60,21 @@
 	regs->seg = GET_SEG(seg) | 3;			\
 } while (0)
 
-#define RELOAD_SEG(seg)		{		\
-	unsigned int pre = GET_SEG(seg);	\
-	unsigned int cur = get_user_seg(seg);	\
-	pre |= 3;				\
-	if (pre != cur)				\
-		set_user_seg(seg, pre);		\
+#define LOAD_SEG(seg)		{			\
+	pre_##seg = 3 | GET_SEG(seg);			\
+	cur_##seg = get_user_seg(seg);			\
+}
+
+#define RELOAD_SEG(seg)		{			\
+	if (pre_##seg != cur_##seg)			\
+		set_user_seg(seg, pre_##seg);		\
 }
 
 static int ia32_restore_sigcontext(struct pt_regs *regs,
 				   struct sigcontext_32 __user *sc)
 {
+	u16 pre_gs, pre_fs, pre_ds, pre_es;
+	u16 cur_gs, cur_fs, cur_ds, cur_es;
 	unsigned int tmpflags, err = 0;
 	void __user *buf;
 	u32 tmp;
@@ -85,10 +89,10 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 		 * the handler, but does not clobber them at least in the
 		 * normal case.
 		 */
-		RELOAD_SEG(gs);
-		RELOAD_SEG(fs);
-		RELOAD_SEG(ds);
-		RELOAD_SEG(es);
+		LOAD_SEG(gs);
+		LOAD_SEG(fs);
+		LOAD_SEG(ds);
+		LOAD_SEG(es);
 
 		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
 		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
@@ -106,6 +110,11 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 		buf = compat_ptr(tmp);
 	} get_user_catch(err);
 
+	RELOAD_SEG(gs);
+	RELOAD_SEG(fs);
+	RELOAD_SEG(ds);
+	RELOAD_SEG(es);
+
 	err |= fpu__restore_sig(buf, 1);
 
 	force_iret();

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
