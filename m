Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B55217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYHwja4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B55217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KahBxW2kSMzJ5W0xtRaQxLiX83/7rSfnku+8fR8m7fI=; b=iYHwja4kaqyFHt
	rnrcCnwjl8vIvIaSEfyV/c31kD0yWqO1arNVQm8TUl4YNBrLGoHd7bnYy1jw4RlZ8klold+03ExsQ
	DzlZ8JOnzqRndsducJx7PvQWUvccA7bvbLosMj7vG4EwwQJwK3URUs6mb+K/XQQxTVOEyz+U/AITn
	PqfEb2wepqjUPgVN/D42Dr3uCylrsq6IkIXpbuZVBMXsojalvQu3hF57tnVmN5df11ZumBTpNOWO3
	HJKni7/IPeI4Msbi28tCdrL7U+7v8oU3uWJUkGnSUYdl00m0P38kFGQYzvOOoL8cTthQYxoBqDnJ9
	priFYjy3Wb9/+tdXl6aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmdd-0006ti-22; Mon, 18 Feb 2019 17:23:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmdZ-0006iy-Ba
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:23:26 +0000
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 845C3217D9;
 Mon, 18 Feb 2019 17:23:23 +0000 (UTC)
Date: Mon, 18 Feb 2019 12:23:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] trace: skip hwasan
Message-ID: <20190218122322.5219d3cb@gandalf.local.home>
In-Reply-To: <CAAeHK+yDa=Ks7TY8unVfFYt7ekDOyqpqW4otyMg1XUxkFt5Q+A@mail.gmail.com>
References: <20190217043434.46233-1-cai@lca.pw>
 <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
 <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
 <CAAeHK+yDa=Ks7TY8unVfFYt7ekDOyqpqW4otyMg1XUxkFt5Q+A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_092325_410155_97F21357 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>,
 Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 18 Feb 2019 16:56:44 +0100
Andrey Konovalov <andreyknvl@google.com> wrote:

> On Mon, Feb 18, 2019 at 4:53 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> >
> > On 2/18/19 10:25 AM, Andrey Konovalov wrote:  
> > > On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:  
> > >>
> > >> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> > >> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> > >> because there is a burst of too much pointer access, and then KASAN will
> > >> dereference each byte of the shadow address for the tag checking which
> > >> will kill all the CPUs.  
> > >
> > > Hi Qian,
> > >
> > > Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
> > > mm/kasan/Makefile helps with that?  
> >
> > Yes, you nailed it!  
> 
> Great! I'll send the patch.

OK, then I'll ignore the original patch in this thread.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
