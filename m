Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:06:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA9821473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bL5fMKGj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4Gqwq5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA9821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4KH5Neoot0wuhFSR0wp2K5SXaeXjDSFcf8etFDekBQo=; b=bL5fMKGj25KR7C
	zpVS4c2JEq1I+G7nQYDEKgR1uHto6SlP4+LRt1Wleoroq3DQu+sPAxv8CMDo5RSnKIP8zaqxKTbXF
	FgcT41B3+27IgDCg0m5ECryHoHWIM6EOpJAyxu15nD5OpBaYUOUpfI4POfEsbzCvKrIVVY5HyscEZ
	HLXLec5sKEFceawlMVDd5BnaAy0FHNwYL5vDAWuwe09u28WKWNsPe57Hl1ePtRXPdKSQSwcgKPtlH
	YiEWgUYxdDG9Xzn/tNulxY0BIibfhadQuYsHEVf73oCLfSNGYn3zjNSaZ2psBUhHKRrD8qFQ48M8j
	6bCvpz8JSnJE6tmGi28Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1godOs-0007UX-Hj; Wed, 30 Jan 2019 00:06:42 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1godOn-0007U0-P0
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 00:06:39 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so10487893pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 16:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=J3t3syngpNWVWc5RPSPJlDGMBzfCMGEKozDCy+4ajxg=;
 b=C4Gqwq5yIOoj5NiIT5EHSn5NSDqB77MrAPWCdTSBlegSLgsjpUuT/c5dgP0QttLbm5
 rnoF1xiCHU9YIvbmsOFzT+98soSLsM9HRy1OJn8+3iUpkrS6oPV1DQ/C14FbMIHQTs6+
 GIsEK/dDEPCvJqRJPwUd/kldOo9HdlNIpI7vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J3t3syngpNWVWc5RPSPJlDGMBzfCMGEKozDCy+4ajxg=;
 b=Hy1fNG6KqvSr4H+tSXhT0LLidV6qav1EAReFpfGwTmT86yroNA9pknvw3G5dLF181r
 EJRCOmNO64e2r6iPX1fWsJCY6rhtz71EC7N26D6Brq/JYM3TsWwUMnEEUMVRNDnfO09r
 RQoB/Fwbj1HXDTpStPvXYsuyBJMrYa+fQQWePFLHmti++Hd/W6KEHWQXhZyLl4mwRz4u
 BeT0+BTLcuhxkv7bk4lVrQPMNKZv0npTDJQ5zhX59j23ZI2LY3+TGD84KuIIlP/zcxui
 RPxwm/6q12qvqEmDwXGCYIGUqqgZ3sxKvu2TcdqibLPGaz29Ctoc1KqAgs5hkfk7Ksk6
 7V0Q==
X-Gm-Message-State: AJcUukdqO/g4mJ5c4eMzMHeRrvKFHId+Fh15VkqFYSY0SHNjjMLl6Ed9
 I+sKcIMXVsvxnf+lNFKSLNI1H2/PwOw=
X-Google-Smtp-Source: ALg8bN6DxcazhutIF1W+FZDu4Wl/3ptID0TDvvDU6LwyRTXGpops1bI3HXDUSwhmCFItD5sUFq3WRA==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr24981206pgi.8.1548806796426; 
 Tue, 29 Jan 2019 16:06:36 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id x11sm94974852pfe.72.2019.01.29.16.06.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 16:06:35 -0800 (PST)
Date: Tue, 29 Jan 2019 16:06:18 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
Message-ID: <20190130000618.GM31596@builder>
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_160637_818611_4F7A31E5 
X-CRM114-Status: GOOD (  31.33  )
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
Cc: mark.rutland@arm.com, linux-efi@vger.kernel.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, will.deacon@arm.com,
 Alexander Graf <agraf@suse.de>, Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat 26 Jan 02:22 PST 2019, Ard Biesheuvel wrote:

> The UEFI spec revision 2.7 errata A section 8.4 has the following to
> say about the virtual memory runtime services:
> 
>   "This section contains function definitions for the virtual memory
>   support that may be optionally used by an operating system at runtime.
>   If an operating system chooses to make EFI runtime service calls in a
>   virtual addressing mode instead of the flat physical mode, then the
>   operating system must use the services in this section to switch the
>   EFI runtime services from flat physical addressing to virtual
>   addressing."
> 
> So it is pretty clear that calling SetVirtualAddressMap() is entirely
> optional, and so there is no point in doing so unless it achieves
> anything useful for us.
> 
> This is not the case for 64-bit ARM. The native mapping used by the OS
> is arbitrarily converted into another permutation of userland addresses
> (i.e., bits [63:48] cleared), and the runtime code could easily deal
> with the original layout in exactly the same way as it deals with the
> converted layout. However, due to constraints related to page size
> differences if the OS is not running with 4k pages, and related to
> systems that may expose the individual sections of PE/COFF runtime
> modules as different memory regions, creating the virtual layout is a
> bit fiddly, and requires us to sort the memory map and reason about
> adjacent regions with identical memory types etc etc.
> 
> So the obvious fix is to stop calling SetVirtualAddressMap() altogether
> on arm64 systems. However, to avoid surprises, which are notoriously
> hard to diagnose when it comes to OS<->firmware interactions, let's
> start by making it an opt-out feature, and implement support for the
> 'efi=novamap' kernel command line parameter on ARM and arm64 systems.
> 
> (Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
> used, given that the physical memory map and the kernel virtual address
> map are not guaranteed to be non-overlapping like on arm64. However,
> having support for efi=novamap,noruntime on 32-bit ARM, combined with
> the recently proposed support for earlycon=efi, is likely to be useful
> to diagnose boot issues on such systems if they have no accessible serial
> port)
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This makes the SDM850 bootable, thanks.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/efi/libstub/arm-stub.c        |  5 +++++
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 10 ++++++++++
>  drivers/firmware/efi/libstub/efistub.h         |  1 +
>  drivers/firmware/efi/libstub/fdt.c             |  3 +++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index eee42d5e25ee..626ec4b4a664 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -370,6 +370,11 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
>  		paddr = in->phys_addr;
>  		size = in->num_pages * EFI_PAGE_SIZE;
>  
> +		if (novamap()) {
> +			in->virt_addr = in->phys_addr;
> +			continue;
> +		}
> +
>  		/*
>  		 * Make the mapping compatible with 64k pages: this allows
>  		 * a 4k page size kernel to kexec a 64k page size kernel and
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index e94975f4655b..442f51c2a53d 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -34,6 +34,7 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
>  
>  static int __section(.data) __nokaslr;
>  static int __section(.data) __quiet;
> +static int __section(.data) __novamap;
>  
>  int __pure nokaslr(void)
>  {
> @@ -43,6 +44,10 @@ int __pure is_quiet(void)
>  {
>  	return __quiet;
>  }
> +int __pure novamap(void)
> +{
> +	return __novamap;
> +}
>  
>  #define EFI_MMAP_NR_SLACK_SLOTS	8
>  
> @@ -482,6 +487,11 @@ efi_status_t efi_parse_options(char const *cmdline)
>  			__chunk_size = -1UL;
>  		}
>  
> +		if (!strncmp(str, "novamap", 7)) {
> +			str += strlen("novamap");
> +			__novamap = 1;
> +		}
> +
>  		/* Group words together, delimited by "," */
>  		while (*str && *str != ' ' && *str != ',')
>  			str++;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 32799cf039ef..337b52c4702c 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -27,6 +27,7 @@
>  
>  extern int __pure nokaslr(void);
>  extern int __pure is_quiet(void);
> +extern int __pure novamap(void);
>  
>  #define pr_efi(sys_table, msg)		do {				\
>  	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 0dc7b4987cc2..f8f89f995e9d 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -327,6 +327,9 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
>  	if (status == EFI_SUCCESS) {
>  		efi_set_virtual_address_map_t *svam;
>  
> +		if (novamap())
> +			return EFI_SUCCESS;
> +
>  		/* Install the new virtual address map */
>  		svam = sys_table->runtime->set_virtual_address_map;
>  		status = svam(runtime_entry_count * desc_size, desc_size,
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
