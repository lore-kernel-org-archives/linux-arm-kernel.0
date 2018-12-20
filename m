Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A53C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:03:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFB921741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g78IDksN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KOeaA4RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFB921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DuF4LstEdtEUzzntDURyTUiawAM6DSzJ6mYGxUhU5u8=; b=g78IDksNVixmGz
	ZQSeW64e+Fr2+p/pkFxWD1k2w2/ge590GwPZMF+7Aoh9trnatuyMCaZWx3l+pMLStRyNg+aqDrcAA
	NflDJxtg+zde2rhQ6jPAjrddJi3QkczYRdb6U92t87wcbuaLv2uUgjTRWjTDkuR08q9XYeIwQh0rl
	JgAT+MW1D2/K+5TnRvyXFqM0A3lo0ymtFO9kQ+YnslcOxgMpDeMy/LJkZxywOevQ7q8BpnNxiE8mB
	d2TNE8Igx4cTz6SJHNxZEdEehUJ2VTlj0o32db4giC9W5j7lBcqRwd9Nti8N9wHyt4v/LUi2oxkqP
	sjcJFJBKXKhUDG6lJ0dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZxyv-0007eU-1n; Thu, 20 Dec 2018 13:03:17 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZxyo-0007Z8-3z
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 13:03:15 +0000
Received: by mail-pl1-x643.google.com with SMTP id y1so855639plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 05:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z33AmGyYeTegWwnOqVnqPvq8oZtBrBxpXFU1R2PJCDQ=;
 b=KOeaA4RFW7Vqmg1WmtF7cLRxXmCj5vMgg/OW/MzbZg9l2h0MXNBFsh3zJFRGYNu9DL
 JQNodnslaUNkEMUDlplfn5SNiK72WbiPVGpnNv6NRBHvX6XoGTgY/jZj+W4fZ/MeW/7D
 oTOnVG92FVpJiZ3YMS0mI2x4XmEEitQ36aIsSIqOOzMnvzxdAwV+Nl7IaJ0UgmIOiLOz
 6fPS168dfauNGrXAZW3rlx9zDa++2V2sFumbzrBbc9I2rQvcBCtHZGrqGSW0wn4Fflvx
 fE+uj/0LHKELDJESqQj4LRamOVJ974sekG30+ZoSbG/78as7kjwnRa+y4ifax8qYDwxR
 UCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z33AmGyYeTegWwnOqVnqPvq8oZtBrBxpXFU1R2PJCDQ=;
 b=nc38Ooc8EphhtYVfGCJATw8Dc4erGVGtKggtgDNw0Q234qDLV0ZnenFWedlhy1l8d4
 RraGlj0IK3sjASOmMfa9a43jTsL/hvBCMD4ZPB8vPCSB2eHUpKtumUt8xLgSN/uIUbhc
 BYmffblFq+PkJ4MKi0YrrAhbW38isV4xPC5uSicbDNOP85Rj3/eG3vaJUALCNI9r910a
 toyxXxxIx/ZpjmnMWO4wDC5nhtb8HTa44gNR8LCYgkQz9+Lo9ot3wUKVdUysOP5FdIi7
 Ltg8ijqMKbaBflcqiPVDNKPaz82DT77dkKS3IVbblqIR7MDs5W8cYO0wsiRzuwtzGoOB
 V6WQ==
X-Gm-Message-State: AA+aEWahbHawvluTvaaNyfgmNeDirpWx1vwOP9vNfnL9bmPH0IqhA+mI
 g2Vc9cgCIGHJjYn+IvMIiqGDVRS0XjXAY/H9BqYMWw==
X-Google-Smtp-Source: AFSGD/WOa83WUlOnQ0njasNEnkyLgn6475HlT3sAOPSTUT2Ym4C/TKTW1I6IgMjTWWIfkk7SKMal+m4GX2ZLl0cvNIQ=
X-Received: by 2002:a17:902:a58a:: with SMTP id
 az10mr24543086plb.10.1545310976746; 
 Thu, 20 Dec 2018 05:02:56 -0800 (PST)
MIME-Version: 1.0
References: <706da77adfceb0c324e824d03b52d58a752577ea.1545139710.git.andreyknvl@google.com>
 <20181218125453.4c5e6c056d31ccaa3a73d4a5@linux-foundation.org>
In-Reply-To: <20181218125453.4c5e6c056d31ccaa3a73d4a5@linux-foundation.org>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 20 Dec 2018 14:02:45 +0100
Message-ID: <CAAeHK+yggnKfkycdUdTHG4MvWBMq_XK70m0rQuH873DZU+RnGQ@mail.gmail.com>
Subject: Re: [PATCH mm] kasan,
 arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
To: Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_050310_189053_D1BAD38D 
X-CRM114-Status: GOOD (  17.99  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
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
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 9:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 18 Dec 2018 14:30:33 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> > in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> >
> > ...
> >
> > --- a/arch/arm64/include/asm/kasan.h
> > +++ b/arch/arm64/include/asm/kasan.h
> > @@ -36,6 +36,10 @@
> >  #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
> >                                       (64 - KASAN_SHADOW_SCALE_SHIFT)))
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +#define ARCH_SLAB_MINALIGN   (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > +#endif
> > +
> >  void kasan_init(void);
> >  void kasan_copy_shadow(pgd_t *pgdir);
> >  asmlinkage void kasan_early_init(void);
>
> This looks unreliable.  include/linux/slab.h has
>
> /*
>  * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
>  * Intended for arches that get misalignment faults even for 64 bit integer
>  * aligned buffers.
>  */
> #ifndef ARCH_SLAB_MINALIGN
> #define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> #endif
>
> so if a .c file includes arch/arm64/include/asm/kasan.h after
> include/linux/slab.h, it can get a macro-redefined warning.  If the .c
> file includes those headers in the other order, ARCH_SLAB_MINALIGN will
> get a different value compared to other .c files.
>
> Or something like that.
>
> Different architectures define ARCH_SLAB_MINALIGN in different place:
>
> ./arch/microblaze/include/asm/page.h:#define ARCH_SLAB_MINALIGN L1_CACHE_BYTES
> ./arch/arm/include/asm/cache.h:#define ARCH_SLAB_MINALIGN 8
> ./arch/sh/include/asm/page.h:#define ARCH_SLAB_MINALIGN 8
> ./arch/c6x/include/asm/cache.h:#define ARCH_SLAB_MINALIGN       L1_CACHE_BYTES
> ./arch/sparc/include/asm/cache.h:#define ARCH_SLAB_MINALIGN     __alignof__(unsigned long long)
> ./arch/xtensa/include/asm/processor.h:#define ARCH_SLAB_MINALIGN STACK_ALIGN
>
> which is rather bad of us.
>
> But still.  I think your definition should occur in an arch header file
> which is reliably included from slab.h.  And kasan code should get its
> definition of ARCH_SLAB_MINALIGN by including slab.h.
>

KASAN code doesn't use this macro directly, so I don't think it needs
to get it's definition.

What do you think about adding #include <linux/kasan.h> into
linux/slab.h? Perhaps with a comment that this is needed to get
definition of ARCH_SLAB_MINALIGN?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
