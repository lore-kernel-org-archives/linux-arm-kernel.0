From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Mar 2011 09:34:38 -0800
Subject: [PATCH 3/3] ARM: tegra: enable new drivers in defconfig
In-Reply-To: <1299486399-21761-4-git-send-email-olof@lixom.net>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<1299486399-21761-4-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF045687B863@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Monday, March 07, 2011 1:27 AM:
> Enable new platforms and tegra drivers in tegra_defconfig. Also enable
> some of the common devices several platforms, and GUID partition tables
> to make it possible to boot a tegra_defconfig kernel with a ChromiumOS
> filesystem.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
>...
> @@ -78,12 +81,21 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  # CONFIG_LEGACY_PTYS is not set
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C=y
> -# CONFIG_HWMON is not set
> +# CONFIG_I2C_COMPAT is not set
> +# CONFIG_I2C_HELPER_AUTO is not set
> +CONFIG_I2C_TEGRA=y
> +CONFIG_SENSORS_LM90=y

I'm not sure why the LM90 is needed?

-- 
nvpublic
