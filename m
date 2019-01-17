Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AAFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B892054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LWTNnDsm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDe82Sb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B892054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sAuc0KFgJXz7u/Wq+juRBwdvTm67bN/w7aOq5VjRuxQ=; b=LWTNnDsmVsPfWv
	KNPJD+kb+L43wyhRyjm+wMYhbq2D54Wg0cP9iAQDpOrO0QmijdxQX0AkTC8nNKcalGy14n0qugPqs
	hEb1hRkwaWfiehIflvTfcrr0Jrb2Kf7YSXXyco6c7AQYbcH4geErvlzat91aqHpcsdsiyGyq6PBqz
	InY2eFvuENq5TOhjfZDBX5Z5+C4nG2yH9OW7d/VOwrqNDF/hnLfQofmEaGeMCMcteT/KbuACKSPNw
	H0tDT3p0bOt6a+EkaDvB7b7hqaotSH96M/Ln+YokAdSY9oNR6XxO6q4iRDTqcLwqSn2HmSx7NlfgY
	tpQ5ZcpfAG27SXEjG8mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5mE-0000a5-7F; Thu, 17 Jan 2019 11:24:02 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5mA-0000Ze-Gj
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:23:59 +0000
Received: by mail-lf1-x143.google.com with SMTP id a16so7497492lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 03:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GZAuKN4FHOkeuvFTVfdXuwEyS7W+wswuosNv2Pa8ysE=;
 b=kDe82Sb4BfkBwqNE3l3qCPBQRWjCXAMCiNQ4eoXgTk6ztyOTbiyGE+tms6+mFmqU4i
 1MWb2xNrSjUodizYBNrccHWBOzyJe16tfhhu6NJiPXn/bmSyg0ECdnFS76ZKEpsJSJYk
 BlUpZ1Kei/vlJ55BigXZ5ACN1kXug0y/N24QJskK+3ZtXEKnyZb0RjGyEp7IOVzrC5GR
 YxR5vtvc7WJM3gtlfO5ER1FkTQBpECr8tHYVxuhcS7xPqVwxAmRWk1r4WI0DSJ/Su8o/
 4NgYSlmT34YJUgYuZX2OfTaF1KoRHpIIq9Q3G4JBijCaVi7Z1IOlu0g26WorgE5cbP1R
 kUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GZAuKN4FHOkeuvFTVfdXuwEyS7W+wswuosNv2Pa8ysE=;
 b=M0VJ/KFieN+dRXw7NetO6VtVyk23M8el0ULl8itR7PmCAyfHpReJHGVV+aCt2rnQN+
 ZX2exk5FCaJXU9KcHDbt5KIzjo2o3EMfvDTGZjv8BzFza+BFZAwkN4DvaCeqL/GydYmp
 WvW0+BJi8Ngrhf+rlqrZCSc6r6SJeFSVQIBO64bBP8vPpQwQf/M7Seiws+MkNaWsjeEx
 FZzBSiTge0/yuJOrcugTe28V3JNe8YYvf1o8KAvlgWbw69n5/H7vgXzkosbEFRNMV7iv
 kcCGcV0KpVD3jV+LYvpJIY/QLxEJjYEEUXdXenCZEUXk5xbt1WUmp7dxDuCvMTOvMpwG
 5PyA==
X-Gm-Message-State: AJcUukel1n/JpqUlBoFAE7nqedlwbYz25GscaCtYWgUBKdGpo3N4UG6r
 XZFrmx3cMcTie08YSUG82kUuuablYLBdMN6wZyc=
X-Google-Smtp-Source: ALg8bN6YVJ9BGmyrwg1/LPDqrGvSCHD/6Z2SagrixxHQrMHQSrRvVZkL9u4zTosJ5PU7vgAjpUXiCL6PJJwm1yun+xk=
X-Received: by 2002:a19:2906:: with SMTP id p6mr9702397lfp.17.1547724236455;
 Thu, 17 Jan 2019 03:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 17 Jan 2019 16:53:44 +0530
Message-ID: <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mm: Remove duplicate header
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Michal Hocko <mhocko@suse.com>, rppt@linux.vnet.ibm.com, 
 Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_032358_553106_304FF175 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  arch/arm/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index f5cc1cc..dde3032 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -23,7 +23,6 @@
>  #include <asm/sections.h>
>  #include <asm/cachetype.h>
>  #include <asm/fixmap.h>
> -#include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <asm/smp_plat.h>
>  #include <asm/tlb.h>
> @@ -36,7 +35,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/pci.h>
> -#include <asm/fixmap.h>
>
>  #include "fault.h"
>  #include "mm.h"
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
