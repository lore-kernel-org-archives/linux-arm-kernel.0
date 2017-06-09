From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 9 Jun 2017 16:32:09 +0530
Subject: [PATCH] ARM: dts: omap3-overo: Remove "vqmmc-supply" property
 from MMC dt node
In-Reply-To: <CAPDyKFrZvnCPWUxDeewB=BTQPvuMnJ5tUg7CN=VK5=v+e+du4Q@mail.gmail.com>
References: <20170609084141.15582-1-kishon@ti.com>
 <CAPDyKFrZvnCPWUxDeewB=BTQPvuMnJ5tUg7CN=VK5=v+e+du4Q@mail.gmail.com>
Message-ID: <275a0313-2cda-2328-e9e1-32bc91aca701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 09 June 2017 04:07 PM, Ulf Hansson wrote:
> On 9 June 2017 at 10:41, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> commit 94647a30124e2c7 ("ARM: dts: omap3-overo: Enable WiFi/BT combo")
>> while enabling WiFi/BT combo added regulator to trigger the nReset
>> signal of the Bluetooth module in vqmmc-supply. However BT should be
>> handled by UART. Moreover "vqmmc" is not a defined binding for
>> omap_hsmmc. While "vqmmc" in mmc2 hasn't caused any issues so far,
>> mmc2 will start to mis-behave once omap_hsmmc defines "vqmmc"
>> binding.
>>
>> Remove "vqmmc-supply" property in mmc2 here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Okay, so I assume I also need to carry this in my immutable branch for
> the omap driver changes. More precisely before the driver changes?

yeah, that's right!

Thanks
Kishon
