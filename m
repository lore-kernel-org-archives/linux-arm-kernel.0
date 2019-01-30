Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A9C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CD320869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mk6hmRDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CD320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CY/lSG70lDnn6IKCKDq8SVT7nxz/ldlfwTgG8zKZMNg=; b=Mk6hmRDG2oY/Tr
	G6ZjbrjbpBiq1w6Rmlu6XQ+gAyYeWwxLVPIDDVU2EI0qy7uyOujFiAhwIdzpI6LVXo39OQ91f62TA
	uot6Wo9jhj/ZD7t1XSBTAmFAgPHICF+yoRCJH9n0VduCbjNdU7fur/78sh8uU1Olkbgn9MgI7m24X
	GMdATJLgzBLrc1+JyjAIY0MmlJUw3P7TzCvHMC67GEbIkKRhqgvky/m51w0q8+7lCbR7gl/m9osIF
	Fk3IA6NadwaQKKoNp5Cdb7gB0ed+xw71rGw2TvnclDCLn2Gn9bduDk28q4gEKs5oTuEbjJ3wG7amI
	5cDDqoplvlLNXaDLXKpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouCz-0000pM-Cz; Wed, 30 Jan 2019 18:03:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouCw-0000ou-To
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:03:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D3180D;
 Wed, 30 Jan 2019 10:03:30 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 927163F557;
 Wed, 30 Jan 2019 10:03:27 -0800 (PST)
Date: Wed, 30 Jan 2019 18:03:24 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 02/12] arm64: Provide a command line to disable
 spectre_v2 mitigation
Message-ID: <20190130180254.0b716b2c@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-3-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-3-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_100330_963710_2A3EB6BF 
X-CRM114-Status: GOOD (  17.56  )
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
Cc: stefan.wahren@i2se.com, Jonathan Corbet <corbet@lwn.net>,
 julien.thierry@arm.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, linux-doc@vger.kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 12:07:01 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> There are various reasons, including bencmarking, to disable spectrev2
> mitigation on a machine. Provide a command-line to do so.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++----
>  arch/arm64/kernel/cpu_errata.c                  | 11 +++++++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt index
> 9475f02c79da..2ae77979488e 100644 ---
> a/Documentation/admin-guide/kernel-parameters.txt +++
> b/Documentation/admin-guide/kernel-parameters.txt @@ -2849,10
> +2849,10 @@ check bypass). With this option data leaks are possible
>  			in the system.
>  
> -	nospectre_v2	[X86,PPC_FSL_BOOK3E] Disable all
> mitigations for the Spectre variant 2
> -			(indirect branch prediction) vulnerability.
> System may
> -			allow data leaks with this option, which is
> equivalent
> -			to spectre_v2=off.
> +	nospectre_v2	[X86,PPC_FSL_BOOK3E,ARM64] Disable all
> mitigations for
> +			the Spectre variant 2 (indirect branch
> prediction)
> +			vulnerability. System may allow data leaks
> with this
> +			option.
>  
>  	nospec_store_bypass_disable
>  			[HW] Disable all mitigations for the
> Speculative Store Bypass vulnerability diff --git
> a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 9950bb0cbd52..9a7b5fca51a0 100644 ---
> a/arch/arm64/kernel/cpu_errata.c +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -220,6 +220,14 @@ static void qcom_link_stack_sanitization(void)
>  		     : "=&r" (tmp));
>  }
>  
> +static bool __nospectre_v2;
> +static int __init parse_nospectre_v2(char *str)
> +{
> +	__nospectre_v2 = true;
> +	return 0;
> +}
> +early_param("nospectre_v2", parse_nospectre_v2);
> +
>  static void
>  enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities
> *entry) {
> @@ -231,6 +239,9 @@ enable_smccc_arch_workaround_1(const struct
> arm64_cpu_capabilities *entry) if (!entry->matches(entry,
> SCOPE_LOCAL_CPU)) return;
>  
> +	if (__nospectre_v2)
> +		return;
> +
>  	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
>  		return;
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
