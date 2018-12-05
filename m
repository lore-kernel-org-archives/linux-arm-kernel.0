Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28440C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:03:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAACF20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dQDlCGXY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AJblSxBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAACF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5kZhifdicqmY21L3WNVIq1xKMFRCeadE+XxzUyeF5Ao=; b=dQDlCGXYqauT7S
	LtWewJs9x7TLkt/EBHc+Zpmr2r53Nk7sAS2ahEnPYxL1rL/pyme6nVPgwncjaWM7yBQYqLEkVeXNT
	nSR10otYOqcmU7XMo8fLTB2klYjrGQoiY0ZtAqALjn9WcbLrFTuuELz8ZEjSUXJh04YeqilFtoqCl
	HL25PaoKfyu0JPjtiOvJi7H1JN6Tc5tMvlU5HFtvyP8+hXtlDeGw+oh64S0sLY9gwDUgIrT5tRxqT
	e/Qk10u0bAtf9l0FiaPjf51Q8fdwCgw1tLMbv6ZCa6Kvt10vK+x9636efbQBohA1AkJyPb0ohfEDu
	1c4gYnShf007+BvrONaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZdW-00051r-0l; Wed, 05 Dec 2018 16:02:54 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZcu-0004Li-Iw
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:02:31 +0000
Received: by mail-qk1-x741.google.com with SMTP id 189so12130527qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q63NP6HHv8MmLXxuAIzKXrKWfuE1xKbiTqkCNXb9RGw=;
 b=AJblSxBh6qa0ivGrrvlx7jfgkSEqUZpnF5+m/gHsll81N+WTkvBL/+26tQ2C+MHKfG
 4TUfaRVpRRYK/OqnoQ+PmgCKzdqg+iX7IEEs8QQMsd4X2zYBJ4Mcs+Mw+BhS7fk/L4Mu
 I4bSjcxrFt7QofF1LhXElnIu3svO/RWDxm0Zfm8EDOri/0lavK5IqrheFyNrnHjGvwgh
 Mh5pxXS4yPM8jCp2tYR2vXmsNwJuUNvV/GvYrTV0EKwIm4bi6nVieDZRcURis8SFu0kX
 T2NGgFjzsFHi9eLTKm0dCID/XGv+xCPRCh4WOOtthnATSL+hgrSurmkG3f9j0f8357Jl
 Njug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q63NP6HHv8MmLXxuAIzKXrKWfuE1xKbiTqkCNXb9RGw=;
 b=dmDGEWagzG0lP9OK5YjpF2qQ+7ENvM3lkdny3yIJa6Ri/jq3iH7s9DCG85ulGLANFP
 y+hREP2GdAAk3nJJ21UnpCiJEcFKW02D7GdX6XXNTAhRxOHL2uXKKTLxTlq0ZF4tV6Tq
 YLTrjEMu9m5AtkpbXe0rnWVrPUuu3w3Ga/6rj9QLxVCz+yR5mmzXX/1jIkskjRug0e2S
 BFIFkt89weSFiPlOBGSHgolfBZsCPKUTMEUakI5iEC33RFFWdlASqJSBr7EDMgAxa6JV
 FoNaFuSvHoNXr8+oHDS7xSei4fL8cPR1d8j2h2xTZbusMi7gDTsNGYZc03pC9eCENKmA
 aWrw==
X-Gm-Message-State: AA+aEWbC++KKN3o2FQp28hz346qkShXus18v1Q1neaYXUvd7l5gd5Z77
 cdqaSMacHy+kwKtvncOoL1hk2w==
X-Google-Smtp-Source: AFSGD/WXASXlWCPCtfJgJzLkQJFNd+29a5HpSHF2hcpSNlm5NwF5/SumXGrVcWxucHB1Gx46wRG+pw==
X-Received: by 2002:a37:9181:: with SMTP id
 t123mr22081025qkd.187.1544025722700; 
 Wed, 05 Dec 2018 08:02:02 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net
 ([40.117.208.181])
 by smtp.gmail.com with ESMTPSA id p47sm14181745qta.36.2018.12.05.08.02.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 08:02:01 -0800 (PST)
Date: Wed, 5 Dec 2018 16:01:59 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 1/1] arm64: Early boot time stamps
Message-ID: <20181205160159.qetplipng3bhrgnb@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
 <20181120144340.30201-2-pasha.tatashin@soleen.com>
 <20181121174706.GC9801@arm.com>
 <20181121175841.if3vyumzvw3yoovi@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <86lg5lrygq.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86lg5lrygq.wl-marc.zyngier@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_080217_025917_6575BA01 
X-CRM114-Status: GOOD (  25.60  )
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
Cc: mhocko@suse.com, ard.biesheuvel@linaro.org, sboyd@kernel.org,
 catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com, james.morse@arm.com,
 andrew.murray@arm.com, akpm@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-11-22 14:14:29, Marc Zyngier wrote:
> On Wed, 21 Nov 2018 17:58:41 +0000,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> > 
> > On 18-11-21 17:47:07, Will Deacon wrote:
> > > > +	/*
> > > > +	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> > > > +	 * the timer frequency. To avoid breakage on misconfigured
> > > > +	 * systems, do not register the early sched_clock if the
> > > > +	 * programmed value if zero. Other random values will just
> > > > +	 * result in random output.
> > > > +	 */
> > > > +	if (!freq)
> > > > +		return;
> > > > +
> > > > +	arch_timer_read_counter = arch_counter_get_cntvct;
> > > 
> > > Why do you need to assign this here?
> > > 
> > > > +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);
> > > 
> > > arch_timer_read_counter can be reassigned once the arm_arch_timer driver
> > > has probed; what stops this from being unused as the sched_clock after that
> > > has happened? I worry that toggling the function pointer could lead to
> > > sched_clock() going backwards.
> > 
> > No reason, I will revert it back to use a local variable.
> 
> I think the issue is that you are doing an assignment for something
> that the kernel has already statically initialized.
> 
> > I agree, time can go backward for a period of time while we switch
> > to permanent clock later, if that clock is different.
> 
> It is worse than that. You're setting up sched_clock with an
> unreliable clock source which can go backward at any point, not just
> at handover time.
> 
> I'd rather we have the timestamping code be able to use another souce
> than sched_clock, and eventually switch to it once sched_clock is
> registered (and properly corrected.

Hi Marc,

The early sched clock is implemented the same way on SPARC and x86: it
uses the sched_clock() interface to get timestamps. In addition it can
be used be engineers to precisely measure and debug early boot problems
by directly inserting cheap sched_clock() calls into code. Ftrace might
also be extended in future to support early boot.

I am not sure it is a good idea to invent a different interface that
would be used by printk() only for timestamping early in boot.

During the hang over from unstable to stable the sched_clock_register()
does the right thing and calculates the offset where the last clock
ended and new started.

In unlikely even if on some broken chips time goes backward, it will
happen during early boot only. Do you know if there are arm64 chips
exist where time may go backward? We can either don't do early boot
clock on those chips, or modify sched_clock() to check for the last
return value, and make sure that it is always smaller than the new
return value.

Thank you,
Pasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
