From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Oct 2012 09:59:05 -0600
Subject: [PATCH 3/5] ARM: tegra: fix clock entry of slink controller
In-Reply-To: <508119CE.9070408@nvidia.com>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-4-git-send-email-ldewangan@nvidia.com>
 <5080862C.9030203@wwwdotorg.org> <508119CE.9070408@nvidia.com>
Message-ID: <508178C9.9090504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2012 03:13 AM, Laxman Dewangan wrote:
> On Friday 19 October 2012 04:13 AM, Stephen Warren wrote:

>>> +    OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK1_BASE,
>>> "spi-tegra-slink.0", NULL),
>> Here, can't we just use the existing device names in the clock files...
>>
>> So we can completely drop the changes to these two files:
>
> I want to name the driver as spi-tegra-slink. When we add the sflash spi
> driver for tegra20, the driver name will be spi-tegra-sflash.
> Also current name is "spi_tegra" I do not want to name with "_". So it
> is require to convert as "-".

The driver name is whatever you put into the driver file. The AUXDATA
only affects the device name. There should be no conflict with the
"sflash" driver, since that clock is set up to expect driver name "spi"
which doesn't conflict with "spi_tegra.*".

So, there's really no point in churning the clock names any more,
especially since it's temporary. If you feel strongly about this, the
best thing to do is help push Tegra's support of DT clock bindings forward.
