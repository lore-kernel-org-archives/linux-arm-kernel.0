Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C41DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:29:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2E720842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WYI1ei2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2E720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XvyRMCxcKVUFkt2koLASex73w+s1JGvUNi5kEVAjFjI=; b=WYI1ei2x9xg/qG
	THpVFjAdQJxUjWk7RWY1NxyLFS8iznCbstDIKdeMd6EQRZhiIgTs2lUWuFzYp5NbqhWWeYkyIGnLl
	mj5KXVlSKMdhPiMZ6x8ubCK+Ux3BX4u6+AxdVWFwKy6C6w+o+21yIwyNom44kEIDFxkm6DxYsJSLN
	HKJn7++4+U3Cl9A2vAHq/CwleL+LxdbrCEX0Lmex140xvvvrAwuW46MJzunR1HrtPARAwJhmVR1Mj
	0zYeVgp0vCq3+o1JEK0OIVGBPc389EUrOzSHOMsylLYGfKl2jXC1wP8BdaYWCCcfM35+lKCLzfrd1
	HSqzCTkkK+qv8l+FTZEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyK43-0001nz-Aw; Mon, 25 Feb 2019 17:29:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyK3z-0001nL-OI
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:29:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDA880D;
 Mon, 25 Feb 2019 09:29:09 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF673F703;
 Mon, 25 Feb 2019 09:29:08 -0800 (PST)
Subject: Re: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
From: James Morse <james.morse@arm.com>
Message-ID: <d391d125-86a9-82e3-5add-10a15e578dd7@arm.com>
Date: Mon, 25 Feb 2019 17:29:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_092911_789109_E99A53FB 
X-CRM114-Status: GOOD (  20.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Will Deacon' <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Zhang,

On 23/02/2019 13:06, Zhang, Lei wrote:
> Zhang, Lei wrote:
>> I think you mean it may be a problem to modify the KPTI trampoline because
>> some patches about KPTI will be merged to mainline in the near future.
>> I understood that.
>> I should discuss with my colleagues whether we can set NFDx=0 all of time on
>> A64FX.
> 
> The result of our investigation also supports your suggestion. 
> We surely agree with you that your proposed method (never set NFDx=1 on A64FX)
> is the best to resolve this erratum.
> 	
> For this erratum, James's patch should be merged to mainline
> instead of my previous patches (v1 to v4).
> Since KPTI fully covers the effect of NFD1 for A64FX, KPTI is
> recommended to be used in conjunction with James’s patch.

>> And thanks for your patch.
>> If we can set NFDx=0 all of time, I will review, test and report the result.
> 
> I have already tested James's patch on A64FX, and the result is no problem at all.
> 
> Tested-by:zhang.lei<zhang.lei@jp.fujitsu.com>

Thanks, I'll post it properly with this tag.


>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
>> a4168d366127..b0b7f1c4e816 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041
>>
>>  	  If unsure, say Y.
>>
>> +config FUJITSU_ERRATUM_010001
>> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
>> +	default y
>> +	help
>> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
>> +	  On some variants of the Fujitsu-A64FX cores version (1.0, 1.1), memory
>> +	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
>> +	  This fault occurs under a specific hardware condition when a
>> +	  load/store instruction performs an address translation using:
>> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
>> +
>> +	  The workaround is to ensure these bits are clear in TCR_ELx.
>> +	  The workaround only affect the Fujitsu-A64FX.
> 
> I think it is better to add a notice here as follows:
> 
>   Recommend to enable KPTI (UNMAP_KERNEL_AT_EL0 = y).

That unmap option is on by default, you can't turn it off without CONFIG_EXPERT. While I
agree, I don't think we need to spell this out.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
