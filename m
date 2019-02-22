Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:49:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AC32075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PuV/UpUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AC32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kyfIKejmB6sMqL0clkL4Iqjk7PpYzaMYQ/dU4pcJvA0=; b=PuV/UpUKaXo3Nj
	8CIxGVfB0n/tdQI8s07aUUqe4QofZMonyvApG9XZ/PNvI1obFjBQWgTtWXNio+Nyj7zEAQwVM4huU
	4jUsyTZ11y62BwZjhH/hUwH+PxNR1dmSY6sIqKquYR0wlUpxc6oIH25VEpbqW0305HtgsyrXdIoeR
	Ul02KzxNAroSFV3LrSJemsv7hQ5NsLXGPC9mYekEq5fMwjyslv1POzK0CIS1uw9uxEX54RYF2Graf
	psFfObtZua0uUQ+nchBEz/gKixuO/95i2q493DFaELDEv/U+r3+4LKXkQfEgV+jeowx7zQazGhtkG
	PCzllfs9QruRvxieHbSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBD1-0004yB-Lf; Fri, 22 Feb 2019 13:49:47 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBCz-0004xC-3x
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:49:46 +0000
Received: by mail-qt1-f196.google.com with SMTP id z39so2529990qtz.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 05:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YCdzHUnCVid6VQpyu7+gAywSyiJ0Zvm252ZRUXeryVw=;
 b=ESuzCGf5nVzErb6atiNBIwUQBEpm6GUjrJtpe6vPAokZnYm9MhjsQwS2+vF4EAmZqs
 HswiSncCokTvP877hKquWh2kVi4DTRkqmzuavNEVoIEEx6nyZ0ay9HN26//F4Y3Upq3o
 RiZJzT/DZCyJONy6gWLHjNEaSigAGK5hulZl6x7V0EN6+KM1F2VJpLBPhj+p7bZthDHf
 VakxsWlgIT6VUmL8Yg+zxVYpsHQ/bhrCCc9S5wxOmz9V+xnR1xe0fiPfgD4W2gdStxHh
 UDvZ/0U/PZbzLaH8M/fAa0Q1WlQGbdPSgCi6ukgISMOpXo7IzzLAvDFyoKYqqxQcv4jn
 hhng==
X-Gm-Message-State: AHQUAuY+qVt4LbqKYdstSWe6TE742HHHzC9wvFX099gRyodqHX8xLRgV
 HElAMwX0WuK3QXUyZVzjlRteByy/ZUtdwp2B3nA=
X-Google-Smtp-Source: AHgI3IbexA327EtterpQO4g1wJgTy49ml8cI2NeubF0E+iRdBcMFo7B6SZbUSZD6hTJwTjBrTgdDCfgaDZF9wNUYqRE=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr3225301qvn.115.1550843382721; 
 Fri, 22 Feb 2019 05:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 14:49:26 +0100
Message-ID: <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_054945_155956_3BD72B5F 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
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

I don't think we need __vdso_timeval at all, just use
__kernel_old_timeval everywhere. There is no generic
64-bit timeval type in the kernel, and there won't be because
gettimeofday() is deprecated.

For __vdso_timespec, I see how you ended up with this
redefinition, and it makes the current version of your patches
easier, but I fear it will in turn make it harder to add the
__kernel_old_timeval based variant.

What I'd prefer to see here is to always use the fixed length
types everywhere in the code, such as

static notrace int __cvdso_clock_gettime64(clockid_t clock,
                                        struct __kernel_timespec *ts)
{
... /* normal clock_gettime using 64-bit times */
}

static notrace int __cvdso_clock_gettime32(clockid_t clock,
                                        struct old_timespec32 *ts32)
{
     struct __kernel_timespec ts;
     int ret = __cvdso_clock_gettime64(clock, &ts);

     ts32->tv_sec = ts->tv_sec;
     ts32->tv_nsec = ts->tv_nsec;

     return ret;
}

and then have two different versions for 32-bit and 64-bit
architectures, calling one or the other function of the
generic code.

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
