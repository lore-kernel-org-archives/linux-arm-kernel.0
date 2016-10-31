From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 10:02:07 +0000
Subject: [PATCH V4 10/10] arm64: KVM: add guest SEA support
In-Reply-To: <1477071013-29563-11-git-send-email-tbaicar@codeaurora.org>
References: <1477071013-29563-1-git-send-email-tbaicar@codeaurora.org>
 <1477071013-29563-11-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20161031100206.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject line on this patch is misleading - it's not only ARM64
specific...

On Fri, Oct 21, 2016 at 11:30:13AM -0600, Tyler Baicar wrote:
> diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
> index a3d61ad..86e1faa 100644
> --- a/arch/arm/include/asm/system_misc.h
> +++ b/arch/arm/include/asm/system_misc.h
> @@ -24,4 +24,9 @@ extern unsigned int user_debug;
>  
>  #endif /* !__ASSEMBLY__ */
>  
> +inline int handle_guest_sea(unsigned long addr, unsigned int esr)

This needs to be static.

> +{
> +	return -1;
> +}
> +
>  #endif /* __ASM_ARM_SYSTEM_MISC_H */

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
