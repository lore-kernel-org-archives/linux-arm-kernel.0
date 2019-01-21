Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C6FC37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:48:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101BC2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nN2VAKMP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4qLHVLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101BC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7IzNSir5AuosBzk2ah5ruEx0VSNjUS5PJFmuCquXyw8=; b=nN2VAKMPO2rcia
	YkRtR0QdiSxAy/vzN3E2RbGa0wOO0lQm8jNd07y4h/F0Aru6KIwcWKTSQLNqcjXXRTdxk9Dq6Xq9L
	NDrjTFFFRlogKdnQnHNG2UeFBhpS5y8yb30HSN+vtUxVHPCMxLwFouxbQy+8ZqX+hXSxnelzk0MPG
	EdLV4JGzmMyeaYBEuDz2VkuJVnbv+OWQz5RZSCu7pmAnuwUGgvqqGZ2XRnoVsJ4u9hAapZ7X+npKm
	HzPkRMxW/9Hx7qOlYvNgXLyBJV+aRGy+bpuq849FnLH2TbmPUyE2Ade+sVawgCMT+aoTjMIQTCzxb
	CMtAB8CweeexR0cU3cKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgUg-0007ZQ-4c; Mon, 21 Jan 2019 20:48:30 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgUc-0007Yz-GA
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 20:48:27 +0000
Received: by mail-pf1-x443.google.com with SMTP id z9so10651507pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c0kZxok94KKeRTyVXwWuR1xdX68Tm9K3v9pDbt6sGZY=;
 b=u4qLHVLPPg+yzTpzHRIh3LOq+aYvzX9lXXaH5/VmGParPp0dUlT7EaYZLqJHvdGuEn
 SwVA03gEkyVf8MyJYE+TwD/okMbqczKHIHVqUki9pd2MDnAJIeDry3sEY8oD1jgBryTN
 h3CtMGY4u5SOgI6x80y4IQoOrGOgVrjlecrGYbsvmCtQCTiDUOB/1QqLb9zw0wZe9IYk
 GNZsRllGu1qc8aTiPW1N3IQpgljbCvCEpHhYHTl9Je4in5Ca70y0zDENuO/mFOJcctFA
 tiwk1wSzstxWLPiOWaAa8ljwf0K2q8jwfbDOgXIzJ0f0kn8ORRnkKjC7h0UpIYlYW0UW
 VuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=c0kZxok94KKeRTyVXwWuR1xdX68Tm9K3v9pDbt6sGZY=;
 b=e+6HI4aXpBGeV7z/cNrNO4Vwwng7wcpqGgx25nvQvUueSwZpbDvo1U+DB6eV3pv/1P
 llJN/XnTMcY/tIR5TqE3hfKWOlAfNaQpJHjN2Y95TsJNxnJF3hjKSUiTxiPZLFaBCGrh
 z7m924Mlhcc1x4LYG675+KFrn1pM/jOUB9zsbs1QeDGgAnDFKpPY1283IU0D0mgoPsPn
 +FllhBMm21Sb/YPB/sd6JGeuu+RDwbgCPKhgz8ohhOagEjQLENO9+w+dFZ9mBRgBlLDj
 Ej3+DhU3zH7ecJrVVrkkVnpTBRJWCSasZqIhhE0GbyGhuOosVvE58Ubz1n7fclpooTS1
 C8xg==
X-Gm-Message-State: AJcUukeNJ36SinfYFhzLAFkDcOGDziPO550Ja/ohkYdXRox5vKycWCYC
 eAAwXufyGTTDSQifo38wYMsGlNuH
X-Google-Smtp-Source: ALg8bN4/pneWf6oVNvvB3fpAi9qeNp43/xdkKgyipksi5yrrb8+Su4QVjCtbVsWg4eH+Mmv3mky+IQ==
X-Received: by 2002:a63:65c7:: with SMTP id
 z190mr29568545pgb.249.1548103704512; 
 Mon, 21 Jan 2019 12:48:24 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id n7sm19317697pff.36.2019.01.21.12.48.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 12:48:23 -0800 (PST)
Subject: Re: [PATCH] ARM: mm: initialize pfn limits with find_limits()
To: Doug Berger <opendmb@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
 <c05d7dcf-ab03-1313-d7b8-d630cdaed167@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <ab09bcea-a55d-e562-6637-0df909b03e22@gmail.com>
Date: Mon, 21 Jan 2019 12:48:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c05d7dcf-ab03-1313-d7b8-d630cdaed167@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_124826_559747_EB85291E 
X-CRM114-Status: GOOD (  19.39  )
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
 linux-kernel@vger.kernel.org,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 Jinbum Park <jinb.park7@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/10/19 11:07 AM, Doug Berger wrote:
> On 12/27/18 3:47 PM, Doug Berger wrote:
>> The max_low_pfn value must be set before sparse_init() is called to
>> keep the early memblock allocations and frees balanced for kmemleak
>> initialization when sparsemem is enabled.
>>
>> This commit accomplishes that by replacing the local variables min,
>> max_low, and max_high with the global limit variables min_low_pfn,
>> max_low_pfn, and max_pfn respectively in bootmem_init(). The global
>> variables are initialized directly by find_limits() and used in the
>> remainder of the function.
>>
>> Fixes: 9099daed9c69 ("mm: kmemleak: avoid using __va() on addresses that don't have a lowmem mapping")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>  arch/arm/mm/init.c | 20 ++++----------------
>>  1 file changed, 4 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 32e4845af2b6..98a733f3a5b9 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -302,15 +302,12 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>>  
>>  void __init bootmem_init(void)
>>  {
>> -	unsigned long min, max_low, max_high;
>> -
>>  	memblock_allow_resize();
>> -	max_low = max_high = 0;
>>  
>> -	find_limits(&min, &max_low, &max_high);
>> +	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
>>  
>> -	early_memtest((phys_addr_t)min << PAGE_SHIFT,
>> -		      (phys_addr_t)max_low << PAGE_SHIFT);
>> +	early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
>> +		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
>>  
>>  	/*
>>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>> @@ -328,16 +325,7 @@ void __init bootmem_init(void)
>>  	 * the sparse mem_map arrays initialized by sparse_init()
>>  	 * for memmap_init_zone(), otherwise all PFNs are invalid.
>>  	 */
>> -	zone_sizes_init(min, max_low, max_high);
>> -
>> -	/*
>> -	 * This doesn't seem to be used by the Linux memory manager any
>> -	 * more, but is used by ll_rw_block.  If we can get rid of it, we
>> -	 * also get rid of some of the stuff above as well.
>> -	 */
>> -	min_low_pfn = min;
>> -	max_low_pfn = max_low;
>> -	max_pfn = max_high;
>> +	zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
>>  }
>>  
>>  /*
>>
> 
> Any feedback on this patch?

Mike, Catalin, does this looks sensible to you? If so, should this be
thrown into Russell's patch tracking system?

Thanks
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
