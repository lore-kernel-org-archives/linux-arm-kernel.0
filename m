Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2745DC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC182084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ONkuLc15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC182084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SdiShfDlnnmReva5xMnKCTBpIP7fS8lkKTckrilK8rQ=; b=ONkuLc15xBHTgV
	KcIJf3Ja3Y9ArmXPhHQX6Fdtk1p0ESJ5icuyIO25XDT55LY2OSRMX0VS8exSHfnT18z5Ppc59MmPO
	5eRQUC1IN9FGrNmu+Gk1W2KgwMZy4bm2CslSkHwMc0Z6O8A0bBxigumjskXtX1b7cMWRmvsSwSVe/
	cwMHPQkjRKUFNvFTRBk10dyxFifYtHgbV6saDrojNHri/ThY0s/d5ad+JK9gN4gRmMOwPQuUOyTHw
	XOYYhfusXhgg2Dg+//vygV/S7/ks9SvQq9h0li25AigSzsWer1WL4OvUoBIYLKC0NMPx2TXo2tZ23
	geEintGOIGtE9Wr/QUuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWpmX-0006M1-Sv; Tue, 11 Dec 2018 21:41:33 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWpmU-0006L6-Mn
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:41:32 +0000
Received: by mail-qk1-f193.google.com with SMTP id 189so9550229qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f0/FrkVP3McbCeTjYhUDkGTFUmDNWs5Pir8TL42Mkxk=;
 b=DsoMI6czBzF8PviL+tBxPI/muaqr58nPrfH3dtQ9nd8nxLCqi1mEjsAc6OXN67munI
 Dy1l+M2/TZJVef1eyGK8+2MqdkfpNbk4owRXzQAybJbATBvp1HjEyG27NfEkDwoWy9KN
 kT3RpdWpoA1bea99uf7qBpofRk1sMjVGdjmPYmcsYsMSaTwi1inrUxgdE2ni8PCm15BU
 GKtBLNcRF3IA6W5Ffaj0wMZGAmeSKn1v7nwuTs29XOGCVDAyFiftgvIK3zZpYbBA0isQ
 et5Yfq5gBY2Gm6toCc15XocoFbRHUG/WSHH12Il0TxQUFUHoVxdb3XuY7yGh8dXmU3iU
 3LQA==
X-Gm-Message-State: AA+aEWYQ7M2e/SzspXIdtrre8wHiH2QrnBrDZPIwrFt+0pyoJmpZNuel
 g1kQ51qpqdWEsuyh9V6cr41d2ajAo7jkrdx2Uo0=
X-Google-Smtp-Source: AFSGD/XglYloaswYksaZvUm7iTmUAf5jsTXxQPRztZ/kKnZP+jaCkl1fnj8ozFWrT8fyfQLPRCv/pANqEjH2RmLbHrI=
X-Received: by 2002:a37:a3c6:: with SMTP id
 m189mr16112068qke.173.1544564478685; 
 Tue, 11 Dec 2018 13:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
 <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
In-Reply-To: <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 22:41:01 +0100
Message-ID: <CAK8P3a0LgFuv_s4xiC_rD0X7-GxHRWfzmdDcxJ7vvHrEETApRw@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134130_777343_3576A1A9 
X-CRM114-Status: GOOD (  19.79  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 2:39 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 29/11/2018 20:42, Arnd Bergmann wrote:
> > On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >
> >> +/*
> >> + * The definitions below are required to overcome the limitations
> >> + * of time_t on 32 bit architectures, which overflows in 2038.
> >> + * The new code should use the replacements based on time64_t and
> >> + * timespec64.
> >> + *
> >> + * The abstraction below will be updated once the migration to
> >> + * time64_t is complete.
> >> + */
> >> +#ifdef CONFIG_GENERIC_VDSO_32
> >> +#define __vdso_timespec                old_timespec32
> >> +#define __vdso_timeval         old_timeval32
> >> +#else
> >> +#ifdef ENABLE_COMPAT_VDSO
> >> +#define __vdso_timespec                old_timespec32
> >> +#define __vdso_timeval         old_timeval32
> >> +#else
> >> +#define __vdso_timespec                __kernel_timespec
> >> +#define __vdso_timeval         __kernel_old_timeval
> >> +#endif /* CONFIG_COMPAT_VDSO */
> >> +#endif /* CONFIG_GENERIC_VDSO_32 */
> >>
> >
> > Have you considered doing this in the reverse way, by including
> > the common parts from multiple implementations (32 and 64
> > bit), instead of compiling the same source file multiple
> > times with different macros set? I think that would make it
> > easier to understand.
> >
>
> The common code is never compiled as standalone. It includes arch specific code
> (for the fallbacks) and it is included in the arch specific vdso library (for
> both 32 and 64 bit where it makes sense). Hence it is built once or twice.
>
> If I understand correctly your question, seems inline with what I am doing.

The result is very similar, it's just a question of which file includes which
other file. If I understand your current method right, you use Makefile
logic to build multiple object files from a single source file, and setting
ENABLE_COMPAT_VDSO on one of them, right?

My preference would be to keep that Makefile simpler and have one
source file per object file, but have each one define a set of macros
before including the common source file, similarly to how we deal
with fs/compat_binfmt_elf.c. If that turns out to be worse than what
you have here, I'm not overly attached to that solution since including
C files is still ugly, but I think it's worth trying if that lets you end
up with more easily understandable source code.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
