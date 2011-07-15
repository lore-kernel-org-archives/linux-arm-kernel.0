From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 15 Jul 2011 10:30:42 -0700
Subject: [PATCH 2/3] ARM: tegra: paz00: export the WIFI rfkill gpio
In-Reply-To: <4E2077EC.1070902@ru.mvista.com>
References: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
	<1310725464-2524-3-git-send-email-marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049E834C2F@HQMAIL01.nvidia.com>
	<4E2077EC.1070902@ru.mvista.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E834C57@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote at Friday, July 15, 2011 11:25 AM:
> Stephen Warren wrote:
> 
> >> This makes the WIFI rfkill gpio available to userspace. On boot,
> >> WIFI will be unblocked by default.
> > ...
> >> +static void __init paz00_wifi_init(void)
> >> +{
> >> +	int ret;
> >> +
> >> +	/* unlock hw rfkill */
> >> +	ret = gpio_request_one(TEGRA_WIFI_PWRN, GPIOF_OUT_INIT_HIGH,
> >> +		"wifi pwrn");
> >> +	if (ret) {
> >> +		pr_warning("WIFI: could not requestrfkill gpio\n");
> >> +		return;
> >> +	}
> >> +	gpio_export(TEGRA_WIFI_PWRN, 0);
> >> +};
> >
> > Wouldn't you want to skip the gpio_export() call if the gpio_request()
> > call failed?
> 
>     I think that's what he does -- there's a *return* statement.

D'oh. There is indeed. For some reason I only noticed the warning call.
I guess I suck at reviews:-(

-- 
nvpublic
