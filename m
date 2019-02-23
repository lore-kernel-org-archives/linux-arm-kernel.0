Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5520C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:38:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9696320684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q9JWZCr4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldeiozMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9696320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P4EY7n3rToaUhrtzTg1vWENLJ6jisjzR8vR/tgBAKOw=; b=q9JWZCr4EWOPp8
	jyc3hoqRxN+KKonbJMTe9KAwL4YoxatdArWmG9lCUarKePyE6GX/r9k6nKKc+5dSyreS9e0j7OZkC
	lc31ONX5ALbjPlv+4/Jny7LY/Vpda4ySn6RnBrEWhdHPl3NMZnirh4tXifFH2JXKEkCdBSf8jDkN1
	I3bzapOAukdcjasknuexBKkC2uXQmLZCRr0uN6Pz+ocd9SUk4WPhKvKdzd9SrDJ1GJuYJrce5Csut
	uMVjxGw9QNK0Wa7fELB00Xm4Ja2KGsw4hg5F3lbpB/sLHlE/1Z05bMUoeAQA5+Hc9sDYe5ptaZVyQ
	FJtqkMfl/qWyUQrV/W5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxYRQ-0000qI-PH; Sat, 23 Feb 2019 14:38:12 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxYRM-0000pY-Kh
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 14:38:10 +0000
Received: by mail-pg1-x541.google.com with SMTP id b2so2432638pgl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n6FUQSYQvUFEycWA5KwWZpSsaRLlBroz3IlvJU3oqWw=;
 b=ldeiozMw5Dv/aPnge0ahHdfu2zXrCzwVQvoCUE3DUbUL27J8OQE7AnMnb4KA1yK5Pe
 dVVz2+VfONQ/jeM6oh4j7Iv/KX9hbAtoVVGIbeQjwi0CgsICN+4xrfB5Je/4obJQZR8e
 eOfvaAmYUU2mrcRIKNg0rST8n5SowV1JDN5doew4JXUNNQ1/2f/8M9EmglhSoxfJC6xb
 0rdulcsTRW+bQ7+I8JwakOLxSY3WHCBxEFxIB2AjWYHrMfFaOIwhwr9tcM3tTxa/Nlre
 IdpjtNJ2Jl+34UAz3CZeBJxdEzUywBml6WZF3X+fr7TJrQMYqmxUOqAEK3umJLWC220C
 XeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n6FUQSYQvUFEycWA5KwWZpSsaRLlBroz3IlvJU3oqWw=;
 b=ulJ6pmdOx+33ZiL3vhXTFDje49ykShQ8shlZEboDe67YsRa6SzdRHekwaF1G2FRFsg
 myiCsf/axWqN3BABuXcfHvH/fcck3UfCeRicToFfE28j9CYXxo8sVJe/PV/wiJx0fgLW
 ugjQ2GdGfI3Cs/iqupYg4UBiRvevfTloGX1AqYyGCXZ+1ypy0XcnmbxQt2+ZDkByKo98
 4x5WPwo6E3mAftc5xMusBMtDY1ClO2kVkzFywnJvTItC/r5Mt92f6G1m5cXlSw297act
 rO/gDrcG0eL75zD5yGb6lN8kamSHHzSEGYZKu9A3I/gpldB18/bKZacfJWcJB/95kHu3
 7CrQ==
X-Gm-Message-State: AHQUAuZD/yNfWTa5OoFmmKfOzWanWjqjd6M6n3Qt5ZG434qxWa4NpZf5
 VtDRE9278DJYJ4wEOZ5Ryj1SiwM5jev8lq59M5Y=
X-Google-Smtp-Source: AHgI3IaTEs9wR2DkVIfSbPR8akoMBe5TzeNXZfOrzZslm6+igFUCmJYaI9AtkqFeHn9T6UXb3i7TENBXyvdFEYmCsJo=
X-Received: by 2002:a62:b502:: with SMTP id y2mr1993591pfe.212.1550932684655; 
 Sat, 23 Feb 2019 06:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
 <75e9238a-f168-b90d-e1f1-89938e6df57a@redhat.com>
In-Reply-To: <75e9238a-f168-b90d-e1f1-89938e6df57a@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Sat, 23 Feb 2019 22:37:53 +0800
Message-ID: <CAOLK0pzvtO6Aj0T7uKwOHdNcsnM_Fq_wPL1VUTwF347fYA5Vdw@mail.gmail.com>
Subject: Re: [PATCH V3 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM
To: Paolo Bonzini <pbonzini@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_063808_678721_DDA7F474 
X-CRM114-Status: GOOD (  10.96  )
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
 benh@kernel.crashing.org, will.deacon@arm.com, christoffer.dall@arm.com,
 paulus@ozlabs.org, "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, Sasha Levin <sashal@kernel.org>,
 sthemmin@microsoft.com, mpe@ellerman.id.au,
 the arch/x86 maintainers <x86@kernel.org>, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
 catalin.marinas@arm.com, jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com, devel@linuxdriverproject.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 2:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 22/02/19 16:06, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patchset is to introduce hv ept tlb range list flush function
> > support in the KVM MMU component. Flushing ept tlbs of several address
> > range can be done via single hypercall and new list flush function is
> > used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
> > also adds more hv ept tlb range flush support in more KVM MMU function.
> >
> > This patchset is based on the fix patch "x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT".
> > (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1939455.html)
>
> Note that this won't make it in 5.1 unless Linus releases an -rc8.
> Otherwise, I'll get to it next week.
Hi Paolo:
      Sure. Thanks for your review.

-- 
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
