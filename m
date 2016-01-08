From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2016 15:08:28 +0000
Subject: [PATCH v5 4/6] ARM: debug: add hi3519 debug uart
In-Reply-To: <1452219400-32478-5-git-send-email-xuejiancheng@huawei.com>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-5-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160108150828.GM19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:16:38AM +0800, Jiancheng Xue wrote:
> @@ -1449,6 +1457,7 @@ config DEBUG_UART_PHYS
>  	default 0xf7fc9000 if DEBUG_BERLIN_UART
>  	default 0xf8b00000 if DEBUG_HIX5HD2_UART
>  	default 0xf991e000 if DEBUG_QCOM_UARTDM
> +	default 0x12100000 if DEBUG_HI3519_UART
>  	default 0xfcb00000 if DEBUG_HI3620_UART
>  	default 0xfd883000 if DEBUG_ALPINE_UART0
>  	default 0xfe800000 if ARCH_IOP32X

Please insert at the appropriate location - examination of the list
of defaults will show that it's sorted numerically, please keep this
sorted numerically.

> @@ -1529,6 +1538,7 @@ config DEBUG_UART_VIRT
>  	default 0xfe230000 if DEBUG_PICOXCELL_UART
>  	default 0xfe300000 if DEBUG_BCM_KONA_UART
>  	default 0xfe800000 if ARCH_IOP32X
> +	default 0xfef00000 if DEBUG_HI3519_UART
>  	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HIX5HD2_UART
>  	default 0xfeb24000 if DEBUG_RK3X_UART0
>  	default 0xfeb26000 if DEBUG_RK3X_UART1

Same for here.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
