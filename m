Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF69C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:28:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD55222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="odN9n5sz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qaKlVpIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD55222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qoqRmGw0x3BNUN4NxBiCDhaDCA3anjRSuzi9J/DUTyM=; b=odN9n5szBMobbf
	iRP4HXN3Ze6rVNNhLRRd8wfJsBdoRSy7JpTFAQvWfdgJBXy2R9tU0dhJ65hyA6XLMD1v+ZINuZ3Mr
	Pj8FY4O80F9La+Ggdansgf8urbQmobxrAj8rK/dSgkHBv0gIYM7PNYEjEN5CFcbBQNDiFO94+J3HS
	gcai7ZNzi4Pg9fpUZ7zlRTF8sWBniLYJmbRe3QBwqFthb3tqRLiEps/KyjbF3EkXdNJs7+Lg1HW7C
	b2pnGMDWcAT/0L5J5ycqVjO5h6K0huXeAbd6DmGnxsh2VaaAIdw7gnXpdH5T5XZEkDl0PR1x5T3Mt
	bBwd0AMUqmCXlx/AojtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiDf-0002kj-1T; Fri, 15 Feb 2019 18:28:15 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiDb-0002kF-CX
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:28:12 +0000
Received: by mail-pf1-x444.google.com with SMTP id n22so5218137pfa.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=PiEKiV7OXlo1L7Z9MWkQ2TibsoGawYs0+jN/HTFtj5g=;
 b=qaKlVpIbVNWs/vA9F9I4fH6Hr1NEm+3INn6ksJif61pT0zQ0pU5TQPcm7RMEQM9qZu
 tPFzbJO1pZgS+7nsx9rA00Cxijuceef3F7/xySpBGtEKB/cT6+O3yh23jrtXXLAD1OXU
 nhpBI3JtB9Nze2OFJum33/piv/V7VUxKQ4ejCiqhwzt5cnkHJOioWjjFSFhNNor30r9m
 FAV8g9C1Q/QHIJPRU/gJ7Qbl2SlUCR6/Hbrf89ZdW2usDyjH9/3f28fxiAFNEjJ386n7
 ClYVpeoDQy2UIBEQm1z6tUwRG1eRZa0ao5QeMyQZPBBmQ9GWU42ms4iFAU1CmBFar2Ad
 /H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=PiEKiV7OXlo1L7Z9MWkQ2TibsoGawYs0+jN/HTFtj5g=;
 b=hHCuyUZb9i6D9VAYECwRyNdMLXFnXKMIUWBZFTFhJ8nz6wb5dI4DHuzHHezufMHCXP
 ovJuuAuqXNu6eYQJCVOJWtK14kkWBbuLOSYRp5DD4cn5yRsNVM7MLcLCyWFzci9gnazi
 6pt6lLntxMFUeQ9OVTLUiROgw7WGCg2ZU4ATraVpkZihhxGZVr799ztIYNScsaZyg5HI
 uoXNzD+CUV0Lfh3PNYO/sswrMHeVUsC/reOmLw95Cs9l6AcKQIswluk5M+F8JK+kM2nW
 6fQXyOFY/ZLo4VBjtJLtIlsMJXHL06D0w2hq0kGLfq5mqJmVWKArFr28oU66gPqyor6g
 KJPw==
X-Gm-Message-State: AHQUAuYTeCkPgeexXWLBYanEwPxsxCIAMX1rV2O/Kx3LNawkvfyTk47x
 9j2BpPAMy/CfTJqqhOeRWi68kw==
X-Google-Smtp-Source: AHgI3Ia2Z3R+N5mt4FE+M8YXa5LIzT6YNo9F12DKe6DrcZhgqErjZRM4MX6JlppsHvz7KywcQprfyQ==
X-Received: by 2002:a65:4c01:: with SMTP id u1mr6691952pgq.116.1550255290295; 
 Fri, 15 Feb 2019 10:28:10 -0800 (PST)
Received: from ?IPv6:2601:642:c400:7877:8ce1:4e59:b8f:be36?
 ([2601:642:c400:7877:8ce1:4e59:b8f:be36])
 by smtp.gmail.com with ESMTPSA id v75sm10743292pfa.164.2019.02.15.10.28.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 10:28:09 -0800 (PST)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190215174034.GP32494@hirez.programming.kicks-ass.net>
Date: Fri, 15 Feb 2019 10:28:08 -0800
Message-Id: <FD23FA3D-DAF5-43C9-8888-09B4C2509460@amacapital.net>
References: <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
 <20190215174034.GP32494@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_102811_475548_0B32DE3E 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> On Feb 15, 2019, at 9:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Fri, Feb 15, 2019 at 09:18:00AM -0800, Linus Torvalds wrote:
>>> On Thu, Feb 14, 2019 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>> 
>>> Something like the below, right?
>>> 
>>> +       frame->flags = 0;
>>> +       frame->flags = 0;
>> 
>> Those are not valid flag values.
>> 
>> Can you popf them? Yes.
>> 
>> Do they make sense? No.
>> 
>> It has the IF flag clear, for example. Is that intentional? If it is,
> 
> Uhmm. yeah, that's bonkers. We should have interrupts disabled here.
> I'll go read up on the eflags and figure out what they _should_ be right
> about there.

And probably add a comment near the POPF explaining that it will keep IRQs off :)
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
