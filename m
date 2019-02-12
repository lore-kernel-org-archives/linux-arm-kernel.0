Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E3E20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tqk6SgRz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ke2HFn5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E3E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vpKQqVokTWc89/Xw2iAK6FrcNNLbl68w3SngnXJ93mo=; b=Tqk6SgRz8g77ZR
	0SFx6nSxMI0eONLpVCO4fz/Adx+DnhrEGM1xB4r0N670U74DqfOSm1I5pmy0wpI0iC2ix8WZp5wTA
	SxiiiCG5fbFMF0C6SMm5j+UOb8SmS5iyC1psIeRSGn/c6ByqZEUHesOmkUZ+/6hQF8iaggedVJd3y
	yYN3u2STVTgB6dkoqCBwyNnWwIaH8b2fNNCU1nF+ko7UHV9CKnY5upewtw2vqWWbplEhf71Wnxr3E
	iLCOUYJ6M/EAj3PP83kSDMUWn0zvfGjWJWP8F/xeM9WwuYUOho5FrGPdl4t3SOawBDtL6uL5AMJ9U
	CcIlSlBHegaThLCivkQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbsB-0000Be-1o; Tue, 12 Feb 2019 17:29:31 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbs6-0008Kr-FI
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:29:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qRPk2mO4HOuqi7gK96QPC0khLRra82LJpcTGMdunHM=; b=ke2HFn5EBlrR1+QlpbpRQYPJX
 Tr1oZjA51fxrk9hvsf6bSTpPgOiEAjbueMvlz+5K6/BLKQY2LUbFCAZxyrnT2AkSmOa5+/rOrfgbS
 SpayKvqMFhh8nGJJ4RMyCsp+1SRULJQ84hhRAF3w7a4cnJy+Xot7Q8Me/Vfau68BCl97Q=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36728)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gtbps-0006uu-8q; Tue, 12 Feb 2019 17:27:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gtbpl-0002C3-0Q; Tue, 12 Feb 2019 17:27:01 +0000
Date: Tue, 12 Feb 2019 17:27:00 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm: use memblocks_present
Message-ID: <20190212172700.xwtomhb3qahyxugx@shell.armlinux.org.uk>
References: <20190211131602.3294-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211131602.3294-1-peng.fan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_092926_709178_A12906CC 
X-CRM114-Status: GOOD (  15.09  )
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
 "robh@kernel.org" <robh@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 01:04:59PM +0000, Peng Fan wrote:
> arm_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks good, please put it in the patch system, thanks.  Details in
my signature.

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
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
