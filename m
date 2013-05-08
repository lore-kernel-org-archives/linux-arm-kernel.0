From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 22:38:21 +0800
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851B455F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-2-git-send-email-b35083@freescale.com>
 <20130503074105.GA31873@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851B455F@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20130508143819.GE26072@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 07:26:04AM +0000, Lu Jingchang-B35083 wrote:
> >If mvf600 uses the same wdt IP block as imx, we should make this restart
> >routine a common function to be used on mvf600, imx6q and imx6sl etc.
> >
> [Lu Jingchang-B35083] 
>     Do you have plan to update the mxc_restart() function in system.c?

Yes, I plan to update it to support DT platforms.

> We once used that common function for mvf600. But now this function cannot be used for mvf600 as the new clock framwork used.
>     On the other hand, even we udpated the clk_get for the the common mxc_restart() funciton. different with i.MX6, the MVF600 need to enable the clock before using the wdt module, we still need some clue code for i.mx and mvf600. So I suggest keep the restart function for mvf600 currently. Thanks.
> 
Ok, you can keep it for mvf600 and I will consolidate it to use
mxc_restart() later.  But please make the compatible looks like the
following, so that mxc_restart() will look for "fsl,imx21-wdt" to find
the node in device tree.

	compatible = "fsl,mvf600-wdt", "fsl,imx21-wdt"

Shawn
