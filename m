From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 21:26:49 +0000
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
Message-ID: <201210262126.49201.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 October 2012, dinguyen at altera.com wrote:
>  ENTRY(secondary_trampoline)
> +#if __LINUX_ARM_ARCH__ >= 7
>         movw    r0, #:lower16:CPU1_START_ADDR
>         movt  r0, #:upper16:CPU1_START_ADDR
> +#endif

I don't think this is the right fix, because it will break
running on SMP socfpga machines if you enable both socfpga
and picoxcell in a multiplatform configuration.

	Arnd
