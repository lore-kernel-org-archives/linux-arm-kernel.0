Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:39:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4AE218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KEvhpuc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4AE218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+o1JWnPyZ28iE+rQmTQC30iu84zG5I8yKATJ6SCmHHM=; b=KEvhpuc+lql7xc
	mI9xciB8wQclGpIagxz18PDo7ZAiihHIV/+XPdhLOH0+bqVaC1CcXA5ILQSmDE7ebl2EFTLCkX2+7
	ton2da/wnzIP7Oakmx6+jkfTRdPhe6TTLchSPwZ+E8zBGJ8M5KiTN3iDt3uqUpE8LOKy6mKiLJl6y
	oGrMe/4AAQ79gMOJYZffm7DudI3m74N6d85yy5mj8mgs8SlkjVn55EkJPJ5ILVEID3KpB7RCyj10Z
	m9VF/gFc4Ov3UQ6oimDD+09r6PaIWiQriHRQcGfm4ZGjtpbwWrVYlaID/nKtCAzdihraBmSPlkNhd
	AognxIBJdDAf7q1jvIyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomLS-0003oN-Ok; Wed, 30 Jan 2019 09:39:46 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomLP-0003o3-DH
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:39:44 +0000
Received: by mail-ot1-f65.google.com with SMTP id u16so20559604otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xfqJpYjLPJU9hr+vSJUe0Tk4KYpvDcwI3A9ccP1pAxM=;
 b=Z4n+BKsROEw6/x/c9W8S84OStgWQxi2JsGvVF1UmS0ENnJM/oAQXqDOPb5y5U1OtRg
 Uebiv60K7IwGwXK5vqqD/3idzNaEdn55m584hFkGPIMbwT5jWz71MM/exeFHpi5nwzUB
 uC4b//S3h8Y/cbcFCvN5jEa0EJavZqJ67Ypcr7UQiI478ahuVHx02aOTDK/AP4gGg/+y
 g43lAAbYSDr+vnOSbFJgYkjgh8OwIbKO/k0bGZtXBoag9RGWAtvzZIV8j2A6/qZRxm3E
 jZkHdK+28W0dHF+DeoiO8GoamCU44akvMAqRhE/kqVhmLgdwGNHuLPMWgV3yZBQFnreJ
 PlYw==
X-Gm-Message-State: AJcUukdpRLC05uBbTIUZvZNsN6L3hIZ7kh6ereQ1C8ufPB7w4NdCjnan
 V2wsE/n2wztn5eRSoTG3sLNpPp8I2s6BijtECY8=
X-Google-Smtp-Source: ALg8bN5MauY/nMq3uFyPzgxOQRmBBRts3X2/VtxUWgqIGzsRRphC0idmZbkMleVRGOLH/jR2f0kSTW77ScG1lMeNCsY=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr20185440otf.124.1548841182133; 
 Wed, 30 Jan 2019 01:39:42 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
 <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
 <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
In-Reply-To: <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Jan 2019 10:39:30 +0100
Message-ID: <CAJZ5v0jLJ8Tu7Gpt-4bhW59Q3=PX4wyb2rFBWuPKMFHcFXBxAA@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_013943_445771_AE93AE07 
X-CRM114-Status: GOOD (  22.48  )
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

On Wed, Jan 30, 2019 at 10:14 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Geert,
>
> On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Vincent,
> >
> > On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> > >                 pm_runtime_mark_last_busy
> > >                     ktime_get
> > >                         do
> > >                             read_seqcount_begin
> > >                         while read_seqcount_retry
> > >     ....
> > >     write_seqcount_end
> > >
> > > Although we should be safe because we haven't yet changed the clocksource
> > > at that time, we can't because of seqcount protection.
> > >
> > > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> > >
> > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > Thanks for your patch!
> >
> > /**
> >  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
> >  *
> >  * This timestamp is not guaranteed to be monotonic across an update.
> >  * The timestamp is calculated by:
> >  *
> >  *      now = base_mono + clock_delta * slope
> >  *
> >  * So if the update lowers the slope, readers who are forced to the
> >  * not yet updated second array are still using the old steeper slope.
> >  *
> >  * tmono
> >  * ^
> >  * |    o  n
> >  * |   o n
> >  * |  u
> >  * | o
> >  * |o
> >  * |12345678---> reader order
> >  *
> >  * o = old slope
> >  * u = update
> >  * n = new slope
> >  *
> >  * So reader 6 will observe time going backwards versus reader 5.
> >  *
> >  * While other CPUs are likely to be able observe that, the only way
> >  * for a CPU local observation is when an NMI hits in the middle of
> >  * the update. Timestamps taken from that NMI context might be ahead
> >  * of the following timestamps. Callers need to be aware of that and
> >  * deal with it.
> >  */
> >
> > As this function is not guaranteed to be monotonic, have you checked how
> > the Runtime PM code behaves if time goes backwards? Does it just make
> > a suboptimal decision or does it crash?
>
> As a worst case this will generate a suboptimal decision around the update

So that should be explained in the changelog of the patch.  In detail,
if poss, please.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
