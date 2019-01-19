Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AC7C0031C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:46:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C2C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rJTwlWQf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2HfoSTqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C2C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iL9axHJuxbiukwqjdk7/3ucKrtQU/hDFHGP+l6VrROY=; b=rJTwlWQfJd7AZP
	BegyZjBWmZGXRHhduzpGAyrLHTaYcqd5vdQeaNh7US5X0ptp8EKM6uhsBgZtolvpu3SJtWFAIIx3t
	B2DTHLJGdx+S31ujJP379mhdLIgYtBX3+qtHp+JOp79moCzFmX92aOk99EQzmpTasa3GoF5c1crDI
	236M1c/y/AO0GRiQd7ynjsnhlpBGalq6rIvA4clHzq1dqbM/QLVtHuYstZiOlaVTZFS4U5JFwIa+N
	Lziq020xUm5NpzDMDZaLYBH0veBUBGEquZapuTVRFCyEJpSdvZ3P22IgT+a+SB1YsivIkG99hDmci
	nHcSAsxOJIhPyBSTYd6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkha5-0008I7-NO; Sat, 19 Jan 2019 03:46:01 +0000
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkha2-0008Hn-5I
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 03:46:00 +0000
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x0J3jVFw009777
 for <linux-arm-kernel@lists.infradead.org>; Sat, 19 Jan 2019 12:45:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0J3jVFw009777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547869533;
 bh=GmXcVg56/uy4EXsHvS3OpOX4Tq5rsuK7nLrJEUMmhfk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2HfoSTqMSZJ48GK1ldLSQEQz2+KriWPObm/vnKHN8W6/7I96cXXN+p3+OGqQi+Avc
 q+rvXXIZbrBhfi4pI6vtzHDilWbyMbIsUj6l8nmuNixJuGcXSD8URmTD6MQ+WEfLtM
 mO5xx6EvrCS87Uukpb2tf16A8XP9fQ6KX/AXcxw9nWLS8oG+ygB8FsSI4BIv0K/4Ti
 Sxz21Vql6Fv0X0qrqWD37ipzUaYZeDt2/MYlXWK6oS5wxULkbcZ12H7HNVAHo0XsVb
 0kRQGpzvybhDUKMiZg5NsDuGU27SYqeAufUwL1PRr6dVl8b0b1YlZxKA5Zrqmizb5y
 p6QO5WQogHdxA==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id o130so3524593vke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 19:45:32 -0800 (PST)
X-Gm-Message-State: AJcUukftlf2+TOXKKC++SBnGyRB6N40vZF6Kne4Iu+aTHSI+hhGVXVbt
 ErZ/vVrH3l6CYTgRk6Xp/hk35xS+h1MT48zVDV8=
X-Google-Smtp-Source: ALg8bN7ZGFaB/Nw1ZFyZkyYobPx6HU9H8wxgHrPHpk2faygYiBBU9Pd0xgDvPOBSZolhe7AlXD+V/pzwadN/L1fdBRA=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr8320663vkd.74.1547869531293; 
 Fri, 18 Jan 2019 19:45:31 -0800 (PST)
MIME-Version: 1.0
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 19 Jan 2019 12:44:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_GHpqKC3bC_-eC+64Kn+h2md70NpshUHUUN0kNQa0cQ@mail.gmail.com>
Message-ID: <CAK7LNAR_GHpqKC3bC_-eC+64Kn+h2md70NpshUHUUN0kNQa0cQ@mail.gmail.com>
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS
 macro
To: Andrew Murray <andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_194558_436709_83ECE5B8 
X-CRM114-Status: GOOD (  17.05  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Price <Steven.Price@arm.com>, Grant Likely <Grant.Likely@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave P Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 19, 2019 at 1:02 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> A common pattern found in header files is a function declaration dependent
> on a CONFIG_ option being enabled, followed by an empty function for when
> that option isn't enabled. This boilerplate code can often take up a lot
> of space and impact code readability.
>
> This series introduces a STUB_UNLESS macro that simplifies header files as
> follows:
>
> STUB_UNLESS(CONFIG_FOO, [body], prototype)
>
> This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
> to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
> inline' followed by an empty function body. Where optional argument 'body'
> is present then 'body' will be used as the function body, intended to allow
> simple return statements. Using the macro results in hunks such as this:
>
> -#ifdef CONFIG_HAVE_HW_BREAKPOINT
> -extern void hw_breakpoint_thread_switch(struct task_struct *next);
> -extern void ptrace_hw_copy_thread(struct task_struct *task);
> -#else
> -static inline void hw_breakpoint_thread_switch(struct task_struct *next)
> -{
> -}
> -static inline void ptrace_hw_copy_thread(struct task_struct *task)
> -{
> -}
> -#endif
> +STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> +void hw_breakpoint_thread_switch(struct task_struct *next));
> +
> +STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> +void ptrace_hw_copy_thread(struct task_struct *task));
>
> This may or may not be considered as more desirable than the status quo.
>
> This series updates arm64 and perf to use the macro as an example.
>
> Andrew Murray (3):
>   kconfig.h: abstract empty functions with STUB_UNLESS macro
>   cpufreq: update headers to use STUB_UNLESS macro
>   arm64: update headers to use STUB_UNLESS macro
>
>  arch/arm64/include/asm/acpi.h           | 38 +++++++++-------------
>  arch/arm64/include/asm/alternative.h    |  6 +---
>  arch/arm64/include/asm/cpufeature.h     |  6 +---
>  arch/arm64/include/asm/cpuidle.h        | 18 +++--------
>  arch/arm64/include/asm/debug-monitors.h | 10 ++----
>  arch/arm64/include/asm/fpsimd.h         | 57 +++++++++++++--------------------
>  arch/arm64/include/asm/hw_breakpoint.h  | 16 +++------
>  arch/arm64/include/asm/kasan.h          |  9 ++----
>  arch/arm64/include/asm/numa.h           | 19 ++++-------
>  arch/arm64/include/asm/ptdump.h         | 13 +++-----
>  arch/arm64/include/asm/signal32.h       | 29 +++++------------
>  include/linux/cpufreq.h                 | 21 ++++--------
>  include/linux/kconfig.h                 | 31 ++++++++++++++++++
>  13 files changed, 110 insertions(+), 163 deletions(-)
>
> --
> 2.7.4
>

Honestly, I am not a big fan of shorting the code
for the purpose of shorting.


This patch series is based on the assumption
the first argument is "defined or undefined".
In other words, it cannot handle tristate CONFIG option.


But, if you go this way, could you make
it work in a more generic manner?

And, decouple this from <linux/kconfig.h>



For example, see the following cases:

https://github.com/torvalds/linux/blob/v5.0-rc2/include/acpi/button.h#L7

https://github.com/torvalds/linux/blob/v5.0-rc2/include/linux/firmware.h#L42




The latter is a good example.

In many cases, the kernel headers look like this:


#ifdef CONFIG_FOO

  { large block of prototype declaration }

#else

  { large block of nop stubs }

#endif


So, this approach shifts "duplication of prototype"
into "duplication of conditional part".


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
