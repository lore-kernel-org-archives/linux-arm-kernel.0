From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Oct 2012 16:22:59 -0600
Subject: [PATCH 1/7] ARM: tegra: cpuidle: separate cpuidle driver for
 different chips
In-Reply-To: <1349691981-31038-2-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-2-git-send-email-josephl@nvidia.com>
Message-ID: <5074A3C3.1080006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 04:26 AM, Joseph Lo wrote:
> The different Tegra chips may have different CPU idle states and data.
> Individual CPU idle driver make it more easy to maintain.

> diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> similarity index 72%
> copy from arch/arm/mach-tegra/cpuidle.c
> copy to arch/arm/mach-tegra/cpuidle-tegra20.c
> index 4e0b07c..e2fc26a 100644
> --- a/arch/arm/mach-tegra/cpuidle.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> @@ -1,24 +1,22 @@
>  /*
> - * arch/arm/mach-tegra/cpuidle.c
> + * CPU idle driver for Tegra20 CPUs
>   *
> - * CPU idle driver for Tegra CPUs
> - *
> - * Copyright (c) 2010-2012, NVIDIA Corporation.
> + * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
>   * Copyright (c) 2011 Google, Inc.
>   * Author: Colin Cross <ccross@android.com>
>   *         Gary King <gking@nvidia.com>
>   *
> - * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
>   *
>   * This program is distributed in the hope that it will be useful, but WITHOUT
>   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>   * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */

While that is the correct (c) header for new work submitted upstream,
given this file is existing, just renamed and tweaked a bit, I don't
believe you want to be changing the (c) header at all. Same for
cpuidle-tegra30.c.
