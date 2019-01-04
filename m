Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24700C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F7221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="om4X3Rpu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dLIW1BkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F7221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EKQYt13o6oL1cAsADpP4Ko+8pH07sYyDUZ3SQjw7FvA=; b=om4X3RpubRYno3
	sOiGj7it61ZUFbs1eSLF64dEP+0PTEYcYm082pku807YSWKEZAKvE46cMyKWp3rXDKo/3V7stTrCx
	SxgD51eBvbiG4M81Q/DUFg07E+pKfREvbjH7KbGdRrUaF7Ut4ccHQJbOOouQ5BIMzUoajiHnlzq4K
	yHh089DoH+OHscjUgp4CkNaEGyyy3XNt4hcoc+tuDCpWLmbdFsB9EoKbriA+226nui+ocV/W62vzl
	TlE26rXyoiCgNCYosPsuSpaiHdk6SvDbq4x8aSF4Q3vjyExQjQk+zNxqVfnOc5TH9GVsiBLaGR0Kq
	oTLG2drge1JY57EYYVgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfWUI-0005PZ-Hc; Fri, 04 Jan 2019 20:54:38 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWUD-0005Ok-MN
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 20:54:35 +0000
Received: by mail-ed1-x543.google.com with SMTP id b14so32837091edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jgLnauOZkXoPtHurEq0Oj675WU+WR7c8BuPRsux1g84=;
 b=dLIW1BkFDXIrQxkNITRdb9L5EiSTpqzGsbIs32IbyQ3pZwjHb5l+Oqn3OwQy06lLTg
 FGqkc1s0gOCwtbBh48HEMNFjQXC7ykcc6oMr2FFIDf8x5jriybPLmS2cPQQW1GCy/EUx
 ahlfpPHwxJubS5g1bDHElcQFUQ3vylfEGZC+4F27DiutpPaxOzwZ/VXDf5v1EOU3w8xs
 SJ/DaxCmPd+3FSht8FS9Mny3qNWrXBuuI+y1AWL1nNJQoO2oY/59IggtqbS8AEoWmLsJ
 q0RcEiVnSwDbA0QUYk6gP4zJxlMO4vEnr7bWDnBBjVkZbSwWzvvs4QAVLdZ8fgWureJv
 XtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jgLnauOZkXoPtHurEq0Oj675WU+WR7c8BuPRsux1g84=;
 b=ODh+yAQ8FaAJ0motZUj9+juyTyzC48JYYKDWsO47CBeYN3VDzsd9QDOTmpcishFQeL
 WF86HqVgOkUnqTXR6DNBjQvO65wTwDspqmYMUTkyllHiY8diwo67GSWadcdZaKnOsUzf
 Wpe61ezRvABt1FmvrUtZ0C1RPWFavn3H2tgh/4czgkQTPYVfBVIh2Di3vdyWwA1V1Nio
 rS06WwrTzWz/DhuvlPNxVU3yihTw7evb8LBotxiaWdRvRLasqwCuthqaOM44LSpxzUzt
 /syXv5X0cGzhYQdZFrtry9VnCrH2c17JYooFqxdCWwq/boiK8ABRuFcbVTGOVgr8fvGc
 06gA==
X-Gm-Message-State: AA+aEWbkOSzUnDS5iA4UmO0+pJIXU9+W7iIz7iUoNxkzsFH4wHSuEOBh
 TE7WehYFG7DnA3PD/EzDvidBO4w+4rXa7nJocppowQ==
X-Google-Smtp-Source: AFSGD/WV2GWDyRSY5Vx6ILFoLgSS25PVv9o1SpyFwb649Vf3CGlvHX/6T2KnPylQxURgKy+W/spO2cCQ8lepipoebNs=
X-Received: by 2002:a17:906:1c5b:: with SMTP id
 l27-v6mr40169644ejg.118.1546635271379; 
 Fri, 04 Jan 2019 12:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
 <20181226164509.22916-4-pasha.tatashin@soleen.com>
 <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
 <CA+CK2bA_006YGu3dtJM24pN1ZGgcJZnF2oEeWKkq3QBrcCbB6Q@mail.gmail.com>
 <86bm4wbff9.wl-marc.zyngier@arm.com>
 <CA+CK2bCZHCp7d3SyiE2UpZr=K-NMPcGPVS0d-iU_7_tfcVmaGw@mail.gmail.com>
 <54caed52-2859-df94-1e3b-223397d42602@arm.com>
In-Reply-To: <54caed52-2859-df94-1e3b-223397d42602@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 4 Jan 2019 15:54:20 -0500
Message-ID: <CA+CK2bAMSspkLmvypqEgO-4mzNvE7JzjkkTWv7Pq-+DanZR+xw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: Early boot time stamps
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_125434_174076_9AFEF34F 
X-CRM114-Status: GOOD (  22.53  )
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

> > sched_clock() will still be strictly monotonic. During switch over we
> > will guarantee to continue from where the early clock left.
>
> Not quite. There is at least one broken integration that results in
> large, spurious jumps ahead. If one of these jumps happens during the
> "unstable" phase, we'll only return old_clock. At some point, we switch
> early_unstable_clock to be false, as we've now properly initialized the
> timer and found the appropriate workaround. We'll now return a much
> smaller value. sched_clock continuity doesn't seem to apply here, as
> you're not registering a new sched_clock (or at least that's not how I
> understand your code above).
>
> >> What I'm proposing is that we allow architectures to override the hard
> >> tie between local_clock/sched_clock and kernel log time stamping, with
> >> the default being of course what we have today. This gives a clean
> >> separation between the two when the architecture needs to delay the
> >> availability of sched_clock until implementation requirements are
> >> discovered. It also keep sched_clock simple and efficient.
> >>
> >> To illustrate what I'm trying to argue for, I've pushed out a couple
> >> of proof of concept patches here[1]. I've briefly tested them in a
> >> guest, and things seem to work OK.
> >
> > What I am worried is that decoupling time stamps from the
> > sched_clock() will cause uptime and other commands that show boot time
> > not to correlate with timestamps in dmesg with these changes. For them
> > to correlate we would still have to have a switch back to
> > local_clock() in timestamp_clock() after we are done with early boot,
> > which brings us back to using a temporarily unstable clock that I
> > proposed above but without adding an architectural hook for it. Again,
> > we would need to solve the problem of time continuity during switch
> > over, which is not a hard problem to solve, as we do it already in
> > sched_clock.c, and everytime clocksource changes.
> >
> > During early boot time stamps project for x86 we were extra careful to
> > make sure that they stay the same.
>
> I can see two ways to achieve this requirement:
>
> - we allow timestamp_clock to fall-back to sched_clock once it becomes
> non-zero. It has the drawback of resetting the time stamping in the
> middle of the boot, which isn't great.

Right, I'd like those timestamps to be continuous.

>
> - we allow sched_clock to inherit the timestamp_clock value instead of
> starting at zero like it does now. Not sure if that breaks anything, but
> that's worth trying (it should be a matter of setting new_epoch to zero
> in sched_clock_register).

This is what I am proposing above with my approach. Inherit the last
value of unstable sched_clock before switching to permanent. Please
see [1] how I implemented it, and we can discuss what is better
whether to use timestamp hook in printk or what I am suggestion.

[1] https://github.com/soleen/time_arm64/commits/time
sched_clock: generic unstable clock is a new patch, the other patches
are the ones sent out in this series. Because we use sched_clock() as
the last value calculating epoch in sched_clock_register() we
guarantee monotonicity during clock change.

Thank you,
Pasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
