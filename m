Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44458C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145492086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQQ8r8sd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nBiB1TTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145492086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wqrfTX0/PIEiDQnqeCYn+wrn+ANq5O+CUT0NDmYrC5M=; b=VQQ8r8sd6riNMh
	7VMtcuW2ZXtyRkMLZQBMZXqD1f6QIZJ8Yg5UQC8Uc49qOiTlWE48jB7eU0Y2DmRs6zJd3RgtioZmq
	hI2w3TTz2udrDExRYUh5YWAeiaaBgMVCBVcsZYWolzTn9ZPTMEQbO9iTN8BenrluVlu5sVfG3o4tf
	q67nv/d8NgTuabkv1xFEhibotBgC98jmQh5P6unNpSnEcIxBppmTh0P/SRIzDm7ZwFU4JFeKz44Sa
	FBoLNViNX2zC8vjDYxN/AE6rnloC7n1FcUuFRggChrwCYyLlLrEnjSTqPyt5h7iGHJ2HfzdDerA/p
	QQ7aJdVDsktiwOOcdR/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX66T-0003C4-S0; Wed, 12 Dec 2018 15:07:13 +0000
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX643-0007yY-Kh
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:05:10 +0000
Received: by mail-it1-x12e.google.com with SMTP id o19so9422582itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PpoxLeEWdCe6ZUeKoHp9WMUaj9WSDS7J7D+6g3Uf7k4=;
 b=nBiB1TTFievXIyFZJ1GjOf7BR/ieJpcwr36DtE6EMtni+BLGACt3LH3GWi+q1azY5H
 6ztQpGuF4Z1Ers5PB54/G1UVBEQOxjPYdD+Xl+0yrtTzxJ9X9qH9yFzuyQZExbq22Jj0
 zyp6z+cPo5Td2P3g9Ie2aItdJm+qdepJejDvr1kM3CA26NsXWCZb2F8nVHV8LrKLDlKx
 18+QNZKNBv95T/cjciFi8SHnxO9lereVW+tRg45xAEC5yC4RuYmybEGf4uRNJ+/ma360
 nNHfTc8eQwM6p/MUReWygmFhEYH5Zvl0u85p3Gtr334RfpAyOPk5u1YJjehrpZC4O5EI
 CvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PpoxLeEWdCe6ZUeKoHp9WMUaj9WSDS7J7D+6g3Uf7k4=;
 b=Lix4wsn1pSIi0fb1O9LpqWPxPyHuyZ5J8p8ahESMy9KB79b/7Wf2/ZL6Q4gxejNP7M
 RA3HP7K4ObAfhVmTu4LaLzMO8+ItLC+wqdTAkXASiBRE2uqSUNtD0+6kEcR+vkYDISDj
 XfCQYu06NKwdKpvBObKddOj9oYpQGuwOOA9mHRdZ6Rj5P6BIudAaA+BXday8bctMTrl/
 oaGadWweInwd0iDjQ58cCRF0P/ojGp1lUti9YxfxdhBCq6+ty221yAfsozorFiqKd7kT
 SdZll7oblE4eSrxTZVgTxbNvkT0K6xRiyTcztCSyXPjx/Lg6kcYMKT5vG63VcEyjXZ5C
 QPMw==
X-Gm-Message-State: AA+aEWYYg1/ynBNIgs8A6xNWKq+JD8/oN1XiBnX9UwXiOXuPr2dgQqan
 poQ0pxWb1fUnyeahJaaMNEsWHvWYtRBUbssNVempBQ==
X-Google-Smtp-Source: AFSGD/VRxxoyIT9Ze9skeIakHn7TDDpkVWcZCqMd8qAXsBEINZB5VGKJRFzWOZ5YA/BSKpSsG8Dbk0jI8ykdYQy6fg8=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr19921762jak.10.1544627071413; 
 Wed, 12 Dec 2018 07:04:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com>
 <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
In-Reply-To: <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 12 Dec 2018 16:04:20 +0100
Message-ID: <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based
 mode
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070443_861374_1ABDCCF5 
X-CRM114-Status: GOOD (  27.08  )
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
 Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

On Tue, Dec 11, 2018 at 5:22 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 06/12/2018 12:24, Andrey Konovalov wrote:
> > This commit adds tag-based KASAN specific hooks implementation and
> > adjusts common generic and tag-based KASAN ones.
> >
> > 1. When a new slab cache is created, tag-based KASAN rounds up the size of
> >    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
> >
> > 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
> >    memory, that corresponds to this object to this tag, and embeds this
> >    tag value into the top byte of the returned pointer.
> >
> > 3. On each kfree tag-based KASAN poisons the shadow memory with a random
> >    tag to allow detection of use-after-free bugs.
> >
> > The rest of the logic of the hook implementation is very much similar to
> > the one provided by generic KASAN. Tag-based KASAN saves allocation and
> > free stack metadata to the slab object the same way generic KASAN does.
> >
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
> >  mm/kasan/kasan.h  |   8 ++++
> >  mm/kasan/tags.c   |  48 +++++++++++++++++++
> >  3 files changed, 153 insertions(+), 19 deletions(-)
> >
>
>
> [...]
>
> > @@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >               return;
> >       }
> >
> > +     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> > +
>
> Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?

I didn't know about this macro. Looks like we can use it to do the
same thing. Do you think it's a better solution to redefine
ARCH_SLAB_MINALIGN to KASAN_SHADOW_SCALE_SIZE for arm64 when tag-based
KASAN is enabled instead of adjusting cache->align in
kasan_cache_create?

>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2bf7415e-2724-b3c3-9571-20c8b6d43b92%40arm.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
