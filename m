Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6474C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:57:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE0F20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JN20xg32";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/K+HXPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE0F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YgJkFgAwxCMdbfZ3ajWk7krCIQJtMlLboj5zqN5fHN0=; b=JN20xg32e7VTEV
	3o5ZFRprJmrdwgpX73cHAoYPPM8K68pmKfZjmYAT9rdtt8/+3+hdv+qODCCgkvM2CiK2IQveQ7ERW
	fAS4lL4hrVVfM52pXcC57fcYIaduFFRZLQNQjmQL7QCl4llZxb9jugvXVD9jjSwwHiQChdbG24q/m
	PbZFMPa15TIpitxJaOek9/P6r7H7hb0/Nc0lcNeCBSA8qRap1VT/2y+KSLL8ES06H/Jp28Bh6DzN4
	t+FGMrE679z86z9PG57Y2pPIGsnD+co5erfenS2+R0EC6cV86z5KwRqkYNcSsFViiwA3vEI7pDWmo
	6oaoQLpJT5EMB/l6V7kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmyt-0001TD-RS; Thu, 21 Feb 2019 11:57:35 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmyq-0001So-6e
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:57:33 +0000
Received: by mail-oi1-x243.google.com with SMTP id w66so1166376oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 03:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2D1az9jgyphnq1otWzo3sYVX/jKlPZOEjhmTd+xmzAU=;
 b=E/K+HXPEBm4GIr1eP2DTlgxLDm69AVn4UClVNFXE7CxFtzL+baoCF3PqT1kGAJ85+G
 XAcxrqU+ykRh6XXqXb8y9mP4rBuC92YLQlayRG5rpPwLngZdt0qy7g5pmuGSeb9MbT1e
 TZGPZdhYtU4WoczZkgEpCQlTrMHThdY0N2ZVzbEbyUn19t8mqnoAO1alN/OtFvD+erTS
 AWOIwmggjdoVRhZSFWCRqYJ3WA0wILAly1WMQDZvH/KgmycCHlJD6ug2hB8Epj6FPgyv
 382Brc0D2NsITeImqBd7KYnJ7jU7wynwbklcyEtnM+NyrbYEKfrjqm/pOOySibVfg+Vj
 yoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2D1az9jgyphnq1otWzo3sYVX/jKlPZOEjhmTd+xmzAU=;
 b=XWSL/6HbolLzHCm8YPkrVl90KqBk64ZmY4fZReH7rPgBs9FTlQW6VuwnF1wo2MmlZx
 Ad50ULOpUoxBCQUd7kurlC3qwOfaat8qBue/uJoLIAzLCZbZM105IBvW5nEKtbnlrReq
 t0WDPW7TpeVC/ekzVQgH91+kbdXnMCsZAWDbjLDV2JYsdwhJWMEU3Y6T1cnEY0Yo05zb
 Z7ayKuvgVjFVn8GnxHDxCwQZB6QYmYewMEnZVRgqdue4k8k9ufS1Cmpy5pSRJibgfcQQ
 5TPwga07LdC+dQT3NCXrqv1UKp37C4lNlIzo5DMjtQSapXBbwWZ2vfbmrThXIuLrkKk2
 nVqg==
X-Gm-Message-State: AHQUAua0GlYA0iV7feVuTP4zcDOkYhNySaQWoRE5iK7ecXCaX6kWl6AL
 6Zyts0LhZ50uwnLqVVpP6TrtpHPFh6D3k/VbXxrdaw==
X-Google-Smtp-Source: AHgI3IYCyITbh7gh9ibfyIkvl400naFm0ZuO8oZzQW5A4pzF9NNqP3uGA7iBBaOAeoBS+K2vucOkNOuadlbyMpbrvP0=
X-Received: by 2002:aca:ab11:: with SMTP id u17mr9263658oie.98.1550750250859; 
 Thu, 21 Feb 2019 03:57:30 -0800 (PST)
MIME-Version: 1.0
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-2-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1550519559-15915-2-git-send-email-Dave.Martin@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 11:57:19 +0000
Message-ID: <CAFEAcA-mydDP1GN+ODL0eUYqOrxYZgzW5oxnpa2Ss9v0wfk1HA@mail.gmail.com>
Subject: Re: [PATCH v5 01/26] KVM: Documentation: Document arm64 core
 registers in detail
To: Dave Martin <Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_035732_243365_4D88D81E 
X-CRM114-Status: GOOD (  16.93  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 18 Feb 2019 at 19:54, Dave Martin <Dave.Martin@arm.com> wrote:
>
> Since the the sizes of individual members of the core arm64
> registers vary, the list of register encodings that make sense is
> not a simple linear sequence.
>
> To clarify which encodings to use, this patch adds a brief list
> to the documentation.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  Documentation/virtual/kvm/api.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 356156f..097b8ba 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2090,6 +2090,30 @@ contains elements ranging from 32 to 128 bits. The index is a 32bit
>  value in the kvm_regs structure seen as a 32bit array.
>    0x60x0 0000 0010 <index into the kvm_regs struct:16>
>
> +Specifically:
> +    Encoding            Register  Bits  kvm_regs member
> +----------------------------------------------------------------
> +  0x6030 0000 0010 0000 X0          64  regs.regs[0]
> +  0x6030 0000 0010 0002 X1          64  regs.regs[1]
> +    ...
> +  0x6030 0000 0010 003c X30         64  regs.regs[30]
> +  0x6030 0000 0010 003e SP          64  regs.sp
> +  0x6030 0000 0010 0040 PC          64  regs.pc
> +  0x6030 0000 0010 0042 PSTATE      64  regs.pstate
> +  0x6030 0000 0010 0044 SP_EL1      64  sp_el1
> +  0x6030 0000 0010 0046 ELR_EL1     64  elr_el1
> +  0x6030 0000 0010 0048 SPSR_EL1    64  spsr[KVM_SPSR_EL1] (alias SPSR_SVC)
> +  0x6030 0000 0010 004a SPSR_ABT    64  spsr[KVM_SPSR_ABT]
> +  0x6030 0000 0010 004c SPSR_UND    64  spsr[KVM_SPSR_UND]
> +  0x6030 0000 0010 004e SPSR_IRQ    64  spsr[KVM_SPSR_IRQ]
> +  0x6060 0000 0010 0050 SPSR_FIQ    64  spsr[KVM_SPSR_FIQ]
> +  0x6040 0000 0010 0054 V0         128  fp_regs.vregs[0]
> +  0x6040 0000 0010 0058 V1         128  fp_regs.vregs[1]
> +    ...
> +  0x6040 0000 0010 00d0 V31        128  fp_regs.vregs[31]
> +  0x6020 0000 0010 00d4 FPSR        32  fp_regs.fpsr
> +  0x6020 0000 0010 00d5 FPCR        32  fp_regs.fpcr
> +
>  arm64 CCSIDR registers are demultiplexed by CSSELR value:
>    0x6020 0000 0011 00 <csselr:8>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

It is weird that we document these in terms of apparently
arbitrary hex digits in the encoding, but the headers
exposed to userspace define helpful #defines for the various
subfields. So nobody really wants to use these hex
digits and they need to then go hunting in the headers
to confirm that if they use KVM_REG_ARM64 | KVM_REG_SIZE_U32 |
KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.fpsr)
they are getting the officially approved working encoding.
But it is how we're documenting everything else in this
section, so that's a separate issue.

thanks
-- PMM

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
