Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38185C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:32:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088B021B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CMwRY+4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088B021B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pf8shWncucng8oI1lQ7jSw5uKgRYbEv65fkbsBn5AQ4=; b=CMwRY+4IoKN65YLbR0veJzenm
	y5faPol5ywJ7rkBW9Eh1YtJxWoTpzSDPbP68yUUNzHXYsEwGR+BD/OsFACnDSdS879pKl8ugjeJPT
	Vr+h6KwZ8i+CC4SriXvr4zz5hgWoxkkvcmyRkYHYKVorHy1KU4hLqGosMNmJHFJ4XKyO3gMZgVpvM
	fmPh0IXkzTauYAFFORhCblBmVOx33qIwP+6OVJYLn9nJR3TiwaRSpeESJuj3G+vd0CDpTz2iX0Lj7
	c9S6b02ZiJOxMlwOzRJC1FRsNODd1Z9Bk7ug7PJI+3qarr69Wy5bmGSpJ/HEx+Up79rzxt2VxhJqy
	kEEWJc1Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guOby-0006jg-9D; Thu, 14 Feb 2019 21:32:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guObu-0006jJ-Nv
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 21:32:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF0CEEBD;
 Thu, 14 Feb 2019 13:31:57 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E103F557;
 Thu, 14 Feb 2019 13:31:55 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To: Douglas Anderson <dianders@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will.deacon@arm.com>
References: <20190214204433.155715-1-dianders@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
Date: Thu, 14 Feb 2019 21:31:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214204433.155715-1-dianders@chromium.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_133158_787050_84EF5669 
X-CRM114-Status: GOOD (  28.79  )
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 evgreen@chromium.org, tfiga@chromium.org, iommu@lists.linux-foundation.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Doug,

On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> Right now the only way to disable the iommu bypass for the ARM SMMU is
> with the kernel command line parameter 'arm-smmu.disable_bypass'.
> 
> In general kernel command line parameters make sense for things that
> someone would like to tweak without rebuilding the kernel or for very
> basic communication between the bootloader and the kernel, but are
> awkward for other things.  Specifically:
> * Human parsing of the kernel command line can be difficult since it's
>    just a big runon space separated line of text.
> * If every bit of the system was configured via the kernel command
>    line the kernel command line would get very large and even more
>    unwieldly.
> * Typically there are not easy ways in build systems to adjust the
>    kernel command line for config-like options.
> 
> Let's introduce a new config option that allows us to disable the
> iommu bypass without affecting the existing default nor the existing
> ability to adjust the configuration via kernel command line.

I say let's just flip the default - for a while now it's been one of 
those "oh yeah, we should probably do that" things that gets instantly 
forgotten again, so some 3rd-party demand is plenty to convince me :)

There are few reasons to allow unmatched stream bypass, and even fewer 
good ones, so I'd be happy to shift the command-line burden over to the 
esoteric cases at this point, and consider the config option in future 
if anyone from that camp pops up and screams hard enough.

Cheers,
Robin.

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/iommu/Kconfig    | 22 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c |  3 ++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 46fcd75d4364..c614beab08f8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -359,6 +359,28 @@ config ARM_SMMU
>   	  Say Y here if your SoC includes an IOMMU device implementing
>   	  the ARM SMMU architecture.
>   
> +config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> +	bool "Default to disabling bypass on ARM SMMU v1 and v2"
> +	depends on ARM_SMMU
> +	default n
> +	help
> +	  Say Y here to (by default) disable bypass streams such that
> +	  incoming transactions from devices that are not attached to
> +	  an iommu domain will report an abort back to the device and
> +	  will not be allowed to pass through the SMMU.
> +
> +	  Historically the ARM SMMU v1 and v2 driver has defaulted
> +	  to allow bypass by default but it could be disabled with
> +	  the parameter 'arm-smmu.disable_bypass'.  The parameter is
> +	  still present and can be used to override this config
> +	  option, but this config option allows you to disable bypass
> +	  without bloating the kernel command line.
> +
> +	  Disabling bypass is more secure but presumably will break
> +	  old systems.
> +
> +	  Say N if unsure.
> +
>   config ARM_SMMU_V3
>   	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>   	depends on ARM64
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..930c07635956 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -110,7 +110,8 @@ static int force_stage;
>   module_param(force_stage, int, S_IRUGO);
>   MODULE_PARM_DESC(force_stage,
>   	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
> -static bool disable_bypass;
> +static bool disable_bypass =
> +	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
>   module_param(disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
