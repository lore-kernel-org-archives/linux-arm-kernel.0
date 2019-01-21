Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94890C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C1C2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mYfa1TPN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL9I95He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C1C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/GfsPScfwmQ7Tp2MtRLer6umUxVFvJvhlSOPDqvKRqg=; b=mYfa1TPNKJhRuG
	ZRzspfWRmv/LdtsKoEPbaVVllYvSruHQr926kS0C71iIEAb3bGR4FGpzQP5snncU4OPllBHmwT6G5
	jBSonLF/KeGBrVKfwuY0XcGgimgemmnA/lMPsj1oqWySbBhk8LtCWA7/6FMJWWXXBcU/Poq4FFwLF
	AfUhGvtH/+kQdb/jzeJYp3FXGW9Trru4krJ/ws5fF0EGc74GHJyv9SxHXZdKE0HsFQlcp8E8B1MEp
	IdKLR1E2zXC3rxiKNSUb3VjPdfOj5dZef0QMLdahZ+7DrMbasiUILwcaMlaQVdifzy+chT8KwnFbc
	03nWeW4vqyy8svW6q+3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbj9-00075U-DW; Mon, 21 Jan 2019 15:43:07 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbj5-00074t-GH
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:43:04 +0000
Received: by mail-io1-xd42.google.com with SMTP id b23so16706740ios.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yhXNhVthK2ADzkNXHxGjOO9GA4GV19AqWl+e6KsOOhg=;
 b=DL9I95He0QGH9IK22WIEmrQxuPDUp/mjHLqqMMWGYkKVVaQt+Wf2ophnhVWRa5rIJm
 X40hYJUacKmclFtP6/yFmArpNo6kNvqEvz5zVlZcHXBlrfYDHWaFmjF5RS/50tRyaVvk
 PwpdECd8tQHlvIbxp9WMMgbBH8bAMDTLIt1no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yhXNhVthK2ADzkNXHxGjOO9GA4GV19AqWl+e6KsOOhg=;
 b=FhbgV/qvFWkPrWkyjE+bTRLYYoQZ38iJqDgqDZBfIsZzCqDQ3AwjhHge+hjS6wq73A
 xcXGQrZE9dFEfWuSJyYxWF9Z703ecYtKsUiZxP4bVZjjRYXQvfNaKtTN1Nz0tTXnCpib
 l6OCKx7T08aUim6p59ihanSgW3xIuEpgaSSFCk6C54WY1dChBsLhnOGthx0mtspsr0G/
 tzsVkK52mT0h1ZodohXTKVWo7bndYpEvLCvwzRhLK21ckv2JFx8u8+5PR84cuoiv6/rT
 tUVL71qXi8BW3bxGGrCX+CMjvknN1RixRE2OsSGD/gJ9MTfEIKSsSFUdexbZLFpSc7F/
 wUqw==
X-Gm-Message-State: AJcUukeq7IMUGv4Pl9NrXF1Y2dKCVpF/6Mn4affTG834deDN0DR+0Sko
 LxVLZcdlRHaTupas7xtZE6/4eUx2Vg+EKyMmPV1OQg==
X-Google-Smtp-Source: ALg8bN7oA+eNciAo7OAY1Trq/TCQHSPNwLNgcgIMUor0zOlWetbhkxMGl14dJFm5IhZLFq9psBXNHdhDPirSC/jrin8=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr16954755ion.173.1548085379377; 
 Mon, 21 Jan 2019 07:42:59 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-12-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1548084825-8803-12-git-send-email-julien.thierry@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 16:42:48 +0100
Message-ID: <CAKv+Gu8w1cgrqpoL2n2Q=Jbjt_ZruF=oH0-cDyy-LuJUo8YBEA@mail.gmail.com>
Subject: Re: [PATCH v9 11/26] efi: Let architectures decide the flags that
 should be saved/restored
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074303_547980_4B078927 
X-CRM114-Status: GOOD (  17.00  )
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
 linux-efi <linux-efi@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 16:34, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Currently, irqflags are saved before calling runtime services and
> checked for mismatch on return.
>
> Provide a pair of overridable macros to save and restore (if needed) the
> state that need to be preserved on return from a runtime service.
> This allows to check for flags that are not necesarly related to
> irqflags.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/runtime-wrappers.c | 17 +++++++++++++++--
>  include/linux/efi.h                     |  5 +++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 8903b9c..2f4b68b 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -89,11 +89,24 @@
>         efi_rts_work.status;                                            \
>  })
>
> +#ifndef arch_efi_save_flags
> +#define arch_efi_save_flags(state_flags)       local_save_flags(state_flags)
> +#define arch_efi_restore_flags(state_flags)    local_irq_restore(state_flags)
> +#endif
> +
> +inline unsigned long efi_call_virt_save_flags(void)

If you drop the 'inline' here,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> +{
> +       unsigned long flags;
> +
> +       arch_efi_save_flags(flags);
> +       return flags;
> +}
> +
>  void efi_call_virt_check_flags(unsigned long flags, const char *call)
>  {
>         unsigned long cur_flags, mismatch;
>
> -       local_save_flags(cur_flags);
> +       cur_flags = efi_call_virt_save_flags();
>
>         mismatch = flags ^ cur_flags;
>         if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
> @@ -102,7 +115,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
>         add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
>         pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI %s\n",
>                            flags, cur_flags, call);
> -       local_irq_restore(flags);
> +       arch_efi_restore_flags(flags);
>  }
>
>  /*
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 45ff763..bd80b7e 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1607,6 +1607,7 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
>
>  bool efi_runtime_disabled(void);
>  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
> +extern unsigned long efi_call_virt_save_flags(void);
>
>  enum efi_secureboot_mode {
>         efi_secureboot_mode_unset,
> @@ -1652,7 +1653,7 @@ enum efi_secureboot_mode {
>                                                                         \
>         arch_efi_call_virt_setup();                                     \
>                                                                         \
> -       local_save_flags(__flags);                                      \
> +       __flags = efi_call_virt_save_flags();                           \
>         __s = arch_efi_call_virt(p, f, args);                           \
>         efi_call_virt_check_flags(__flags, __stringify(f));             \
>                                                                         \
> @@ -1667,7 +1668,7 @@ enum efi_secureboot_mode {
>                                                                         \
>         arch_efi_call_virt_setup();                                     \
>                                                                         \
> -       local_save_flags(__flags);                                      \
> +       __flags = efi_call_virt_save_flags();                           \
>         arch_efi_call_virt(p, f, args);                                 \
>         efi_call_virt_check_flags(__flags, __stringify(f));             \
>                                                                         \
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
