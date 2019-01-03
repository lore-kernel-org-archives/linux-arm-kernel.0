Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDD8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:02:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C8821479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NEm/VSX9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lzA/4xS/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GoUxsewU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C8821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0lQWtuj2VAfvhHMd9A8dnYsZgNXROSmeETz8qXhdgbk=; b=NEm/VSX9fST74l
	z4OcZZZm2qVIBguo4RdqSUfPSNYcQnRIn2qiT2niq9val4a2KeGQDL/iwqMQMd29XVI866Xy8Yd7/
	tzMI+ok3fDuDAlnVHbsbmU6I1dtbtyN9aGtxLXuy1MGcS9LOeQqh9nOQDOZzHFYcFQPVVQB/egL/T
	WYjdDWjCaVFGrP4lOKFRLC9TOAl0si12VyVewU+IcHI0+oLixL5widYKc/yQuVimQvdDf6KpKp8Aq
	TvduL7xIJ2x3edxw6DGd9EmEwVvgR5t4Gbbwxn3y32CBExBIGCxS57WXdIIZUwJngKxKCz0O/4fjZ
	I8i6ZqhQuLQ46XqBd4+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8Fr-0004ui-5U; Thu, 03 Jan 2019 19:02:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8Fp-0004pG-GJ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 03 Jan 2019 19:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MgzV5dTndps76ADDi/niLj9jnEoksetg/kN5EQSE/zM=; b=lzA/4xS/A41+40ZcxOTBGD2Bm
 N3ApUDLgAQpE5sUlX9H34tJGqAS7AAHxgNjyx5/w8oVTXVQ0gbBqGFkkx9JflQB/qLD7v55TwaYHr
 81nJCRcGhcmvXgl4lOYwN1Jam11UR5R2IKCL5D7cS/Avb3X2HuvoMVKsQE+F6T8eVoAcYeHdTzj1M
 RUQZEZNyFGrq/Nahx6zouYLgGx74plMzsGyfQGyUiLOjF8OdAsvcnraCohNfR/4r4D9aQ2S3tWIKQ
 pa5KFdWIYBQ3V5gVIm+o0dk6oWyRoMfe6gGQRBK4XM4RBJjXfy3755wt3rU01Q2T3m6UuU2sWRR8h
 sx29YWCow==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf80n-0006io-Oq
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:46:35 +0000
Received: by mail-pf1-x444.google.com with SMTP id b85so17076063pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MgzV5dTndps76ADDi/niLj9jnEoksetg/kN5EQSE/zM=;
 b=GoUxsewUnTYsCM77AWfGlQfTgMINGlA35HpX38hrx1dskXw4mI65zWLT8zB5BYj6e8
 dWsAYaoSKabJNGNo9wQ7kiRDOy+0ey1nWiWJLIWcYQN0z+K9h3DYz2J59oKlX+nzSTTa
 aT57NflI4m5PdSfbXZIhK5emMEoGtqL0F3zjVt4kHv7srAa90A8KpUyo/X4pRSfnHe45
 mAT04CkeOtEEc/W2zJ2MdjjmkeoXPYwO94z4+bpJzerWLi7x1dNRRviz0FSvXA89Biog
 sYyO53jbmfC2HT0on1mg+NJMYZHuZQNJAPTRUv2ZWXjRpBcxKkAu8FFYEp88Z0s/Fqyd
 5EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MgzV5dTndps76ADDi/niLj9jnEoksetg/kN5EQSE/zM=;
 b=T9nfQgdlHXmB4/Z5rDQZ0Pi26RBvwszH/MK7kRtFuCAd4iL7TsvYA5O14SOEDvvWjL
 nqd0G/V/eW97E4XcP/Z90d38dIq0FjGIGfoiZilnrckXBGB54p+Hg1N7tPSa3ij9rLZ9
 Q09R5GdYMXIKq38gY4GMzf02QFHTx/xjayY4w2x5MswVihSLkaJ93Nr166csobn0eqSj
 oGR4NHkA8xIX3fm5RM1Uxc0QcrVD9XvxctfPyH5xd+x5n+W8Ex3RXRtchRm3+COivhx3
 exzkJ12oKxOaom56kpJ01cg7gq7Iap5GqnK1m3JerCF6LEjaKyM3lV5AuNYy3EpfuxVZ
 9QhQ==
X-Gm-Message-State: AJcUukdldaMUfHNcjNE/giG5uY5gnTjvxFyh1n/mpFVaSAftiuOY+zFD
 btFTX7bmMIO9XFLbj6GwsqIOWPhJtaOlxd/HvLndQg==
X-Google-Smtp-Source: ALg8bN5SinAEs0gYR2nS6mwrBbNs6CaZLdp3j4CHwOgZ9jildDr4wOzb2uxGWuD9JrGMv17tlykPD+ZozUjLDh+fs1c=
X-Received: by 2002:a65:560e:: with SMTP id l14mr18036989pgs.168.1546541191326; 
 Thu, 03 Jan 2019 10:46:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546450432.git.andreyknvl@google.com>
 <b16c90197bb2c06c780e6e981c40345e03fda465.1546450432.git.andreyknvl@google.com>
 <20190102121436.5c2b72d1b0ec49affadc9692@linux-foundation.org>
In-Reply-To: <20190102121436.5c2b72d1b0ec49affadc9692@linux-foundation.org>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 3 Jan 2019 19:46:20 +0100
Message-ID: <CAAeHK+yE38g0dSbL7LiVPSgECgdcJ5w7+kwaiBaRYr5YkHtbjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
 manual aligning
To: Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_184633_820716_0F13B7C7 
X-CRM114-Status: GOOD (  27.90  )
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

On Wed, Jan 2, 2019 at 9:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  2 Jan 2019 18:36:06 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
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
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 11b45f7ae405..d87f913ab4e8 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/overflow.h>
> >  #include <linux/types.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/kasan.h>
> >
>
> This still seems unadvisable.  Like other architectures, arm defines
> ARCH_SLAB_MINALIGN in arch/arm/include/asm/cache.h.
> arch/arm/include/asm64/cache.h doesn't define ARCH_SLAB_MINALIGN
> afaict.
>
> If arch/arm/include/asm64/cache.h later gets a definition of
> ARCH_SLAB_MINALIGN then we again face the risk that different .c files
> will see different values of ARCH_SLAB_MINALIGN depending on which
> headers they include.
>
> So what to say about this?  The architecture's ARCH_SLAB_MINALIGN
> should be defined in the architecture's cache.h, end of story.  Not in
> slab.h, not in kasan.h.

Done in v3, thanks!

>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190102121436.5c2b72d1b0ec49affadc9692%40linux-foundation.org.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
