Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:31:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4662081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNKnZ8Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4662081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cY+DpCIopL+RmjnPz0ZwV9/endz8enMs8B6z6Cbg5Wk=; b=HNKnZ8Q/hyPZph
	sULCGLi7o1y7hY2ewL5hdKZdHaBMs4VmySLhebkA8ftBgzynMopF7gCkCjfZ+0QxUdDAlyeR/HHNd
	BQavKOfspn+3ZkRlHkZQ0Gw5dsEQJsBZg3e+i2Ap7Vex46BH2grOB0x/mgrvzIPD5aCicIdDFGfyd
	7SRJ9L5taDP9WczRR+atSJuebY2vpcWgK9erftc21ITv0B+qT040MPALm+Kvsh6ZSD3ptbg1HLjs0
	eQf86BVU1wYSyK+SlZN7NcE98+IQcTszPrMVOX+ddMS9LpPEazpaZomsnn+ZoKWlaXFhOResalUf7
	u+yIh0l0h3fRX2L+yUbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEXP-0005wM-66; Tue, 04 Dec 2018 17:31:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEXM-0005v1-Mv
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:31:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F19CA78;
 Tue,  4 Dec 2018 09:30:57 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF833F59C;
 Tue,  4 Dec 2018 09:30:55 -0800 (PST)
Subject: Re: [PATCH v6 07/24] arm64: Make PMR part of task context
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-8-git-send-email-julien.thierry@arm.com>
 <20181204170908.GB19210@arrakis.emea.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <d7651225-97ed-02a1-dd87-87cdbd36bca5@arm.com>
Date: Tue, 4 Dec 2018 17:30:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181204170908.GB19210@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_093108_752711_5CA032F5 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 04/12/18 17:09, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:56:58AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 039144e..eb8120e 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -249,6 +249,12 @@ alternative_else_nop_endif
>>  	msr	sp_el0, tsk
>>  	.endif
>>  
>> +	/* Save pmr */
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	mrs_s	x20, SYS_ICC_PMR_EL1
>> +	str	x20, [sp, #S_PMR_SAVE]
>> +alternative_else_nop_endif
>> +
>>  	/*
>>  	 * Registers that may be useful after this macro is invoked:
>>  	 *
>> @@ -269,6 +275,13 @@ alternative_else_nop_endif
>>  	/* No need to restore UAO, it will be restored from SPSR_EL1 */
>>  	.endif
>>  
>> +	/* Restore pmr */
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	ldr	x20, [sp, #S_PMR_SAVE]
>> +	msr_s	SYS_ICC_PMR_EL1, x20
>> +	dsb	sy
>> +alternative_else_nop_endif
> 
> What's this DSB for? If it's needed, please add a comment.
> 

The DSB is to make sure that, in the case we are unmasking interrupt
priorities, the unmasking is seen by the redistributor. Without it the
redistributor might only start forwarding interrupts (if their
priorities are too low) to the CPU once it has seen that PMR was
modified, which could happen after the CPU has returned from the exception.

I'll add a comment.

> I would have expected an ISB (or none at all as we are going to return
> from an exception).

So the two reasons we don't need an ISB are:
- the only thing that matter is that PMR modification + DSB happens
before exception return
- writes to ICC_PMR_EL1 are self synchronizing so we don't need an ISB
before the DSB

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
