Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB261C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90ED2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="llIbPIGI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jNUQo5VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90ED2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Svmdx8M3+oVTobbgP79tMzd1nXzn8WU32YF/TmX4sB0=; b=llIbPIGInv/n08
	g4GSu8msMWsZqURnaakr2oDlLu4J2Ldja5rkxtKjHgsulCcwNhdddvshnqeD6M8zTPQZzoQ0fOkBU
	6ZqxLCB1KEfvxxcENGq53H4ctXqDF/mjyJ10lpid8DcX4TK9ITLicQqTz7CoreldoqgV37U+H4TMf
	lQnpa76i3jbiXmSzsjKBALU4LdYNW4wqaRak9PuKdvyUACr2iZplyRGSQZA/DsiyOlvWhGd2GZ3fF
	7f1rMZN+6WY0y1Ax5kQRNHyZGWN9/+4XqwEd1BVseS4ZiEax8qxFG9RHYliXAijN7Vrm1IMm0hRie
	iKYVjHL2Zmf6gqJIhhrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw9dA-00054g-BC; Tue, 19 Feb 2019 17:56:32 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw9d7-00054A-AE
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:56:31 +0000
Received: by mail-pg1-x543.google.com with SMTP id u9so6945112pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D3k/fTwFAJcnAvgpmzPqXcm1agIqgYFNPtfTHdM+fE0=;
 b=jNUQo5VN/OzKNRH12uOZI6GP82lmOyPp/ApWjUYA01FmcL6Ug9PcZ5Q+2nABqqARTx
 LFv2Z8zRg3F7D79wPLHFbYsWObBfkH99JTHHd7dd6Y/E6VWul+xxt6rjN3CV5Su+dJi+
 q+cN0bsDzWkSHDygdPSi02xnZ9booB6LPmZZd3r9wgRa0hgpM5bpRhkrKSd6MVGmqGfP
 zRXhl15aNz8y3nYxAahz+LWx/0059DDNPew6zitJZ/Y7NWBLwpay2WRJnRNpMkorzgbM
 fxQCTx4a0c2I1EGbSCP22XOivEczPvh8QtzgxItkrVW6NomKNjU+WvNZ1eaJEDAGzPEa
 pabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D3k/fTwFAJcnAvgpmzPqXcm1agIqgYFNPtfTHdM+fE0=;
 b=BRweb07ow069qXArAsKnaV9MQT62gryro7G82F6DJ8Ei/kukgViTj4buLSmm1iMHW9
 /VHnNktDM5lGCu33MvfJ5q8GmzkhPLqab/PHp+W4PHgWRfvcMiAjkz3f0hpvx8qqDVgz
 itSvBB+P8chrp7M4KMLgxVvO63mGs/YYyAiVhIyeBXjPwxYwOqmg8pE3VEFwAArh3ifi
 oD1GzY14DsZajhy86XDogP1JFC44m+MaSy4jDZOLg7n9BGGSXT26EmtXRU+JtnWzwfPY
 WKr+NX3O/TR6/tBlkZWEawojif97x5n7UGjOi59PVORcJ/jHlzJmubQ0aJcnfESN5e73
 midw==
X-Gm-Message-State: AHQUAuZceSqfm8vEFUKnn4xj78xdGfh8g5fu7+rDrdQEYjSQFhtfZlGU
 V2KLTVunkX5QOFlP4YuJZyWdcFn+bNTnQGTFk536cA==
X-Google-Smtp-Source: AHgI3IapkVoG9LExoNAF1Wn6+vFMcWabeoA/qIEHrhwK5BNyQ3H9O+rMSjacaPlGyCZDwsNEAxR/ROkQ9DJGT7D3SyY=
X-Received: by 2002:a63:68c9:: with SMTP id
 d192mr25741945pgc.264.1550598982129; 
 Tue, 19 Feb 2019 09:56:22 -0800 (PST)
MIME-Version: 1.0
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
 <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
 <20190214180125.GH2475@fuggles.cambridge.arm.com>
 <a31780dc-2fac-734e-61b8-8bdedaca2f05@lca.pw>
 <20190215142350.GA6299@fuggles.cambridge.arm.com>
In-Reply-To: <20190215142350.GA6299@fuggles.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 19 Feb 2019 18:56:11 +0100
Message-ID: <CAAeHK+yUKS=5kMaug51ZyekQn8ee2pZQYChyxd_RqK-O6538dg@mail.gmail.com>
Subject: Re: livelock with KASAN_SW_TAGS
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_095629_600207_B92E7D3E 
X-CRM114-Status: GOOD (  28.16  )
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
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Qian Cai <cai@lca.pw>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 3:23 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Feb 14, 2019 at 11:04:25PM -0500, Qian Cai wrote:
> > On 2/14/19 1:01 PM, Will Deacon wrote:
> > > On Thu, Feb 14, 2019 at 11:50:59AM -0500, Qian Cai wrote:
> > >> On 2/14/19 11:35 AM, Will Deacon wrote:
> > >>> On Wed, Feb 13, 2019 at 10:32:11PM -0500, Qian Cai wrote:
> > >>>> Running LTP msgstress03 [1] triggers endless soft lockups below after a few
> > >>>> minutes on a ThunderX2 server. It works fine with KASAN_GENERIC and finish the
> > >>>> test in roughly 11 minutes.
> > >>>
> > >>> I've not been able to reproduce this failure under KVM, however the test
> > >>> only takes around 18s to complete on the host and the guest, so it feels
> > >>> like something is amiss here. Please could you share more information about
> > >>> how you're triggering this problem? For example:
> > >>>
> > >>>   - Kernel version and .config
> > >>
> > >> Latest mainline at 1f947a7a01 ("Merge branch 'akpm' (patches from Andrew)") plus
> > >> a few KASAN_SW_TAGS patches in order to boot.
> > >>
> > >> https://marc.info/?l=linux-mm&m=155006632110129&w=2 (all 5)
> > >> https://marc.info/?l=linux-mm&m=154968731424637&w=2
> > >> https://marc.info/?l=linux-mm&m=155010395725051&w=2
> > >>
> > >> https://git.sr.ht/~cai/linux-debug/tree/master/config
> > >
> > > I struggled to get this config to boot under KVM :(
> > >
> > >>>   - Clang version
> > >>
> > >> clang-7.0.1
> > >
> > > It would be helpful to know if the issue persists with the latest nightly
> > > build of clang.
> > >
> > > Anyway, please could you annotate the goto loop in free_debug_processing()
> > > so that the object and tail pointer are printed each time around? It would
> > > be useful to know if we're failing to exit that.
> > >
> >
> > Well, I am not sure I understand what your debugging strategy. Maybe, you can
> > send along a debug patch you have in mind for me to run.
> >
> > From the trace, it definitely exit the "goto next_object" and reached further in
> > this line in free_debug_processing(),
> >
> > spin_unlock_irqrestore(&n->list_lock, flags);
> >
> > Once the machine is restricted to 16 CPUs (nr_cpus=16), although it still
> > trigger soft lockups and msgstress03 would seem running forever, the machine is
> > still responsible and is able to login via ssh. Hence, it is possible to capture
> > a task dump (echo t >/proc/sysrq-trigger) while this is happening.
> >
> > https://git.sr.ht/~cai/linux-debug/tree/master/console
> >
> > Some traces looks strange that looks like running free_debug_processing() in a loop,
> >
> > [ 1986.002139] Call trace:
> > [ 1986.002145]  _raw_spin_unlock_irqrestore+0x44/0xac
> > [ 1986.002152]  free_debug_processing+0x2f4/0x3e4
> > [ 1986.002157]  kmem_cache_free+0x44c/0x870
> > [ 1986.002163]  free_object_rcu+0x200/0x228
> > [ 1986.002169]  rcu_process_callbacks+0xb00/0x12c0
> > [ 1986.002175]  __do_softirq+0x644/0xfd0
> > [ 1986.002181]  irq_exit+0x29c/0x370
> > [ 1986.002187]  __handle_domain_irq+0xe0/0x1c4
> > [ 1986.002192]  gic_handle_irq+0x1c4/0x3b0
> > [ 1986.002197]  el1_irq+0xb0/0x140
> > [ 1986.002203]  lock_release+0x660/0x7dc
> > [ 1986.002209]  rcu_lock_release+0x20/0x28
> > [ 1986.002214]  do_msgrcv+0x708/0xed0
> > [ 1986.002219]  ksys_msgrcv+0x4c/0x60
> > [ 1986.002224]  __arm64_sys_msgrcv+0xb8/0x194
> > [ 1986.002230]  el0_svc_handler+0x230/0x3bc
> > [ 1986.002236]  el0_svc+0x8/0xc
> > [ 1986.007106]  OUTLINED_FUNCTION_169+0x4/0xc
> > [ 1986.011885]  free_debug_processing+0x2f4/0x3e4
> > [ 1986.017186]  load_msg+0x4c/0x324
> > [ 1986.021617]  kmem_cache_free+0x44c/0x870
> > [ 1986.026917]  ksys_msgsnd+0x1e0/0xe5c
> > [ 1988.050035]  _raw_spin_unlock_irqrestore+0x44/0xac
> > [ 1988.054821]  free_debug_processing+0x2f4/0x3e4
> > [ 1988.059260]  kfree+0x3f8/0x7ac
> > [ 1988.062313]  free_msg+0x50/0xb0
> > [ 1988.065450]  do_msgrcv+0xd80/0xed0
> > [ 1988.068846]  ksys_msgrcv+0x4c/0x60
> > [ 1988.072243]  __arm64_sys_msgrcv+0xb8/0x194
> > [ 1988.076336]  el0_svc_handler+0x230/0x3bc
> > [ 1988.080255]  el0_svc+0x
>
> I'm hoping that Andrey can make sense of this, since he recently hacked up
> freelist_ptr(), although only if CONFIG_SLAB_FREELIST_HARDENED=y, which
> isn't the case in your .config.

So far, I've been unable to trigger this in QEMU as well.

Qian, could you check if this still happens after adding that -pg flag
in KASAN Makefile?

>
> One thing I did spot is that KASAN doesn't play nicely with page poisoning,
> because the pointer returned by kmap_atomic() which is used to poison and
> unpoison a page on free and alloc respectively is tagged. The simplest way
> to fix this was to disable KASAN around these operations (diff below).

There's a patch in the mm tree that addresses this already.


>
> I think the unfortunate reality is that KASAN_SW_TAGS will always be flaky
> because most kernel code isn't (and wasn't) written with it in mind.  The
> reason that's acceptable is because it's a debug option, but it also means I
> can't justify spending very much time on these sort of reports, sorry.
>
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
