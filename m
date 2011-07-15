From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 15 Jul 2011 21:25:00 +0400
Subject: [PATCH 2/3] ARM: tegra: paz00: export the WIFI rfkill gpio
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049E834C2F@HQMAIL01.nvidia.com>
References: <1310725464-2524-1-git-send-email-marvin24@gmx.de>	<1310725464-2524-3-git-send-email-marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049E834C2F@HQMAIL01.nvidia.com>
Message-ID: <4E2077EC.1070902@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Stephen Warren wrote:

>> This makes the WIFI rfkill gpio available to userspace. On boot,
>> WIFI will be unblocked by default.
> ...
>> +static void __init paz00_wifi_init(void)
>> +{
>> +	int ret;
>> +
>> +	/* unlock hw rfkill */
>> +	ret = gpio_request_one(TEGRA_WIFI_PWRN, GPIOF_OUT_INIT_HIGH,
>> +		"wifi pwrn");
>> +	if (ret) {
>> +		pr_warning("WIFI: could not requestrfkill gpio\n");
>> +		return;
>> +	}
>> +	gpio_export(TEGRA_WIFI_PWRN, 0);
>> +};
> 
> Wouldn't you want to skip the gpio_export() call if the gpio_request()
> call failed?

    I think that's what he does -- there's a *return* statement.

WBR, Sergei
