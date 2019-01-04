Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94242C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:23:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B4E21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NV5w0Ztn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MTf7F8H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B4E21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=am+LrRukiE3PPQAqh6w2n7r4RW3CD0yOG5JtLGR9Xhk=; b=NV5w0Ztnr9EFJt
	nXXhqaUxh6EAztXrZeFyqLt1WGuMFjR9Xitro/pxRd+nIsru2HRGiKTRgNEYjAYeeq+u/VWlRq9AP
	9qa3iF5x7jwTFAFjWHiDdtGT+UeRuJScjWZ/iQ/VppRySLFKY/61DHe/madLy9ziWwew59pkmQBeO
	fR5MSm2pT0R3s067v5s3bnKB9nf61GH9kDb7ilWs7LYKVvOIDNAnwci/hs3MLBVFoCODUc9Xrx/o2
	NzGUpTtY76sSkGjZyQEDiJJb1MrIqpijIm88zWtHiV1boXF72wL4SX8pbvJVXQoeO0u3pEoF+Dqyn
	BpyCJoLtFsNAJ50HKLfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfSFv-0003Cr-F7; Fri, 04 Jan 2019 16:23:31 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfSFs-0003CL-6U
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 16:23:30 +0000
Received: by mail-ed1-x542.google.com with SMTP id o10so32200535edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 08:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=miDxGg+YmvAT9Y3xAasJRZiV38oWMoZ+0BvWf8K6SjE=;
 b=MTf7F8H6L4yMCqEesbT9bG8kx+vEVAPgrqJGXhf9cabRrcWs7ZKrEkJIGT3nIwaIg2
 /CSlTaPG4JK14Pi/B0gVMaWqKwcvhL+l/N118J1f/kzox2Bc4DbcyKFNYxCEkyG8r514
 yXtwHu8DTTl1/02doXqRWav/S6hpkSRaAfz5AB5WFFb7bF8EqHWkrJSuzqvv7ThFKow0
 8OphvrFf0y3Ni+FPjE146avfm2BrQj6HY0oW8Ls/g8iLeAbXelmP6CIjPJcwLXAPKL5K
 +R7xNbkI5XmXV0k8yIGtWjUD/Hbj5yO2QLqXsiWeqMwFGKBx5v36rwC+LdZkZwpvvyXd
 FJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=miDxGg+YmvAT9Y3xAasJRZiV38oWMoZ+0BvWf8K6SjE=;
 b=ikDPtReK3AbakEKYVvegVQV4dwjNEKgYSVARMUuoU1dJZUNXC62wr4HUPKiNhcKBBQ
 8HF77dLYk/DA2OwXN3wKmRi9iTk7gEmAl7dkhWoF1Tm+lGdIOHKPRW0GUR4eP8Ysy4zf
 pHMA43A9CUrP4YacD6Aea+kKkN+Khc/BR0/g+SW7hBDgwGE7hYTCQjuxZTySVbIie7uG
 WeZtLdM3uWqUaGcOgWnaqglWrTPGTy35rCOPomI9+CN+SBkpNsponX2vJlMzBDNxS7n2
 E3QyNp1x9+kSQ4ex6DkI7VcQiVIia6+dOcYu3JLxPbAgwuDK4UAC9fZZxBYf6P7Qzl4d
 DGhA==
X-Gm-Message-State: AA+aEWb9P4BWnn/6c7ninU0VYJNmklvLE/fvJRfYk2g8rI0n+AVqzUQX
 KKZpsxdtIZJZvTp5SKjUNXcTfZhPWV5N6o55GXWrXw==
X-Google-Smtp-Source: AFSGD/XNhOTTfPs8uYlTIoMu02t6MWINZnhGzO5LQR/xPNE/ASUB+D55u72mACMwbHzkajMPJJecTWodQ5C6zuy1S0k=
X-Received: by 2002:aa7:cb56:: with SMTP id w22mr48211115edt.240.1546619005382; 
 Fri, 04 Jan 2019 08:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
 <20181226164509.22916-4-pasha.tatashin@soleen.com>
 <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
 <CA+CK2bA_006YGu3dtJM24pN1ZGgcJZnF2oEeWKkq3QBrcCbB6Q@mail.gmail.com>
 <86bm4wbff9.wl-marc.zyngier@arm.com>
In-Reply-To: <86bm4wbff9.wl-marc.zyngier@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 4 Jan 2019 11:23:14 -0500
Message-ID: <CA+CK2bCZHCp7d3SyiE2UpZr=K-NMPcGPVS0d-iU_7_tfcVmaGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: Early boot time stamps
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_082328_421424_BE69827F 
X-CRM114-Status: GOOD (  25.67  )
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
Cc: Michal Hocko <mhocko@suse.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 sboyd@kernel.org, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, rppt@linux.vnet.ibm.com,
 james.morse@arm.com, andrew.murray@arm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

Thank you for taking a look at this please see my replies below.

> > I think, given that on other platforms sched_clock() is already used
> > early, it is not a good idea to invent a different clock just for time
> > stamps.
>
> Square pegs vs round holes. Mimicking other architectures isn't always
> the right thing to do when faced with a different problem. We put a
> lot of effort in working around timer errata for a good reason, and
> feeding the rest of the system bogus timing information doesn't sound
> great.
>
> > We could limit arm64 approach only for chips where cntvct_el0 is
> > working: i.e. frequency is known, and the clock is stable, meaning
> > cannot go backward. Perhaps we would start early clock a little later,
> > but at least it will be available for the sane chips. The only
> > question, where during boot time this is known.
>
> How do you propose we do that? Defective timers can be a property of
> the implementation, of the integration, or both. In any case, it
> requires firmware support (DT, ACPI). All that is only available quite
> late, and moving it earlier is not easily doable.

OK, but could we at least whitelist something early with expectation
that the future chips won't be bogus?

> > Another approach is to modify sched_clock() in
> > kernel/time/sched_clock.c to never return backward value during boot.
> >
> > 1. Rename  current implementation of sched_clock() to sched_clock_raw()
> > 2. New sched_clock() would look like this:
> >
> > u64 sched_clock(void)
> > {
> >    if (static_branch(early_unstable_clock))
> >       return sched_clock_unstable();
> >    else
> >       return sched_clock_raw();
> > }
> >
> > 3. sched_clock_unstable() would look like this:
> >
> > u64 sched_clock_unstable(void)
> > {
> > again:
> >   static u64 old_clock;
> >   u64 new_clock = sched_clock_raw();
> >   static u64 old_clock_read =   READ_ONCE(old_clock);
> >   /* It is ok if time does not progress, but don't allow to go backward */
> >   if (new_clock < old_clock_read)
> >     return old_clock_read;
> >    /* update the old_clock value */
> >    if (cmpxchg64(&old_clock, old_clock_read, new_clock) != old_clock_read)
> >       goto again;
> >    return new_clock;
> > }
>
> You now have an "unstable" clock that is only allowed to move forward,
> until you switch to the real one. And at handover time, anything can
> happen.
>
> It is one thing to allow for the time stamping to be imprecise. But
> imposing the same behaviour on other parts of the kernel that have so
> far relied on a strictly monotonic sched_clock feels like a bad idea.

sched_clock() will still be strictly monotonic. During switch over we
will guarantee to continue from where the early clock left.

>
> What I'm proposing is that we allow architectures to override the hard
> tie between local_clock/sched_clock and kernel log time stamping, with
> the default being of course what we have today. This gives a clean
> separation between the two when the architecture needs to delay the
> availability of sched_clock until implementation requirements are
> discovered. It also keep sched_clock simple and efficient.
>
> To illustrate what I'm trying to argue for, I've pushed out a couple
> of proof of concept patches here[1]. I've briefly tested them in a
> guest, and things seem to work OK.

What I am worried is that decoupling time stamps from the
sched_clock() will cause uptime and other commands that show boot time
not to correlate with timestamps in dmesg with these changes. For them
to correlate we would still have to have a switch back to
local_clock() in timestamp_clock() after we are done with early boot,
which brings us back to using a temporarily unstable clock that I
proposed above but without adding an architectural hook for it. Again,
we would need to solve the problem of time continuity during switch
over, which is not a hard problem to solve, as we do it already in
sched_clock.c, and everytime clocksource changes.

During early boot time stamps project for x86 we were extra careful to
make sure that they stay the same.

Thank you,
Pasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
