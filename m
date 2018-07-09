From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 09 Jul 2018 15:48:30 -0700
Subject: [PATCH 0/2] Add support for S805X based P241 Reference Design
 board
In-Reply-To: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 5 Jul 2018 11:50:41 +0200")
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hfu0sm3ep.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic P241 board is the Reference Design board for the S805X
> variant of the Amlogic Meson GXL SoC family.
>
> The S805X is a variant of the Amlogic Meson GXL SoC family with the
> following physical limitations :
> - No SDCard interface
> - No GPIOCLK pins
> - No USB OTG ID pin (but Gadget feature can stil be forced)
> - No 5V regulator
> - Reduced ADC inputs (only ADC0 and ADC1)
> - GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
>   GPIOX_15, GPIOH_3 are no more exposed on the package
>
> Amlogic exposes the following SW limitations :
> - HDMI max resolution should be 1080p60, VPU clock should be downgraded
> - Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
> - CPU speed should be limited by SCPI OPP table to 1.2GHz
> - DRAM interface is limited to DDR4 16bit up to 1GiB
>
> The P241 board has the following features :
> - 1GiB DDR4 Memory
> - HDMI Connector with CEC
> - A/V jack with Stereo Audio and CVBS
> - 10/100 Ethernet
> - 2x USB2.0 Type-A
> - On-board WiFi SDIO Module
> - On-board eMMC storage
> - Infraread Received
> - Factory Reset button
> - UART connector

Applied to v4.19/dt64.

The cover letter didn't say, but I assume this was at least boot tested
on a p241 board?

Thanks,

Kevin
