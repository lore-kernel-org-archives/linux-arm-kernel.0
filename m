Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C01C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:51:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C8C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o10FvBQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C8C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nGzhVaSAYgaDHjD1xJwKpEtrPtJp61Bpup2xemot2rs=; b=o10FvBQAAGk3ZD
	ZprHb7OU6aQA/Nr1aowFOWRFpcq8oXFiEEHvbSILq91rjPAvOAWSG3qbiJC7LYFXShKEk/GkZVAvS
	KEmESX/U+3bswWPVYjLvxnh7G89BG1mJ6nK+M+fRuhupeWr90Dxy2tDqM/vUUiiQHArQ6+zQWl1va
	dnGuGgmLNfY/yazJWVBsrtrRSbqQ/gQV/ITOCwl5+b6SFE8PewMFgY9G7OO2vOKY28PMq7ZLtAWeT
	04XfDD8mWxor56TlYWor2q8DN9s987uEM5cXT7YFlGwSIXYB7oxZcf6g2FWXgRwPBdIGwMb2i8ces
	nSxNMws7yGft6M9QuT9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4Vu-0005SJ-JO; Mon, 14 Jan 2019 15:50:58 +0000
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4Vp-0005Qe-7s
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 15:50:57 +0000
Received: by mail-lf1-f67.google.com with SMTP id b20so15909993lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 07:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=31z+XEMzJ6K5/5aQETRHBYXsxTO0tFnzs/8KDuSnm1o=;
 b=aT/8LtTptrmvl6+3QnnMMlCtjSLHD3985fYKQ5WvJQWgKBPAc5HxI28Ye67GchrB3m
 cQpT9G4Yp/fhuCeJeyytbduVj2wJ1evYCJtMmIHumfU39sPSa5SYWef7lEG4IMuXCsDK
 1EeWmffDakXaCx4TyatJY98gzP/Q779GV6IY0gQbNv8rTMVVDkspXsX0IeNFHxtc2Jz3
 s7AT+OJW9YVs4L6qa4p5POzQF0ZHwbJxzBbpMhDSDBw3VtchE57LeEh46ONng1mHPC8t
 U4FC3ev3meo67tNXMDzAulgrnCA2UBQ+E5Wnp3bY6XCcpjVqUt/gxBdiwc+Eovz2C+Px
 xXxA==
X-Gm-Message-State: AJcUukfaVkQNgq0aDZ4LzS/fJEkHZvbGxJ6bwdr8oYwIqJ3Kru/hdENL
 wRpvWr5PzYLFwK/kbCcTJ2MlU845UBkKL8NFmIYjVg==
X-Google-Smtp-Source: ALg8bN5txqcWH3KBN3VoGeUeW3+QHeURZnmU0Eso/D3tnH22waYzfYP3ty/L2QT+uI5i27K+O4hWHkLJc7cF20VJOfE=
X-Received: by 2002:a19:750a:: with SMTP id y10mr13446847lfe.43.1547481048577; 
 Mon, 14 Jan 2019 07:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-7-david@redhat.com>
In-Reply-To: <20190114125903.24845-7-david@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 14 Jan 2019 21:20:01 +0530
Message-ID: <CACi5LpPb5Mkk-AQARm96mHJ6S5KLKkSswP-=4z9oPYzK0-knEQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] arm64: kexec: no need to ClearPageReserved()
To: David Hildenbrand <david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_075053_298506_B92993CD 
X-CRM114-Status: GOOD (  16.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
 Dave Kleikamp <dave.kleikamp@oracle.com>, linux-mediatek@lists.infradead.org,
 James Morse <james.morse@arm.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

Thanks for the patch.

On Mon, Jan 14, 2019 at 6:29 PM David Hildenbrand <david@redhat.com> wrote:
>
> This will be done by free_reserved_page().
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Acked-by: James Morse <james.morse@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/kernel/machine_kexec.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index aa9c94113700..6f0587b5e941 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -361,7 +361,6 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>
>         for (addr = begin; addr < end; addr += PAGE_SIZE) {
>                 page = phys_to_page(addr);
> -               ClearPageReserved(page);
>                 free_reserved_page(page);
>         }
>  }
> --
> 2.17.2
>

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
