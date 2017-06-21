From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 21 Jun 2017 07:13:55 +0000
Subject: [PATCH 9/9] clk: imx: add imx7ulp clk driver
In-Reply-To: <20170620204152.GS4493@codeaurora.org>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-10-git-send-email-aisheng.dong@nxp.com>
 <20170620020119.GQ4493@codeaurora.org>
 <20170620094256.GF6805@b29396-OptiPlex-7040>
 <20170620204152.GS4493@codeaurora.org>
Message-ID: <AM3PR04MB3068D246A722A3EAA6652C280DA0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Wednesday, June 21, 2017 4:42 AM
> To: Dong Aisheng
> Cc: A.s. Dong; linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; mturquette at baylibre.com;
> shawnguo at kernel.org; Anson Huang; Jacky Bai
> Subject: Re: [PATCH 9/9] clk: imx: add imx7ulp clk driver
> 
> On 06/20, Dong Aisheng wrote:
> > On Mon, Jun 19, 2017 at 07:01:19PM -0700, Stephen Boyd wrote:
> > >
> > > Any reason why it can't be a platform driver? If not, please add
> > > some comment explaining why.
> > >
> >
> > Timer is using it at early stage. GIC seems not although standard
> > binding claim possible clock requirement.
> > Others still not sure.
> >
> > What your suggestion?
> > Convert timer to platform driver and make clock as platform driver as
> well?
> >
> 
> The timer can't be a platform driver because it would be too late. The
> clock driver could register whatever clks are required for the timer/GIC
> in a CLK_OF_DECLARE_DRIVER hook, and then leave the rest to a platform
> driver. This way we get some of the device driver framework in this code.
> 

Okay, I could try it. Thanks.

One thing is that TPM clock has a lot parents and parents having parents,
as well as PIT timer. So I may need enable more than half clocks in
CLK_OF_DECLARE_DRIVER hook.

BTW, What's benefit to convert into two parts of probe?
I'm not quite if I already get it all, can you help clarify it?

Regards
Dong Aisheng

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project
