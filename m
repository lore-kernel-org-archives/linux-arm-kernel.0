From: han.xu@nxp.com (Han Xu)
Date: Thu, 1 Jun 2017 21:14:57 +0000
Subject: [PATCH v3 0/2] ARM: dts: imx7: add NAND support
In-Reply-To: <20170601192044.6548-1-stefan@agner.ch>
References: <20170601192044.6548-1-stefan@agner.ch>
Message-ID: <3c086d95-96e5-71ec-b44f-12ed41903fcf@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/01/2017 02:20 PM, Stefan Agner wrote:
> This are the missing device tree parts to add NAND support for i.MX 7.
> See previous patchset:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2017%2F4%2F21%2F832&data=01%7C01%7Chan.xu%40nxp.com%7C3b9081a68c94476c4a2108d4a9235512%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=mQ2aq5rW%2B9uADY5mSzFxk8P6bAVq%2BosPJQAi0PL9SQg%3D&reserved=0
>
> The previous version also included driver changes, which are already
> merged.
>
> --
> Stefan
>
> Changes since v2:
> - Only specify IMX7D_NAND_USDHC_BUS_ROOT_CLK which seems to be sufficent
Hi Stefan, sorry I didn't reply your last patch. I was unable to fully 
test on i.MX7 since the work bandwidth, but the quick test shows DMA 
cannot work WITHOUT IMX7D_NAND_ROOT_CLK on my side, I will fully check 
it tomorrow morning and let you know the result.
> - Dropped driver changes, alreay merged
>
> Changes since v1:
> - Make clks_count const
> - Introduce IS_IMX7D for i.MX 7 SoC's and make it part of GPMI_IS_MX6
>
> Stefan Agner (2):
>    ARM: dts: imx7: add GPMI NAND
>    ARM: dts: imx7-colibri: add NAND support
>
>   arch/arm/boot/dts/imx7-colibri.dtsi |  9 +++++++++
>   arch/arm/boot/dts/imx7s.dtsi        | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
>
