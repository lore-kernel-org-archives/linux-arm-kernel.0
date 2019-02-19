Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933662146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R5YWafAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933662146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4h0lsETFBsQUJIYRDVNMEs3S0baNgaVDlZOSIYYX0a8=; b=R5YWafAyt88/4l
	xAMgXpA9T68nmbyG+VORRJGcE5SzebmoVFHTZUA8QTba6WFchC/pjU+8YsDpOYJTQ/kKtoraTxWow
	cbLCuOeIgZi4yUh/PeSYYkuDQBLzNYiIg0kM7BbojkcJ/YNYXl+dNcW98Qx7HcTjK15z6mcLYLZv7
	7vTDleCaswKOz0ujM73YD1neyOZ2PpW0f9EiN5f+cZMO42WeNy+/l8YSkixnlivkKl1dp3SGn4BQR
	SGlSzDyGl926lIJd/fovQP6QxqW9qHgk1Jhow4D0ma5TZMcnZQRcku0DqOhYtSscxphdEV+vFXLNt
	PhuGpBfxPPJiu7t+lGow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1QD-0004iD-1X; Tue, 19 Feb 2019 09:10:37 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1QA-0004hC-9l; Tue, 19 Feb 2019 09:10:35 +0000
Received: by mail-qt1-f195.google.com with SMTP id z25so558343qti.13;
 Tue, 19 Feb 2019 01:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZgZfbfGDAIrLHm8OGM0hyr2IUJKMkKhN5SqMTkRLPEM=;
 b=H9MvxyL2I9TJLc7RUkjxFALjf6zvctB6YRsibqqDtLC8T8NFdTg7It/I1UWoULe0yv
 XjPR2gnNxtsETzRzpc6I0L3nf/Kk+b8IosKZol9ADxIZDHZoa1qqkM7Bft5ew2E4ZPC1
 4S3OTT2MspTxU9h7LvQNX4xUoZnL8ygdiTcOxFa3aIyWPzh0Gg+DWb3QZlxzOoHrrHcF
 Ilvys34Aib2aqKrP/e7BGBGOUUMfLAkkozemE6iWA2Ne4BowxcbBoJNTHhnrCemDa7gj
 utGCqcRmcDY+NTs/f8XG9rJUxK6V7OpuitSWLACXJ1K6T4h4cEJRB1Ie4uaUY39kHu9N
 NwYQ==
X-Gm-Message-State: AHQUAuYZ2iiQ0X4HkAMcGROHXpi8ciL/Joa4qxOGJu/Ua/9BtosnbkiA
 qAlUwXx8Xo+hGyqGOETuTCi9Cj1gk7rsk+30TEk=
X-Google-Smtp-Source: AHgI3Ib1oYxLVKiIDWh7U+TqJfRLgTvr9IGfVMPPSTo6RezHMX4HFg8tiIfwxKyn6Qj1jqFpKTa9fVhbXPrYEoLnrfI=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr20279762qvi.149.1550567432050; 
 Tue, 19 Feb 2019 01:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de>
 <20190218210712.3503891-3-arnd@arndb.de>
 <CAMuHMdUb47nLkorUpQ1ohD-WMaEG7d3DBAs7JWA6rvgKTZAGGw@mail.gmail.com>
In-Reply-To: <CAMuHMdUb47nLkorUpQ1ohD-WMaEG7d3DBAs7JWA6rvgKTZAGGw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 10:10:15 +0100
Message-ID: <CAK8P3a3RTZDfc-4womPK2qbPTwuaP0Jin6Nzq6Ep3G4SnFpZvw@mail.gmail.com>
Subject: Re: [PATCH 2/8] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_011034_363994_F7DE15D5 
X-CRM114-Status: GOOD (  17.91  )
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "moderated list:H8/300 ARCHITECTURE"
 <uclinux-h8-devel@lists.sourceforge.jp>, Yury Norov <ynorov@marvell.com>,
 Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@caviumnetworks.com>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 Stafford Horne <shorne@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd, Yuri,
>
> On Tue, Feb 19, 2019 at 3:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > From: Yury Norov <ynorov@caviumnetworks.com>
> >
> > All new 32-bit architectures should have 64-bit userspace off_t type, but
> > existing architectures has 32-bit ones.
> >
> > To enforce the rule, new config option is added to arch/Kconfig that defaults
> > ARCH_32BIT_OFF_T to be disabled for new 32-bit architectures. All existing
> > 32-bit architectures enable it explicitly.
> >
> > New option affects force_o_largefile() behaviour. Namely, if userspace
> > off_t is 64-bits long, we have no reason to reject user to open big files.
> >
> > Note that even if architectures has only 64-bit off_t in the kernel
> > (arc, c6x, h8300, hexagon, nios2, openrisc, and unicore32),
> > a libc may use 32-bit off_t, and therefore want to limit the file size
> > to 4GB unless specified differently in the open flags.
> >
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Yury Norov <ynorov@marvell.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> >  arch/m68k/Kconfig       |  1 +
>
> For m68k:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -276,6 +276,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >         bool
> >
> > +config ARCH_32BIT_OFF_T
> > +       bool
> > +       depends on !64BIT
> > +       help
> > +         All new 32-bit architectures should have 64-bit off_t type on
> > +         userspace side which corresponds to the loff_t kernel type. This
> > +         is the requirement for modern ABIs. Some existing architectures
> > +         already have 32-bit off_t. This option is enabled for all such
>
> s/already/still/
>
> > +         architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > +         h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > +         nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > +         unicore32, x86_32 and xtensa. This is the complete list. Any
>
> Do we really need this list here?  It's intended to shrink only.
> It includes removed architectures (blackfin, cris, frv, m32r, metag,
> mn10300, score, tile32), but lacks several new ones affected by this
> patch (c6x, csky, nds32, riscv).

Right, I (finally)  took Yury's patch that was already several years old
without checking this text (I did make sure all architectures are changed
correctly).

I'll just remove the list here.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
