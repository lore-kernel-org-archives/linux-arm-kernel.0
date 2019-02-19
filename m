Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7909C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:57:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676DB2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rDVTlAly";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PHUPHmLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676DB2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KMhwCJJlK7qCbNUoVZugTDClmxp/G4y6L0LbWmJpxNE=; b=rDVTlAlyIZRSMQ
	VfXY+By84DN2YhH7/1tZVrpUaV4B45pThSPP2GPmqKX7VBboTtomQ9kLy4sCdy8mS2H4ncHYpGZzc
	sKhymArwDdw9kOM69CVFkwuXLYLMqYx3YGcNQK6ntlayIC3UGTZE2hEK1wuiTj10oA8N8D5nr4/9+
	yr6fbIjKNtE+mdx55qmCI7o04L51Ahk1Y52k0l9TfHbAUZkL/PMrHao48UZf7+yszrl0Uj5u12ADH
	00OaGuYpndAihM2c4sCdF8ooAO/Lsh0UC6ah+H97AfkBg3lUyCiFGx7D7ZaROPb5cORk6KxUEnKS9
	X5YBNT8p+5XvytdV+vbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAZt-0002ck-1N; Tue, 19 Feb 2019 18:57:13 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAZp-0002bM-EK
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:57:11 +0000
Received: by mail-pf1-x442.google.com with SMTP id q17so10638573pfh.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2XiAfBpuM7b4fatrS2Zv7dZSiTYhqm0wOxJWwzD3YcI=;
 b=PHUPHmLyobzqlHpALGyGM86OheNZKqWUN8Uyc9lQe7b+GfTTPffFyBTpSjcZWDqDcH
 9f0u7kVZ41G7MVO7YGhi9fPio/qTzWReAPaHofHgPOzpoPN7KV5BU60BzTg2VMRwIjG5
 O2c32ktz/5L5QQCO9FKstzgWjKiRxqiGGkv7Y+tIDz5jMu8rg8kstMtyIIhqB9mVNeRg
 p75nOhl9ZJGWpNw7TgqjtTDmFUaAGPuFjME0Jm3FsI+EyTQMrsJabXGAMoXIW5yJCYav
 bSOJ3L3vXLtemA2ySxBu0805OKpzClNtywtzFzAU570WM4gRogSN5VUOcVO2VIZPi1Q/
 68NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2XiAfBpuM7b4fatrS2Zv7dZSiTYhqm0wOxJWwzD3YcI=;
 b=Zn/iEhLjtiVhTcGEISxlCseb9sx8kuyTLz7gpvdUD7A8YkzFhkRnGfsDyQ68Z0Tjqc
 FaHjBatXhp8YIgkDj+a4VoOQWn1OfyTCYzhJDX80dAr1bPw5q6J7IjZ+SRXK/zRoaqa1
 IJ7ziBPBZ2lZc9h0yRORMCsGFvvncyqwryJVVyDlTuiiwtsxD2Xwcx/mBEUu5egwVLk/
 4sPYe6Ul87vVEWDDvtYyLD2q2l3PIVywuJzvn6Ql6DlMoWcNmWVk9xVz3vBcxLe9mwuf
 F1Ei5wM0ONzPsEJ9Tap5yMrOKARyv08+Q21vB5CXlBTUXLl1OqLYUnNhugholRnmeFok
 o8Kg==
X-Gm-Message-State: AHQUAuYgMRLlFJMJSX6zEMTAYiS1NqxIo+bEPAwR+yMWGHzniJdavOVl
 8tnw6pAqTGNHh/9TQ+cfRUQfvOzqinWbuAaNwC9V+McE87E=
X-Google-Smtp-Source: AHgI3Ib9FnrH/bmXa3wTg8gG3wMoe8YuazOySQIVGFfBnhpoKjEAO/Cg85Y/vWedB6FW83EvZD1jtEMXNRGLxYv+Dx8=
X-Received: by 2002:a63:68c9:: with SMTP id
 d192mr26002811pgc.264.1550602628491; 
 Tue, 19 Feb 2019 10:57:08 -0800 (PST)
MIME-Version: 1.0
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
 <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
 <20190214180125.GH2475@fuggles.cambridge.arm.com>
 <a31780dc-2fac-734e-61b8-8bdedaca2f05@lca.pw>
 <20190215142350.GA6299@fuggles.cambridge.arm.com>
 <CAAeHK+yUKS=5kMaug51ZyekQn8ee2pZQYChyxd_RqK-O6538dg@mail.gmail.com>
 <1550601754.6911.41.camel@lca.pw>
In-Reply-To: <1550601754.6911.41.camel@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 19 Feb 2019 19:56:57 +0100
Message-ID: <CAAeHK+yUQ0kZUspiFazjkFu7CRdaL_DZijUXD1po45gnGZkV3w@mail.gmail.com>
Subject: Re: soft lockups with SLAB_CONSISTENCY_CHECKS + KASAN_SW_TAGS (was:
 livelock with KASAN_SW_TAGS)
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_105709_510305_351E5615 
X-CRM114-Status: GOOD (  21.42  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 7:42 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-02-19 at 18:56 +0100, Andrey Konovalov wrote:
> > > > Once the machine is restricted to 16 CPUs (nr_cpus=16), although it still
> > > > trigger soft lockups and msgstress03 would seem running forever, the
> > > > machine is
> > > > still responsible and is able to login via ssh. Hence, it is possible to
> > > > capture
> > > > a task dump (echo t >/proc/sysrq-trigger) while this is happening.
> > > >
> > > > https://git.sr.ht/~cai/linux-debug/tree/master/console
> > > >
> > > > Some traces looks strange that looks like running free_debug_processing()
> > > > in a loop,
> > > >
> > > > [ 1986.002139] Call trace:
> > > > [ 1986.002145]  _raw_spin_unlock_irqrestore+0x44/0xac
> > > > [ 1986.002152]  free_debug_processing+0x2f4/0x3e4
> > > > [ 1986.002157]  kmem_cache_free+0x44c/0x870
> > > > [ 1986.002163]  free_object_rcu+0x200/0x228
> > > > [ 1986.002169]  rcu_process_callbacks+0xb00/0x12c0
> > > > [ 1986.002175]  __do_softirq+0x644/0xfd0
> > > > [ 1986.002181]  irq_exit+0x29c/0x370
> > > > [ 1986.002187]  __handle_domain_irq+0xe0/0x1c4
> > > > [ 1986.002192]  gic_handle_irq+0x1c4/0x3b0
> > > > [ 1986.002197]  el1_irq+0xb0/0x140
> > > > [ 1986.002203]  lock_release+0x660/0x7dc
> > > > [ 1986.002209]  rcu_lock_release+0x20/0x28
> > > > [ 1986.002214]  do_msgrcv+0x708/0xed0
> > > > [ 1986.002219]  ksys_msgrcv+0x4c/0x60
> > > > [ 1986.002224]  __arm64_sys_msgrcv+0xb8/0x194
> > > > [ 1986.002230]  el0_svc_handler+0x230/0x3bc
> > > > [ 1986.002236]  el0_svc+0x8/0xc
> > > > [ 1986.007106]  OUTLINED_FUNCTION_169+0x4/0xc
> > > > [ 1986.011885]  free_debug_processing+0x2f4/0x3e4
> > > > [ 1986.017186]  load_msg+0x4c/0x324
> > > > [ 1986.021617]  kmem_cache_free+0x44c/0x870
> > > > [ 1986.026917]  ksys_msgsnd+0x1e0/0xe5c
> > > > [ 1988.050035]  _raw_spin_unlock_irqrestore+0x44/0xac
> > > > [ 1988.054821]  free_debug_processing+0x2f4/0x3e4
> > > > [ 1988.059260]  kfree+0x3f8/0x7ac
> > > > [ 1988.062313]  free_msg+0x50/0xb0
> > > > [ 1988.065450]  do_msgrcv+0xd80/0xed0
> > > > [ 1988.068846]  ksys_msgrcv+0x4c/0x60
> > > > [ 1988.072243]  __arm64_sys_msgrcv+0xb8/0x194
> > > > [ 1988.076336]  el0_svc_handler+0x230/0x3bc
> > > > [ 1988.080255]  el0_svc+0x
> > >
> > > I'm hoping that Andrey can make sense of this, since he recently hacked up
> > > freelist_ptr(), although only if CONFIG_SLAB_FREELIST_HARDENED=y, which
> > > isn't the case in your .config.
> >
> > So far, I've been unable to trigger this in QEMU as well.
> >
> > Qian, could you check if this still happens after adding that -pg flag
> > in KASAN Makefile?
>
> Yes, it still happen. Although the reproducer (LTP msgstress0[3-4]) is making
> slow progress, so not strict a live lock now. The situation gets worse if the
> system has more CPUs probably because more CPUs are trying to acquire the
> spinlock in free_debug_processing() and then flush the console with soft
> lockups.
>
> One workaround is to add "KASAN_SANITIZE_string.o := n" to lib/Makefile which
> will stop inserting KASAN instruments for check_bytes8(), and then the
> reproducers are running smoothly without triggering any soft lockups.
>
> It looks like check_bytes8() is a big CPU consumer especially with KASAN
> instruments added.
>
> 0000000000001a2c <check_bytes8>:
>     1a2c:       d2c20008        mov     x8, #0x100000000000
>     1a30:       f2fdffe8        movk    x8, #0xefff, lsl #48
>     1a34:       34000202        cbz     w2, 1a74 <check_bytes8+0x48>
>     1a38:       aa1e03e3        mov     x3, x30
>     1a3c:       94000047        bl      1b58 <OUTLINED_FUNCTION_2>
>     1a40:       aa0303fe        mov     x30, x3
>     1a44:       54000060        b.eq    1a50 <check_bytes8+0x24>  // b.none
>     1a48:       7103fd3f        cmp     w9, #0xff
>     1a4c:       54000101        b.ne    1a6c <check_bytes8+0x40>  // b.any
>     1a50:       39400009        ldrb    w9, [x0]
>     1a54:       6b21013f        cmp     w9, w1, uxtb
>     1a58:       54000101        b.ne    1a78 <check_bytes8+0x4c>  // b.any
>     1a5c:       91000400        add     x0, x0, #0x1
>     1a60:       51000442        sub     w2, w2, #0x1
>     1a64:       35fffea2        cbnz    w2, 1a38 <check_bytes8+0xc>
>     1a68:       14000003        b       1a74 <check_bytes8+0x48>
>     1a6c:       d4212400        brk     #0x920
>     1a70:       17fffff8        b       1a50 <check_bytes8+0x24>
>     1a74:       aa1f03e0        mov     x0, xzr
>     1a78:       d65f03c0        ret
>
> This function is called by over and over again (with interrupts disabled),
>
> free_debug_processing [1]
>   free_consistency_checks
>     check_object
>       memchr_inv [2]
>         check_bytes8
>
> [1] iterate all objects in the slab.
> [2] while (words) { words--;

Ah, so it doesn't lock, it's just very slow? memchr_inv() is the only
caller of check_bytes8(), so we could remove instrumentation from the
latter, and add one KASAN range check into the former. But I'd say
this is the expected behavior, KASAN slows down stuff and I don't
think it makes much sense to enable it together with other memory
debugging options.


>
> I also noticed that even the single "top" command is now consuming 30% - 40%
> CPUs all the time. Sometimes, it could jump to 80% or so.
>
> 5969 root      20   0   24512  10560   4736 R  83.8   0.0   3:25.79 top

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
