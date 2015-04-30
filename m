From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 15:16:42 +0000
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <20150430051543.GX6325@pengutronix.de>
References: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
 <20150429185736.GA27777@pengutronix.de>
 <BL2PR03MB370C3AEE0CB1200EDDDD0FE83D70@BL2PR03MB370.namprd03.prod.outlook.com>
 <20150430051543.GX6325@pengutronix.de>
Message-ID: <BL2PR03MB3704B9B39885D8EF1ED141B83D60@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: 2015?4?30? 0:16
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
> independent of SoCs.
> 
> 
> The policy so far is:
> 
> - use the exact SoC name as primary compatible string
> - Use the oldest SoC we *think* is compatible at the time of writing as
>   secondary compatible.
> 
> This way we can always match to the oldest compatible in the driver (Thus i.MX7
> could get a "i.MX6sx" compatible or whatever). Should we realize later that there
> are slight differences between timers that we thought would be identical, then
> we can still change the driver to match against the exact compatible string.
> 
> Whether we use the SoC name or Vxy doesn't matter at all. With Vxy we still
> need to increase the counter with each new SoC since there might be differences
> discovered later. We can't really say for sure that there only four versions of the
> timer, only that by now we have identified four versions. On i.MX we chose to
> match to the SoC name not only for the timer but for all other devices aswell, so
> let's keep it that way.
> 
> That i.MX6q has two different versions of the timer is unfortunate, that needs a
> new compatible string, but whether that is fsl,imx-gpt-v3 or
> fsl,imx6q-gpt-newone again doesn't matter.

As it is a rule, we should follow it. But I don?t' think it is a good idea to bind the SoC name 
with the IP block. It seems even ugly especially in this case. You will have to create a new
string for each new SoC even the IP block has no changes at all. Otherwise, you will 
have to re-use a string containing another SoC's name.


> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
