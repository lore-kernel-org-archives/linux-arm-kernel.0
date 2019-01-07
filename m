Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:14:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A000A2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="simiJTMq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjNCFmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A000A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uCttGHctLkjueboXsfrW//LmQ/D16JxkREmAT1n6XPM=; b=simiJTMqUA3kbh
	qPyNfd0ottiyAqBaG66KQVTFlytAqwiW1KRhqo28oHwULPkIm8Xxgt6Iuunv0z9eCZgORiieeQyHc
	BIuy81UQ9VMVuZKlEwh4UPWc7xXs1GxFguerPPEH/M5kwT9Hok1Ah7KdQHdIiDZSAvtAI2pwYn5AN
	PtFBsCzOVaWVpqHrdEZlABV8Tj1a9kwAP590XTc4TnoPwCBqzbwhx2EuDlCfwLPbkbF4w/89BVt52
	EgleAQuwPJmym2wMQIt9M6SHmEL4QnfSBpu2IdWQ+JyTx8xM4GO/bdUadukthkNysfdrhPGRMRHSN
	BNbib443dvn79vYr4qiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggNEt-0007Vd-IW; Mon, 07 Jan 2019 05:14:15 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggNEp-0007VD-Kd
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 05:14:13 +0000
Received: by mail-pg1-x542.google.com with SMTP id d72so20187593pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 21:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jkcm1HTbMQBDwve8/v16eQj6g2NpqtytScttFvde1sI=;
 b=TDjNCFmoJrm+GqQkTwUJs2zJ9JR4ndHopbHKyvuC3qFVRSV8H9d+pteoP53xeDgVJ/
 BVDSUiAmcgwcS4PiJmoJTK8R8C/E/d+OefgCTl88z0jEXs9ltiHJJqGN5Du15ClEX9vp
 qniTw3SKWriemK3Rddiv8yfbFJI8SvUZBezNiE08BtP6ikrGN+gzn0Ui3YF59Q7xIA2H
 eif0b60ulE18GWwu9mUPlliP4IRdxhzpqSjvPkHg62BzYeXG+7K5z+VoW9fHB4QMgy6U
 /a4qTeYgWZpk6WRCyKEmzlOTVqpf0ZlfS4KjQpV0SiOrUDaDWzrI0lXMzk6o5sZ7p6uI
 s/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jkcm1HTbMQBDwve8/v16eQj6g2NpqtytScttFvde1sI=;
 b=PKVPgYOS/rITFrr73HEzGnO8VFO+3JnbXxLfhdbO3YyGLqK5bd7yv25GLtDLDMWdVP
 8sn3BBFBmrdaOGBTbcC5zvrMa61UI5FTmaff+eA2eR2W7JJ+f4rdutDcrlXP7WE+P1eh
 dUwuYt1iVYYtdpqD3lbXh56w5ovJLxG/JUKCijTTZ3pezz4pmQXp8GpcOXZlAXJWIFC8
 2w+mqGGonBzHtgOrErHfu6rpeAQOkTD46zjFk7c7END1NMjoFryiPEHhDJqHTGIDRqiB
 NftVOgIZZ0o9L3EvDuf9Gz+vOG+462rms0ypDKIoRes27EonC0hKh7RfBNNDBIIyEWrE
 9A2A==
X-Gm-Message-State: AJcUukcadrOWfuhL7Kwnd0mIuGVdXYIxSdHnshCCDkuM2qmclFDYFLTq
 8FofemNHONqgLeVOWaotacmTYuhK7pS9r+RRRJs=
X-Google-Smtp-Source: ALg8bN6ETe1B9Q5up9Hz9+4Q4Khc8bwT2716MN0eJrPgrbPk5aEqN1u7xxt9RAxMs1TCeO7x9mqiJ4rAUgtKjunlSgk=
X-Received: by 2002:a63:da14:: with SMTP id c20mr9334574pgh.233.1546838050378; 
 Sun, 06 Jan 2019 21:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
 <20190104163035.GC11288@linux.intel.com>
In-Reply-To: <20190104163035.GC11288@linux.intel.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Mon, 7 Jan 2019 13:13:59 +0800
Message-ID: <CAOLK0pyMbKuxA0KnsRz_92jr5j15YXb2yUP0GH-xE06BqO_zTA@mail.gmail.com>
Subject: Re: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_211411_704549_E877807C 
X-CRM114-Status: GOOD (  21.23  )
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
 ralf@linux-mips.org, paul.burton@mips.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 5, 2019 at 12:30 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Jan 04, 2019 at 04:54:00PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patch is to flush tlb via flush list function.
>
> More explanation of why this is beneficial would be nice.  Without the
> context of the overall series it's not immediately obvious what
> kvm_flush_remote_tlbs_with_list() does without a bit of digging.
>
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> > index 833e8855bbc9..866ccdea762e 100644
> > --- a/arch/x86/kvm/paging_tmpl.h
> > +++ b/arch/x86/kvm/paging_tmpl.h
> > @@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >       bool host_writable;
> >       gpa_t first_pte_gpa;
> >       int set_spte_ret = 0;
> > +     LIST_HEAD(flush_list);
> >
> >       /* direct kvm_mmu_page can not be unsync. */
> >       BUG_ON(sp->role.direct);
> > @@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >       first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
> >
> >       for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
> > +             int tmp_spte_ret = 0;
> >               unsigned pte_access;
> >               pt_element_t gpte;
> >               gpa_t pte_gpa;
> > @@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >
> >               host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
> >
> > -             set_spte_ret |= set_spte(vcpu, &sp->spt[i],
> > +             tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
> >                                        pte_access, PT_PAGE_TABLE_LEVEL,
> >                                        gfn, spte_to_pfn(sp->spt[i]),
> >                                        true, false, host_writable);
> > +
> > +             if (kvm_available_flush_tlb_with_range()
> > +                 && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
> > +                     struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
> > +                                     & PT64_BASE_ADDR_MASK);
> > +                     list_add(&leaf_sp->flush_link, &flush_list);
> > +             }
> > +
> > +             set_spte_ret |= tmp_spte_ret;
> > +
> >       }
> >
> >       if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
> > -             kvm_flush_remote_tlbs(vcpu->kvm);
> > +             kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
>
> This is a bit confusing and potentially fragile.  It's not obvious that
> kvm_flush_remote_tlbs_with_list() is guaranteed to call
> kvm_flush_remote_tlbs() when kvm_available_flush_tlb_with_range() is
> false, and you're relying on the kvm_flush_remote_tlbs_with_list() call
> chain to never optimize away the empty list case.  Rechecking
> kvm_available_flush_tlb_with_range() isn't expensive.

That makes sense. Will update. Thanks.

>
> >
> >       return nr_present;
> >  }
> > --
> > 2.14.4
> >



-- 
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
