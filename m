Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:26:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144921905
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IKUf3c8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144921905
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S7nfdP3BhJudpzxDibz0YnvRBgtN14RcJD/XyC0Pyyg=; b=IKUf3c8IsCHW6J
	GhshITRemqPoRtGsz2B8yYqJoPs0tRxhKiB9jJXAg6teAP+kKyM/ck0XSSZkKZOW86sd8hdatJ1/t
	tZZsPthckW6+2T3d82rsYtfAaY7H5zHAUoPSuaSioYYcdunBhZVY7irSQCN4pqf6lZeFKItBfUGa6
	11/+Gg/ebOYio6GFU1VlBiome7OaWDoCReZNhb6zt+E7j9PTh9joUW8Gntw/lvY/jiCsDjl3mQpQt
	GUSiNPySNVti13EsOVuV7wlT5bqHdukBN6mGUZlSurjHv82ZCMvVUS/ueCMGoOscay3HqHBPa4k9j
	8F+x2vF6NcXAEfIagvTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1fu-0006WK-Ts; Tue, 19 Feb 2019 09:26:50 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1eq-0005N0-I9
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:26:12 +0000
Received: from [IPv6:2601:646:8680:2bb1:8028:226d:d731:7182]
 ([IPv6:2601:646:8680:2bb1:8028:226d:d731:7182])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1J9LrJV2978378
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 19 Feb 2019 01:21:54 -0800
Date: Tue, 19 Feb 2019 01:21:44 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
References: <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>
From: hpa@zytor.com
Message-ID: <D9BA7815-5028-4000-8155-71955786B953@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_012545_180715_1C52FAFE 
X-CRM114-Status: GOOD (  22.71  )
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
Cc: dvlasenk@redhat.com, jpoimboe@redhat.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org, brgerst@gmail.com,
 bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On February 19, 2019 1:04:09 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>On Mon, Feb 18, 2019 at 02:30:21PM -0800, H. Peter Anvin wrote:
>> On 2/16/19 2:30 AM, Peter Zijlstra wrote:
>> > On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
>> >> This implies we invoke schedule -- a restricted operation
>(consider
>> >> may_sleep) during execution of STAC-enabled code, but *not* as an
>> >> exception or interrupt, since those preserve the flags.
>> > 
>> > Meet preempt_enable().
>> 
>> I believe this falls under "doctor, it hurts when I do that." And it
>hurts for
>> very good reasons. See below.
>
>I disagree; the basic rule is that if you're preemptible you must also
>be able to schedule and vice-versa. These AC regions violate this.
>
>And, like illustrated, it is _very_ easy to get all sorts inside that
>AC
>crap.
>
>> >> I have serious concerns about this. This is more or less saying
>that
>> >> we have left an unlimited gap and have had AC escape.
>> > 
>> > Yes; by allowing normal C in between STAC and CLAC this is so.
>> > 
>> >> Does *anyone* see a need to allow this? I got a question at LPC
>from
>> >> someone about this, and what they were trying to do once all the
>> >> layers had been unwound was so far down the wrong track for a root
>> >> problem that actually has a very simple solution.
>> > 
>> > Have you read the rest of the thread?
>> > 
>> > All it takes for this to explode is a call to a C function that has
>> > tracing on it in between the user_access_begin() and
>user_access_end()
>> > things. That is a _very_ easy thing to do.
>> > 
>> > Heck, GCC is allowed to generate that broken code compiling
>> > lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user
>(esp.
>> > with CONFIG_OPTIMIZE_INLINING), and making that a function call
>would
>> > get us fentry hooks and ftrace and *BOOM*.
>> > 
>> > (Now, of course, its a static function with a single caller, and
>GCC
>> > isn't _THAT_ stupid, but it could, if it wanted to)
>> > 
>> > Since the bar is _that_ low for mistakes, I figure we'd better fix
>it.
>> > 
>> 
>> The question is what "fix it" means. 
>
>It means that when we do schedule, the next task doesn't have AC set,
>and when we schedule back, we'll restore our AC when we had it. Unlike
>the current situation, where the next task will run with AC set.
>
>IOW, it confines AC to the task context where it was set.
>
>> I'm really concerned about AC escapes,
>> and everyone else should be, too.
>
>Then _that_ should be asserted.
>
>> For an issue specific to tracing, it would be more appropriate to do
>the
>> appropriate things in the tracing entry/exit than in schedule.
>Otherwise, we
>> don't want to silently paper over mistakes which could mean that we
>run a
>> large portion of the kernel without protection we thought we had.
>> 
>> In that sense, calling schedule() with AC set is in fact a great
>place to have
>> a WARN() or even BUG(), because such an event really could imply that
>the
>> kernel has been security compromised.
>
>It is not specific to tracing, tracing is just one of the most trivial
>and non-obvious ways to make it go splat.
>
>There's lot of fairly innocent stuff that does preempt_disable() /
>preempt_enable(). And just a warning in schedule() isn't sufficient,
>you'd have to actually trigger a reschedule before you know your code
>is
>bad.
>
>And like I said; the invariant is: if you're preemptible you can
>schedule and v.v.
>
>Now, clearly you don't want to mark these whole regions as
>!preemptible,
>because then you can also not take faults, but somehow you're not
>worried about the whole fault handler, but you are worried about the
>scheduler ?!? How does that work? The fault handler can touch a _ton_
>more code. Heck, the fault handler can schedule.
>
>So either pre-fault, and run the whole AC crap with preemption disabled
>and retry, or accept that we have to schedule.
>
>> Does that make more sense?
>
>It appears to me you're going about it backwards.

I'm not worried about the fault handler, because AC is always presented/disabled on exception entry; otherwise I would of course be very concerned.

To be clear: I'm not worried about the scheduler itself. I'm worried about how much code we have gone through to get there. Perhaps the scheduler itself is not the right point to probe for it, but we do need to catch things that have gone wrong, rather than just leaving the door wide open.

I would personally be far more comfortable saying you have to disable preemption in user access regions. It may be an unnecessary constraint for x86 and ARM64, but it is safe.

And Julien, yes, it is "somewhat arbitrary", but so are many engineering tradeoffs. Not everything has a very sharply definable line.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
