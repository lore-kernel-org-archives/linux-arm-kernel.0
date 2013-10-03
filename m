From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Oct 2013 08:21:53 +0100
Subject: [PATCH v2] ARM: bcm: Add DEBUG_LL console support
In-Reply-To: <1379462711-6957-1-git-send-email-csd@broadcom.com>
References: <1379462711-6957-1-git-send-email-csd@broadcom.com>
Message-ID: <20131003072153.GE12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 05:05:11PM -0700, Christian Daudt wrote:
> @@ -980,6 +991,7 @@ config DEBUG_UART_PHYS
>  	default 0xffd82340 if ARCH_IOP13XX
>  	default 0xfff36000 if DEBUG_HIGHBANK_UART
>  	default 0xfffff700 if ARCH_IOP33X
> +	default 0x3e000000 if DEBUG_BCM_KONA_UART

Please take a moment to think about this.

>  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>  		DEBUG_UART_8250 || DEBUG_UART_PL01X
>  
> @@ -1035,6 +1047,7 @@ config DEBUG_UART_VIRT
>  	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
>  	default 0xfefff700 if ARCH_IOP33X
>  	default 0xff003000 if DEBUG_U300_UART
> +	default 0xfe300000 if DEBUG_BCM_KONA_UART

And this.

In particular, study the list which you are adding to and see whether
you can spot what you're doing wrong.

Thanks.
