Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B3E208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="radD2c6G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HmoGJlRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B3E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b7DXtbQe/NTrm/9xi/pLax8GXD2t7zwD0O4djdOOUT8=; b=radD2c6G5DAXkN
	o+fGEexSWdCp+Bnx3coykfU147mg2OxT4oWfrn11boW0sSROX71cKkeuV5cIvVd/+TsOPNh6XxluZ
	RzMI4aol2tXMuEduNbB4sNU7JLOLCmTde/lDggKD7mrGHsSno5j9KwsP6boX2SP8fKUjKgxttnM3e
	0UgxBbVHp5kPwo3Mr1xNcMwZVtb0hgRPkwSMIqOZlIuiQBipTD2eCN7ThUubjy7B8vP1lboe7awJz
	Ycb87eBO2qeYQ5497aOzicUF4RuIRAS0r9KY1CQYmR4eWMEnxEJry8DypQwVQLm6A3GaW5kdAAcyq
	uNe1dkBzpWF0CuiqKoJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsxc-0000RW-SY; Thu, 06 Dec 2018 12:40:56 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsjR-0004lK-Bk
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:26:58 +0000
Received: by mail-io1-xd41.google.com with SMTP id x6so177144ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wcrQnAPF661+3WixbW/biGMry6TOjJEviqadHK67u1g=;
 b=HmoGJlRIzBGjTI45c6oZZWLJ27CVota+y9lZnaIsdIwFfftDE7rpBoZpiV81DpW8E5
 bbbZYB/VJq7jFDkIkODJxkM3IF6YadZuGC/qRwXJP9f62FgsVCDuHjXhnBihZhIJ/kzJ
 ijdLXpZMnjydMB5b0mgfN+X3h7uOXtsClC2AN1sXVvipVgnPbKk76xGdmLRK4ap3xQ/O
 YElv6bsfYZYa+Zd6qnV6DwOmTbb0LvEUGzkjH9esFyq4N/gqsIa3+0kdORAXODRkS0A1
 Te4u9veYTWfdeWYC4NlC1HZfzLvHS7zt88QxWijgLt9P3lEYMEDW28wpHbxPz356g1Er
 +4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wcrQnAPF661+3WixbW/biGMry6TOjJEviqadHK67u1g=;
 b=DUaLi41V9aVX1gdDeR5h7B0BU/uw9BcoIM1Ocdyq/IinbAdO031952NB4NkcAd774I
 qaKhlx4KcxLAT/aJfSjglFrbD2QYftT2kmSp50opZKRQZ/R0eOSpq6kQb45L16d4yDlC
 +simdXhL3RleRQukX0y8sEepaSC3XZt5vLVRrUpU3ICBgGd4B6cXoyBbThFp9Xf1jPtr
 3RxEeGJDiLxV2v47ctnaxdbH6b927Cy/IWPGY4oCrgfP+sYv3K8gC90BHLCk8TZXrJ1v
 khF3gcFnGMQG/EkkjeOYsDtu1Ayp5Zkmas7XHG82bmIsuVv32lAuRoFvdK6mw0eg3qOg
 F65Q==
X-Gm-Message-State: AA+aEWYyo35j3x3YWAQvrRAUV3slr6tmmc2I/8fBkVy15EjRqo9y7K0z
 RiTm/h5F1VtwTnEN6RlW2vtXY8ITrpjHQ5uaG9wzsQ==
X-Google-Smtp-Source: AFSGD/XMruDrVJTKAoWkikR35kp0TkElzg8XSiJWXCLDTiuVscHdJFtYhqXFO5HCqhr+U+ZmpZE9vl5ADf7M7pl8HHs=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr26027272ior.31.1544099165799; 
 Thu, 06 Dec 2018 04:26:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com>
 <e825441eda1dbbbb7f583f826a66c94e6f88316a.1543337629.git.andreyknvl@google.com>
 <20181129180138.GB4318@arm.com>
 <CAAeHK+zVzWJ7RBsX88SOsebq0a40ypuawYFd4w4woFSHuximOw@mail.gmail.com>
 <20181206111107.GE23697@arm.com>
In-Reply-To: <20181206111107.GE23697@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 13:25:54 +0100
Message-ID: <CAAeHK+w9NQYRHuNw-fAFDKVjF1L7pxTVRfe=DX1aC1iq5hYt1w@mail.gmail.com>
Subject: Re: [PATCH v12 20/25] kasan,
 arm64: add brk handler for inline instrumentation
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042617_845326_42ACD9EB 
X-CRM114-Status: GOOD (  27.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 12:10 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Dec 06, 2018 at 11:31:43AM +0100, Andrey Konovalov wrote:
> > On Thu, Nov 29, 2018 at 7:01 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > On Tue, Nov 27, 2018 at 05:55:38PM +0100, Andrey Konovalov wrote:
> > > > Tag-based KASAN inline instrumentation mode (which embeds checks of shadow
> > > > memory into the generated code, instead of inserting a callback) generates
> > > > a brk instruction when a tag mismatch is detected.
> > > >
> > > > This commit adds a tag-based KASAN specific brk handler, that decodes the
> > > > immediate value passed to the brk instructions (to extract information
> > > > about the memory access that triggered the mismatch), reads the register
> > > > values (x0 contains the guilty address) and reports the bug.
> > > >
> > > > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >  arch/arm64/include/asm/brk-imm.h |  2 +
> > > >  arch/arm64/kernel/traps.c        | 68 +++++++++++++++++++++++++++++++-
> > > >  include/linux/kasan.h            |  3 ++
> > > >  3 files changed, 71 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> > > > index ed693c5bcec0..2945fe6cd863 100644
> > > > --- a/arch/arm64/include/asm/brk-imm.h
> > > > +++ b/arch/arm64/include/asm/brk-imm.h
> > > > @@ -16,10 +16,12 @@
> > > >   * 0x400: for dynamic BRK instruction
> > > >   * 0x401: for compile time BRK instruction
> > > >   * 0x800: kernel-mode BUG() and WARN() traps
> > > > + * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
> > > >   */
> > > >  #define FAULT_BRK_IMM                        0x100
> > > >  #define KGDB_DYN_DBG_BRK_IMM         0x400
> > > >  #define KGDB_COMPILED_DBG_BRK_IMM    0x401
> > > >  #define BUG_BRK_IMM                  0x800
> > > > +#define KASAN_BRK_IMM                        0x900
> > > >
> > > >  #endif
> > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > > index 5f4d9acb32f5..04bdc53716ef 100644
> > > > --- a/arch/arm64/kernel/traps.c
> > > > +++ b/arch/arm64/kernel/traps.c
> > > > @@ -35,6 +35,7 @@
> > > >  #include <linux/sizes.h>
> > > >  #include <linux/syscalls.h>
> > > >  #include <linux/mm_types.h>
> > > > +#include <linux/kasan.h>
> > > >
> > > >  #include <asm/atomic.h>
> > > >  #include <asm/bug.h>
> > > > @@ -284,10 +285,14 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
> > > >       }
> > > >  }
> > > >
> > > > -void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > > > +void __arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > > >  {
> > > >       regs->pc += size;
> > > > +}
> > > >
> > > > +void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > > > +{
> > > > +     __arm64_skip_faulting_instruction(regs, size);
> > > >       /*
> > > >        * If we were single stepping, we want to get the step exception after
> > > >        * we return from the trap.
> > > > @@ -959,7 +964,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
> > > >       }
> > > >
> > > >       /* If thread survives, skip over the BUG instruction and continue: */
> > > > -     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > > > +     __arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > >
> > > Why do you want to avoid the single-step logic here? Given that we're
> > > skipping over the brk instruction, why wouldn't you want that to trigger
> > > a step exception if single-step is enabled?
> >
> > I was asked to do that, see the discussion here:
> >
> > https://www.spinics.net/lists/linux-mm/msg146575.html
> > https://www.spinics.net/lists/linux-mm/msg148215.html
> > https://www.spinics.net/lists/linux-mm/msg148367.html
>
> Aha, but we subsequently fixed the underlying problem in commit
> 9478f1927e6e ("arm64: only advance singlestep for user instruction traps").
> You were on cc, but I appreciate it's not clear that it was related to this.

Sorry, missed that patch.

> Anyway, you can just call arm64_skip_faulting_instruction() as you were
> doing and there's no need for this refactoring.
>
> Please could you spin a new version so that akpm can replace the one which
> he has queued?

Done. Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
