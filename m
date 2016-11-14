From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 14 Nov 2016 05:59:01 +0000
Subject: [PATCH v2 1/3] ARM: imx6ull: add imx6ull support
In-Reply-To: <20161114054833.GG3310@dragon>
References: <1478584614-12054-1-git-send-email-peter.chen@nxp.com>
 <1478584614-12054-2-git-send-email-peter.chen@nxp.com>
 <20161114054833.GG3310@dragon>
Message-ID: <HE1PR04MB14509BFD0CBA838BC1EA7D598BBC0@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best regards,
Peter Chen


>-----Original Message-----
>From: Shawn Guo [mailto:shawnguo at kernel.org]
>Sent: Monday, November 14, 2016 1:49 PM
>To: Peter Chen <peter.chen@nxp.com>
>Cc: sboyd at codeaurora.org; mturquette at baylibre.com; linux-arm-
>kernel at lists.infradead.org; kernel at pengutronix.de; devicetree at vger.kernel.org;
>robh+dt at kernel.org; Fabio Estevam <fabio.estevam@nxp.com>;
>mark.rutland at arm.com; linux-clk at vger.kernel.org
>Subject: Re: [PATCH v2 1/3] ARM: imx6ull: add imx6ull support
>
>On Tue, Nov 08, 2016 at 01:56:52PM +0800, Peter Chen wrote:
>> It is the 10th processor in the well-known imx6 series, and derived
>> from imx6ul but cost optimized. The more information about imx6ull can
>> be found at:
>>
>> http://www.nxp.com/products/microcontrollers-and-processors/
>> arm-processors/i.mx-applications-processors/i.mx-6-processors
>> /i.mx6qp/i.mx-6ull-single-core-processor-with-arm-cortex-a7-core
>> :i.MX6ULL
>>
>> In this patch, for SoC part, the imx6ull.dtsi includes imx6ul.dtsi;
>> for board part (imx6ul/imx6ull 14x14 evk), it has a common board file
>> imx6u-14x14-evk.dtsi, and this file is included by both
>> imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts.
>>
>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>  arch/arm/boot/dts/Makefile              |   3 +-
>>  arch/arm/boot/dts/imx6u-14x14-evk.dtsi  | 487
>> ++++++++++++++++++++++++++++++++
>> arch/arm/boot/dts/imx6ul-14x14-evk.dts  | 479
>> +------------------------------
>
>What's the real change between imx6u-14x14-evk.dtsi and imx6ul-14x14-evk.dts?
>Instead of renaming the file, I would like to have imx6ull-14x14-evk.dts include
>imx6ul-14x14-evk.dts directly, if we can work out the difference within imx6ull-
>14x14-evk.dts.
>

The main difference is compatible string, I can't include two compatible strings in one dts file,
the dts build will fail for that.

imx6ull-14x14-evk.dts 
/ {
        model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
        compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
};

imx6ul-14x14-evk.dts 
/ {
        model = "Freescale i.MX6 UltraLite 14x14 EVK Board";
        compatible = "fsl,imx6ul-14x14-evk", "fsl,imx6ul";
};

Peter
