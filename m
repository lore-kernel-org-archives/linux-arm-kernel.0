Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ACFC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:43:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF1E2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wzp9pGWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF1E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YEedktCIKt/tJm+LZPrMGkUePj3XVvXEA2CFlRj54hU=; b=Wzp9pGWTZ3dg/I
	hHmFM61FxUej6TZf+GKUnbl5HXhzKMhzVJH8Obcz57QurLrjcPYosUZYeUeh9MJfZwJpmZ+zcJJMn
	JrpAi6WVXxf4lw8xwl1joARVOZPD94qItEU6IE2IV1/c1NSukovH++G+QCuMjAqV7KPkJ90xSgG/K
	A1IOCAqSPgPV9ZHqpiwsckVI/xUv2YBMsK8dOUBeqR9yWpkk/tIom4d81BQKZQqRMJl/TXVB87E9i
	IOcIQy5oHhv8XetEYiYKbExkiKRYnkuRxooeNfNF25VRauy2dxrZ7s3dHXf4a/VmQoACsJbaolBMw
	5QmXKqrHksoF85ZQtuDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gST9R-0005C2-GZ; Thu, 29 Nov 2018 20:43:09 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gST9N-0005Bb-UD
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:43:07 +0000
Received: by mail-qk1-f195.google.com with SMTP id y16so1908365qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yfIkpq2yd0BgshyKjmLyezQsO7IAIWlzR8udZ0ePDfQ=;
 b=LGOsWYK6OmkpYbWE9nJms/ibTGtxk192uRk29g81Eh95uJzasFCfmB2MupGWHriu7q
 Fn8tPM5+7NwdXxkh9lps8n794nlioU9DcKlhOzF20l7AK96aQsl0v4dOeP01DfZo1nyW
 uOKtfhAF3bEeM5aDS3ZOwXALSDnWfWQMxtPlOpM3e7QBKbTa6TARhtnMDLHcO56k64ON
 0gCv6UfKWFlFHSaz1Yt4eeqXCUhITaQ0XpnABXspGjQgotN6ZyAElmJhTZfuP40jy2ML
 ro6Z2L7oUMIjO5ypsZ2GusuGmsAX32iym2+WAJvtU6MYmoqGMLdFWIrddZHLl1WECly7
 gLeQ==
X-Gm-Message-State: AA+aEWYnfpKvT3TKNWIQS/yciDRdpSbKLIHgO4L7dx6BgDiEgP1LHzxX
 qaJbVERKJ+ErwxhZESYE6R44T0BrVyW9Y47k8LM=
X-Google-Smtp-Source: AFSGD/Ume9XyA5hHsD9HOi97v4m7eRr/KEP1AuczhlMiTFrpSq/o3rGQhT+IrJWKsisDh0CBcwbzs8THx1mjM/1JbKg=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2689785qkf.107.1543524173498; 
 Thu, 29 Nov 2018 12:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
In-Reply-To: <20181129170530.37789-7-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Nov 2018 21:42:35 +0100
Message-ID: <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_124305_971310_268136D0 
X-CRM114-Status: GOOD (  16.51  )
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

On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +/*
> + * The definitions below are required to overcome the limitations
> + * of time_t on 32 bit architectures, which overflows in 2038.
> + * The new code should use the replacements based on time64_t and
> + * timespec64.
> + *
> + * The abstraction below will be updated once the migration to
> + * time64_t is complete.
> + */
> +#ifdef CONFIG_GENERIC_VDSO_32
> +#define __vdso_timespec                old_timespec32
> +#define __vdso_timeval         old_timeval32
> +#else
> +#ifdef ENABLE_COMPAT_VDSO
> +#define __vdso_timespec                old_timespec32
> +#define __vdso_timeval         old_timeval32
> +#else
> +#define __vdso_timespec                __kernel_timespec
> +#define __vdso_timeval         __kernel_old_timeval
> +#endif /* CONFIG_COMPAT_VDSO */
> +#endif /* CONFIG_GENERIC_VDSO_32 */
>

Have you considered doing this in the reverse way, by including
the common parts from multiple implementations (32 and 64
bit), instead of compiling the same source file multiple
times with different macros set? I think that would make it
easier to understand.

> +
> +#ifdef CONFIG_HAVE_ARCH_TIMER
> +static __always_inline notrace int __do_realtime_or_tai(
> +               const struct vdso_data *vd,
> +               struct __vdso_timespec *ts,
> +               bool is_tai)
> +{
> +       u32 seq, cs_mono_mult, cs_shift;
> +       u64 ns, sec;
> +       u64 cycle_last, cs_mono_mask;
> +
> +       if (vd->use_syscall)
> +               return -1;
> +repeat:

Maybe instead of the #ifdef, do it like

     if (!IS_ENABLED(CONFIG_HAVE_ARCH_TIMER) ||
         vd->use_syscall)
                return -1;

> +static notrace int __cvdso_clock_gettime(clockid_t clock,
> +                                        struct __vdso_timespec *ts)
> +{
> +       const struct vdso_data *vd = __arch_get_vdso_data();
> +
> +       if (!__arch_valid_arg(ts))
> +               return -EFAULT;
> +
> +       switch (clock) {
> +       case CLOCK_REALTIME:
> +               if (do_realtime(vd, ts))
> +                       goto fallback;
> +               break;
> +       case CLOCK_TAI:
> +               if (do_tai(vd, ts))
> +                       goto fallback;
> +               break;
> +       case CLOCK_MONOTONIC:
> +               if (do_monotonic(vd, ts))
> +                       goto fallback;
> +               break;
> +       case CLOCK_MONOTONIC_RAW:
> +               if (do_monotonic_raw(vd, ts))
> +                       goto fallback;
> +               break;

Please sync this up with the latest x86 version in
arch/x86/entry/vdso/vclock_gettime.c, that version has
seen a lot of improvements recently, so I'd recommend
using a copy of that file as the base, and then
modifying it as needed to make it work on the other
architectures.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
