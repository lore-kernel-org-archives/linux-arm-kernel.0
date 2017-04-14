From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 14 Apr 2017 08:45:13 -0700
Subject: [PATCH 8/8] ARM: dts: imx7d-sdb: Enable PCIe peripheral
In-Reply-To: <20170414035102.GI14915@dragon>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-9-andrew.smirnov@gmail.com>
 <20170414035102.GI14915@dragon>
Message-ID: <CAHQ1cqFSpEzaEytjJXXdZAxGOdmqH1PSSUkRkjgviJoftWgGww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 8:51 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 06:32:42AM -0700, Andrey Smirnov wrote:
>> Enable PCIe peripheral on this board.
>>
>> Cc: yurovsky at gmail.com
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx7d-sdb.dts | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
>> index e0ff276..f77e26a 100644
>> --- a/arch/arm/boot/dts/imx7d-sdb.dts
>> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
>> @@ -352,6 +352,13 @@
>>       };
>>  };
>>
>> +&pcie {
>> +     pinctrl-names = "default";
>> +     reset-gpio = <&gpio_spi 1 GPIO_ACTIVE_LOW>;
>> +     disable-gpio = <&gpio_spi 0 GPIO_ACTIVE_LOW>;
>
> I do not see this disable-gpio is documented or supported.
>

My bad, didn't notice it when taking the code from downstream tree.
Will remove in v2.

Thanks,
Andrey Smirnov
