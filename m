Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:09:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F6B20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="If3aG4Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F6B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BZvcN8+OdGdF1APpLBIfpfPR8UVhp6m7UPO9Rmt4oYA=; b=If3aG4Pg6xMiGS
	9exVbUOLGn+GanwAbJ9+vlKe1W6FcdrXodldcOQhP/SaxSGWbd7aZ/PQ+DxIiWHfFkiNeoCjjRUbe
	EhD25j+jrqu2PvMeziPVU/fKWRmeo1rH56veaRgsVlmLHawGgpulLwUJtmGrbSIm80SOR85Xl8obG
	DMxC0KYsEfMEOwM+BasDBDJ4zwzEw0OTqx/WtWe3Aj+b3t1eF33qSJebAGVU4QHSxNQB1CeyLgpPu
	TVmEwGP5pED5m0i7zklty9hu1K9SwtETv7UxKzQGkslTgjFgUtbsd0/qEzFkcU2etQVRsTsZBBKg1
	msaECPctghxLniJyIobw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOsE-0004ur-6S; Thu, 13 Dec 2018 11:09:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOsA-0004tW-54
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:09:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23A8CA78;
 Thu, 13 Dec 2018 03:09:29 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544B23F59C;
 Thu, 13 Dec 2018 03:09:27 -0800 (PST)
Subject: Re: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-5-jeremy.linton@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <6c572de0-da38-c273-82ed-bafb86bbfa7a@arm.com>
Date: Thu, 13 Dec 2018 11:09:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206234408.1287689-5-jeremy.linton@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_030942_200136_F3D9EDFF 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 06/12/2018 23:44, Jeremy Linton wrote:
> Add code to track whether all the cores in the machine are
> vulnerable, and whether all the vulnerable cores have been
> mitigated.
> 
> Once we have that information we can add the sysfs stub and
> provide an accurate view of what is known about the machine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 72 +++++++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 559ecdee6fd2..6505c93d507e 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c

[...]

> @@ -766,4 +812,20 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  }
>  
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	switch (__spectrev2_safe) {
> +	case A64_SV2_SAFE:
> +		return sprintf(buf, "Not affected\n");
> +	case A64_SV2_UNSAFE:
> +		if (__hardenbp_enab == A64_HBP_MIT)
> +			return sprintf(buf,
> +				"Mitigation: Branch predictor hardening\n");
> +		return sprintf(buf, "Vulnerable\n");
> +	default:
> +		return sprintf(buf, "Unknown\n");
> +	}

Again I see that we are going to display "Unknown" when the mitigation
is not built in.

Couldn't we make that CONFIG_GENERIC_CPU_VULNERABILITIES check whether a
CPU is vulnerable or not even if the mitigation is not implemented? It's
just checking the list of MIDRs.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
