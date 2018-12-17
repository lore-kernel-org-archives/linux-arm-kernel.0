Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86471C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5405E2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eM0Qkufc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=43HKfUzRTVIMd63CYrfOU1e+muvp4Vp7NoVkpQrzgk4=; b=eM0QkufcK6ZZTR
	7ddCrj0bHLzXw9l9+oRq3ShEkAHBXICrLZaob/8hmSedYsbYjgOy0hsgnfVdN3wMW+GD2HhLZfj6Y
	CfPCGBT+XUGBpYm4fhcty6ntTrobeZhxrOTVbanwwTcqBzgsjTkzBkHrWJziA2mHtl9++gBlDRyXR
	A+JvzBWyWKuuE3xIre9z7g6VPTyiqBFoo+EuhxcKfBNoXBjSAUUO2rnLjHYtjlvDUXtZPrH0+u95S
	hG9yG5UGYyMVOQ+E0T/MTeTlUzKUWEaTbKpgLP5mzAWbi8atOxsBRu3nNw2G1AfdnckWaYWelQY2C
	/wnsuy5CLNh3By1gZFOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpmH-0007KS-BE; Mon, 17 Dec 2018 10:05:33 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpm9-0007J0-8q
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 10:05:30 +0000
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id dbdcdb4cfb7b4916; Mon, 17 Dec 2018 11:05:07 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v10 5/6] arm64: select ACPI PCI code only both features
 are enabled
Date: Mon, 17 Dec 2018 11:04:42 +0100
Message-ID: <2376424.2qzz6yc3ay@aspire.rjw.lan>
In-Reply-To: <20181215010247.26101-6-okaya@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-6-okaya@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_020525_475043_DC79EB5E 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Saturday, December 15, 2018 2:02:46 AM CET Sinan Kaya wrote:
> ACPI and PCI are no longer coupled to each other. Specify requirements
> for both when pulling in code.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  arch/arm64/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..bcb6262044d8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -5,7 +5,7 @@ config ARM64
>  	select ACPI_GTDT if ACPI
>  	select ACPI_IORT if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> -	select ACPI_MCFG if ACPI
> +	select ACPI_MCFG if (ACPI && PCI)
>  	select ACPI_SPCR_TABLE if ACPI
>  	select ACPI_PPTT if ACPI
>  	select ARCH_CLOCKSOURCE_DATA
> @@ -163,7 +163,7 @@ config ARM64
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_RESERVED_MEM
> -	select PCI_ECAM if ACPI
> +	select PCI_ECAM if (ACPI && PCI)
>  	select POWER_RESET
>  	select POWER_SUPPLY
>  	select REFCOUNT_FULL
> 

I need a maintainer ACK here.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
