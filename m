From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jul 2016 19:29:33 +0100
Subject: [PATCH v3 1/7] firmware: rockchip: sip: Add rockchip SIP runtime
 service
In-Reply-To: <1469178440-4668-2-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
 <1469178440-4668-2-git-send-email-hl@rock-chips.com>
Message-ID: <20160726182933.GA2288@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 05:07:14PM +0800, Lin Huang wrote:
> +config ROCKCHIP_SIP
> +	bool "Rockchip SIP interface"
> +	depends on ARM64 && ARM_PSCI_FW
> +	help
> +	  Say Y here if you want to enable SIP callbacks for Rockchip platforms
> +	  This option enables support for communicating with the ATF.

[...]

> +typedef unsigned long (psci_fn)(unsigned long, unsigned long,
> +				unsigned long, unsigned long);
> +asmlinkage psci_fn __invoke_psci_fn_smc;

Use the SMCCC wrappers (see include/linux/arm-smccc.h).

This is *not* PSCI, even if the same ATF FW provides both services.

NAK for using the PSCI functions.

Thanks,
Mark.
