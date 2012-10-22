From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 13:38:01 -0700
Subject: [PATCH] ARM/dts: omap3: Fix mcbsp2/3 hwmods to be able to
 probe the drivers for audio
In-Reply-To: <508530CE.9000703@ti.com>
References: <1350552307-10226-1-git-send-email-peter.ujfalusi@ti.com>
 <507FD32C.7010108@ti.com> <508530CE.9000703@ti.com>
Message-ID: <20121022203800.GH4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* P?ter Ujfalusi <peter.ujfalusi@ti.com> [121022 04:42]:
> Hi Tony,
> 
> On 10/18/2012 12:00 PM, Benoit Cousson wrote:
> > On 10/18/2012 11:25 AM, Peter Ujfalusi wrote:
> >> Fixes the following errors:
> >> [    2.318084] omap-mcbsp 49022000.mcbsp: invalid rx DMA channel
> >> [    2.324432] omap-mcbsp 49024000.mcbsp: invalid rx DMA channel
> >>
> >> Which is because we failed to link the sidetone hwmod for McBSP2/3. The
> >> missing sidetone hwmod link will prevent omap_device_alloc() to append the
> >> DMA resources since we - accidentally - end up having the same number of
> >> resources provided from DT (IO/IRQ) as we have in hwmod for the McBSP ports
> >> without the ST resources.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Acked-by: Benoit Cousson <b-cousson@ti.com>
> 
> Can you take this patch for -rc3?

Thanks will apply into omap-for-v3.7-rc2/fixes.

Regards,

Tony
