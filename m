Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82478C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:58:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB56222C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/bwXugD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D253Chez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB56222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PE4UXnLFAHviSw3ls7BdzXsr3l0tFKrRIuAN6zFmzVo=; b=G/bwXugDttlp5L
	1ZdwVeygOeWmZPuBjm6qCP4pk2ptWcSYTiWWFdV8tx/zprSy2JaAnsiKv/2riDNVh75flm3WZIwRO
	Lv1+1jVmskbLK1XvWU/nYUsrcfzRBh22FpkdLKgmp+K7dIaORCw/qtgYGukmE2lL8HNwj6RRUxtVF
	AovdkYm5jHk31miNhBrwSb2MgDvr3slPHpQaFpx344/ljrvC5hSNwWcttJpChDCdI6YjosSmiQR+k
	Gf29pVYEGj7wk8zlJzNZ5eVbD+kJXVwC9QHlyuClleqyJm8OxtKysRFEZXQiIqCbK8sc9gcjLEhh/
	ZP10YmOUQJ5KI5UD1PpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gteCL-00021B-8I; Tue, 12 Feb 2019 19:58:29 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gteCG-00020e-Uq
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:58:26 +0000
Received: by mail-lf1-x144.google.com with SMTP id b20so2964012lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/n+2vOYomTB5BLs+7tL7KTaBHH30/oos+ud6/cnVnSI=;
 b=D253Chez2iaEQIcdy2TZNsUlaqMRm9VIwWrpW4fWK//FTDXCKKfklGuD0o642xmL34
 Mp7YirjzpQRotbrv0djWXVT+vJS5/MLsACCfzpkJ9An4MiWd9dVmmIgjhdo9yVZ3/bHH
 9o6+1iNpzzKTb5pLfsCFl4j2YHGc18WAFp/jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/n+2vOYomTB5BLs+7tL7KTaBHH30/oos+ud6/cnVnSI=;
 b=bVwr5fgn3qu3coulScMyNMAos1TOYA5/tcaPZdwvsKWQVyolBXWrsYhxvMuCLoevE9
 +DqNC7AZMDI3IcmmP41wC8XKJx/69HIOu5J3Hsybx/NZ3v/vf1NyK4zBzgd79J8lo6zp
 /I/Jh78V7zIPa3gXoKTdzFor9YyD9F9YOyf2vh48MPAma1wJMDHOnoOSVLjZ9s9v0yQW
 9n2P2KSCchlfH/SyzNIZfBoUDEZ4d5cmsbP2hyJFTo4JKH+mg6olMBm4JJH8YwrmD6o0
 ohT0Ker+77laevEPqUmO6oeqzGW/ZeMBb6VUPn8T2hihaatT6ily8+debsoMCmScAnyL
 EAbA==
X-Gm-Message-State: AHQUAubgmtBf2FI8lzVxmnRe3NEPm5j586pImJNvVybPA9NK9uPDg5F3
 nfukD9c+s1GLyuoxxh81YoelDc3l+7c=
X-Google-Smtp-Source: AHgI3IYsYoUsySPn2tlkvt/a2oB03wm73MTIBFpO4PD4VA2ZtgakvdtPDq+9HNKPAqNId1kuWDBr2g==
X-Received: by 2002:a19:ab09:: with SMTP id u9mr3438626lfe.149.1550001502164; 
 Tue, 12 Feb 2019 11:58:22 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id c140sm1801737lfd.36.2019.02.12.11.58.19
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 11:58:20 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id q128so3130442ljb.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 11:58:19 -0800 (PST)
X-Received: by 2002:a2e:7316:: with SMTP id
 o22-v6mr1693665ljc.82.1550001499483; 
 Tue, 12 Feb 2019 11:58:19 -0800 (PST)
MIME-Version: 1.0
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
In-Reply-To: <1549913486-16799-3-git-send-email-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Feb 2019 11:58:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_115825_030778_7E4F0A45 
X-CRM114-Status: GOOD (  18.32  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 11:31 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to make it generate slightly better code
> (smaller and maybe a tiny bit faster).

This looks good, but I would ask you to try one slightly different approach.

Instead of this:

>        long tmp = atomic_long_read(&sem->count);
>
>        while (tmp >= 0) {
>                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
>                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
>                        return 1;
>                }
>        }

try doing this instead:

        long tmp = 0;

        do {
                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
                        return 1;
        } while (tmp >= 0);
        return 0;

because especially when it comes to locking, it's usually better to
just *guess* that the lock is unlocked, than it is to actually read
from the line to see what the state is.

Often - but certainly not always - the lock is the first access to the
target cacheline, and assuming the trylock is successful (which I
think is the case we want to optimize for), we're much better off
causing that first access to be a read-for-ownership, rather than a
read-for-sharing.

Because if you first read from the line, and then do a cmpxchg, and if
the line was not in the cache, your cache coherency protocol will
generally go through two states: first shared (for the initial read)
and then exclusive-dirty (for the cmpxchg).

Now, this is obviously very micro-architecture dependent, and in fact
the microarchitecture could even see the "predict fallthrough to a
cmpxchg with the same address" and turn the first read into a
read-for-ownership, but we've done this at some point before, and the
"guess unlocked" was actually the one that performed better.

Of course, the downside is that it might be worse when the guess is
incorrect - either because of a nested read lock or due to an actual
conflict with a write, but on the whole those *should* be the rare
cases, and not the cases where we necessarily optimize for latency of
the operation.

Hmm?

                    Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
