Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31948C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F379F20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqqKIxPU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rOY8UICN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mcP1ITkJRC5aZhzR948Y+CjCn/tDj8iyjPt1xANm7s=; b=tqqKIxPUBaECaW
	uKuYQmkeW9b7/54kRT9SXQe5qJS1eXJWAEj6Z7jJqnz9ncBfUY0AQV2cvblNK1xx6wg8h9EOBx8jg
	a1hdiZFM3759z95rJqojf2cB2obsL8bSHEkCZ5OOLYNxFBqUD8tf5d5+Yxv6BRwzPvJf2rPrCXRm1
	GSwxNsMu6gVqxGnkazFzAtCG4gG7bsj0OcumDgJneXFV4Uar0Ej/mNih/pT15LZE9ZTzb/OPtASvb
	DqdKO0tACqE5iI52N7vsM5g3aIKZyW1ZI1dXs5YIpSG9ABGCA6IAFVwuqJ8v3g1YB043HcmmOBAgz
	17D+3oUXuL0RGQTZt5Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWNHN-0005v9-OI; Mon, 10 Dec 2018 15:15:29 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWNHF-0005tI-O5
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 15:15:27 +0000
Received: by mail-lf1-x141.google.com with SMTP id f23so8206512lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 07:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E5xm7eH52Fy6OJNbIJDutqhE46UBtijO2dHJCxBrof4=;
 b=rOY8UICNhwgenMQ974wdzmyfQp3RMk4pfA4G90T6YXz4bNiCBoITjKkVPjP8oMcCON
 uHUOoz0prTIV9VETT8vOEQqGkwYD3k7h8BC0YPUSjIa51YDC02AJdYRompscCVlPIq5a
 0DIZdEI1azzblOZp1L+ueNUczetC6OH4t/4JjOSECJ83RzrKi8ighmib2MFtofFZHY/y
 yAShWskIH8VJgeH6RnKnCMlZ4c7cYrMzJYLscx2WUl4nXZy4600eOfuD63Swyx7UL2bp
 khabEgtpfrDVZAFhikxK7/cDnuHIXoi6vwJYKriH+XcnLaTgnA7m3vvf5XDgt70EHnbU
 lMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E5xm7eH52Fy6OJNbIJDutqhE46UBtijO2dHJCxBrof4=;
 b=ZkMFbJqULkkk99zJ0BVSKplD4nl82y/JyJCKM5mp8ZlHoQTPmNK5juR5i69KFIEPKS
 eVOwW7SclB2vjlg7tZLXWIKL4dt7eUUFCCP2iP609CwVpwJkhQ+ABsCvkzwzQb2WctxD
 HCAl/WsMqe88m1Mc6BFikA1WlyZI5AS2IQj+8doA9xD+lFg6dnQFrmCYisIbj0BLmODd
 ds0rStEcOtKNwECqPz8kAKXL7vQ5PsfNvB0vId+s3ukAtWUYAQiyIj8SqB7ZjSSBob6I
 A+fPx695R249td7sjHqHvzf97FFF9ikolUH5Z4ug4DrV7C0/wOzxupzAQPdiptpalXU4
 f22A==
X-Gm-Message-State: AA+aEWbgi+AIbB2rLuZP7PK3ag6HKxLDNxCxmy9uENwlvdLR1N6N1VqC
 +3YKAdSXlpgya3bwVe3TMDPGGA==
X-Google-Smtp-Source: AFSGD/X7lJuM1kAIPu8kAyzpO2/5GH0DL/7RY2tdW0r70cn17ZYoIEjBj5YaEZKPstRbOKVPX/N/ag==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr6814620lfk.151.1544454909175; 
 Mon, 10 Dec 2018 07:15:09 -0800 (PST)
Received: from kshutemo-mobl1.localdomain
 (mm-113-209-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.209.113])
 by smtp.gmail.com with ESMTPSA id b128sm2162380lfe.91.2018.12.10.07.15.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 07:15:08 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id D049130155D; Mon, 10 Dec 2018 18:15:06 +0300 (+03)
Date: Mon, 10 Dec 2018 18:15:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
Message-ID: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210142105.6750-1-rafael.tinoco@linaro.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_071521_791133_CAA31625 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Nitin Gupta <ngupta@vflare.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Juergen Gross <jgross@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, Tony Luck <tony.luck@intel.com>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Minchan Kim <minchan@kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 12:21:05PM -0200, Rafael David Tinoco wrote:
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 84bd9bdc1987..d808cfde3d19 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -64,8 +64,6 @@ extern unsigned int ptrs_per_p4d;
>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>  #define P4D_MASK		(~(P4D_SIZE - 1))
>  
> -#define MAX_POSSIBLE_PHYSMEM_BITS	52
> -
>  #else /* CONFIG_X86_5LEVEL */
>  
>  /*
> @@ -154,4 +152,6 @@ extern unsigned int ptrs_per_p4d;
>  
>  #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
>  
> +#define MAX_POSSIBLE_PHYSMEM_BITS (pgtable_l5_enabled() ? 52 : 46)
> +

...

>  #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 0787d33b80d8..132c20b6fd4f 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c

...

> @@ -116,6 +100,25 @@
>   */
>  #define OBJ_ALLOCATED_TAG 1
>  #define OBJ_TAG_BITS 1
> +
> +/*
> + * MAX_POSSIBLE_PHYSMEM_BITS should be defined by all archs using zsmalloc:
> + * Trying to guess it from MAX_PHYSMEM_BITS, or considering it BITS_PER_LONG,
> + * proved to be wrong by not considering PAE capabilities, or using SPARSEMEM
> + * only headers, leading to bad object encoding due to object index overflow.
> + */
> +#ifndef MAX_POSSIBLE_PHYSMEM_BITS
> + #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
> + #error "MAX_POSSIBLE_PHYSMEM_BITS HAS to be defined by arch using zsmalloc";
> +#else
> + #ifndef CONFIG_64BIT
> +  #if (MAX_POSSIBLE_PHYSMEM_BITS >= (BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS))
> +   #error "MAX_POSSIBLE_PHYSMEM_BITS is wrong for this arch";
> +  #endif
> + #endif
> +#endif
> +
> +#define _PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)

Have you tested it with CONFIG_X86_5LEVEL=y?

ASAICS, the patch makes OBJ_INDEX_BITS and what depends from it dynamic --
it depends what paging mode we are booting in. ZS_SIZE_CLASSES depends
indirectly on OBJ_INDEX_BITS and I don't see how struct zs_pool definition
can compile with dynamic ZS_SIZE_CLASSES.

Hm?

-- 
 Kirill A. Shutemov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
