Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:03:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C2520880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c2PTFlhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C2520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5zOxht/t1WAgP/boYPSCNH5nkJGf72Auk4Qka4lf7AQ=; b=c2PTFlhBJVVUHx
	uxTyxtG2SbjynA8etxFY3tT3p5ctOJ+Wn1SM+pNk33uKyKcVN/wnjswtlEJEkCKLvMHnYT92KgiCZ
	MWDGPjm7Jw9eDDUx+rhS3OkcbbT7eZXjGz5Y3o86VUya9VARhJtB68jSreI1R+hZr7HTscwEJ6DEl
	AuRyQ7ZibSjGeAgY2dsQ1MhjdX+ypPP5Va/9uq2kGdoqZSp17rHhCa3p095faBcBU00Lt3XCy0oUG
	PWoxjX9YeCmDqPKSPdoBM0Eh+De/eQyQelEWHOHddGxmEA+xR+FxLzDQGD4tSchJ7AXTXzsoeW5Ka
	q6OvSGlLeWPvfnS41dsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwST0-00030e-Aa; Wed, 20 Feb 2019 14:03:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSSx-00030C-Ic
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:03:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5FEEBD;
 Wed, 20 Feb 2019 06:03:14 -0800 (PST)
Received: from [10.1.35.156] (e121487-lin.cambridge.arm.com [10.1.35.156])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00C6E3F690;
 Wed, 20 Feb 2019 06:03:13 -0800 (PST)
Subject: Re: [PATCH 2/2] ARM: virt: Align GIC version check with arm64
 counterpart
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1550662986-40987-1-git-send-email-vladimir.murzin@arm.com>
 <1550662986-40987-2-git-send-email-vladimir.murzin@arm.com>
 <20190220135005.2df6c6e1@why.wild-wind.fr.eu.org>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <0b0b857a-1e3d-484c-80d1-3248a90a3fdb@arm.com>
Date: Wed, 20 Feb 2019 14:03:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190220135005.2df6c6e1@why.wild-wind.fr.eu.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_060315_619825_713A6600 
X-CRM114-Status: GOOD (  16.99  )
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
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/20/19 1:50 PM, Marc Zyngier wrote:
> On Wed, 20 Feb 2019 11:43:06 +0000
> Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> 
> + Russell,
> 
>> arm64 has got relaxation on GIC version check at early boot stage due
>> to update of the GIC architecture let's align ARM with that.
>>
>> To help backports (even though the code was correct at the time of writing)
>> Fixes: e59941b9b3817c9b1dd6662d903150fe3f3c3b0b ("ARM: 8527/1: virt: enable GICv3 system registers")
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/kernel/hyp-stub.S | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>> index 9ef1759..fd0a723 100644
>> --- a/arch/arm/kernel/hyp-stub.S
>> +++ b/arch/arm/kernel/hyp-stub.S
>> @@ -179,8 +179,8 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
>>  	@ Check whether GICv3 system registers are available
>>  	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
>>  	ubfx	r7, r7, #28, #4
>> -	cmp	r7, #1
>> -	bne	2f
>> +	teq	r7, #0
>> +	beq	2f
>>  
>>  	@ Enable system register accesses
>>  	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Can you please put this in Russell's patch system?

Patch #8848

Cheers
Vladimir

> 
> Thanks,
> 
> 	M.
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
