From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 15:13:19 +0000
Subject: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
In-Reply-To: <1425341988-1599-5-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-5-git-send-email-keescook@chromium.org>
Message-ID: <20150309151319.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:19:47PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 248d99cabaa8..e2f0ef9c6ee3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,7 +1,6 @@
>  config ARM
>  	bool
>  	default y
> -	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST

This doesn't mean much on its own...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
