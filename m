Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47386C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBE520867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TtYg1Y11";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECdzdTRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBE520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQCF6ciKbFeQAHPZ3Ek0hxxE32rr6OZhlh+nGFU2SD0=; b=TtYg1Y11CIFcl8
	k0YuqoYBZ9sxV97d1jvX2QRBUCklT4M63vFD95d1BPw+yK4R6F1GjKTReM+01CkHVHMtK60vrxXK8
	JPgmmhI5FqdM1XeJw61qvzAy5eRCa8HK/CyeLqjxy65lbT6UUNgE0q5Ak0KTQ4jYS4sh8XTu7INKa
	d/1M75MvhpkeGKAxZYBfnR3ql5GKXHkD1nG5kEGavaY4JhtdXagzOqsi+QN/kz3TdmoxsHCh3d/8g
	gg/CID5kDEuYl9YG7obMff4wqTNWsTdJ3WPHD63cJ5Go7dURy/D8H52FT6gLmvOiReGttpoMdhNlI
	At0Ykz09nwx+ihiGeWrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnAX-0001WZ-Fi; Fri, 30 Nov 2018 18:05:37 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnAK-0001IQ-V9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:05:28 +0000
Received: by mail-it1-x144.google.com with SMTP id z7so10437222iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a43LC2+4MAeMgP4igS8FVKZSHAUCT+u0zToUDddAkqI=;
 b=ECdzdTRmPqsRenzzLUYd1cvwmKrJBeGDGQrZEkjBcvE3o95fimJc6FCHLuyHyccYM/
 Vv4lypSZU693Jyse70NWt0AhlCKdUq5E8Rko3m33dpJUOq/E4CHBEV04H6EGSXmxomZZ
 HQjCOBHJWdXGEz1XOHpm7hQr8IlV8FDRMLlDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a43LC2+4MAeMgP4igS8FVKZSHAUCT+u0zToUDddAkqI=;
 b=SMVKCik6cUOVHqiqkw7+uvfGen9sez9oRzgTcA1JWSLt6jt+8odTrvW/ZASN5NjnSv
 6jZIuZfHQpo+rNxnLi2JqDjx424BtiMKRKDTukdil8PWtab2dBkeQFUgST7GzShZntoc
 OdvZ/cg/5dR5pjoKpSuz1mMCdY9HdJC5jEVnt2ZncwWsvmC5lQtcs2upQctXbdOq8nZ8
 XuHZlGqRqLdVTrb0dYfg8V7pUEuGIdtXTzzECmX87BEXvCOfJIMOW+L7MkpoFMoi99GO
 4ZIbldcM2zhed9qj8fjyumCZ5Fqz5Fla7QVJqZHsslxZrRqFQUUfTPRpfIlMlo/SR+lR
 re9Q==
X-Gm-Message-State: AA+aEWYfZOHoR793Nwh2BKS8s4gX2c1J1KqflfXDXM0U6w8naUHwCNZ+
 MH7CTLoaOCoP5kfgv6paxnB1rnHTZQ5V8IAMYAXz0Q==
X-Google-Smtp-Source: AFSGD/UOutzJiAIsPArlD/Uevkn+hzwz7NexH+71fGQJB8JFciQ0GLyyriLXcKtUiUuT0kuD6lV9KgPB1VBZxV8WgXE=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6363976itg.137.1543601113722; 
 Fri, 30 Nov 2018 10:05:13 -0800 (PST)
MIME-Version: 1.0
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com> <20181129230915.GA8881@xps15>
 <20181130074253.GA3314@kroah.com>
In-Reply-To: <20181130074253.GA3314@kroah.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 30 Nov 2018 11:05:02 -0700
Message-ID: <CANLsYkwcbbrPAE1=_R-HZ4XtT7_=wyWVSaADbfis+_YjiuZfww@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_100525_515212_07B41E4D 
X-CRM114-Status: GOOD (  30.31  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 suzuki.poulosi@arm.com, Jiri Olsa <jolsa@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 at 00:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 29, 2018 at 04:09:15PM -0700, Mathieu Poirier wrote:
> > Hi Greg,
> >
> > On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> > > On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > > > This patch uses the PMU driver configuration held in event::hw::drv_config
> > > > to select a sink for each event that is created (the old sysFS way of
> > > > working is kept around for backward compatibility).
> > >
> > > It is "sysfs", no InterCaps please, I've never called it that in the
> > > past.
> > >
> > > And just use sysfs, if that does not work properly, then fix that, don't
> > > create yet-another-way-to-configure-this-thing to just confuse people.
> >
> > Thanks for the review, you've provided usefull comments.
> >
> > Regarding the "char *" argument for the ioctl, I followed an example that
> > currently exist but I can proceed differently.
>
> What driver currently uses a char * on an ioctl to parse arbritrary
> userspace information to set its configuration?  That should be fixed...
>

Perf filters [1] are communicated to the kernel as a char *.  Given
the dynamic nature of event creation I really don't know how else it
could have been done.

[1]. https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/perf_event.h#L459

> > My goal with this patchset was specifically to fix what is wrong with sysfs and
> > completely take it out of the equation.  The only reason to keep the kernel
> > interface alive was to prevent braking older user space perf tools currently
> > using it.
>
> That's fine, just don't create a new syscall that takes arbritrary data
> and parses it in the kernel, that's not ok.

You got it.

>
> > I chose to use an ioctl() because it is flexible and well suited for the dynamic
> > nature of perf events.  It is also currently used to set various event specific
> > configuration so doing the same adds to the established pattern and avoids
> > creating a new way of doing things, something the perf crew would have been
> > quick to point out.
> >
> > Was my approach wrong?
>
> I don't know how the perf interface works, so perhaps work with those
> developers to sync up and match what they use today?

I have already done a fair amount of work with them.

>
> But step back, what exactly are you trying to do here?  You have an
> implementation of a solution but I don't see the problem stated anywhere
> here.

In the coresight world there can be more than one sink to aggregate
trace data generated by CPUs, hence the need for users to select which
one to use from the perf command line.

Up until now sysfs was used to communicate sink information to the
kernel but that was never the right way to proceed because it breaks
when more than one perf session are created at the same time.  The
situation was manageable when working with per-thread scenarios where
a single HW trace event is created but in CPU-wide mode a HW trace
event is created for each CPU that is specified on the perf command
line, taking us back to the concurrency problem we have when dealing
with multiple per-thread session.

Since my goal is to add coresight support for CPU-wide trace
scenarios, the issue with sysfs concurrency needs to be addressed
first, which this set is aiming at.  Sysfs is a problem so I'm
removing it in favour of an ioctl() where a specific sink can be
assigned to each event.

The above should probably go in the cover letter.  Let me know if you
want more information.

Thanks,
Mathieu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
