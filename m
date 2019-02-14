Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07301C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:11:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C762D222D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q9zc+R2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C762D222D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xzWk1Xzmrq2UB6QMwsSyGI9lZ0WS+6Du1nPqIbjPB2A=; b=Q9zc+R2FJSFWKWFxW8jMp6guA
	Setrz8fwVJh7ND17wAxnJKoc/D4i+u4vGk9G6LFwHfJ605+fJNNNXZFXVqGzAV4RkAy7nFxdYDok9
	ECW8d2NNFYb6npGcwiH3SxM092XMusR1Mq6wDzkB06pjoVuW2aay24bHG1v22GZvznnr1rlNbtd0y
	NJQ+uTHXAxRz265GtMKApejV42DM45XuzYss7yNODgaZNUbIxIAyvZHdBVPU1xMEjBji1H3wC8Wnk
	EqIQIcQQb290rDlZWLtCH1NPsQZ7Nuzo2/SG//Acwfqdz8SVTHrNXcQEeQWIaSXXVcbmNWLo7T1qj
	JS2k1GPFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDzh-0006C2-CZ; Thu, 14 Feb 2019 10:11:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDzd-0006Bb-VQ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:11:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC89AEBD;
 Thu, 14 Feb 2019 02:11:44 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F8B3F575;
 Thu, 14 Feb 2019 02:11:42 -0800 (PST)
Subject: Re: [PATCH] kvm: arm64: Fix comment for KVM_PHYS_SHIFT
To: yuzenghui@huawei.com, christoffer.dall@arm.com, marc.zyngier@arm.com
References: <1550108746-14704-1-git-send-email-yuzenghui@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f14b90b1-ca81-e57e-9c42-6c8a4608cf72@arm.com>
Date: Thu, 14 Feb 2019 10:11:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550108746-14704-1-git-send-email-yuzenghui@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_021146_017824_85CFE3FC 
X-CRM114-Status: GOOD (  17.19  )
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
Cc: wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi

On 14/02/2019 01:45, Zenghui Yu wrote:
> Since Suzuki K Poulose's work on Dynamic IPA support, KVM_PHYS_SHIFT will
> be used only when machine_type's bits[7:0] equal to 0 (by default). Thus
> the outdated comment should be fixed.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   arch/arm64/include/asm/kvm_mmu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 8af4b1b..a12bf48 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -138,7 +138,8 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>   	})
>   
>   /*
> - * We currently only support a 40bit IPA.
> + * We currently support using a VM-specified IPA size. For backward
> + * compatibility, the default IPA size is fixed to 40bits.
>    */
>   #define KVM_PHYS_SHIFT	(40)

Thanks for the fix.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
