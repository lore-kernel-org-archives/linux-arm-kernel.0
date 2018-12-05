Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B42EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F89E20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D62YuBzB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLbOQiiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F89E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3oAgSQLCbM4zSSgFVYrN/TiYvjQxyBGaZkb8MDh6OA=; b=D62YuBzBfiCEpJ
	q15KQnFDydnprxvq/rPh20xK76iVxjZG4kptwjMgPcFd+OZrBBsuEAkBSchjJq4NktrDV2nKeGmeq
	rNjKzUALZtHKRbuMn/tG0jYRsuDH41pX/0j1sPSuhy99h7AQuHfcS7hvBozBlCkAoI/7zptr/5mlt
	2m/yB/lYuQYssbIFDRQgbsW71kjRDkCiTlXZqLkuvcuSHAlQP+iQSmLA+J9K6q3ynl5rt5MK/MQiK
	1BtKd4OohPJb9gtnGcNWVkRpdmX2RmiZL3vgJ6gJgISAABx+pLh7JnruyI0lAuMuGG6VtH705Bv/G
	njm5JOr39zleLUQeQMlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUc6S-0007Jo-78; Wed, 05 Dec 2018 18:40:56 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUc6O-0007Ih-KV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:40:54 +0000
Received: by mail-pl1-x644.google.com with SMTP id k8so10466839pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KEwf4cb/XWVkxZOrt56/52D/0gRHqwxlGcYV+PdLeLI=;
 b=ZLbOQiiRHw6p/Iqudp6ZDAL5mqP2uYUIKDpOYeBu/JMl195R0sHwOzefc9htKk8qvB
 I9Ts/+oYKr0tm1ML4Q/SjDI9bGJn6rMUyZdm+/gCM/npJ8qHY7Tor2WZZkfSwPuHsTK7
 lU3AsLE/DOybpWyfPCmUzhCUfOTzeKtFsTW3W8oA3Nmy0IWK7duV/45aPbx+swYhxwMZ
 zPo8kuiKj3OLXdHPLpz1s5k88wKuduLU26PbZntfWLjIkyr8AJmvM5dDmWi+I/QQXbgH
 zP8B8K8quOGyoCoLZoBLeRwmrC8KBJypFoRTVRbblgUMoAHqjfTzRyG2R/OOPfTqTHqe
 KeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KEwf4cb/XWVkxZOrt56/52D/0gRHqwxlGcYV+PdLeLI=;
 b=azrIDMe2IOIC2tY6sfnStovBxl+AC3BwggHaXQMPx6+ZojRjTRx6wXMeBtTVGuM56Q
 d/h4w1RuYMs8I7oJTBwIlL2J1NIBP6rydRgcpuQj7V+VX0oLGYn1VyErfPNx+BpCiyW8
 TAzQBN0dCePIIq30z0CYCA+WP1iBM9bPbK8asILWzYIg4LpJXciM3LVHrzkrdKm1Fhzx
 KmwLq2YauCdXS6y5uWF5th+ZvI6X+OLr+h9YkKNfskIieVEw96uqnZXxbzdK9V1ikoSR
 A2Of54/O+VUgM6WqcjycVa2ZLVQ/EbHh7dmeP2U20CJcQjD6ul7Py3/+kcapXf4rp8Ma
 SF4w==
X-Gm-Message-State: AA+aEWaK0jMiNHrKomPqP4FeyD1w8gU/ZULpX6GErUfrZjG+PzL7/Nkd
 ZnkR+DNYWRnPzT0l7dhWa45pyy3jr67m/OTC8xOXSA==
X-Google-Smtp-Source: AFSGD/UKFHJK5Isqil4WQQfeCrCORN5fHeoXyKjGtuos/xHYuziQEp3M6LE4hBGu1QyHO1gRnbuobhVj0hmHDE6BUhA=
X-Received: by 2002:a17:902:4464:: with SMTP id
 k91mr25655609pld.13.1544035241436; 
 Wed, 05 Dec 2018 10:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox>
In-Reply-To: <20181205183606.GA7274@flashbox>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 5 Dec 2018 10:40:30 -0800
Message-ID: <CAKwvOdn+qRhNX1x+pTiqGA=8ud5PxtiV61sPL5JTawQ6HAFtxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Nathan Chancellor <natechancellor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_104052_683164_A1D17F70 
X-CRM114-Status: GOOD (  29.45  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 linux@armlinux.org.uk, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 10:36 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> > (+ Arnd)
> >
> > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > >
> > > > > This flag is not supported by lld:
> > > > >
> > > > >     ld.lld: error: unknown argument: --pic-veneer
> > > > >
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > >
> > > > Hi Nate,
> > > >
> > > > Does this mean ld.lld is guaranteed to produce position independent
> > > > veneers if you build kernels that are bigger than the typical range of
> > > > a relative branch?
> > > >
> > >
> > > Hi Ard,
> > >
> > > Honestly, I'm not quite sure. I saw your commit that introduced this
> > > flag and I wasn't quite sure what to make of it for lld. What
> > > configuration would I use to verify and what would I check for?
> > >
> >
> > Try building allyesconfig, and check the resulting binary for veneers
> > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> > them). These veneers should not take the [virtual] address of the
> > branch target directly, but take a PC relative offset (as in the
> > example in the commit log of that patch you are referring to)
> >
>
> Alright, compiling with allyesconfig is a little rough at the moment
> (bug reports I will file in due time) but I was able to do it. Here's
> the disassembly specifically for the functions you had in your commit,
> my assembly knowledge is pretty much non-existent unfortunately so I am
> not sure what to make of it (it doesn't look like there is a virtual
> address for pc in that mix?). I am happy to provide any more information
> that is needed.

Nathan,
Thanks for getting a build working!  I think Ard is looking for the
presence of symbols with `veneer` in the name.

Something like `llvm-objdump -t vmlinux | grep veneer` or `llvm-nm
vmlinux | grep veneer` should tell you if such symbols exist.

If they do, Ard was then looking for the disassembly of those labels
(like you provided for __enable_mmu/__turn_mmu_on).

>
> c03030cc <__enable_mmu>:
> c03030cc:       e3c00002        bic     r0, r0, #2
> c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
> c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
> c03030d8:       e3a05051        mov     r5, #81 ; 0x51
> c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
> c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
> c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
> c03030e8:       e320f000        nop     {0}
> c03030ec:       e320f000        nop     {0}
> c03030f0:       e320f000        nop     {0}
> c03030f4:       e320f000        nop     {0}
> c03030f8:       e320f000        nop     {0}
> c03030fc:       e320f000        nop     {0}
>
> c0300000 <__turn_mmu_on>:
> c0300000:       e1a00000        nop                     ; (mov r0, r0)
> c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
> c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> c0300014:       e1a03003        mov     r3, r3
> c0300018:       e1a0300d        mov     r3, sp
> c030001c:       e1a0f003        mov     pc, r3
>
> Thanks,
> Nathan
>
> > > Additionally, I have filed an LLVM bug for the lld developers to
> > > check and see if this is a flag they should support:
> > >
> > > https://bugs.llvm.org/show_bug.cgi?id=39886
> > >
> > > Thanks for the quick reply,
> > > Nathan
> > >
> > > > > ---
> > > > >  arch/arm/Makefile | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > > index e2a0baf36766..4fab2aa29570 100644
> > > > > --- a/arch/arm/Makefile
> > > > > +++ b/arch/arm/Makefile
> > > > > @@ -10,7 +10,7 @@
> > > > >  #
> > > > >  # Copyright (C) 1995-2001 by Russell King
> > > > >
> > > > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > > > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > > > >  LDFLAGS_vmlinux        += --be8
> > > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > > > --
> > > > > 2.20.0.rc1
> > > > >



-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
