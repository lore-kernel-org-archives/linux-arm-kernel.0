Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508732082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GNGXYLYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508732082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7NMzKAp3dtWf0sb4W7XGe7j2mzjM8tM3GzujzWf0fJU=; b=GNGXYLYqh8MMnU
	8vEnoyEr72jp5jzsfHrxKsYmyZ/7MunwuK+9xSYXSX8OBpX4Ktbz5hyXkydV7QRrACCNZG6DwL9y5
	EpOxyXRkI6mb1v8cQkaWIrJu/DnAJsftlfsmOSPhbvQPX0hM8fiXIuDRTm4Iw0zYTLT3AABMD03fQ
	QnDLVZ0nGmmbIwVflcSChhQ7KJuP6TwKaX2GrOhtvO71tveb1k5Xa0wv1Gr1FbfKikdCg6RWNUL95
	44R1Z2CFkCOs2+ZCC1SNan+wENjGwM5PHAg51VM8QfEqxlnHft01owRe7cMT+B1+8Hctjh8DS7VPY
	stZqXpdQ2exxHgUsMyQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSijs-0003qb-JE; Fri, 30 Nov 2018 13:21:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSij1-0002vh-UM; Fri, 30 Nov 2018 13:20:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 771351596;
 Fri, 30 Nov 2018 05:20:55 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4755E3F5A0;
 Fri, 30 Nov 2018 05:20:55 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 175601AE12D3; Fri, 30 Nov 2018 13:21:14 +0000 (GMT)
Date: Fri, 30 Nov 2018 13:21:14 +0000
From: Will Deacon <will.deacon@arm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v16 15/16] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20181130132113.GE9000@arm.com>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-16-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181115055254.2812-16-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_052056_257710_77BD7E52 
X-CRM114-Status: GOOD (  22.12  )
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
Cc: prudo@linux.ibm.com, herbert@gondor.apana.org.au, bhe@redhat.com,
 ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com,
 heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
 schwidefsky@de.ibm.com, james.morse@arm.com, dyoung@redhat.com,
 davem@davemloft.net, vgoyal@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 15, 2018 at 02:52:54PM +0900, AKASHI Takahiro wrote:
> With this patch, kernel verification can be done without IMA security
> subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> 
> On x86, a signature is embedded into a PE file (Microsoft's format) header
> of binary. Since arm64's "Image" can also be seen as a PE file as far as
> CONFIG_EFI is enabled, we adopt this format for kernel signing.
> 
> You can create a signed kernel image with:
>     $ sbsign --key ${KEY} --cert ${CERT} Image
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93dc4d36d6db..11f3e1a00588 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -867,6 +867,30 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>  
> +config KEXEC_VERIFY_SIG
> +	bool "Verify kernel signature during kexec_file_load() syscall"
> +	depends on KEXEC_FILE
> +	help
> +	  Select this option to verify a signature with loaded kernel
> +	  image. If configured, any attempt of loading a image without
> +	  valid signature will fail.
> +
> +	  In addition to that option, you need to enable signature
> +	  verification for the corresponding kernel image type being
> +	  loaded in order for this to work.
> +
> +config KEXEC_IMAGE_VERIFY_SIG
> +	bool "Enable Image signature verification support"
> +	default y
> +	depends on KEXEC_VERIFY_SIG
> +	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> +	help
> +	  Enable Image signature verification support.
> +
> +comment "Support for PE file signature verification disabled"
> +	depends on KEXEC_VERIFY_SIG
> +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> +
>  config CRASH_DUMP
>  	bool "Build kdump crash kernel"
>  	help
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9f0d8b5d62d3..d1c6c54c22e3 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -12,7 +12,9 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
> +#include <linux/pe.h>
>  #include <linux/string.h>
> +#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>  				sizeof(h->magic)))
>  		return -EINVAL;
>  
> +	pr_debug("PE format: %s\n",
> +			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
> +							"no" : "yes");
> 

Is this hunk really necessary? I'd prefer not to commit pr_debug()
invocations.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
