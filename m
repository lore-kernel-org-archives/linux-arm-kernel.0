Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03852C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA60206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PTa1bNJX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Vb6I7xDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA60206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KvkZ4INpLQtsnOGeA8O1FIyvQezyumExG2/9puBiqu0=; b=PTa1bNJX+aK1lG
	FGjnD7C+Np7FvjgfuqlLRUEvTmJFF0+3ZjddOnmRCpzf62qWWEpw0feQR6EiWUO3caEl/HKiDlWt7
	VurkKaM1nieKQLrQyUElOK+zyMlPfaDl8dh4YnMy9rqFcTej52ePdb5nQ1uzjqO8u6kN24M4C0k9X
	8G+UoOVcVFP60vlRDbg1Wq1PmltfkC2UA3HJaiBCVP9uLDn4Ztcbci8bv2HfEYhVWYrGvv77HUna9
	HCNqfVnO5Ax/3vQfuZLv25TwAvscl+nscWEe8TSsFdeGn1ksud568VFzzsoVJzDkPLyAL5NHmiwTD
	GPlLjWjMsGFmSmTcg4Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYyeZ-00040Z-8E; Mon, 17 Dec 2018 19:34:11 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYyeV-0003ys-EP
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 19:34:09 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so6583530pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zqAJ7CpVrClj01fc/bQYKz6q7wMWGbGap3pF5MFiebg=;
 b=Vb6I7xDD+N84CKMrD7JqBKLThyRzVJstMpfI88sWi3C/amzPJqd++0eAjzjxfSGZ5p
 owoD9N9R8WxLP4KxFs670QbqMIUxys3LisKdvQQvPxDlpMliFOTnEFQQcf47kHzDZuIQ
 rERc8yBDh5MrMar07ymNZJvCxhAEKbYgH3GJqYmnBMcWQEg4r3NdJeEHc49AlzPM+U9F
 ln2jrtI/nxmIoBuaTB64cLW7lttBtPNESWQjnywIyeiO1IC0YaJcInXINJK4YTyrUT5k
 SKpUoB+RmGiwHonpgoXMWhSOjdhX8l4A0KPTOygwYVbEbsfq2kXKcJEDj4Ee9iYxXmeP
 x2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zqAJ7CpVrClj01fc/bQYKz6q7wMWGbGap3pF5MFiebg=;
 b=Yh/eDqVqOGlThF7diLFsPBFINHVEH3zhySIcM8PxZ57GEPVEr1DYQRx8APJfu//CLW
 htrmbugngDMYFlwQKQX8YHVclgMBp2eKofSHJeFoWCZDb5X61dZYR+fXArdpOcfmPUHX
 u3L1lyeUFhTeAj6cvTqGhDdEyg092Ppmw/9H3F9yA5KUpdC5FgkWMqlsirS5MiT6p5Dg
 ZLrmkXFcsU9nfTmgI+TsGKvw5KoD+B6wER19eVxZ28i+T81KaOZo+wARvVJ62uz1DRo4
 tiK9sac0iBT67SMFMbA5bHzYu1YEoMwEG8JsuNaNzD6NrDplBYfzdqxfpOZwdnsJyKZn
 oF9w==
X-Gm-Message-State: AA+aEWaO3G1AxZ9xBk3PbxZ5EoOSCRtnml72jQmP/toGhmc6WQUaLnba
 pYEuqw/GlK346hptZf9+v8A2sUtcXioS3cc33V6pzQ==
X-Google-Smtp-Source: AFSGD/Xd0N9kSPdtbqHt/fg4ep3w/r7nr4OCd0w90Ake1b8L6P3PKf9tZwx1pfsuvpi4AzjAyra5gqpyLz3prTpDllI=
X-Received: by 2002:a63:7044:: with SMTP id a4mr12916378pgn.359.1545075233957; 
 Mon, 17 Dec 2018 11:33:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com>
 <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
 <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
 <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
In-Reply-To: <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 17 Dec 2018 20:33:42 +0100
Message-ID: <CAAeHK+w2jppKbb26bBk6uP9ydZeHrtNc6b2CVv4xbvt6ecVooA@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based
 mode
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_113407_486956_1D87011E 
X-CRM114-Status: GOOD (  31.33  )
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
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 1:34 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 12/12/18 3:04 PM, Andrey Konovalov wrote:
> > On Tue, Dec 11, 2018 at 5:22 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> Hi Andrey,
> >>
> >> On 06/12/2018 12:24, Andrey Konovalov wrote:
> >>> This commit adds tag-based KASAN specific hooks implementation and
> >>> adjusts common generic and tag-based KASAN ones.
> >>>
> >>> 1. When a new slab cache is created, tag-based KASAN rounds up the size of
> >>>    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
> >>>
> >>> 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
> >>>    memory, that corresponds to this object to this tag, and embeds this
> >>>    tag value into the top byte of the returned pointer.
> >>>
> >>> 3. On each kfree tag-based KASAN poisons the shadow memory with a random
> >>>    tag to allow detection of use-after-free bugs.
> >>>
> >>> The rest of the logic of the hook implementation is very much similar to
> >>> the one provided by generic KASAN. Tag-based KASAN saves allocation and
> >>> free stack metadata to the slab object the same way generic KASAN does.
> >>>
> >>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> >>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >>> ---
> >>>  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
> >>>  mm/kasan/kasan.h  |   8 ++++
> >>>  mm/kasan/tags.c   |  48 +++++++++++++++++++
> >>>  3 files changed, 153 insertions(+), 19 deletions(-)
> >>>
> >>
> >>
> >> [...]
> >>
> >>> @@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >>>               return;
> >>>       }
> >>>
> >>> +     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> >>> +
> >>
> >> Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?
> >
> > I didn't know about this macro. Looks like we can use it to do the
> > same thing. Do you think it's a better solution to redefine
> > ARCH_SLAB_MINALIGN to KASAN_SHADOW_SCALE_SIZE for arm64 when tag-based
> > KASAN is enabled instead of adjusting cache->align in
> > kasan_cache_create?
> >
>
> Yes, I think it is better because in this way we do not need to add extra code
> to do the rounding.
>
> Curiosity, did you try your patches with SLUB red zoning enabled?
> Since the area used for the Redzone is just after the payload, aligning the
> object_size independently from the allocator could have side effects, at least
> if I understand well how the mechanism works.
>
> Setting ARCH_SLAB_MINALIGN should avoid this as well.
>
> What do you think?

Sounds good to me.

Andrew, how should proceed with this? Send another fixup patch or
resend the whole series?

>
> >>
> >> --
> >> Regards,
> >> Vincenzo
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> >> To post to this group, send email to kasan-dev@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2bf7415e-2724-b3c3-9571-20c8b6d43b92%40arm.com.
> >> For more options, visit https://groups.google.com/d/optout.
>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/b99b331d-22ca-b9db-8677-4896c427ef10%40arm.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
