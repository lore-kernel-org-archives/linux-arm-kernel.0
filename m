Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E44C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55184222B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XA5GP+6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55184222B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UbE751EYkSFkqUaTF4UgEsw9J+Robhxb9/oe8xpfkUA=; b=XA5GP+6KmN6D/m
	o2KUesjjAPe3GIhSbCN+ikOmUFbBWNLsMDPZ5usQIiJZRYb88BvwBZ/9lAlFUcrNr4juKGsMebPU9
	N0q7wDjJZf92PzJ5wnTaAQ6z8jwcrSv5Qi8QFlT83UQISZ/ozThlk7Vure/nqXnXdSahKGhtuB6IW
	lvT84W9DWCzI8SYzT7IEP0V/WdjvWe+EM38jCrBuvPXGj0tSbxWoqmV9iSoptxN15MXl11EWLXAv8
	CoND1mbH31udS5JYUZ7ge5YL8ysfzU6NeOpuUio1Z2HBusqMLX5nEuSFcZReFbpiL0Sk3RUPV4xaz
	TuMpL8BC+eihWGw4f+aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtC8m-0005im-Qs; Mon, 11 Feb 2019 14:00:56 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtC8T-0005Qz-Iw
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:00:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C3A27ACB5;
 Mon, 11 Feb 2019 14:00:34 +0000 (UTC)
Date: Mon, 11 Feb 2019 15:00:31 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm: use memblocks_present
Message-ID: <20190211140031.GD15609@dhcp22.suse.cz>
References: <20190211131602.3294-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211131602.3294-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_060037_787865_C5918C20 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 11-02-19 13:04:59, Peng Fan wrote:
> arm_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm/mm/init.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 478ea8b7db87..6c50dd407ba8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
>  
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg)
> -		memory_present(0, memblock_region_memory_base_pfn(reg),
> -			       memblock_region_memory_end_pfn(reg));
> -}
> -#endif
> -
>  static bool arm_memblock_steal_permitted = true;
>  
>  phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> @@ -292,7 +277,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>  	 * so must be done after the fixed reservations
>  	 */
> -	arm_memory_present();
> +	memblocks_present();
>  
>  	/*
>  	 * sparse_init() needs the bootmem allocator up and running.
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
