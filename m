Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3915521B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tf7LBOnH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+Se9Qfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3915521B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I1P779Itgr2Zs5XhILTZ1QMXa7XLzFp3PN2to8Y6GIU=; b=Tf7LBOnHz+gs4l
	DilGsVoqeLuqwSl5ES4ExhE5JXvpV3EgK6j+JT4kMm6oxJbGwOn8nUuL19KG+zzrZ5Nw6uaj08U3O
	vazO2V1xx98rdbTlYRmFCnJxqKO5/kVAQq/LUKRfW8xPwMNKt6g1fgxiaqNSrUUpXw2zMdWO+ixaY
	RH1ZQDNn9i//wkaZ9kU+C67fIFPP4sTmU3Ew+oXXsQAY+KJx31axWiOA+fMFFMqcOkkYLkFURVRx3
	jYb/SOzLhOC7m4hmzpvJkd9UCM16Z1grezD3xhE2j9dzoBfiCwsMAl3P36P7hP7Z5ujuY3/d0Xe/P
	B99senBnKsIh6q5PscmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtFxj-0003wj-As; Mon, 11 Feb 2019 18:05:47 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtFxf-0003wJ-PI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:05:45 +0000
Received: by mail-vs1-xe41.google.com with SMTP id x1so6800163vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dSXJwo4OQXQxRsTOCSe23Gk1F/94WN7WPyLUpxDsV/I=;
 b=B+Se9QfzrAua3HqPolh9Fh4/IEL5hPggcfF+qYSrbT6IcwjJGHsI8kW7aN4usPY7JB
 8IjQv9ryeZQw33IK7c/iQ4anLNz0YFFCVPcbYpnDzb7shMB04D6gt9jYw3IBZHgYYRnV
 0+I0a4ovqSGDe79QtfA+A3PwCbM+z4IxQjsQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dSXJwo4OQXQxRsTOCSe23Gk1F/94WN7WPyLUpxDsV/I=;
 b=rfPZymYdA6utpOm2HN3peiGhsYQ48dbBXuoHQO071PAct/yv9Z/cM0aGl4tSRx++OV
 T30TMG+LXX5mtdHdwr75crL6rILtD2Ho1t3tX3w4OwCmQ1vAtM6b4RCPMGwnc8Y7zpPj
 64xMTi+k6lOOMqHREC+qrUXZjvb5u+QrHAAhgyFgn9uY+S9t7o6pmLxQ2Qg8hf45KlO7
 sI3Lii+yBl/RaNCYcpB1h/LJPlb4MC3qF/xZIkECTqkURLBhbyBjdhVen0ZlAUr8DmrV
 9JVQ+SDndwjFzKHJArVFRHmocYdJK5Z9gPm8fCKJrYv5mTavbNhOLGXIroLAC8+GpMmm
 Ju8A==
X-Gm-Message-State: AHQUAuaKJKwPg0GbfqeWfSRrNTYqqnuJ+qdRdOuXJyHWvacBk603Kevl
 AxLIlRjqXBdUhyBLIOH1IUTy8iLuGJQ=
X-Google-Smtp-Source: AHgI3IbbkmFVx40kbqdktkABm5oelgY94ifpPQNfItSE19K/ERgLTROCimiACmK3bcsxCHY0kim5kw==
X-Received: by 2002:a67:fd8b:: with SMTP id k11mr4758277vsq.226.1549908341602; 
 Mon, 11 Feb 2019 10:05:41 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com.
 [209.85.217.46])
 by smtp.gmail.com with ESMTPSA id t133sm12332715vsc.8.2019.02.11.10.05.40
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 10:05:40 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id s16so6837952vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:05:40 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr14954430vsv.20.1549908340104;
 Mon, 11 Feb 2019 10:05:40 -0800 (PST)
MIME-Version: 1.0
References: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
 <20190204131241.GB46085@lakrids.cambridge.arm.com>
In-Reply-To: <20190204131241.GB46085@lakrids.cambridge.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Feb 2019 10:05:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQaYym4gv+GMOQWYm_dCkqp+JTP-q17OPa0NETcq1+oQ@mail.gmail.com>
Message-ID: <CAD=FV=UQaYym4gv+GMOQWYm_dCkqp+JTP-q17OPa0NETcq1+oQ@mail.gmail.com>
Subject: Re: Possible to annotate ARM64 IRQ handling to help gdb?
To: Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_100543_845573_E871EBA1 
X-CRM114-Status: GOOD (  24.29  )
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
Cc: kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>,
 Stephen Boyd <swboyd@chromium.org>, Caroline Tice <cmtice@chromium.org>,
 Dave Martin <Dave.Martin@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Feb 4, 2019 at 5:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 01, 2019 at 01:38:05PM -0800, Doug Anderson wrote:
> > Hi,
>
> Hi Doug,
>
> > I was wondering if anyone out there has given any thought to
> > annotating the ARM64 IRQ handling in such a way that we could stack
> > crawl past el1_irq() when in gdb.
> >
> > I spent a bit of time on this a few months ago and documented all my
> > findings in:
> >
> > https://bugs.chromium.org/p/chromium/issues/detail?id=908721
>
> There, the error from GDB is:
>
>     Backtrace stopped: previous frame identical to this frame (corrupt
>     stack?)
>
> ... is that misleading?
>
> ... or do we have some duplicate stack frame that we somewhow skip in
> the kernel unwinder?

If I had to guess I'd say that when gdb doesn't see a frame it
recognizes then it just returns the previous one, which causes it to
stop.  I don't think gdb falls back to just looking at the link
register because it needs more.


> > I can copy and paste all the discussion from that bug here, but since
> > it's public hopefully folks can read the discussion / investigation
> > there.  To put it briefly, though: I can stack crawl past "el1_irq"
> > with the normal linux stack crawl (which is what kdb uses) but I can't
> > crawl past "el1_irq" in gdb().  After talking to some of our tools
> > guys here I'm fairly certain that we could solve this with the right
> > CFI directives, but when I poked at it I wasn't able to figure out the
> > magic.
>
> AFAICT, we don't know why GDB is terminating early. Could we please
> figure that out first? e.g. by looking for the above message in the GDB
> sources.
>
> If we do need CFI annotations, I'd rather move that entry code to C
> first, to minimize how painful that is. I have an ongoing project [1] to
> do just that...
>
> Thanks,
> Mark.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm

OK, I tried this.  It _changes_ the behavior but doesn't magically get
me get a full crawl.  If something like this is likely to merge to
mainline before too long then it makes sense to spend the time
debugging it instead of the old code...

---

Vanilla v5.0-rc6 on kevin:

#13 0xffffff801013e08c in generic_handle_irq_desc
    (desc=0x1)
    at .../include/linux/irqdesc.h:154
#14 generic_handle_irq
    (irq=<optimized out>)
    at .../kernel/irq/irqdesc.c:628
#15 0xffffff801013e110 in __handle_domain_irq
    (domain=0xffffffc000211880, hwirq=<optimized out>,
     lookup=<optimized out>, regs=0xffffff8011003ce0)
    at .../kernel/irq/irqdesc.c:665
#16 0xffffff8010081124 in handle_domain_irq
    (domain=0x1, hwirq=<optimized out>, regs=<optimized out>)
    at .../include/linux/irqdesc.h:172
#17 gic_handle_irq (regs=0xffffff8011003ce0)
    at .../drivers/irqchip/irq-gic-v3.c:367
#18 0xffffff8010082bf4 in el1_irq ()
    at .../arch/arm64/kernel/entry.S:609
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

---

Vanilla v5.0-rc6 + your patches on kevin:

#13 0xffffff801013e3cc in generic_handle_irq_desc
    (desc=0x1)
    at .../include/linux/irqdesc.h:154
#14 generic_handle_irq
    (irq=<optimized out>)
    at .../kernel/irq/irqdesc.c:628
#15 0xffffff801013e450 in __handle_domain_irq
    (domain=0xffffffc000211880, hwirq=<optimized out>,
     lookup=<optimized out>, regs=0xffffff8011003ce0)
    at .../kernel/irq/irqdesc.c:665
#16 0xffffff80100810c4 in handle_domain_irq
    (domain=0x1, hwirq=<optimized out>, regs=<optimized out>)
    at .../include/linux/irqdesc.h:172
#17 gic_handle_irq
    (regs=0xffffff8011003ce0)
    at .../drivers/irqchip/irq-gic-v3.c:367
#18 0xffffff8010084fd0 in call_on_stack
    ()
    at .../arch/arm64/kernel/entry.S:718
Backtrace stopped: Cannot access memory at address 0xffffff8010004008


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
