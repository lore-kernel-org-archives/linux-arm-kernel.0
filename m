From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 10 Oct 2011 14:44:02 +0400
Subject: [PATCH v2 10/14] ARM: tegra: tegra_powergate_is_powered should
	be static
In-Reply-To: <1318224484-2090-11-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
	<1318224484-2090-11-git-send-email-olof@lixom.net>
Message-ID: <4E92CC72.3030809@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-10-2011 9:28, Olof Johansson wrote:

> Not exported and not used externally.

> Also, fix return type  and change to instead WARN_ON on bad parameters.

    Change to what? You're changing _to_ WARN_ON() as we can see, not from it...

> Signed-off-by: Olof Johansson<olof@lixom.net>
> ---
>   arch/arm/mach-tegra/include/mach/powergate.h |    1 -
>   arch/arm/mach-tegra/powergate.c              |    5 ++---
>   2 files changed, 2 insertions(+), 4 deletions(-)

[...]
> diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
> index 3cee9aa..9483064 100644
> --- a/arch/arm/mach-tegra/powergate.c
> +++ b/arch/arm/mach-tegra/powergate.c
> @@ -89,12 +89,11 @@ int tegra_powergate_power_off(int id)
>   	return tegra_powergate_set(id, false);
>   }
>
> -bool tegra_powergate_is_powered(int id)
> +static bool tegra_powergate_is_powered(int id)
>   {
>   	u32 status;
>
> -	if (id < 0 || id >= TEGRA_NUM_POWERGATE)
> -		return -EINVAL;
> +	WARN_ON(id<  0 || id>= TEGRA_NUM_POWERGATE);
>
>   	status = pmc_read(PWRGATE_STATUS)&  (1<<  id);
>   	return !!status;

WBR, Sergei
