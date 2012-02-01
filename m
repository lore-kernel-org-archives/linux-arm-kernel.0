From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2012 23:54:48 -0800
Subject: [PATCH v2 3/8] ARM: tegra: rework Tegra secondary CPU core bringup
In-Reply-To: <1328028051-24271-4-git-send-email-pdeschrijver@nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <1328028051-24271-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120201075448.GI7399@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 06:40:41PM +0200, Peter De Schrijver wrote:

> +	.align L1_CACHE_SHIFT
> +	.type	__tegra_cpu_reset_handler_data, %object
> +	.globl	__tegra_cpu_reset_handler_data
> +__tegra_cpu_reset_handler_data:
> +	.rept	TEGRA_RESET_DATA_SIZE
> +	.long	0
> +	.endr
> +	.size	__tegra_cpu_reset_handler_data, .-tegra_cpu_reset_handler_data
> +	.align L1_CACHE_SHIFT
> +

This doesn't build:

/tmp/ccPd4Pcj.s: Assembler messages:
/tmp/ccPd4Pcj.s: Error: .size expression for __tegra_cpu_reset_handler_data does not evaluate to a constant

Did you mean .-__tegra_cpu_reset_handler_data there?

-Olof
