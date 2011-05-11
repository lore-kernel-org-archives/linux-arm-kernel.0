From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 11 May 2011 20:21:32 +0200
Subject: [RFC 1/2] ARM: Tegra: Device Tree Support: Update how sdhci
	devices are initialized
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04986AA0E4@HQMAIL01.nvidia.com>
References: <20110510201108.22693.50319.stgit@riker>
	<20110510201414.22693.7427.stgit@riker>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA06A@HQMAIL01.nvidia.com>
	<BANLkTingm7PCJPC-xCremYg_Ab7qFvPSag@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA077@HQMAIL01.nvidia.com>
	<4DC9BD39.30108@secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA0A6@HQMAIL01.nvidia.com>
	<4DC9CB47.9000900@secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA0E4@HQMAIL01.nvidia.com>
Message-ID: <BANLkTik2JxjT6aNYFOEGB9rg7q2zxC+nig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 7:01 AM, Stephen Warren <swarren@nvidia.com> wrote:
> John Bonesio wrote at Tuesday, May 10, 2011 5:33 PM:
> +static struct tegra_sdhci_platform_data sdhci_pdata1 = {
> + ? ? ? .cd_gpio ? ? ? ?= -1,
> + ? ? ? .wp_gpio ? ? ? ?= -1,
> + ? ? ? .power_gpio ? ? = -1,
> +};
> ...
> + ? ? ? tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
>
> The SDHCI driver has already been updated to get this platform data
> from the OF node in the platform device; it doesn't need hard-coded
> platform data to be passed to it.
>
> Similarly, the following from your I2C patch shouldn't be required:
>
> +static struct tegra_i2c_platform_data harmony_i2c1_platform_data = {
> + ? ? ? .bus_clk_rate ? = 400000,
> +};
> ...
> + ? ? ? tegra_i2c_device1.dev.platform_data = &harmony_i2c1_platform_data;

Correct.  John, you /should/ be able to simply drop the hunk in this
patch that adds platform_data bits.  All you're doing with this patch
is dropping the local declaration of the platform_devices and using
the ones defined in arch/arm/mach-tegra/devices.c.  Setting the
platform_data pointer is not required.

g.
