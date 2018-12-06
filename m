Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AB520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T3YM03XR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="k1HrU0KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AB520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I4W/olF//kTMeaQnwhp9+Hl+1mDDG9X+SQzit5dfg+c=; b=T3YM03XR8eNmaa
	xzGe5vsAGo2hXa5kHwz+J+mDuYOyahU5wBct1yqysfVMxhsXpDp6rQPeoxLVb+6TC6sLu8mq+YOYJ
	Xexfcq0ZBdQgW6VKFg1KOe+QRxYtxOV6lxzq8HWxHnKHN3Xjx61rYDoQ97Hyi4PrDtS0O+0uXqApC
	hxler2NnIUvpAXbEITUlagmJb2/z7oDvJiPHlUBG8Mk0D6tH5D3s8UJYD/2bsgpgFs6qWt+0k3YKr
	e/bU1N6+FbPb9v0dIQGsSQvTSSRUQvVBm65STEgTtC4QqIjb5uIMCeC5+PoTk3LjO/3sX40fIa6WT
	lMirPllNQKo8hEDpKs/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqx0-0004Ow-Nu; Thu, 06 Dec 2018 10:32:10 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqww-0004N0-4I
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:32:08 +0000
Received: by mail-io1-xd44.google.com with SMTP id o5so13289640iop.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NjA60Ta70B0BdffOxwLfM6fA5laqa+qcnZ7JQd20IsE=;
 b=k1HrU0KSEVnr9c1TqhF36VcNxLHh3i8j8MK1D8HFHqd7xVR8V/Eni9IWlGvZjptFwQ
 x035l63fXncSWvOHa1z8Skf3jP60uEjV0WtpVh4VicCsuf5NvYYki80r+UKnfkMoqnc+
 /b8TNUjzp/kHjvxAXUl9lrkk9aniDQcMAeZX4yU8GCAlgllhHXgBl7EphuZXsJUHSDKg
 KV1zrOBHERkYxjAEuk/W/ZIPnTfc+n1pKMzapVxEjyWlJOOOo8tUXTFBkvrp6xU46VT3
 LLHauH2FiLuid+CfBIs3heWHRA2NeYspmhyGtVd6rtU55S4OTgZXKlcdByg0wNhdCjP+
 zz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NjA60Ta70B0BdffOxwLfM6fA5laqa+qcnZ7JQd20IsE=;
 b=Fa7qA5tByqGodtQujPEvNp1pUrzMWUkhC5lMTdcn1VGDRbPNKOZVU2dpQnA5lQCd6b
 dv7YHwltoMaIcAhXX23xTDOPvPzxdeqPj1asu7d/Cgwhe3q1LSGGmC779zbJlpNM+iix
 43NiNb9+znaS26mglATmFPQed1d1Vg16xszMFJd/9YY10YWUkg7K4W9hb1gnNs4anK+v
 CkSQupRfi7lDjKRQ5oICJRxZPPrG01ySGvYOzD3Zt4gO8C7SCM3bJs65QPy7/3xNU+4o
 7HJmFs+rPK2ZVE/dwbYaUOMiLIs0XhhLV8+5kMoiseiblbpCBuCtYRJ8mJ7H6eNIC0TR
 qGJg==
X-Gm-Message-State: AA+aEWbXQE5/5BSLb4yNbV2eo8GnCGSnS75ZP4kqram+AfAusd6ZLhnL
 tZR8idlUdmv/0dZ3PxD1vNHMGJFpNzg8FACrRjldpA==
X-Google-Smtp-Source: AFSGD/X7kjfiGvPtE1+7cYM3wjPmz7gw1yXVn9ww++aMKruyZOq1Xt/6CmcltuxQFQaHf18t717zniivb+ebW5sMfCI=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr25725066ior.31.1544092314966; 
 Thu, 06 Dec 2018 02:31:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com>
 <e825441eda1dbbbb7f583f826a66c94e6f88316a.1543337629.git.andreyknvl@google.com>
 <20181129180138.GB4318@arm.com>
In-Reply-To: <20181129180138.GB4318@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 11:31:43 +0100
Message-ID: <CAAeHK+zVzWJ7RBsX88SOsebq0a40ypuawYFd4w4woFSHuximOw@mail.gmail.com>
Subject: Re: [PATCH v12 20/25] kasan,
 arm64: add brk handler for inline instrumentation
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_023206_172899_D522BE3E 
X-CRM114-Status: GOOD (  21.73  )
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

On Thu, Nov 29, 2018 at 7:01 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Nov 27, 2018 at 05:55:38PM +0100, Andrey Konovalov wrote:
> > Tag-based KASAN inline instrumentation mode (which embeds checks of shadow
> > memory into the generated code, instead of inserting a callback) generates
> > a brk instruction when a tag mismatch is detected.
> >
> > This commit adds a tag-based KASAN specific brk handler, that decodes the
> > immediate value passed to the brk instructions (to extract information
> > about the memory access that triggered the mismatch), reads the register
> > values (x0 contains the guilty address) and reports the bug.
> >
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/brk-imm.h |  2 +
> >  arch/arm64/kernel/traps.c        | 68 +++++++++++++++++++++++++++++++-
> >  include/linux/kasan.h            |  3 ++
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> > index ed693c5bcec0..2945fe6cd863 100644
> > --- a/arch/arm64/include/asm/brk-imm.h
> > +++ b/arch/arm64/include/asm/brk-imm.h
> > @@ -16,10 +16,12 @@
> >   * 0x400: for dynamic BRK instruction
> >   * 0x401: for compile time BRK instruction
> >   * 0x800: kernel-mode BUG() and WARN() traps
> > + * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
> >   */
> >  #define FAULT_BRK_IMM                        0x100
> >  #define KGDB_DYN_DBG_BRK_IMM         0x400
> >  #define KGDB_COMPILED_DBG_BRK_IMM    0x401
> >  #define BUG_BRK_IMM                  0x800
> > +#define KASAN_BRK_IMM                        0x900
> >
> >  #endif
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 5f4d9acb32f5..04bdc53716ef 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/kasan.h>
> >
> >  #include <asm/atomic.h>
> >  #include <asm/bug.h>
> > @@ -284,10 +285,14 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
> >       }
> >  }
> >
> > -void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > +void __arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> >  {
> >       regs->pc += size;
> > +}
> >
> > +void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > +{
> > +     __arm64_skip_faulting_instruction(regs, size);
> >       /*
> >        * If we were single stepping, we want to get the step exception after
> >        * we return from the trap.
> > @@ -959,7 +964,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
> >       }
> >
> >       /* If thread survives, skip over the BUG instruction and continue: */
> > -     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > +     __arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
>
> Why do you want to avoid the single-step logic here? Given that we're
> skipping over the brk instruction, why wouldn't you want that to trigger
> a step exception if single-step is enabled?

I was asked to do that, see the discussion here:

https://www.spinics.net/lists/linux-mm/msg146575.html
https://www.spinics.net/lists/linux-mm/msg148215.html
https://www.spinics.net/lists/linux-mm/msg148367.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
