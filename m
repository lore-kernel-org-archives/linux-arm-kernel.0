Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D23C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4192084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LPNCMNeX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dJmuXoxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4192084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F6wU01MgYwpAWgnnBivM4L/j9tuMpRJge203Ts0qonw=; b=LPNCMNeXJIzDWg
	f0091z81z5YN8SNmVaDG/ev3Y9DoIVW9YHki/DiS+EWhnHS/JHgcd0OBWFTW3vx84QCpdF3Ty9of7
	cqyixcrF7RZEk63913DDnr/c/zVXpJKNjDSNvOaaJe5mE0O8MZ3s28U0cg7iOd6PxT2MQWe6CLDNv
	qZf3XfSD15VGQMRgqhoWmJbFqWCLTY3AEcOp2axggAP1R3N1gwGgkDFdj/SMiHlb/MhoSyl4Knp/q
	1Uw6kUIShW7W8GvwI7wEoyZv+WQItrDIuuqBGmMO2bIxTAsCFVq0F+0RaHCXfGPO4tgfOVa5+KRtq
	WamttIxadgdNH9wOcRvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxBN-0006Zx-3z; Fri, 11 Jan 2019 13:49:09 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxBJ-0006YG-50
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:49:07 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so6985275pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RXKHpApbXWxCHzZIFxDaePnTRIPPkx7fd2gBjWXrl0Q=;
 b=dJmuXoxoR2ebKOkVPfg/NJObqzbDxo0T1be0tynDB7z6tYj7G9hM8VM8rRfre8xL/V
 J+Mhfuo76Dpr63Aw9Nx1khyw6zIEO4MCNMrBfBI4bsC1uKIcpqgsTkXaJiPhA7PU4ypq
 itA0I7fvkdFB1bQqI0Iw+nFS+6FYEUIgYhaWX0RwgO6Yc6h2MLeMR9LWzeKWA1XVbY67
 RJFRIZTQDBGbYvJARugClvD7yC7wXXL3KUNIli7rE4gdOKYyYJjWvTsqAYPH2zkzkYwD
 n/MXITuQcZ+pBj1xyd1fo5wD2Td1v3bOR0R7eMo/k2I8zhFzEHgr2JM8YCmRgIlh0iyd
 4V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RXKHpApbXWxCHzZIFxDaePnTRIPPkx7fd2gBjWXrl0Q=;
 b=DvHddP6VYC59rkow/E7SXJJj4mDCasc8DVWNNJLdKkt2YDSbvJabaaQX0KcES9yk1F
 cw5MY/fk6sS3DBLD0R0WUF77UNpUtalM8Wg+2WLhFwxcYJR8ewjXE+YrN9ULE3hYyfHR
 s4H6kGlDTmscO+8R1mGWBrVWQsXiIJXaZ6IUYnu9O1t5bAQTNKtt/c+/i0goYgytVECR
 kg5D56/Ea9rm2LPJmi/K+1zJaMtgpMlJjETlGEFQdA6na6aHy+6Z8ol+wUcPwnTd1Rv0
 x/PT02Zrpl6zD5WL1Wxgr4heFV7h8MnYUgVwYfCPQNeQVLEl/f05wCjyLK/w24fm3eTs
 jcmw==
X-Gm-Message-State: AJcUukcWIQzEyk4txEbk3FMNTN/Y1F0LveSCSw0kKZrG0GNCb9jQ/5HY
 subA3F0W1BHd2yOM/S1WvR6NDEM3YVNWdV6xT5PPpg==
X-Google-Smtp-Source: ALg8bN79Ji5SFeOBKJt3PLt4o/figJFVOUJpjacA7qTyh0mPZs5n0LFnTClGYX1AY0wZk8bxKDxdW0PBUJ/+g9Pum+o=
X-Received: by 2002:a63:4706:: with SMTP id u6mr3155263pga.95.1547214543132;
 Fri, 11 Jan 2019 05:49:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546540962.git.andreyknvl@google.com>
 <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
 <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
In-Reply-To: <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 11 Jan 2019 14:48:52 +0100
Message-ID: <CAAeHK+wYo95G3pSoxDWwUs2wf-tBoupwf+0XjO68WXjLzsNWaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
 manual aligning
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_054905_246482_DF9AB5DE 
X-CRM114-Status: GOOD (  23.43  )
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
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
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
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 11:10 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 03/01/2019 18:45, Andrey Konovalov wrote:
> > Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> > in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> >
> > Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/cache.h | 6 ++++++
> >  mm/kasan/common.c              | 2 --
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> > index 13dd42c3ad4e..eb43e09c1980 100644
> > --- a/arch/arm64/include/asm/cache.h
> > +++ b/arch/arm64/include/asm/cache.h
> > @@ -58,6 +58,12 @@
> >   */
> >  #define ARCH_DMA_MINALIGN    (128)
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +#define ARCH_SLAB_MINALIGN   (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > +#else
> > +#define ARCH_SLAB_MINALIGN   __alignof__(unsigned long long)
> > +#endif
> > +
>
> Could you please remove the "#else" case here, because it is redundant (it is
> defined in linux/slab.h as ifndef) and could be misleading in future?

Sure, sent a patch. Thanks!

>
> >  #ifndef __ASSEMBLY__
> >
> >  #include <linux/bitops.h>
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 03d5d1374ca7..44390392d4c9 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >               return;
> >       }
> >
> > -     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> > -
> >       *flags |= SLAB_KASAN;
> >  }
> >
> >
>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/fc93e5a4-fa54-98a1-ea5f-4708568d7857%40arm.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
