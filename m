From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2011 13:56:07 -0800
Subject: [PATCH 08/10] arm/tegra: pinmux tables and definitions for tegra30
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1740D74FA4@HQMAIL01.nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-9-git-send-email-pdeschrijver@nvidia.com>
 <20111118214324.GD31678@quad.lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74FA4@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMh-n9cp1f_tCB7qaFMZ86mXM7WDVkA_hOxf9bb0Z4_XjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 1:51 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Friday, November 18, 2011 2:43 PM:
>> > @@ -667,7 +710,12 @@ void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *co
>> > ?}
>> >
>> > ?static struct of_device_id tegra_pinmux_of_match[] __devinitdata = {
>> > +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>> > ? ? { .compatible = "nvidia,tegra20-pinmux", tegra20_pinmux_init },
>> > +#endif
>> > +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
>> > + ? { .compatible = "nvidia,tegra30-pinmux", tegra30_pinmux_init },
>> > +#endif
>>
>> Again, provide empty stubs instead of ifdeffing the table.
>
> Isn't it better for the driver not to support that compatible flag, rather
> than claiming support, but then not actually working correctly?

Ah, yes, of course. I misread it as one of the scan tables, not used
for probing. Nevermind.


-Olof
