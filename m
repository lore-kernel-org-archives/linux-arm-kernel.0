Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB0DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDFD20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKV2wMD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDFD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VZ4+ZTUITA9GU3pf9cnQntXziUV/R5+Ai4MuovogALQ=; b=lKV2wMD3bpEYtb
	Kcm3WwIgEcuGfIiTwXoKEb9nQpiUpL2gtPEalQNLodBtd2V6pacPfp8GiD0XhLrg9pObSf3os8EBo
	q2+FEnm2uq062oZP6kO8xGjzydeZ4WFuksiwY7zSWnpR6YACw3ZekoGb5ZU53XeDK7k0lRzI3vbX2
	j0bvkqH8V1Lfi3CZ0UDEJOjVk1gGz+Zs8E+kSQK8x1Bw57cBld2pUGuW82iOumzedCVJ+UJDCihlG
	PYRo1dZPjnOiY8x7x94edxtz685Aiao+iO1+zeCgxTuIeSUSKcZka7x24EsPsvMESoAF7IHU5PhMu
	YF+uh5TGfwxi8arme5bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHRq-0000At-Iu; Fri, 07 Dec 2018 14:49:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHRn-000093-U0
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:49:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE2315AB;
 Fri,  7 Dec 2018 06:49:31 -0800 (PST)
Received: from [10.1.196.55] (e112269-lin.cambridge.arm.com [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0AB3F575;
 Fri,  7 Dec 2018 06:49:30 -0800 (PST)
Subject: Re: [PATCH] kvm/arm: return 0 when the number of objects is not less
 than min
To: Andrew Jones <drjones@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>
References: <1543972551-60951-1-git-send-email-peng.hao2@zte.com.cn>
 <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <4c32963e-0dc7-1867-aa76-7314334315c4@arm.com>
Date: Fri, 7 Dec 2018 14:49:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_064943_970572_F7D8A200 
X-CRM114-Status: GOOD (  20.99  )
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
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/12/2018 08:32, Andrew Jones wrote:
> On Wed, Dec 05, 2018 at 09:15:51AM +0800, Peng Hao wrote:
>> Return 0 when there is enough kvm_mmu_memory_cache object.
>>
>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> ---
>>  virt/kvm/arm/mmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index ed162a6..fcda0ce 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -127,7 +127,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>>  	while (cache->nobjs < max) {
>>  		page = (void *)__get_free_page(PGALLOC_GFP);
>>  		if (!page)
>> -			return -ENOMEM;
>> +			return cache->nobjs >= min ? 0 : -ENOMEM;
> 
> This condition will never be true here, as the exact same condition is
> already checked above, and if it had been true, then we wouldn't be here.

The condition can be true if the loop is executed at least once. This
change would appear to allow the call to succeed in the case where the
cache can be topped up to at least "min", but not as far as "max".

It would be good to know in what situation this has actually been hit
though (and indeed whether this has actually been seen) - the system
must be very short on memory to need this, and I'd be surprised if
further failures didn't happen later on.

> What problem are you attempting to solve?
> 
>>  		cache->objects[cache->nobjs++] = page;
>>  	}
>>  	return 0;
>> -- 
>> 1.8.3.1
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
