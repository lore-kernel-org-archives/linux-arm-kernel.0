From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Nov 2016 16:39:14 +0100
Subject: [PATCH 1/3] dt-bindings: add power domains to Tegra BPMP firmware
In-Reply-To: <20160719191442.15439-1-swarren@wwwdotorg.org>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
Message-ID: <20161115153914.GA22611@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:14:40PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra186 BPMP is also a provider of power domains. Enhance the device
> tree binding to describe this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> These patches all build on top of Joseph Lo's baseline BPMP binding patches[1]
> and enhance them to represent a few more features of the firmware.
> 
> [1] https://lkml.org/lkml/2016/7/19/280
> "[PATCH V3 01/10] Documentation: dt-bindings: mailbox: tegra: Add binding for HSP mailbox"
> 
>  .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 10 ++++--
>  include/dt-bindings/power/tegra186-powergate.h     | 39 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/power/tegra186-powergate.h

Applied, thanks.

One small comment below...

> diff --git a/include/dt-bindings/power/tegra186-powergate.h b/include/dt-bindings/power/tegra186-powergate.h
> new file mode 100644
> index 000000000000..388d6e228dc8
> --- /dev/null
> +++ b/include/dt-bindings/power/tegra186-powergate.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (c) 2015-2016, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_TEGRA186_POWERGATE_H
> +#define _DT_BINDINGS_POWER_TEGRA186_POWERGATE_H
> +
> +#define TEGRA186_POWER_DOMAIN_AUD	0
> +#define TEGRA186_POWER_DOMAIN_DFD	1
> +#define TEGRA186_POWER_DOMAIN_DISP	2
> +#define TEGRA186_POWER_DOMAIN_DISPB	3
> +#define TEGRA186_POWER_DOMAIN_DISPC	4
> +#define TEGRA186_POWER_DOMAIN_ISPA	5
> +#define TEGRA186_POWER_DOMAIN_NVDEC	6
> +#define TEGRA186_POWER_DOMAIN_NVJPG	7
> +#define TEGRA186_POWER_DOMAIN_MPE	8
> +#define TEGRA186_POWER_DOMAIN_PCX	9
> +#define TEGRA186_POWER_DOMAIN_SAX	10
> +#define TEGRA186_POWER_DOMAIN_VE	11
> +#define TEGRA186_POWER_DOMAIN_VIC	12
> +#define TEGRA186_POWER_DOMAIN_XUSBA	13
> +#define TEGRA186_POWER_DOMAIN_XUSBB	14
> +#define TEGRA186_POWER_DOMAIN_XUSBC	15
> +#define TEGRA186_POWER_DOMAIN_GPU	43
> +#define TEGRA186_POWER_DOMAIN_MAX	44

It's slightly odd that these are named TEGRA186_POWER_DOMAIN_* since
power domain is a Linuxism. All documentation that I've seen calls these
powergates.

I guess since this is now ABI there is not much we can do to rectify it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/23dffb84/attachment.sig>
