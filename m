From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Sep 2011 10:34:27 -0700
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
Message-ID: <4E723723.2030609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/11 14:41, Will Deacon wrote:
> +choice
> +	prompt "Kernel low-level debugging port"
> +	depends on DEBUG_LL
> +
> +	config DEBUG_DC21285_PORT
> +		bool "Kernel low-level debugging messages via footbridge serial port"
> +		depends on FOOTBRIDGE
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the serial port in the DC21285 (Footbridge).
> +		  Saying N will cause the debug messages to appear on the first
> +		  16550 serial port.
> +
> +	config DEBUG_CLPS711X_UART2
> +		bool "Kernel low-level debugging messages via UART2"
> +		depends on ARCH_CLPS711X
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the second serial port on these devices.
> +		  Saying N will cause the debug messages to appear on the first
> +		  serial port.

How would I unselect this UART2 config to get serial output on UART1? As
far as I can tell there isn't an option for NONE in a choice menu.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
