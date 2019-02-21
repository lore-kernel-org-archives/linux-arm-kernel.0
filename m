Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49F82070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFyCxlr/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="si2bkdMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49F82070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tWiu7LeSRDIMYUE/nnvnI7l8lDvQe3Oskt/2JnY9zdc=; b=BFyCxlr/4Wxb+T
	a5vmTbO+pwYB7GXubIWquJnx0tN6ZHz/Jf1ifu5av0JB06mZ9eZB1weSei2KfwY/2ULxa1VBRGQHH
	E3nbld0I93+VLgqQsZhfgTHtpL14Q6U6hmF4+nHfGnf+fAA71cFiSlFRCyiInl7dENGIYd1+6G5Fu
	O07mK2ImDbIBl6gJD2K6+MApAbfvTokvw1eoPU0wvILk1F7rWf2ftuOpgsr5odUgT2jC+gwMN0exe
	48rMkQm5pVHy2l2PP3qWnAl2qZF69AyR6bA/fIfAdODxi53dFx/GesDuLG9Yk6aoAc/IRAo6MV9Lr
	NX9dR1nL7CKUQ1DyQ4bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwpEH-0004KT-7F; Thu, 21 Feb 2019 14:21:37 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwpEC-0004Ip-UI
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 14:21:35 +0000
Received: by mail-pg1-x544.google.com with SMTP id j3so104614pgm.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iI1RJ0SSXxDh0vlZLQrOFO/u2FUJ4ENpS3Ludw9bPw8=;
 b=si2bkdMJebBvPM0GwIvEO3/Amyao38zKAiijR3TpjprMmoqFKum3Njget2unbrFOug
 Ga5QS8HL9rNhN0+nYuT7Z1Uu30vuTxz/7QrYSi00fO0cXe2GxPw1/zwMWmVyWJcYa23o
 f+J45gf8vblmxl80YXo1DP1ukP8rOkDYFLlVRZ93Vepj3O8V/WlhKysqFYJtQLEkXXvu
 Oh7ZRasJOIPvqvl9oLSXVqrMRxLiDcJW4Jr6wY7G8ezbvntovYIWEP4ik7Idb5ominp4
 8zG9C/Wqm3T7mqY/Z7xn00SZ3SrtBhrBwMG6aS/sCofVD/oqCyNYjTc3pB0OZzOpXqXf
 7Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iI1RJ0SSXxDh0vlZLQrOFO/u2FUJ4ENpS3Ludw9bPw8=;
 b=WiuQl+5ITM3NZ4s0r1ywINFyH1G/TJNK4UVjWQlLb7uchfNTNiBN/TM38ZesRjgMfg
 fl0kpL2PHf2ZT3PdhHPaeeZlIBwZmwC3Ui7AJFAe4ZU1Mw3eu4nhJ2dHAyIALF+S4GQW
 XkDeHi8oZ74PBTHiA3HSBNBxRSPyU46zDwcQb5ARjXEn6qt0YLGTsMRT+riqww5OoXXC
 sdlbStR67eljsQ/VMBbeC0bX6ToiAAPpif+qWlMMSmO4X8GYgjYohjMs7TU1yAmH0gaa
 sGQl/80cZ+KUxtleedGGd6wmUkUeadzTyfP0z77jdD0udoClQENpARzovKzsmOf/ElHR
 dJVA==
X-Gm-Message-State: AHQUAuaexPPFpx0VBDh1TYeCMGwdtxor8DGSMeCTgQyklPZkTOlK2XBn
 rt3SPxtF6NnwcNqdnsNMI/biFWJqelBXgQ==
X-Google-Smtp-Source: AHgI3IZIRxhWmHk+uI4fyRE/obuhbmXUG2L9nLu0JhpIBnQ04LtmbdtCF/YGn8UplGAT9XruNQ0UOA==
X-Received: by 2002:a63:68c9:: with SMTP id
 d192mr35656895pgc.264.1550758891142; 
 Thu, 21 Feb 2019 06:21:31 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
 by smtp.gmail.com with ESMTPSA id o2sm31440498pfa.76.2019.02.21.06.21.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 06:21:30 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 662E6301708; Thu, 21 Feb 2019 17:21:26 +0300 (+03)
Date: Thu, 21 Feb 2019 17:21:26 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 02/13] x86/mm: Add p?d_large() definitions
Message-ID: <20190221142126.k54vqaacrc2ekeff@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190221113502.54153-3-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_062133_018286_B7CB3B14 
X-CRM114-Status: GOOD (  17.55  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 11:34:51AM +0000, Steven Price wrote:
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
> 
> Expose p?d_large() from each architecture to detect these large mappings.
> 
> x86 already has these defined as inline functions, add a macro of the
> same name so we don't end up with the generic version too.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/x86/include/asm/pgtable.h | 3 +++
>  arch/x86/mm/dump_pagetables.c  | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23..3695f6acb6af 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -234,6 +234,7 @@ static inline int pmd_large(pmd_t pte)
>  {
>  	return pmd_flags(pte) & _PAGE_PSE;
>  }
> +#define pmd_large(x)	pmd_large(x)
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline int pmd_trans_huge(pmd_t pmd)
> @@ -873,6 +874,7 @@ static inline int pud_large(pud_t pud)
>  	return 0;
>  }
>  #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
> +#define pud_large(x)	pud_large(x)

Nit: we usually do this in form of

#define pud_large pud_large

and before body of the inline function.

-- 
 Kirill A. Shutemov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
