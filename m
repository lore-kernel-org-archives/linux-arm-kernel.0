Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1DEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FE8208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YIc6Dzlt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="OIuSAW/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FE8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQsYhyfWTfkLLEAjVh+2FX1uimQKsj2pfVUBz6UBfGU=; b=YIc6Dzlt627Je8
	0NowWxglsJ8aHPZmpYAUEe0N1G/UKVoR7ZekIOjOD1k7ajL+wNtARYjGTvfmEEzePoiXDgCQC86od
	KjQzDCY8PCbw2dV5L0qT8jP2E5fPUyWKgzis2Uiu2OHSFOlp0/XXJqEaHhtvw9oOP+YC/TXohhHaF
	AgTyAa5DBhlbhops9dXrl54qiaIUO1JC6S34e+IllGW0ARQdskAm580s17mjPKLlDVLkcrUuyB2Ru
	OuXWDOO+fu2QhrJ6PfEvIrvLmK2q6K3kFJiVgwr2P1UAB5kxYvOhS7Qh+YJTBmf5jvxetxBv88u+v
	XwS4aJF4a4qh2XpbJQnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUg9N-00054P-2W; Wed, 05 Dec 2018 23:00:13 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUg9I-0003pO-Cy
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:00:10 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id EADCB5C0604;
 Wed,  5 Dec 2018 23:59:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1544050789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVYxo4u0la4cM7i7reyYTw5IJsYJFBEQtgfd+YN7xl8=;
 b=OIuSAW/oAyttAZOm1K2O2UJ1k4Ml4RwcA1IDbjNm8D2QPwk+dAOhZgOfNby5poVLZvHdoM
 RBVSzEb7lPNdFeFn9u+27xKfHHMFctjkOx8CERzY46FoVaMtvhHmv+M77nKY2fTiWXo738
 6m9ZDbpD0eFraLtoU/mI3azsPv1njBc=
MIME-Version: 1.0
Date: Wed, 05 Dec 2018 23:59:49 +0100
From: Stefan Agner <stefan@agner.ch>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
In-Reply-To: <CAKwvOdnQy0HsfDgJeq02opRD1A7fje=bZfpypUFcXWj9CHVyVg@mail.gmail.com>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox>
 <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
 <CAKwvOdnQy0HsfDgJeq02opRD1A7fje=bZfpypUFcXWj9CHVyVg@mail.gmail.com>
Message-ID: <baba21221482726e9eab67c24c308870@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_150008_742464_07E7A629 
X-CRM114-Status: GOOD (  26.81  )
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
 LKML <linux-kernel@vger.kernel.org>, linux@armlinux.org.uk,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05.12.2018 19:41, Nick Desaulniers wrote:
> On Wed, Dec 5, 2018 at 10:40 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> >
>> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
>> > > (+ Arnd)
>> > >
>> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> > > >
>> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
>> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> > > > > >
>> > > > > > This flag is not supported by lld:
>> > > > > >
>> > > > > >     ld.lld: error: unknown argument: --pic-veneer
>> > > > > >
>> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > > > >
>> > > > > Hi Nate,
>> > > > >
>> > > > > Does this mean ld.lld is guaranteed to produce position independent
>> > > > > veneers if you build kernels that are bigger than the typical range of
>> > > > > a relative branch?
>> > > > >
>> > > >
>> > > > Hi Ard,
>> > > >
>> > > > Honestly, I'm not quite sure. I saw your commit that introduced this
>> > > > flag and I wasn't quite sure what to make of it for lld. What
>> > > > configuration would I use to verify and what would I check for?
>> > > >
>> > >
>> > > Try building allyesconfig, and check the resulting binary for veneers
>> > > (which have 'veneer' in the symbol name, at least when ld.bfd emits
>> > > them). These veneers should not take the [virtual] address of the
>> > > branch target directly, but take a PC relative offset (as in the
>> > > example in the commit log of that patch you are referring to)
>> > >
>> >
>> > Alright, compiling with allyesconfig is a little rough at the moment
>> > (bug reports I will file in due time) but I was able to do it. Here's
>> > the disassembly specifically for the functions you had in your commit,
>> > my assembly knowledge is pretty much non-existent unfortunately so I am
>> > not sure what to make of it (it doesn't look like there is a virtual
>> > address for pc in that mix?). I am happy to provide any more information
>> > that is needed.
>> >
>> > c03030cc <__enable_mmu>:
>> > c03030cc:       e3c00002        bic     r0, r0, #2
>> > c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
>> > c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
>> > c03030d8:       e3a05051        mov     r5, #81 ; 0x51
>> > c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
>> > c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
>> > c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
>> > c03030e8:       e320f000        nop     {0}
>> > c03030ec:       e320f000        nop     {0}
>> > c03030f0:       e320f000        nop     {0}
>> > c03030f4:       e320f000        nop     {0}
>> > c03030f8:       e320f000        nop     {0}
>> > c03030fc:       e320f000        nop     {0}
>> >
>> > c0300000 <__turn_mmu_on>:
>> > c0300000:       e1a00000        nop                     ; (mov r0, r0)
>> > c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
>> > c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
>> > c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
>> > c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
>> > c0300014:       e1a03003        mov     r3, r3
>> > c0300018:       e1a0300d        mov     r3, sp
>> > c030001c:       e1a0f003        mov     pc, r3
>> >
>>
>> Thanks Nate.
>>
>> So these functions no longer appear to reside far away from each
>> other, so there no veneer has been emitted.
>>
>> What we're looking for are veneers, i.e., snippets inserted by the
>> linker that serve as a trampoline so a branch target that is far away
>> can be reached.
>>
>> If no symbols exist with 'veneer' in their name *, it might make sense
>> to rebuild the kernel as Thumb2, which has a branching range of only 8
>> MB (as opposed to 16 MB for ARM mode)
> 
> Heh, Arnd and I were just talking about this yesterday.  Is there a
> config that sets Thumb2 mode for the kernel?
> 

Yes there is CONFIG_THUMB2_KERNEL, and it works also with LLVM/Clang.

However, it sometimes leads to surprising issues, like I just
encountered a few days ago:

https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/

--
Stefan

>>
>> * I have no idea whether lld names its veneers like this, or even at all

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
