Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F10C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8471F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AzQTVskb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SJqJXjIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8471F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=63yIcNN46ejIdKeSpb2HgOhw45pwb3Bg3vXG4CGEak8=; b=AzQTVskbNFQrII
	Yh2JEhiAhYGWmGddG5Ht6c10gKuXYZAKO0NUw5KYQLYVYxyVy5eJaNx9qg/kBd0ZDKdYKSk02iqED
	oG57Sqps7SzAbvYTDsyojS780N61o9ppju8zXyxGiIkRmmXqWUIpYpSwTA4NRDcyJ6F4Bvsqgr/bo
	ohmL3oCtZqe4x4KKOJX2P4PCg09ZgVJBso3pJlmButAoBrUGbWxFttUtCU9HWMPW3GUAS2362YOtW
	oygR6mLhLKn1EdsnSN3kKqw7Tm0n1PLU+cC/peLvW2+qed2VbxODy0MsF8oOfDDMQQ7cwcJYcwSlL
	j+cc/DG71/kNrUwDwxQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjGU-0000Wo-M0; Thu, 07 Feb 2019 12:58:50 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjGQ-0000W6-VX
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 12:58:48 +0000
Received: by mail-pg1-x541.google.com with SMTP id n2so4462425pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rRWwt4URCRXcwIZxbYDkHZAEZxjPcHH4qziRDx6ay7I=;
 b=SJqJXjIBwzbuiMMx3cdyzQxG2h+pkW8Nqnxt/dW6chSPurhZN+GxpGd2H01aKvryWX
 /7o/c649L3gMxZ/4X+1jK0bprBzSouam0GMBRDQ5skeMM+Tr26A57RLVPiS8+HibBdv5
 DUlwUrgLG1VjrxiPhxli+/qDqdDDvZh9jLQWVY8ZYzhenoJl1LWIeXbPaHv6X13u1MZr
 bMiLBO+p3eQDTjD/M48KQtxZkNpZttRLLWcZ5YZJTWT410noBnrxDJUlIhpdPz+kv+Vp
 R1/uGQ3E/9kAdTtvo29gBWLFW9Ljte4ORSfdyYVq11iUJhJy70WQw3hfEMeq1iMlwOEu
 SsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rRWwt4URCRXcwIZxbYDkHZAEZxjPcHH4qziRDx6ay7I=;
 b=DOw9nrR/hiPYMIdP2cVyGIQdXWkZ2AhoxjZlPD9pFSDvpUXbtCwyIzOkE7/Fb+hD3F
 O347FqBAq/DDUaLps/yYkQC3nyqzi68l57zmo5qVYbmBrSHjAhePHtubkfibZULLOgCO
 ObdTuK3VUal8waduCPwlA91n9Un5SdLPPuS8aR74lZ/T7AKYnZ+Ykgl4rVsoCbsueq8D
 2JuzEQJzjZfWcIR7JU1UVT5QkM643a7uWtEDAdZY4C9dNovSMniqoYbE4/bXs3WU+rpi
 rrCAbmz0pweHn6+VDV8cOhOMBia3+HEgxEJBdRB3/VKYL5hcwVD/wUZq74gg3uoXh3ZJ
 AhqQ==
X-Gm-Message-State: AHQUAub+P0nIjxQUL8Y6jGOeP8ihHBSoFGp7zu0o0e24tR8NOK67/nhy
 S+CwzhaIz645nRI5VuYnap+v35m3RrXHjHzCJ4C6zA==
X-Google-Smtp-Source: AHgI3IYq/RozyymCMYCqwKU17RYvcd7MFhkheCrs+eM9ALWLG/mli/pClahJ31igwZ5DN5iPyTD95MOutF5xsXHzPSU=
X-Received: by 2002:a62:5c1:: with SMTP id 184mr15885896pff.165.1549544323426; 
 Thu, 07 Feb 2019 04:58:43 -0800 (PST)
MIME-Version: 1.0
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
In-Reply-To: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 7 Feb 2019 13:58:32 +0100
Message-ID: <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
Subject: Re: CONFIG_KASAN_SW_TAGS=y NULL pointer dereference at
 freelist_dereference()
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_045847_042118_70160A59 
X-CRM114-Status: GOOD (  19.37  )
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 5:04 AM Qian Cai <cai@lca.pw> wrote:
>
> The kernel was compiled by clang-7.0.1 on a ThunderX2 server, and it fails to
> boot. CONFIG_KASAN_GENERIC=y works fine.

Hi Qian,

Could you share the kernel commit id and .config that you use?

Thanks!

>
> deactivate_slab+0x84/0x6ac:
> freelist_dereference at mm/slub.c:262
> (inlined by) get_freepointer at mm/slub.c:268
> (inlined by) deactivate_slab at mm/slub.c:2056
>
> /* Returns the freelist pointer recorded at location ptr_addr. */
> static inline void *freelist_dereference(const struct kmem_cache *s,
>                                          void *ptr_addr)
> {
>         return freelist_ptr(s, (void *)*(unsigned long *)(ptr_addr),
>                             (unsigned long)ptr_addr);
> }
>
> [    0.000000] Memory: 3259968K/100594752K available (15548K kernel code, 12360K
> rwdata, 4096K rodata, 25536K init, 27244K bss, 7444672K reserved, 0K cma-reserved)
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000078
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x96000005
> [    0.000000]   Exception class = DABT (current EL), IL = 32 bits
> [    0.000000]   SET = 0, FnV = 0
> [    0.000000]   EA = 0, S1PTW = 0
> [    0.000000] Data abort info:
> [    0.000000]   ISV = 0, ISS = 0x00000005
> [    0.000000]   CM = 0, WnR = 0
> [    0.000000] [0000000000000078] user address but active_mm is swapper
> [    0.000000] Internal error: Oops: 96000005 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc5+ #6
> [    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : deactivate_slab+0x84/0x6ac
> [    0.000000] lr : deactivate_slab+0x1cc/0x6ac
> [    0.000000] sp : ffff100012cf7be0
> [    0.000000] x29: ffff100012cf7cc0 x28: ffff1000114e4f00
> [    0.000000] x27: ffff1000114e4f20 x26: ffff1000114e4f08
> [    0.000000] x25: ffff1000114e5078 x24: fb00000000000000
> [    0.000000] x23: ffff7fe002080008 x22: ffff808abb5b72d0
> [    0.000000] x21: ffff7fe002080020 x20: ffff7fe002080028
> [    0.000000] x19: ffff7fe002080000 x18: ffff1000148a5538
> [    0.000000] x17: 000000000000001b x16: 0000000000000000
> [    0.000000] x15: 007ffffffc000201 x14: 04ff80082000fa80
> [    0.000000] x13: 0000000080660002 x12: 0000000080660003
> [    0.000000] x11: 4582a03bdc147ab9 x10: ffff100012d31c90
> [    0.000000] x9 : fb00000000000078 x8 : ffff100012d31c80
> [    0.000000] x7 : cccccccccccccccc x6 : ffff1000105d8db8
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> [    0.000000] x3 : ffff808abb5b72d0 x2 : 04ff800820000580
> [    0.000000] x1 : ffff7fe002080000 x0 : ffff1000114e4f00
> [    0.000000] Process swapper (pid: 0, stack limit = 0x(____ptrval____))
> [    0.000000] Call trace:
> [    0.000000]  deactivate_slab+0x84/0x6ac
> [    0.000000]  ___slab_alloc+0x648/0x6fc
> [    0.000000]  kmem_cache_alloc_node+0x408/0x538
> [    0.000000]  __kmem_cache_create+0x20c/0x6a8
> [    0.000000]  create_boot_cache+0x68/0xac
> [    0.000000]  kmem_cache_init+0xb0/0x19c
> [    0.000000]  start_kernel+0x4b4/0xac4
> [    0.000000] Code: 14000057 b9400369 f940032b 8b090309 (f940012a)
> [    0.000000] ---[ end trace 54ad7e55e4749a96 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/b1d210ae-3fc9-c77a-4010-40fb74a61727%40lca.pw.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
