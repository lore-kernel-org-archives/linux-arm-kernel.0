Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA77C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:42:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10BE2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W48KLe85";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="a9FAF89+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10BE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+VLvCfU6oTBrPHaDE7BeE38BT169Tf92oUgkOqcmUxQ=; b=W48KLe85vkcTtE
	DYXtO56KJoOfnpaTsglDUQBRpms4rdF95fyU37a/Gl3YuhwigNpNL2JXqwe1PiF2OV8VFa6gnXFpq
	VuW12Urbsak9mmtLvE4PK8cvUIGVj6b0B/A9k90WRp92U4E5MzcDaxyxqzBfYsgxZnoULg5H3Mobx
	RaCj+SDzCG8IlpO35rLQx/EGlXsZnWxL8ic7lYgGhjy/rMWZNuegxslObX3DkcR7tC2LPRWTm0Q4z
	uxl3qTo/zOMI7NiMkP1aQf1h+5XQMu3Y+IpB3kPuPULT3dhw+vthxfSelhiq4uuccevkn43X5g7Fb
	tTW2Fnf/NR9jwOAfbJdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUc7T-0007bm-OW; Wed, 05 Dec 2018 18:41:59 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUc7P-0007aw-PE
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:41:57 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so9425637pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L+1EMzKOjBiwuGhi/MG7K020+yXNrdMNTDqMByOmEvg=;
 b=a9FAF89+5mJzJDYK0vVpio2YzWrh8xf0wB8knrh4Ke7fIXgXegBewd2sQcbLbsXcSn
 5TfdISC02xFy7I1TY0IXNGErq8X+ZmeAobFzYt1G8kyPiPxNYsyjMWjfdSlgPCDhL/jl
 hcG+OF9TfhfvrxYX5lVA5I5wolPBFFrzrEPl9N02VyBpFVKyobmYvoQBlgZsCPi6+mCB
 8ulO1oglNCKGM8rBao53rwQVNWHujtvEeW4yP0ymt6VKO7chEGLjTGQRD9xvG3xG/VKO
 yPRezMUBU++CtACz8A2C1wm6Xpziyk2R5qN7H4K6gKudv/oZk8QTbm4Z0Oppb4JrwWyR
 tKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L+1EMzKOjBiwuGhi/MG7K020+yXNrdMNTDqMByOmEvg=;
 b=A4qZI47jVz2XFqqmCDZ/KfcP/JQ2Di2694+fyzz8NfzK2ueUvZOkOrro7mgqZfH7MG
 1SGZDtNT/IS4t+oaUUpj4MIpeBtJA3Noeov3hEoqfxTRsRgH2IySXpBL0+HhBcjx7Apm
 ZSyuWJfL/Sfqlre5oeyUMPa+f+waMENFKEnIPGhxU5FUjzeX7J2mAzk+ugjDGKJZUGk5
 hvOQCxju0coHjOyqXNSHpGXiT4cBexlRT1P32G5+ng758wBHDk67i1CCPw/IydHXU2hv
 wVnmhELXnyBIvspdZ4K3gXQGwmJA4PpTkk91kMjl7kwam3U+sKLWtetfuKbdUbk8qCGU
 u5Vg==
X-Gm-Message-State: AA+aEWbIVZuVNrI+FBYB/S0fJZgCXVvPyOoyY0RftKtuj7rC5ZmZ0puO
 hbG8/XQofwHoBRYa0Fauy1GiTCmHuR/5TE5WpUBqZA==
X-Google-Smtp-Source: AFSGD/V0tUGv06YjyOZoyqygkks8HCVAH16MVZixH/mtBr7QSJV2jc6pDPU/UYkzGu/kXH91xsC8ArpERy0YINJNE34=
X-Received: by 2002:a62:b80a:: with SMTP id p10mr25381895pfe.32.1544035304921; 
 Wed, 05 Dec 2018 10:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox>
 <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 5 Dec 2018 10:41:33 -0800
Message-ID: <CAKwvOdnQy0HsfDgJeq02opRD1A7fje=bZfpypUFcXWj9CHVyVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_104155_834971_B14F1DCB 
X-CRM114-Status: GOOD (  27.86  )
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
 linux@armlinux.org.uk, Stefan Agner <stefan@agner.ch>,
 LKML <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 10:40 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> > > (+ Arnd)
> > >
> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > > >
> > > > > > This flag is not supported by lld:
> > > > > >
> > > > > >     ld.lld: error: unknown argument: --pic-veneer
> > > > > >
> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > >
> > > > > Hi Nate,
> > > > >
> > > > > Does this mean ld.lld is guaranteed to produce position independent
> > > > > veneers if you build kernels that are bigger than the typical range of
> > > > > a relative branch?
> > > > >
> > > >
> > > > Hi Ard,
> > > >
> > > > Honestly, I'm not quite sure. I saw your commit that introduced this
> > > > flag and I wasn't quite sure what to make of it for lld. What
> > > > configuration would I use to verify and what would I check for?
> > > >
> > >
> > > Try building allyesconfig, and check the resulting binary for veneers
> > > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> > > them). These veneers should not take the [virtual] address of the
> > > branch target directly, but take a PC relative offset (as in the
> > > example in the commit log of that patch you are referring to)
> > >
> >
> > Alright, compiling with allyesconfig is a little rough at the moment
> > (bug reports I will file in due time) but I was able to do it. Here's
> > the disassembly specifically for the functions you had in your commit,
> > my assembly knowledge is pretty much non-existent unfortunately so I am
> > not sure what to make of it (it doesn't look like there is a virtual
> > address for pc in that mix?). I am happy to provide any more information
> > that is needed.
> >
> > c03030cc <__enable_mmu>:
> > c03030cc:       e3c00002        bic     r0, r0, #2
> > c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
> > c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
> > c03030d8:       e3a05051        mov     r5, #81 ; 0x51
> > c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
> > c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
> > c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
> > c03030e8:       e320f000        nop     {0}
> > c03030ec:       e320f000        nop     {0}
> > c03030f0:       e320f000        nop     {0}
> > c03030f4:       e320f000        nop     {0}
> > c03030f8:       e320f000        nop     {0}
> > c03030fc:       e320f000        nop     {0}
> >
> > c0300000 <__turn_mmu_on>:
> > c0300000:       e1a00000        nop                     ; (mov r0, r0)
> > c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> > c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
> > c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> > c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> > c0300014:       e1a03003        mov     r3, r3
> > c0300018:       e1a0300d        mov     r3, sp
> > c030001c:       e1a0f003        mov     pc, r3
> >
>
> Thanks Nate.
>
> So these functions no longer appear to reside far away from each
> other, so there no veneer has been emitted.
>
> What we're looking for are veneers, i.e., snippets inserted by the
> linker that serve as a trampoline so a branch target that is far away
> can be reached.
>
> If no symbols exist with 'veneer' in their name *, it might make sense
> to rebuild the kernel as Thumb2, which has a branching range of only 8
> MB (as opposed to 16 MB for ARM mode)

Heh, Arnd and I were just talking about this yesterday.  Is there a
config that sets Thumb2 mode for the kernel?

>
> * I have no idea whether lld names its veneers like this, or even at all



-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
