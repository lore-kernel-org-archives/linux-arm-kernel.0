From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Jan 2012 17:26:05 -0800
Subject: [PATCH v2] arm/tegra: emc: device tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F182F@HQMAIL01.nvidia.com>
References: <1324599468-12845-10-git-send-email-olof@lixom.net>
 <1325743338-2533-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F182F@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMhwTuiJJC=sO8MkFtfkaA=OAxxNXGkPs5av27bLzVJxBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 2:35 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, January 04, 2012 11:02 PM:
>> Add device tree support to the emc driver, filling in the platform data
>> based on the DT bindings.
>>
>> Changes since v1:
>>
>> * Unmangled some messed up patch squashes, moving changes to earlier patches
>> * Flipped an of_property_read_u32 return value test
>> * Clarified clock settings message on case where no table is provided
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
> ...
>> diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
> ...
>> +static struct tegra_emc_pdata __devinit *tegra_emc_fill_pdata(struct platform_device *pdev)
> ...
>> + ? ? pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> + ? ? pdata->tables = devm_kzalloc(&pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(struct tegra_emc_table),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?GFP_KERNEL);
>
> You could convert that one to sizeof(*pdata->tables) too, although feel
> free to ignore this picky comment, or fix it up when you apply the change.
>
> Otherwise,
>
> Acked-by: Stephen Warren <swarren@nvidia.com>


Done, thanks.

-Olof
