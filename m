Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E6C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3872C20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUg5wwON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3872C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZD8zgYGtIupvguRaYxbcIXd3lhmU9tmrmjf/PBoAK9A=; b=ZUg5wwON7nHy3S
	geypY5nlBly/JaG+3uISN+8xK6RDZMq0jn48ybB5xviiLihVznxONZfSP7QRP5ky1egxxoElC7JbO
	kDCXOfxOYSRlOnIcAv606Ls+Y4GxVHX9dnEjUGYa/tU6vRmd5nYgSXA4njYv/+qR6nKnFFS1ajrpI
	0h7XDdhRQMSCqK38GV5su9URbh1ub0LhEGyyXY9CJ99+bjVDSHuv3ZJrkTyF4wGa3x1qemryELG9Q
	gl0Wd/cHNjdneV6RKGYYCd7XGRpRWP4IL2B8uByqj1z1eJiBTjZfQQp8NMyqZgahmfSY7A9mBZYwu
	xmYLKLZFiwRgf5tOgkqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEqf-0002XT-RH; Fri, 07 Dec 2018 12:03:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVEqS-0002Ho-BG
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:03:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83FD015AB;
 Fri,  7 Dec 2018 04:02:59 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2DC3F5AF;
 Fri,  7 Dec 2018 04:02:58 -0800 (PST)
Subject: Re: arm64: WARN_ON_ONCE issue when resuming from hibernation
To: Will Deacon <will.deacon@arm.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
References: <20181207104049.5F64.4A936039@socionext.com>
 <20181207104743.GB23587@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <a21290d6-12c3-4a4a-0156-71a28b5acab6@arm.com>
Date: Fri, 7 Dec 2018 12:02:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181207104743.GB23587@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_040300_394825_12018A6E 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kunihiko, Will,

On 07/12/2018 10:47, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 10:40:50AM +0900, Kunihiko Hayashi wrote:
>> I found that a WARN_ON_ONCE dump occured in the resuming sequence from
>> hibernation on arm64 SoC (I use UniPhier LD20 environment).
>>
>>     ...
>>     Disabling non-boot CPUs ...
>>     CPU1: shutdown
>>     psci: CPU1 killed.
>>     CPU2: shutdown
>>     psci: CPU2 killed.
>>     CPU3: shutdown
>>     psci: CPU3 killed.
>>     WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
>>     Modules linked in:
>>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1
>>     ...
>>
>> I show the result of reading the code, however,
>> I'm not sure that this issue occurs in other arm64 SoC.

It does, but you can only see it if you also have 'no_console_suspend' on the
command-line, otherwise the console driver is frozen with the rest of the system
when this happens.

Thanks for the report!


>> In the resuming sequence, once all CPUs are stopped and local IRQs
>> are disabled [1].

>> What is the possible way to solve this issue?
> 
> Given that all secondary CPUs are hotplugged out at this point, we can
> just use the non-IPI version of flush_icache_range().

Sounds good,

> --->8
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 6b2686d54411..29cdc99688f3 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -214,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	}
>  
>  	memcpy((void *)dst, src_start, length);
> -	flush_icache_range(dst, dst + length);
> +	__flush_icache_range(dst, dst + length);
>  
>  	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
> 

Tested-by: James Morse <james.morse@arm.com>

This changed came from commit 3b8c9f1cdfc50 ("arm64: IPI each CPU after
invalidating the I-cache for kernel mappings"). Which came in with v4.19 if you
want to send it to stable. (let me know if its easier for you if I re-post your
patch)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
