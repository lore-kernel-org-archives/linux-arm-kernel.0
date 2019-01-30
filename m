Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB9C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB92218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojTft120";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdFh7+Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB92218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qhQjRwAj88YnVwy/nxTsSwhDUN7cMTUzwF7PHLUhZEc=; b=ojTft120OQzR6D
	FLxP6n6dc55kgUV6W69+qan3xhI3huVUvMF0asI9BerFEN3fQHl860nqztLoroCJFAT+bF6sNxZOn
	QS7VX471FFaNs6/jHXP2sUUU+Hn1HJVInhd2fX43pFW0adEXaGl6lZ53zQ7boxxyAW4Wvz3kBG4uG
	/S8ceJMdizEe5BHXiFDFhvx8u6gjHOIhYsMYyNC1phcW0bDGQ2pnm/trG26twZVVFZO0jcJRqYQYP
	VoJ3V7758aVHGv9GAy8DPapRXTI7AJlAxZAiaamGY/AlcV5GQj2atH3J90N/8riL5C5jf5zEnXUoN
	1h/qom0s5OvxvfghUAuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomN9-0005uy-PK; Wed, 30 Jan 2019 09:41:31 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomN6-0005uL-9b
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:41:29 +0000
Received: by mail-it1-x142.google.com with SMTP id z7so9262874iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8p9guxdW2dSYDedRw8V3sEOTdwxjxH/BsBrvfgqOjy8=;
 b=ZdFh7+Lhxhub53RHgUUM9RREUxH4vj+Bk6LWu3q71VlW0oV46Fr0Tf22AWvvePQ0fc
 jTZr3dpWZcPFH+74QeiIL9IHAwIsVqyU8O76Oxe3KTsDayGHhUbj4ZIhZWeHD3djGZMZ
 CD6SgSyevqgMvsMsyRDw+Iu8D+IKMHS42eb3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8p9guxdW2dSYDedRw8V3sEOTdwxjxH/BsBrvfgqOjy8=;
 b=uLhZviHPKImMUvfZAtw40C1kyvNfKBed5V3ToUtk6/HfK6kdH85c9SkLI8EoyRUvzT
 QdcWhv8cpk0QrcaBcuxeg7Mtaw+X2BwN1aMHVj46gsstkPA+GECIWLLrv58yn/513ITB
 UvnWJX7cTi/OX2Y7vUCmBbPNCOMJqUQ9K0nfmzuqJ7N3nBsj3ByO/E8x9/am9ICK/HQB
 bxSUpq+VtqeURJv99AsCHcih2KguvR3m0fy52gu09twFMcaIliCOvmDTOPsEZ86jAsG9
 deSAS8tJ8l0ZwL62GX0mSvXcMsGvKInbqjMxa+qDWNkw5a61HTgwCgG/V07Ftuba/oBc
 sTCQ==
X-Gm-Message-State: AJcUukcGgUDqznXw7gdr8fwQ8G4vFjFthCaYMhsV9x64XqFsmJQyurgW
 KE62r5Ep6BC5iw+ReruZvKhAvLq9bK/omH8PkKeFQafYh6Y=
X-Google-Smtp-Source: ALg8bN5wn920FaduALkeh2LPYs0Nvrhp5D8Zd6duGp1ooTD7vwwPGF+V+15A3oTd8AWgW0wQ80vD2es1aExkzfw/aiI=
X-Received: by 2002:a02:7f08:: with SMTP id r8mr15823080jac.20.1548841287480; 
 Wed, 30 Jan 2019 01:41:27 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
 <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
 <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
 <CAJZ5v0jLJ8Tu7Gpt-4bhW59Q3=PX4wyb2rFBWuPKMFHcFXBxAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jLJ8Tu7Gpt-4bhW59Q3=PX4wyb2rFBWuPKMFHcFXBxAA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 Jan 2019 10:41:16 +0100
Message-ID: <CAKfTPtD+Yd7fBw=PhnedYmkGGW-JhNiZ739B-8YD7pFJEe9wig@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014128_337200_B2D6E89D 
X-CRM114-Status: GOOD (  23.85  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 10:14 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Geert,
> >
> > On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > > The call path is:
> > > > change_clocksource
> > > >     ...
> > > >     write_seqcount_begin
> > > >     ...
> > > >     timekeeping_update
> > > >         ...
> > > >         sh_cmt_clocksource_enable
> > > >             ...
> > > >             rpm_resume
> > > >                 pm_runtime_mark_last_busy
> > > >                     ktime_get
> > > >                         do
> > > >                             read_seqcount_begin
> > > >                         while read_seqcount_retry
> > > >     ....
> > > >     write_seqcount_end
> > > >
> > > > Although we should be safe because we haven't yet changed the clocksource
> > > > at that time, we can't because of seqcount protection.
> > > >
> > > > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> > > >
> > > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >
> > > Thanks for your patch!
> > >
> > > /**
> > >  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
> > >  *
> > >  * This timestamp is not guaranteed to be monotonic across an update.
> > >  * The timestamp is calculated by:
> > >  *
> > >  *      now = base_mono + clock_delta * slope
> > >  *
> > >  * So if the update lowers the slope, readers who are forced to the
> > >  * not yet updated second array are still using the old steeper slope.
> > >  *
> > >  * tmono
> > >  * ^
> > >  * |    o  n
> > >  * |   o n
> > >  * |  u
> > >  * | o
> > >  * |o
> > >  * |12345678---> reader order
> > >  *
> > >  * o = old slope
> > >  * u = update
> > >  * n = new slope
> > >  *
> > >  * So reader 6 will observe time going backwards versus reader 5.
> > >  *
> > >  * While other CPUs are likely to be able observe that, the only way
> > >  * for a CPU local observation is when an NMI hits in the middle of
> > >  * the update. Timestamps taken from that NMI context might be ahead
> > >  * of the following timestamps. Callers need to be aware of that and
> > >  * deal with it.
> > >  */
> > >
> > > As this function is not guaranteed to be monotonic, have you checked how
> > > the Runtime PM code behaves if time goes backwards? Does it just make
> > > a suboptimal decision or does it crash?
> >
> > As a worst case this will generate a suboptimal decision around the update
>
> So that should be explained in the changelog of the patch.  In detail,
> if poss, please.

Ok, I'm going to update the commit message

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
