Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E389C208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EhYHz2nh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrgD7g7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E389C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T0E3Yxmw81EBx5R014y+t0k306DxpsuNZRYYyk9WWM8=; b=EhYHz2nhcuDEWa
	2cqnGTKyeYXtDZWH8sOe9Q+8wbv9UNU9OKshPBYVkW0HujdMasUmM/cilsdeyJYAJWJ+eKcP8Ag1S
	v/VPCfBdWLMAeuurG+MuaNgYRWoB6+l1Cj/iEccleP6D9INyg/FiehS7WC/folds1KHgIfm1tKbzP
	VzZ3/yu78IqD88RzMi67sxAHtJhXUJLLUNJ297wvu0L4qQXl1TF5rxTaugJgrq/BcH0JFCTXXrp79
	FYNA0bbYPvjmOEPiAF53pvU3uYDaYKMlSnntD4vYsH1LeAK8/WtjijPaQESDtVmoX7jWOO4zEeZFs
	wOHK/ca9ozrbaiaDmzxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPHZ-0007iU-4d; Thu, 13 Dec 2018 11:35:57 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPHW-0007hq-1D
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:35:55 +0000
Received: by mail-it1-x143.google.com with SMTP id x19so3181458itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P0b7P212MRl/oZ6/6OYVSWLwFMUJ0ti0OMLLNAr9VX4=;
 b=BrgD7g7rcUlvufNbKR+6W3NRUotf614lqNaBoj6EO9Kd8gru5l1uDn7x4DDtduPG+E
 3r4t0x2u/8neRRf0UNOZ+0LT9TJAN3WeUtFbzcwEDTcLaFa9shMXfoUpS4pwUbi4GUHg
 zEU7JqDrG8kmGLKc/w+iwaLe6QyoorDtc6i7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P0b7P212MRl/oZ6/6OYVSWLwFMUJ0ti0OMLLNAr9VX4=;
 b=egVLZUFUNG8pQQ77cO1F49+nBQcIwddGSFuEwF9imWnGcxgXij80qdJYdoJqfTForV
 B6FKW4kr4foRrOB5M/ZkYFEL0gcmrdZaCzExDi+eeywNU9CUymiPj8LfY6YAJMFugo8L
 HlcCHu/uBF9R6x+XahUC9+HiFQ36ja6YrIJQp67pC+wscJp7cMyiB+NkJrHp96/CZn2C
 BcYpnOdLd09KVhImC+arL72U6JnX7UJdh6jQs9EIycJd/KuAeco6edOqbeD/6kRTWQ4A
 ASMDEKF7ueZMA8qhl8yCd84exa/v69V0Yg0TINgadOONIyqQ9sqibJtA2sJoBHZbIGLe
 RXqw==
X-Gm-Message-State: AA+aEWZD//ltZ1TLt1DpVXGO0FWU6jRixR1t3JLcEDkmL0r0O48QRrc2
 zdedPXO48CRz/9wp0O2VoyhVOjLIGDA1cyljT4M52w==
X-Google-Smtp-Source: AFSGD/XUHqg/ATs/aQBA4WcpoUVlbhRhNl1pKzpcwcaHE2yTC67ygtPVr0A8K9BG+H6Qrrfak+jrKVu+Xy5V/bWcC4o=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr10159468ith.158.1544700939482; 
 Thu, 13 Dec 2018 03:35:39 -0800 (PST)
MIME-Version: 1.0
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
 <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
 <CAKv+Gu8+1JNzM4AUujiEfkYujpgakLXcUwTDG4eHwvQ7pKAzFA@mail.gmail.com>
 <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com>
In-Reply-To: <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 13 Dec 2018 12:35:28 +0100
Message-ID: <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_033554_083384_AFEB722E 
X-CRM114-Status: GOOD (  29.34  )
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
 Daniel Thompson <daniel.thompson@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 oleg@redhat.com, joel@joelfernandes.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 at 09:54, Julien Thierry <julien.thierry@arm.com> wrote:
>
>
>
> On 12/12/2018 18:10, Ard Biesheuvel wrote:
> > On Wed, 12 Dec 2018 at 18:59, Julien Thierry <julien.thierry@arm.com> wrote:
> >>
> >>
> >>
> >> On 12/12/2018 17:27, Ard Biesheuvel wrote:
> >>> On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
> >>>>
> >>>> Instead disabling interrupts by setting the PSR.I bit, use a priority
> >>>> higher than the one used for interrupts to mask them via PMR.
> >>>>
> >>>> When using PMR to disable interrupts, the value of PMR will be used
> >>>> instead of PSR.[DAIF] for the irqflags.
> >>>>
> >>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> >>>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will.deacon@arm.com>
> >>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>>> Cc: Oleg Nesterov <oleg@redhat.com>
> >>>> ---
> >>>>  arch/arm64/include/asm/efi.h      |   5 +-
> >>>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
> >>>>  2 files changed, 99 insertions(+), 29 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> >>>> index 7ed3208..a9d3ebc 100644
> >>>> --- a/arch/arm64/include/asm/efi.h
> >>>> +++ b/arch/arm64/include/asm/efi.h
> >>>> @@ -42,7 +42,10 @@
> >>>>
> >>>>  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
> >>>>
> >>>> -#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> >>>> +#define ARCH_EFI_IRQ_FLAGS_MASK                                                \
> >>>> +       (system_uses_irq_prio_masking() ?                               \
> >>>> +               GIC_PRIO_IRQON :                                        \
> >>>> +               (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT))
> >>>>
> >>>
> >>> This mask is used to determine whether we return from a firmware call
> >>> with a different value for the I flag than we entered it with. So
> >>> instead of changing the mask, we should change the way we record DAIF,
> >>> given that the firmware is still going to poke the I bit if it
> >>> misbehaves, regardless of whether the OS happens to use priorities for
> >>> interrupt masking.
> >>>
> >>
> >> Thanks for pointing that out, so this change makes little sense...
> >>
> >> The annoying part is that the flag checking takes place in the arch
> >> agnostic code.
> >>
> >> Would introducing some overriddable efi_get_flags() or efi_save_flags()
> >> that default to local_save_flags() seem like an acceptable solution?
> >>
> >> This way I could override it for arm64 and still return the DAIF bits.
> >>
> >
> > I don't follow the reasoning below about irqflags exactly, but is
> > there any way we could simply but both PMR and DAIF in flags? We could
> > even update the mask here to ensure that the firmware doesn't corrupt
> > the PMR.
> >
>
> So, that was the case in my previous versions of the series, and as you
> said, that covered checking both DAIF bits and PMR on return from EFI
> services. But Catalin suggested that irqflags could just use PMR when we
> enable the priority masking feature. Catalin's suggestion does simplify
> things, except for this part.
>
> However, it doesn't seem to far-fetched to me that the architecture
> could have a more generic way to tell the EFI driver "this is the set of
> stuff that I care about and you should return from runtime services with
> this stuff in the same state as before" without the "set of stuff" being
> limited to irqflags.
>
> But maybe this would be over-engineering just to deal with my use-case...
>

No, that makes sense. As you said, you can just create a
efi_get_irqflags() helper that defaults to what we are using now, and
can be overridden to just return DAIF in our case.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
