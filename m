Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4862AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1524B2229E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nxzTV3aV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HIoJUUUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1524B2229E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eFlenhbKov+ATjQtFypzPMDTNNLBVFIFF8R9INLy4gI=; b=nxzTV3aVcgsIAm
	9iRV9jPcQvYql4YJalPXwEhqEnp0Pfl/xVaQ198oAiXXodaClAVRQ2s+gBm74+BGa4F6qJbbc/U1L
	3GtQxOc84Tt43XtOSP49Y7OyHiS5Fc4ZnhWOxZ0eMzj3skHc+aQ3SMrJqkQ1QcbDhmc8TkcRghZ0i
	piajqS9c6soAhJWmQVg0tGzgi3mMQ/YOQuPJGW2Sfs+r6yGK7LAH1BS8TKZv9Y8gb4KyIw4htjrA+
	/OOM72qZ+obmh3vNoPfA1MqEgcEpUvrr9l6BNd/lXpALdtA9HN3GStr+4luISJIwu3qvTpie3crFb
	b3f1+B6hSF25cyWAyoaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtFMh-00064z-Ff; Mon, 11 Feb 2019 17:27:31 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtFMe-00063r-Kq
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 17:27:30 +0000
Received: by mail-ua1-x943.google.com with SMTP id d21so3672273uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 09:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c1Y3U26ER5RjMUStylendzwqWoHIXo7Zk+HrmSkcSls=;
 b=HIoJUUUmvIrIJzQ+Q8v9j3PvxkaLbTiINQtp4MYaGJepm+1xD9oxd+GzW8qgqJ2zfm
 mEgpvZ/ggrAH3BpTHNgwpQ7zDtu3ld8S3OAOYcIiryb92ygTLgvjP6qZO9N6bCh9O/LZ
 NeNW8rjoxJ7FZptzI/Lw3zSFtXUUaj5ksjZYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c1Y3U26ER5RjMUStylendzwqWoHIXo7Zk+HrmSkcSls=;
 b=V+smtmEUYZPHUQ2IJuRUZ6ROVwB/ztEUiX/kqC5WsMDkvsfLW5HhcAF4pjtJNcJOP9
 IKJo07ntMWcs/5DqS6bCAidyUC42MaKKaHzBjaicAV1vtSJ4JYnMi075Cwl8UCOqjDJr
 emScJOiOemKUknPVJMq3CkXIfYFAx+4LWJ+Ind8+92aasmY0Uye0FEpulVDebai7gk0R
 +64wzh3WjQkad6VxXVFFUooFkvGPWLTz+NkPM92UKrPaZu4cTJl0C0125UgVanwj6Kg0
 36E5wq2wdRScVvNyz6gsvKg7yz6bvsErP0ISvJJE4hj98ImFRaoFTuOpGZEwhFyBYQqO
 qZpw==
X-Gm-Message-State: AHQUAubM7SG9mrn5Cxoip3cmhYuVntKF+KMojUkadb/6kQgz/IsSoE0T
 Ec9QgK4eGWPqLO8S5QVJ6CqE/lTyJ4M=
X-Google-Smtp-Source: AHgI3IZ7gLNnMhWmXBzK1Ug5qCnifdTS3SqB+CHVAhStWD0XfYvI2bu4iq7HfRDPbNKhT/cL+/bfmQ==
X-Received: by 2002:ab0:7591:: with SMTP id q17mr915532uap.111.1549906046540; 
 Mon, 11 Feb 2019 09:27:26 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50])
 by smtp.gmail.com with ESMTPSA id q193sm8354608vsd.0.2019.02.11.09.27.25
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 09:27:25 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id s16so6754752vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 09:27:25 -0800 (PST)
X-Received: by 2002:a67:f943:: with SMTP id u3mr16035890vsq.149.1549906045157; 
 Mon, 11 Feb 2019 09:27:25 -0800 (PST)
MIME-Version: 1.0
References: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
 <20190204123130.GE3567@e103592.cambridge.arm.com>
In-Reply-To: <20190204123130.GE3567@e103592.cambridge.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Feb 2019 09:27:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_wfuU9zYSeu+JNrMts0Y1mf8Usvb7P_wCzgVNy0AUhQ@mail.gmail.com>
Message-ID: <CAD=FV=U_wfuU9zYSeu+JNrMts0Y1mf8Usvb7P_wCzgVNy0AUhQ@mail.gmail.com>
Subject: Re: Possible to annotate ARM64 IRQ handling to help gdb?
To: Dave Martin <Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_092728_730762_FA62DE23 
X-CRM114-Status: GOOD (  24.35  )
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
Cc: Caroline Tice <cmtice@chromium.org>, kgdb-bugreport@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Feb 4, 2019 at 4:31 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Fri, Feb 01, 2019 at 01:38:05PM -0800, Doug Anderson wrote:
> > Hi,
> >
> > I was wondering if anyone out there has given any thought to
> > annotating the ARM64 IRQ handling in such a way that we could stack
> > crawl past el1_irq() when in gdb.
> >
> > I spent a bit of time on this a few months ago and documented all my
> > findings in:
> >
> > https://bugs.chromium.org/p/chromium/issues/detail?id=908721
> >
> > I can copy and paste all the discussion from that bug here, but since
> > it's public hopefully folks can read the discussion / investigation
> > there.  To put it briefly, though: I can stack crawl past "el1_irq"
> > with the normal linux stack crawl (which is what kdb uses) but I can't
> > crawl past "el1_irq" in gdb().  After talking to some of our tools
> > guys here I'm fairly certain that we could solve this with the right
> > CFI directives, but when I poked at it I wasn't able to figure out the
> > magic.
> >
> >
> > Anyway, I figured I'd check to see if anyone here happens to know the
> > right magic.
>
> The kernel (appears to) generate a valid frame record for el1_irq:
>
>    0xffffff8008082b94 <+84>:    mrs     x22, elr_el1
>
>         [...]
>
>    0xffffff8008082ba0 <+96>:    stp     x29, x22, [sp, #304]
>    0xffffff8008082ba4 <+100>:   add     x29, sp, #0x130
>
> (I note that 0x130 == 304.  Yay binutils.)

Right, this is how the kernel is able to do the crawl.  It's also why
I was able to manually do the crawl in the bug by chaining together
frame pointers.


> From the bug report, I don't see any real investigation into what
> precisely causes gdb to choke on this frame.

Right.  I just don't know gdb well enough.  :(  I've had it on my list
to dig into it, but I need to find time.  ;-)


> Do you have evidence that CFI annotations help in this case?  And can
> you explain _why_ they help (i.e., precisely how is gdb relying on the
> annotations)?

I spent a tiny bit of time playing around with CFI annotations.
Mostly it was stumbling around in the dark since I had a hard time
finding good arm/arm64 examples and the documentation was a little
hard for me to parse.

...but from my experience with gdb, my guess is that gdb wants more
than just the simple frame pointers.  It wants to know where _all_ the
registers are stored on the stack and the only way it's going to get
that from assembly code (especially assembly code that barfed the
registers onto the stack somewhere that's not between FUNC and
ENDFUNC) is with some type of annotation.  My guess is that it doesn't
fall back to just looking at frame pointer chains.  Specifically as
you move up the stack frame in gdb and you type "info reg", the set of
registers changes to be those registers that are correct for the stack
frame you're on.  Here's a quick example showing how gdb behaves with
a random register that was barfed, $x22:

(gdb) frame 3
#3  0xffffff800846a088 in __handle_sysrq (key=103,
check_mask=<optimized out>) at .../drivers/tty/sysrq.c:620
620                             op_p->handler(key);

(gdb) disass
Dump of assembler code for function __handle_sysrq:
   0xffffff8008469f64 <+0>:     str     x23, [sp, #-64]!
   0xffffff8008469f68 <+4>:     stp     x22, x21, [sp, #16]
   0xffffff8008469f6c <+8>:     stp     x20, x19, [sp, #32]
   0xffffff8008469f70 <+12>:    stp     x29, x30, [sp, #48]
   0xffffff8008469f74 <+16>:    add     x29, sp, #0x30

(gdb) print /x $x22
$13 = 0xffffff8009035000

(gdb) print /x *(void**)($x29 - 0x30 + 16)
$14 = 0x8000100

(gdb) up
#4  0xffffff800846a0dc in handle_sysrq (key=103) at .../drivers/tty/sysrq.c:649
649                     __handle_sysrq(key, true);

(gdb) print /x $x22
$15 = 0x8000100

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
