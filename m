From: shaohui.xie@nxp.com (Shaohui Xie)
Date: Thu, 24 Dec 2015 07:27:22 +0000
Subject: [PATCH] ARM64: dts: add LS1043a-QDS board support
In-Reply-To: <1450935615.18314.125.camel@freescale.com>
References: <1450935037-42930-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <1450935615.18314.125.camel@freescale.com>
Message-ID: <VI1PR04MB1664F592304E4539A1D6DEA5E8E70@VI1PR04MB1664.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Scott Wood [mailto:scottwood at freescale.com]
> Sent: Thursday, December 24, 2015 1:40 PM
> To: Zhiqiang Hou; devicetree at vger.kernel.org; robh+dt at kernel.org;
> mark.rutland at arm.com; pawel.moll at arm.com; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; linux-arm-kernel at lists.infradead.org;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai.Hu at freescale.com; Shaohui.Xie at freescale.com
> Subject: Re: [PATCH] ARM64: dts: add LS1043a-QDS board support
> 
> On Thu, 2015-12-24 at 13:30 +0800, Zhiqiang Hou wrote:
> > +/dts-v1/;
> > +/include/ "fsl-ls1043a.dtsi"
> > +
> > +/ {
> > +	model = "LS1043A QDS Board";
> > +
> 
> compatible?
Hello Scott,

There is Serdes module on some ARM64 SoCs, e.g. LS2080A and LS1043A,
Seems serdes node has not been added in DTS of the two SoCs.

There are serdes nodes on some powerpc SoCs, e.g. t4240si-post.dtsi:

        serdes: serdes at ea000 {
                compatible = "fsl,t4240-serdes";
                reg        = <0xea000 0x4000>;
        };

Could the similar serdes node be added for ARM64 SoCs, like below?

        serdes: serdes at 1ea0000 {
                compatible = "fsl,ls1043a-serdes";
                reg        = <0x1ea0000 0x2000>;
        };

Thanks,
Shaohui
