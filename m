Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06292207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X4GO+tvL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4zcylc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06292207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FkHRmWfwktMV6CV47x+68RGHFKv326oAbOwucQKGIqY=; b=X4GO+tvLQH4swL
	UEJhcxICm7q27QWWXIn7YaocyYpR1FTOoNwQDZape7vhPhLEqAj/tJl5CIxIkJLnHrCckMjDW7kxu
	ulow4xu0knEb0plicoo0gZ58ttkPB2z3oNVs6fm4Batwqv7qFlF/78/EHGxEgYlipTlCWegSHKfhl
	zkYgQ9NJ5Jf6Kl46k13Ab2q3FSyB8CPsYBhAtO7Tjf8fLwCF0fguwyFXEoXMB13yfAPkbwOn/ldmL
	RuaFKvm9MOGQtIU3NDdvZaTiobBosSBL5sOr3sutN84LdCCAYwzzX89A6XSG44IDLDhr0FW8RlMfs
	xz/IsYSqoCDWvYWxjxZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guf3e-0006lr-QB; Fri, 15 Feb 2019 15:05:42 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guf3Z-0006kO-PG
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:05:40 +0000
Received: by mail-pg1-x542.google.com with SMTP id h11so2573847pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pdlq/dEtI363+RqrBnNPZ7uHe1H/unQpX6+JLG3TUso=;
 b=l4zcylc3JZXCQ5dgtx8+3QDOppft9OqAq2m82EUh2nCHYAFX7hShjjFF8JFVHzGJMU
 hDiNoQiA83mgT5zit13fJerL3eNlO8QK0+YJdgH1hgxjc4nMTuTYtTxbkMP44HSfzyC1
 o9oEY99aJsWTakOSwV2WB8m5VTbJRd5qH22G3VA9WavtTAjRArJ/9Bm3YlEG7iolxA9I
 SCYMG3G+yQ9hchXv9kQOT+DKP1hON8ZP35cDUJXFTVYYragi/KhQ1rkV60PemXeFaYjA
 cmLNbLuwyNbKX2Xgppa4lWNGt3Ckvd2kHMHjWbo3JmLRMOiJC4w3YlEJhYzJnj+58FjL
 v1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pdlq/dEtI363+RqrBnNPZ7uHe1H/unQpX6+JLG3TUso=;
 b=a1aE3N0ByfX6xyuuxa0iJc0mIQF24PO4xeqoxJhZY6gJVKWAhL+bTLviw7S22MHQ/f
 Ppq/6o4gEifbbejR/m0QS/bFhsjEQhySMK5970aa4+rBVpcZPK7YoU1r4UuBCh8KIphE
 DVHJy9uDzazbkysqfJt83nS3oWJ+4RRsMX2IT7Ig7nrZBM6KQnQrkEDRGE8QNGmQYgC7
 HJxQF4RbqqeOlR06t16DJOFGer04h52B5GB3ifSN8Zz2R8nByomb3jAHe9Fl8PN/4zLu
 m5IafLzoRLkAwMmyA+9CGDTeNKG1XRRAQF4xxK4Gajzs8DSGaJeuPa9rwCWQ2i2wv/Dy
 jxYA==
X-Gm-Message-State: AHQUAuZ7fJ8tZ9q2WXC8pQ+qDHHfIRK1/GlYToz1pfNqXjxJ2x96jECy
 M6XESUIxV1QHwo4+FdSYXQjl73pxwOWGBCJI+do=
X-Google-Smtp-Source: AHgI3IZGOB0YXIwlivSAxLHT4URYYb3+UhrAB9EIaQZQ4W7zt8lv9iT8EbVfih6aM7/Q0WiZpsDnUp+4G9hZ8+OTfjo=
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr5915867pgc.25.1550243132454; 
 Fri, 15 Feb 2019 07:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
 <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
 <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
In-Reply-To: <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Fri, 15 Feb 2019 23:05:21 +0800
Message-ID: <CAOLK0pzXnvk=FsfjH07jUyRJGpeiNG7-9vR9Vo0mLJtdPnt_7Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct
 mmu_spte_page
To: Paolo Bonzini <pbonzini@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_070539_203673_056838E0 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 paulus@ozlabs.org, "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au,
 the arch/x86 maintainers <x86@kernel.org>, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
 benh@kernel.crashing.org, jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 12:32 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/02/19 02:38, lantianyu1986@gmail.com wrote:
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index ce770b446238..70cafd3f95ab 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -2918,6 +2918,9 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> >
> >       if (level > PT_PAGE_TABLE_LEVEL)
> >               spte |= PT_PAGE_SIZE_MASK;
> > +
> > +     sp->last_level = is_last_spte(spte, level);
>
> Wait, I wasn't thinking straight.  If a struct kvm_mmu_page exists, it
> is never the last level.  Page table entries for the last level do not
> have a struct kvm_mmu_page.
>
> Therefore you don't need the flag after all.  I suspect your
> calculations in patch 2 are off by one, and you actually need
>
>         hlist_for_each_entry(sp, range->flush_list, flush_link) {
>                 int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
>                 ...
>         }
>
> For example, if sp->role.level is 1 then the struct kvm_mmu_page is for
> a page containing PTEs and covers an area of 2 MiB.

Yes, you are right. Thanks to point out and will fix. The last_level
flag is to avoid adding middle page node(e.g, PGD, PMD)
into flush list. The address range will be duplicated if adding both
leaf, node and middle node into flush list.

>
> Thanks,
>
> Paolo
>
> >       if (tdp_enabled)
> >               spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
> >                       kvm_is_mmio_pfn(pfn));
>


-- 
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
