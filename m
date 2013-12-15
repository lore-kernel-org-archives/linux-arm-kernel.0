From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 15 Dec 2013 23:01:17 +0100
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <20131215134415.GE3651@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
Message-ID: <CAOMqctRspBPmNsyXye_gpfwGoZ=gMcCzEjM+hD3g+ZfQix7G6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 December 2013 14:44, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -665,3 +665,11 @@ config MMC_REALTEK_PCI
>>       help
>>         Say Y here to include driver code to support SD/MMC card interface
>>         of Realtek PCI-E card reader
>> +
>> +config MMC_SUNXI
>> +     tristate "Allwinner sunxi SD/MMC Host Controller support"
>> +     depends on ARCH_SUNXI
>> +     default y
>
> I'm not that fond of these "default y" patterns. It forces the driver
> down to every user of the multiplatform kernels. I'd suggest removing
> the default and adding the driver to the defconfigs we have.

And why would you build support for sunxi without building support for
sunxi mmc?

Like 90%+ sunxi devices actually have a SD slot or an eMMC or a SDIO
card connected so what's the point of supporting sunxi without sunxi
mmc?

Thanks

Michal
