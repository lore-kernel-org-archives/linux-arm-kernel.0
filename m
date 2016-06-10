From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 10 Jun 2016 17:10:03 +0200
Subject: [PATCH] ARM: at91: debug: use DEBUG_UART_VIRT
In-Reply-To: <1465313079-6307-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465313079-6307-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160610151003.GD19050@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 at 17:24:39 +0200, Alexandre Belloni wrote :
> AT91 still uses an offset (0x0100 0000) from the physical address to map
> the debug UART. This is unfortunate as for some platforms (sama5d3 and
> earlier), it ends up in the PCI zone and PCI is enabled in multi_v7.
> Switch to DEBUG_UART_VIRT to solve that.
> 
> Tested on sama5d3 and 9g20.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/Kconfig.debug        | 11 ++++++-----
>  arch/arm/include/debug/at91.S | 10 +---------
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
Applied now.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
