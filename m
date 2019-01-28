Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB0C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2ED20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HZowACr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2ED20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tpHUdx1xhEM3jVVjx9HDOoqfO6Pa/PGp/VwiZo3sfjU=; b=HZowACr0T5EXU1
	fDTjySVgRdgiSZqcQ3u/oM49RRNNMhkkXPP4IxNILcWtskiRPYju/6ifdUd0TB0zPopG96bSb2YoA
	nhqAI8Sl9ppe300loyG2x2StNZiQatyXG5txrUUcc7+hBtQQHMmYICDujwF0qawpiStDKk4jZeXTE
	xe+pYXLLqojaCKirmUXp7uRWbNufX7+n1amAeuHFP4YvvvnRR0bGGk81lNjXVnYLgUzhYjDKr++0Z
	bWS9D+zSwHkzHInPt0nuxN5Pq0wpWytql0tHhCvVuGK8J03fUCY8PDztCyjlK8wmcQ5c/+Gi+iSFh
	AEgDvsZV0Y57MRLDGpuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0wn-0006GX-4Z; Mon, 28 Jan 2019 07:03:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0wj-0006GD-Bu
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 07:03:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB9BD15AD
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 23:03:04 -0800 (PST)
Received: from mail-it1-f179.google.com (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A987D3F906
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 23:03:04 -0800 (PST)
Received: by mail-it1-f179.google.com with SMTP id z20so17856647itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 23:03:04 -0800 (PST)
X-Gm-Message-State: AJcUukc+SLpfW7PFs1BE+ecG7/mT1P8U1BWOoy2yHmaGX99d1zulkd89
 y3qwAflD3E2s1z4n9sGE0zKNwjMSjX5FTTyXt2Q=
X-Google-Smtp-Source: ALg8bN664xwq7reDknsxdCeBBZ8+zo98DEtoj4rF+RVtlyPWTYKQ61nL7fdEC6zgdhIHg6nqVSBJQRmi2PnVERQg/7g=
X-Received: by 2002:a24:7c58:: with SMTP id a85mr9778119itd.9.1548658983837;
 Sun, 27 Jan 2019 23:03:03 -0800 (PST)
MIME-Version: 1.0
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-5-git-send-email-amit.kachhap@arm.com>
 <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
In-Reply-To: <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Date: Mon, 28 Jan 2019 12:32:52 +0530
X-Gmail-Original-Message-ID: <CADGdYn7kcBXO3YbB+QEfS-Aw4O-G-ssQaapRoXCoG6gD08JjAw@mail.gmail.com>
Message-ID: <CADGdYn7kcBXO3YbB+QEfS-Aw4O-G-ssQaapRoXCoG6gD08JjAw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64/kvm: enable pointer authentication
 cpufeature conditionally
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_230305_407016_B4ECC821 
X-CRM114-Status: GOOD (  20.17  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,
On Fri, Jan 4, 2019 at 11:32 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Amit,
>
> On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> > According to userspace settings, pointer authentication cpufeature
> > is enabled/disabled from guests.
>
> This reads like the guest is changing something in the host. Isn't this hiding
> the id-register values from the guest?
I dropped this patch altogether in V5 series and now only key
registers are masked
if userspace disables it.

Thanks,
Amit Daniel
>
>
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 6af6c7d..ce6144a 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1066,6 +1066,15 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> >                       kvm_debug("SVE unsupported for guests, suppressing\n");
> >
> >               val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> > +     } else if (id == SYS_ID_AA64ISAR1_EL1) {
> > +             const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> > +                                      (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> > +                                      (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> > +                                      (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> > +             if (!kvm_arm_vcpu_ptrauth_allowed(vcpu)) {
> > +                     kvm_debug("ptrauth unsupported for guests, suppressing\n");
> > +                     val &= ~ptrauth_mask;
> > +             }
>
> I think this hunk should have been in the previous patch as otherwise its a
> bisection oddity.
>
> Could you merge this hunk with the previous patch, and move the mechanical bits
> that pass vcpu around to a prior preparatory patch.
>
> (I'm still unsure if we need to hide this as a user-controlled policy)
>
>
> Thanks,
>
> James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
