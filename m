Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:06:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4D0214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h5FYZ10t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTGY9Vaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4D0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UFerR3awpyXRgRS0J3rJd3uGDmhALtM7SyJ4wsmX2IQ=; b=h5FYZ10tKxskkF
	Ys+JAKFP6ji+JhDCFG0g3pwgtuZ/+Kw6oJ26hxfgfTaGzjfWrFUsVOVh0Q7j3b7qVyy6UBCJR0dNG
	RqWcfj5OqAmzchLSUx6DLFYj6Vj0Y6L0Mjv+dlQZOoiZ+i2uwFTpwb/BfQTMtypRLQe6tIQF2LzdU
	f+nLeoAYAm3MYECEDW16L6582xnRdlmzYU8wYYSwEid84V7U3sU1ojUwfVutrFsMvVSecV2ddMJ3h
	aW/RQNKepbWSpbbnq2BmuJmMqNt/uOTWF3Pnrm9zjQY1Jtnm/pCrNicFSt7FYq1YVUeibxyzVhOG6
	fzCx19ylbjlUXcTQb95A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWIS-0003Aa-Tt; Thu, 10 Jan 2019 09:06:40 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWIQ-0003AF-9W
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:06:39 +0000
Received: by mail-pf1-x443.google.com with SMTP id q1so5029457pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oq80hyIRxc7kD/9H1MyYY3fFLvm60ShEsiOlrZc3KYA=;
 b=hTGY9VawGhKjAEPgrRt1SPQT4EG5iuZqoIW1KBax7pl8YNTXG4Vfd9yFbNqVTP6CKq
 Lq9gCQr172eU4c6qB+2ZJoksKKEV0IrNS25SJMIWPuxgIbu6deseS3OSzEsbAJy2YeM+
 nA4gDJwymhlOM0pD950PKH7w1M22eiN5i/ObZwBQeq8LJFMBXiVzhVcTAUMlKc5aXzrp
 9vkvrrM9VLbJcerBTbmQuUZK6eUWVSVly6mIouFlvpkaK7mBPZywI4SN2+PEgTyQNXlk
 0civggBqSPQuln3CUOhsBUZ7jfJwDRjbFCyzKA0fficEthHyKNDX96C2SNbZYYLG6FHc
 VpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oq80hyIRxc7kD/9H1MyYY3fFLvm60ShEsiOlrZc3KYA=;
 b=tiU1WXckYoCpkw0a6CDwjwJR5hzfBpnVD8rnqDXKwI75Rqp9RLT2L0UeU0i5jN2QnS
 Eo376jzwIEFAS7rsUhm9lO3YLPy/iDwb8foo9ZH+eXJlHAGEbafPXdrQal3OgY0v16KC
 9GdSSu50GqLGwlFbzrx+fWCjPQ7lKQpI/7P1bNyVSXGB0eqPd3HSFwzK4v6EV0CHpcD/
 bbCdKY6XdfpqCDoWSYEpSwBXyr6VwugDKmax2ZiC0FNoxeeW7cGROoLLRzrwnntra/b+
 Siijk368RJor25EL4Gq5QrM3rJeo+P3Z4mQjKksOR4OAsJkCezltVhVw6pBRCkPkhas+
 Y+oQ==
X-Gm-Message-State: AJcUukfOQeB3UXbK/oBbWzRfp68/pSQNa2MoAB0hhLmimZvNbf0Wbnoj
 fqzXsZJmYjNiccBKQ8cPbVEAN4CfdyNgkcu+8OE=
X-Google-Smtp-Source: ALg8bN4BE6q8xxDDtq+YuLH5+cixz7d0oBOOvQbl+bRUmSLVR5oY8KTP6B615fpl1R0lgmzzlO6hmmnE0EIbQpvPK5o=
X-Received: by 2002:a63:da14:: with SMTP id c20mr8224322pgh.233.1547111196652; 
 Thu, 10 Jan 2019 01:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-10-Tianyu.Lan@microsoft.com>
 <7eb0cde4-9436-9719-dd13-caf4ab5083a2@redhat.com>
In-Reply-To: <7eb0cde4-9436-9719-dd13-caf4ab5083a2@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Thu, 10 Jan 2019 17:06:25 +0800
Message-ID: <CAOLK0pz6K90+QOMV2Vmhd3vC2t5+15vmUo0E=2rwax7cGDfxjw@mail.gmail.com>
Subject: Re: [PATCH 9/11] KVM/MMU: Flush tlb in the
 kvm_mmu_write_protect_pt_masked()
To: Paolo Bonzini <pbonzini@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_010638_342019_BD6EC931 
X-CRM114-Status: GOOD (  14.67  )
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
 ralf@linux-mips.org, paul.burton@mips.com, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 12:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/01/19 09:54, lantianyu1986@gmail.com wrote:
> >               rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
> >                                         PT_PAGE_TABLE_LEVEL, slot);
> > -             __rmap_write_protect(kvm, rmap_head, false);
> > +             flush |= __rmap_write_protect(kvm, rmap_head, false);
> >
> >               /* clear the first set bit */
> >               mask &= mask - 1;
> >       }
> > +
> > +     if (flush && kvm_available_flush_tlb_with_range()) {
> > +             kvm_flush_remote_tlbs_with_address(kvm,
> > +                             slot->base_gfn + gfn_offset,
> > +                             hweight_long(mask));
>
> Mask is zero here, so this probably won't work.
>
> In addition, I suspect calling the hypercall once for every 64 pages is
> not very efficient.  Passing a flush list into
> kvm_mmu_write_protect_pt_masked, and flushing in
> kvm_arch_mmu_enable_log_dirty_pt_masked, isn't efficient either because
> kvm_arch_mmu_enable_log_dirty_pt_masked is also called once per word.
>
Yes, this is not efficient.

> I don't have any good ideas, except for moving the whole
> kvm_clear_dirty_log_protect loop into architecture-specific code (which
> is not the direction we want---architectures should share more code, not
> less).

kvm_vm_ioctl_clear_dirty_log/get_dirty_log()  is to get/clear dirty log with
memslot as unit. We may just flush tlbs of the affected memslot instead of
entire page table's when range flush is available.

>
> Paolo
>
> > +             flush = false;
> > +     }
> > +
>


--
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
