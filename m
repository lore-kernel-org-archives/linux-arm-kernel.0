Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF63C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4686C222A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MxUwIZW5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT2qr0qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4686C222A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JKfvNh19LIZXe6Oj34b/c0tTZgB5CnIBBCOAOMhWxPs=; b=MxUwIZW54MF1JK
	RTfIr1S/HQLkuVYsO9yceV3KOzlNf3S+8Kb365TUXQcEu8YU3OqWAZ+v8VwpQTA9JVqcTDoZbskRk
	hyINJ6R1Jjm3R36v79ZX02nGLke8kyRTI/QPUS98aENL4zyOeF98AyYxpthOKxMTmRvM1UlBaLDua
	FAh+DTnp+09cYm+Rs0bJ9fC1ERVD7wPMQDKUZ8y5PWXKdkoY79WJsWAmeOXZfN9wAvKBGXJM0RofY
	pELG0btVU1CcM+BCNXA7JhZMmOBmXiBF/lUg3Li6Y6XsZ1nBPmf90GZIgR4MMdhB8RBBCALkLWMRX
	I7gIxM6vzgbxOLeHDA9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBtv-0007B9-Vu; Mon, 11 Feb 2019 13:45:35 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBts-0007Ah-5x
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:45:33 +0000
Received: by mail-wm1-x344.google.com with SMTP id m1so17769463wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kQ7WC4iZI0fH6JBvX0aLtoUPVjSMED/F+NlHmiD49ko=;
 b=LT2qr0qIXv6/ktARX7i5PMn65EkcaKQc7yZn0FRAwk+kJ1MXNtu9RJtyQSqw4+OV91
 A7/G8jcvl+0aCIZ6SRtNHm+Y3YhUgXgg3ZRhZkOQ8L0UzLIaB/Q0cpydGucC5S4G61HZ
 Eaj7DmNd3Ky+P3ZUITc6JMvXRDrlZHgItB2rXCk0JXNArVsji9Tr7CUW3j3yp70awD1H
 qN+WqTJclwt8bqWGb4jmKkWtaUen3Qt/U/Z0lghIbV+0olOWrDErdVcwhEokC4BXtG5G
 y/pB4sMZbfbw52un5PrytcB7m5+OP0nLtT8BtWA5OynIfOXxUyn6ADNy2gVEnAxrb93O
 l9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=kQ7WC4iZI0fH6JBvX0aLtoUPVjSMED/F+NlHmiD49ko=;
 b=DJr6d7ofTz0BJKzbJwxBA2Z2uyyjoHU1HnvBpFCnRrlLPALpA2PHSqbHkpzT76Zyi5
 f4mp7kl9xQ72mXf9MFIiRHsFNUHRVyJTTI1esRxDIYFnQX2KMcvGeVVyHVsc0WGvnfSq
 3uKbjNc3jCtdANMPuPUbLiZF/5Ou/ZCF5wE8gYYZeOaC3je2rSWE7+DMn6YwzbwIQD+c
 nNpKTWUx6xxEFCNECn+GWPWmkl6p7Z09nR1of4sXEk6f/9vqurvI0mCSs+gF8r87m++2
 nQBaG0CBZbeZIGsbOGj7rtxAAGe7L/2EuzYMnPoLNTH7UYCxFmaTvRYobLyqMfpWVFYx
 p7uw==
X-Gm-Message-State: AHQUAuZ2jv8X0sfYRQY/wtnbctsfRjpIRHO5j+pZX9X0p4G6awH4mrS5
 qghEAaWYmryzolNAP5Y1Pag=
X-Google-Smtp-Source: AHgI3IbblIEnoeWnYPSuxq6O3lsra7nrKFC/Q9SUJ1OItngkkqSK64xtlcDyecdSSnNKKGnkytztcQ==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr5450747wma.114.1549892730345; 
 Mon, 11 Feb 2019 05:45:30 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id y1sm13560363wru.4.2019.02.11.05.45.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 05:45:29 -0800 (PST)
Date: Mon, 11 Feb 2019 14:45:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190211134527.GA121589@gmail.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_054532_246678_F3469269 
X-CRM114-Status: GOOD (  21.23  )
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
Cc: peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, james.morse@arm.com,
 hpa@zytor.com, valentin.schneider@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Julien Thierry <julien.thierry@arm.com> wrote:

> While running a user_access regions, it is not supported to reschedule.
> Add an overridable primitive to indicate whether a user_access region is
> active and check that this is not the case when calling rescheduling
> functions.
> 
> These checks are only performed when DEBUG_UACCESS_SLEEP is selected.
> 
> Also, add a comment clarifying the behaviour of user_access regions.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> ---
>  include/linux/kernel.h  | 11 +++++++++--
>  include/linux/uaccess.h | 13 +++++++++++++
>  kernel/sched/core.c     | 22 ++++++++++++++++++++++
>  lib/Kconfig.debug       |  8 ++++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 8f0e68e..73f1f82 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -237,11 +237,18 @@
>  struct pt_regs;
>  struct user;
> 
> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> +extern void __might_resched(const char *file, int line);
> +#else
> +#define __might_resched(file, line) do { } while (0)
> +#endif
> +
>  #ifdef CONFIG_PREEMPT_VOLUNTARY
>  extern int _cond_resched(void);
> -# define might_resched() _cond_resched()
> +# define might_resched() \
> +	do { __might_resched(__FILE__, __LINE__); _cond_resched(); } while (0)
>  #else
> -# define might_resched() do { } while (0)
> +# define might_resched() __might_resched(__FILE__, __LINE__)
>  #endif
> 
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 37b226e..2c0c39e 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -263,6 +263,15 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  #define probe_kernel_address(addr, retval)		\
>  	probe_kernel_read(&retval, addr, sizeof(retval))
> 
> +/*
> + * user_access_begin() and user_access_end() define a region where
> + * unsafe user accessors can be used. Exceptions and interrupt shall exit the
> + * user_access region and re-enter it when returning to the interrupted context.
> + *
> + * No sleeping function should get called during a user_access region - we rely
> + * on exception handling to take care of the user_access status for us, but that
> + * doesn't happen when directly calling schedule().
> + */
>  #ifndef user_access_begin
>  #define user_access_begin(ptr,len) access_ok(ptr, len)
>  #define user_access_end() do { } while (0)
> @@ -270,6 +279,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
>  #endif
> 
> +#ifndef unsafe_user_region_active
> +#define unsafe_user_region_active()	false
> +#endif
> +
>  #ifdef CONFIG_HARDENED_USERCOPY
>  void usercopy_warn(const char *name, const char *detail, bool to_user,
>  		   unsigned long offset, unsigned long len);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a674c7db..b1bb7e9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>  		__schedule_bug(prev);
>  		preempt_count_set(PREEMPT_DISABLED);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> +	    unlikely(unsafe_user_region_active())) {
> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> +		       prev->comm, prev->pid, preempt_count());
> +		dump_stack();
> +	}
> +
>  	rcu_sleep_check();
> 
>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  EXPORT_SYMBOL(___might_sleep);
>  #endif
> 
> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> +void __might_resched(const char *file, int line)
> +{
> +	if (!unsafe_user_region_active())
> +		return;

Could you please more clearly explain why you want/need an exception from 
the __might_resched() debug warning?

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
