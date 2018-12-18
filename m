Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:21:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A553C21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NhBPd+Xd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzX0gstJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A553C21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GkIv3bg/IlCkGFdEMtb3NgMi0E2YGEcNsShScs4tZLw=; b=NhBPd+XdwviYi/
	KA7aDBlp7WQNdspXCh8sudEJGSCnt/hWtPOsRqEwj45XcMH355QWCSgLLswpwhXK4N1mVkmK8p2to
	0ZxDKsghQ0+0iSEu/tjwVE4hoWWxXKKXLguhSA78lw//U+l02epAJ008tNAf00dfSkH92xl1fxafx
	0xIdwdAJDlvZmKa1cHgZBdbc8pHohDirWNduiPy0GkV1E8lruc33lQkX2LZSj1lHzOUOtJmgvBd54
	Mp3YUXwh4ZD8PlvlqL53Fagd65IuMBYmRphAzJjpUNtbgcPANm8S9R6w2suU/bodFVc/bLpTr/Wqy
	jSvsTRaW1ZyY8yfNz34g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJzc-0004N2-LJ; Tue, 18 Dec 2018 18:21:20 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJzY-0004Lb-Rf
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:21:18 +0000
Received: by mail-it1-x143.google.com with SMTP id c9so5610244itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tmT+ojIfzoXHWFIf8qOXXNgMtq0rxEi72K/Z9JRjJPw=;
 b=FzX0gstJyd6MVmcxjRorGwjgJe274/TUviKJ/OH6kdlchlQmmMQkenUDMeGLbjviDG
 4EESjlyd2q8YRAnxssqjo4mcNhuczWd8o7K5CQXiuC+7tEj+E6p7oZeKhEvW4Gl/0vXQ
 T1atS0G/kE/qY+vjHyjKc9qydo0xWlxWkdxyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tmT+ojIfzoXHWFIf8qOXXNgMtq0rxEi72K/Z9JRjJPw=;
 b=tgaa9+h1E42q5T+JlMy/7jWhaW1y0RVQZ0iDRC7b959szp+RAciYMc5oWSUyAYD8mt
 x8LY1z6RL1uVjqNiaJvRwsKuQ1FyobUUkW3XISWcKUsGPpMjmdfSbo5fbONzBUiOzXp2
 GdoM5rKMRtP3gfngOo7soaMY14D05+2zddHE8Unr8UAPS33i4HTuMYyop/aHrID6Mb10
 8c6FSCVrllFuwq0ZQEVoKiFfUyKKDEmCaKv3KLb95is1NGIVbWUKCmzof9dcRBBepfZf
 zurjp5yWKB8xbtcOw0UC3BpSORZk4ef8sHTAg0vwbYIhpi+UVf3kdTqhOUi3NenHH+Si
 Hc8g==
X-Gm-Message-State: AA+aEWZDbrY/MP1UoOgzi2OwHkJB2Gvh/NF5MnTOnMZd5x5I8U5CYfjf
 fdNAp6jREb7yVlrFnQDJ/zXAMksYQJNIMKGvGBlLtQ==
X-Google-Smtp-Source: AFSGD/XuUmFo3bfLd7K25mnDfyShkc8U2n4xcLNMV4oqPEO8UO2v8dqn0XxeEyyZBZxw0wyc2eWfaslaWDdL3NlF8sU=
X-Received: by 2002:a02:570d:: with SMTP id u13mr16451137jaa.71.1545157262994; 
 Tue, 18 Dec 2018 10:21:02 -0800 (PST)
MIME-Version: 1.0
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
 <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 18 Dec 2018 11:20:51 -0700
Message-ID: <CANLsYkwiQ6q9KTu7oK8gWiu2Rq+iVbRJnXxr5abZ1RSKgs1GyQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_102116_896710_6A4CBDB1 
X-CRM114-Status: GOOD (  23.82  )
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
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 suzuki.poulosi@arm.com, Jiri Olsa <jolsa@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Alex,

On Tue, 18 Dec 2018 at 08:21, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
>
> >> +    /*
> >> +     * The HW mapping of a component is unique.  If the value we've been
> >> +     * given matches the component's start address, then we must have found
> >> +     * the device we are looking for.
> >> +     */
> >
> > To be frank, I don't quite like the idea of passing the base address of the
> > component as the key to locate a device, (even though that is unique and readily
> > available). I would rather prefer a programmable way to map the keys to the
> > "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> > address is not obvious from the name). Also if we decide to use a platform
> > agnostic naming scheme, it becomes even more complex.
> >
> > We could assign a static "id/key" exported either via the device sysfs dir or
> > the "pmu" dir. I prefer the latter.
> >
> > Thoughts ?
>
> So, my understanding is that we have a bunch of trace sources and a
> bunch of trace sinks to choose from when we set up the perf event. The
> current model basically treats trace sources as PMUs and relies on the
> sink configuration process to be done via sysfs, which is not ideal as
> an API.

That is correct.  Most of the grief comes from the fact that when
tracing CPU-wide session sinks are concurrently used by more than one
CPU.

>
> The first thing that comes to mind is: can then the sinks be made their
> own PMUs, so the above can be done via the existing SET_OUTPUT ioctl?

I had a serious look at the SET_OUTPUT function as part of the
research that pre-dated implementing CPU-wide support for coresight.
The core does not allow events assigned to different CPUs to use the
same mmap'ed area, which is perfectly understandable.

To me the problem of sharing a sink between CPUs is inherent to
coresight and should be fixed within that framework (see full work
here [1] if interested).  The implementation associates a sink with an
mmap'ed area, just like PT and coresight --per-thread.  Where things
differ is that for coresight CPU-wide the sink is kept in function for
as long as a CPU is using it, ignoring other request for updates or to
switch it off.  So the first CPU to use it turns the sink on and the
last turns it off after collecting trace data from it.

Thanks,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/log/?h=cpu-wide-coresight

>
> Regards,
> --
> Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
