From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 14 Apr 2017 09:30:20 -0700
Subject: [PATCH 5/8] ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6
 variant
In-Reply-To: <20170414155639.GC1792@b29396-OptiPlex-7040>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-6-andrew.smirnov@gmail.com>
 <20170414155639.GC1792@b29396-OptiPlex-7040>
Message-ID: <CAHQ1cqFX=_Np_NetO2dYjUQLXCqu75p7fmPyCQ+-TVYHY9aiXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 8:56 AM, Dong Aisheng <dongas86@gmail.com> wrote:
> On Thu, Apr 13, 2017 at 06:32:39AM -0700, Andrey Smirnov wrote:
>> List GPR block as compatible "fsl,imx6q-iomuxc-gpr" to support drivers
>> requesting it that way (PCIe driver is one example).
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
>>  arch/arm/boot/dts/imx7s.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
>> index 1a7058f..cc23478 100644
>> --- a/arch/arm/boot/dts/imx7s.dtsi
>> +++ b/arch/arm/boot/dts/imx7s.dtsi
>> @@ -491,7 +491,8 @@
>>                       };
>>
>>                       gpr: iomuxc-gpr at 30340000 {
>> -                             compatible = "fsl,imx7d-iomuxc-gpr", "syscon";
>> +                             compatible = "fsl,imx7d-iomuxc-gpr",
>> +                                     "fsl,imx6q-iomuxc-gpr", "syscon";
>
> This looks wrong to me.
> mx7d-iomux-gpr gets a big difference from mx6q-iomux-gpr and mostly
> not compatible.
>

AFAICT, there are no upstream drivers that bind to that string
directly and all of the "consumers" of this node request it as a
syscon device. The only code I could find that does so and that is
shared between i.MX7 and i.MX6Q is i.MX PCIe driver which
distinguishes between variants based on its own compatibility string.

Those two register files are different, true, but I don't think there
are any users who try to use them as if they were the same/compatible.

Thanks,
Andrey Smirnov
