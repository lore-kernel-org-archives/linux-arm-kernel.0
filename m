Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC633C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:53:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C75921873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Neab9jTO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q2Rtemo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C75921873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GPs5uKbY67r7bUsqoNL4SDUqLTexomJ6JBs8GZZhEwM=; b=Neab9jTOLp5pj9
	zw0PECK8UwyA9INmXvQPnyZRKu01eb5gWQQ6FIzqXl4l5zfN4w0h3e+TFli7YzjVrL/TAvwM4YhQj
	U42Jo37VV6hi3k2CjF0TRJZFavD7cIB4mqXNpdn0AMa+A788mVnIbFBT6eCia+YHz4HitzoAPWDMn
	6krAQbZxYtcrCSSYqrzbFX+k8EsfHl588+RL+4NCT6OWf6RWG16uaWa8uIpy+SMbNJIu6+HNBodTH
	RVYkfciA97AaA5qxJG0fBK0tfjmDobcn6YBgIzkGkVk14vSar/qwj0Ap7Iq3umwvRotvk5zlMvtA1
	BlsQakIOh7xZv5b8huRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHgA-0001kx-II; Tue, 18 Dec 2018 15:53:06 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHg6-0001YY-Js
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dBK+IsDwvD0APuwJEBoETZXit8t11uO3W9B/NyNLjAY=; b=q2Rtemo1b3oPBh9akJjwO5cGo
 LuW2di/6rJTNyhjUwEljyKnzf08A/ofnUNs3xCXfOxfKHEzyxYZL50OhqoyJnlBeK/4EYrQ/e4sRx
 Su2PqTn6jPKd5w5Uv28MXKj2AxrXT68Jc3pe1ZD9szH/tjQBFzPO963RnuzSeqDN5eElQ=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:59967)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZHfo-0006y4-My; Tue, 18 Dec 2018 15:52:44 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZHfl-0001CT-VT; Tue, 18 Dec 2018 15:52:42 +0000
Date: Tue, 18 Dec 2018 15:52:40 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: patrice.chotard@st.com
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Message-ID: <20181218155239.GP26090@n2100.armlinux.org.uk>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_075302_652725_EB65F461 
X-CRM114-Status: GOOD (  22.21  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 03:48:13PM +0100, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Due to pen_release and boot_lock removal, secondary CPU's bringup
> was broken. Restore CPU's bringup by reworking properly
> .smp_prepare_cpus and .smp_boot_secondary STi callbacks.

Sorry, maybe I don't understand your commit message, but you seem to be
saying that removal of the pen_release and boot_lock broke STi's secondary
CPU bring up?  Please clarify, and explain how that happened.

Thanks.

> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/mach-sti/platsmp.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index 2166850..9bfc93a 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c
> @@ -28,8 +28,21 @@
>  
>  #include "smp.h"
>  
> +static u32 __iomem *cpu_strt_ptr;
> +
>  static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> +	unsigned long entry_pa = __pa_symbol(secondary_startup);
> +
> +	__raw_writel(entry_pa, cpu_strt_ptr);
> +
> +	/*
> +	 * wmb so that data is actually written
> +	 * before cache flush is done
> +	 */
> +	smp_wmb();
> +	sync_cache_w(cpu_strt_ptr);
> +
>  	/*
>  	 * Send the secondary CPU a soft interrupt, thereby causing
>  	 * it to jump to the secondary entrypoint.
> @@ -43,10 +56,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	struct device_node *np;
>  	void __iomem *scu_base;
> -	u32 __iomem *cpu_strt_ptr;
>  	u32 release_phys;
>  	int cpu;
> -	unsigned long entry_pa = __pa_symbol(secondary_startup);
>  
>  	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>  
> @@ -74,8 +85,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  		}
>  
>  		/*
> -		 * holding pen is usually configured in SBC DMEM but can also be
> -		 * in RAM.
> +		 * cpu-release-addr is usually configured in SBC DMEM but can
> +		 * also be in RAM.
>  		 */
>  
>  		if (!memblock_is_memory(release_phys))
> @@ -85,17 +96,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  			cpu_strt_ptr =
>  				(u32 __iomem *)phys_to_virt(release_phys);
>  
> -		__raw_writel(entry_pa, cpu_strt_ptr);
> -
> -		/*
> -		 * wmb so that data is actually written
> -		 * before cache flush is done
> -		 */
> -		smp_wmb();
> -		sync_cache_w(cpu_strt_ptr);
> -
> -		if (!memblock_is_memory(release_phys))
> -			iounmap(cpu_strt_ptr);
> +		set_cpu_possible(cpu, true);
>  	}
>  }
>  
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
