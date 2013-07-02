From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Jul 2013 12:11:18 +0100
Subject: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
In-Reply-To: <51D2AEC1.6030004@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
 <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
 <51D2AEC1.6030004@freescale.com>
Message-ID: <20130702111118.GE31358@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 11:43:13AM +0100, Huang Shijie wrote:
> ? 2013?07?02? 17:56, Mark Rutland ??:
> > On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
> >> >  The imx6 uart can supports the DMA, imx uart driver has added a new
> >> >  compatible property for the imx6 uart.
> >> >  
> >> >  In order to enable the DMA for some uart port in imx6, we rename the
> >> >  uart's compatible property to "fsl,imx6-uart".
> > Doesn't this change break using these dts with an older kernel? You
> is it reasonable to use a new dts with an old kernel?

As long as everything required to boot is described in a fashion the old
kernel understands, I see no reason it shouldn't be. I certainly see no
reason to break compatibility with an old kernel by *removing* a
compatible string ("fsl,imx21-uart") that should not break newer
kernels if they choose to use the more-specific compatible string.

> 
> 
> > remove the "fsl,imx21-uart" string older kernels understand.
> >
> > Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" strings,
> > would it not have made more sense to just add these to the driver?
> I think it's not a good idea.

Are there instances of "fsl-imx6q-uart" or "fsl,imx6sl-uart" that aren't
compatible with this new "fsl,imx6-uart" (i.e. are any not DMA capable)?

If not, then using the existing binding gives the same behaviour without
confusing everyone by adding a slightly different compatible string,
without the churn caused by modifying the dts, and the cost to Linux is
a single line. Boards with a pre-built dtb will get the new
functionality by just changing the Linux image.

I don't see what's wrong with this.

Thanks,
Mark.

> 
> Shawn, what's your opinion about this?
> 
> thanks
> Huang Shijie
> 
> 
> 
