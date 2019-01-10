Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:07:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0134C214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LutvD83Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXdL5qPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0134C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JTw+DjFtyf9DB9kbITHA7QWWThaVvf+R6SuwqBiJLks=; b=LutvD83QBQdm82
	S14UwSfr2Crkmw7TX1yOQeDz3wTZP73A+WDn4JWGiQiMaLLoQTCbRtW2gPpZnapSZ1IV/zIqcj3aQ
	D+5IB0xGvvI6G/m0/NnVd3hU/9RYopnhNG5JgzrsKX8alfUQsvpI7MP+x1F9fjStbp6OeymJwo3w4
	znjM27XS0B+ffPrjiwbxK/gi9OF+WgVVzb4LdMlTFf6yppnfKnkGnWvMNoHR3lL5xMWuddvHyczVK
	8+3vDNTS/eoak1agyQXpAzqWtCmFPW5YJeGs5srG7bBAa0QWMCDda8VdR+XXe3n4iW58WUsBUuI/j
	SGNwlAlQg4nA+nQf/ZPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfgA-0004TC-Lj; Thu, 10 Jan 2019 19:07:46 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfg7-0004Sp-Fq
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 19:07:44 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so5578521plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jtb1xiDey4w11ACTEFyLLZk3WXF5rettAmye4zCA5Qw=;
 b=lXdL5qPN6Rg8aFT3oRPCCQioylcVRpcxPslRkR/LkYXoacml0Pt7NTVqSjwEUYZVm6
 +Tfyovnpjcyelat5ksLOU5UBt5IxX3GTE6nxofZITxFedlJ7LCFSqrxSaOJn4AbUlREM
 buaeaTJY2grCsVZ6XTRUEStray7caZ1kGGfKr8jnpEtZr0FeHEuEVQH2U4CwT3kKys9n
 s6SqEFw03KIu+8irIFzwgeQpylnPJ2jpbtbN4pnWefpoAlpQQQwf5FCoYq3ZtSic2wS3
 6+wgURQyeIW9EuTSUbWJLfBYfYKkQRsMVb1qqJR0hRrmvpZ+aGsn8eIvIOeOsOGutSgX
 ytIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jtb1xiDey4w11ACTEFyLLZk3WXF5rettAmye4zCA5Qw=;
 b=lnLljYmLAgOzxX+0SYXfLGPvehVZQuYMfrQypXzTwo7Akz9hWKRDSpht6X27kRICm/
 6qJlpcj6j3q/I3r0Ty/AEh+O8meZ3YIYRI8K4Q/bULlLnloHCkgYA8fxkEukt4LECIhW
 kDmIoxrRxw6jAn/FCNRXOkvoBdizJ530o7/mG0J7//O7kbhXkJmZJjIQU+pJxjKsRJ63
 LbxUv/tahTfqqvc0Plxd19H2RNDKibhFl/NwpDI6RhSq5Trtq2YIbqpEX7Z9jPE/OQPe
 85sg5ubjc27ZHJDr0YjSoMioTXmhj15iAv/sSAYwM6WTMhc4iB0gAiavr4IEBbg4Kf1s
 Wcrw==
X-Gm-Message-State: AJcUuke7jWgVloSJM4HtqomEWpuZsZVdlB1gpLs3xh85MXnvwu3Hdvex
 gFeRKYU6ifKXHe5/yp3ixZY=
X-Google-Smtp-Source: ALg8bN4/kOMuziRnNHOIZCZYsECJgy5ApdBf/00RCIZ2J3zY33gZWOOYvTMbjN6etulXRvxNl1zLoQ==
X-Received: by 2002:a17:902:bb05:: with SMTP id
 l5mr11744637pls.230.1547147262097; 
 Thu, 10 Jan 2019 11:07:42 -0800 (PST)
Received: from [10.67.51.137] ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id x27sm140416615pfe.178.2019.01.10.11.07.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 11:07:41 -0800 (PST)
Subject: Re: [PATCH] ARM: mm: initialize pfn limits with find_limits()
To: Russell King <linux@armlinux.org.uk>
References: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
From: Doug Berger <opendmb@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=opendmb@gmail.com; prefer-encrypt=mutual; keydata=
 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 YVs=
Message-ID: <c05d7dcf-ab03-1313-d7b8-d630cdaed167@gmail.com>
Date: Thu, 10 Jan 2019 11:07:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_110743_544957_C0EDDE3A 
X-CRM114-Status: GOOD (  22.72  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Michal Hocko <mhocko@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 Jinbum Park <jinb.park7@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/27/18 3:47 PM, Doug Berger wrote:
> The max_low_pfn value must be set before sparse_init() is called to
> keep the early memblock allocations and frees balanced for kmemleak
> initialization when sparsemem is enabled.
> 
> This commit accomplishes that by replacing the local variables min,
> max_low, and max_high with the global limit variables min_low_pfn,
> max_low_pfn, and max_pfn respectively in bootmem_init(). The global
> variables are initialized directly by find_limits() and used in the
> remainder of the function.
> 
> Fixes: 9099daed9c69 ("mm: kmemleak: avoid using __va() on addresses that don't have a lowmem mapping")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  arch/arm/mm/init.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 32e4845af2b6..98a733f3a5b9 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -302,15 +302,12 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>  
>  void __init bootmem_init(void)
>  {
> -	unsigned long min, max_low, max_high;
> -
>  	memblock_allow_resize();
> -	max_low = max_high = 0;
>  
> -	find_limits(&min, &max_low, &max_high);
> +	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
>  
> -	early_memtest((phys_addr_t)min << PAGE_SHIFT,
> -		      (phys_addr_t)max_low << PAGE_SHIFT);
> +	early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
> +		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
>  
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
> @@ -328,16 +325,7 @@ void __init bootmem_init(void)
>  	 * the sparse mem_map arrays initialized by sparse_init()
>  	 * for memmap_init_zone(), otherwise all PFNs are invalid.
>  	 */
> -	zone_sizes_init(min, max_low, max_high);
> -
> -	/*
> -	 * This doesn't seem to be used by the Linux memory manager any
> -	 * more, but is used by ll_rw_block.  If we can get rid of it, we
> -	 * also get rid of some of the stuff above as well.
> -	 */
> -	min_low_pfn = min;
> -	max_low_pfn = max_low;
> -	max_pfn = max_high;
> +	zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
>  }
>  
>  /*
> 

Any feedback on this patch?

Thanks,
    Doug


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
