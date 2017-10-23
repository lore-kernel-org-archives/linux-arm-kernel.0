From: leoyang.li@nxp.com (Leo Li)
Date: Mon, 23 Oct 2017 16:26:36 +0000
Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
In-Reply-To: <20171023011115.GF8700@dragon>
References: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
 <CAK8P3a3cyiOgFXAyADH==L=0P621ucp3Xy0F3kBezV5EW9WdDQ@mail.gmail.com>
 <AM4PR0401MB1699CA477F157A2C7618492D8F430@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <20171023011115.GF8700@dragon>
Message-ID: <AM4PR0401MB1699A6593368BD9657F714A38F460@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Sunday, October 22, 2017 8:11 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Roy
> Pledge <roy.pledge@nxp.com>; arm-soc <arm@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Linux
> ARM <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [GIT PULL] updates to soc/fsl drivers for v4.14
> 
> Hi Leo,
> 
> On Fri, Oct 20, 2017 at 10:04:07PM +0000, Leo Li wrote:
> > > - We should come to an agreement on how we do these in the future.
> > >   Usually I expect any Freescale/NXP/ARM changes to come through the
> > >   i.MX maintainers (Shawn and Sascha), not directly from other developers.
> > >   There is usually some degree of coordination required between the
> > >   SoC drivers and the DT files and platform code, so it's really best to
> > >   have someone be aware of all the components, and I prefer to have
> > >   a smaller number of people sending me pull requests. If you already
> > >   talked to Shawn about it and he prefers you to send the pull request
> > >   to us directly, that's fine too, but please at least keep him on Cc.
> >
> > I would like to share some more background information on this.  The
> microcontroller business(produces i.mx product line) and the networking
> business(produces qoriq product line) are completely two different business
> units within Freescale/NXP.  There are separate hardware design teams and
> software development teams due to the different targeting markets.  The
> hardware design are almost completely different.  Historically, the
> microcontroller product line focused on m68k and armv7 architectures while the
> networking product line focused on PowerPC architecture and recently moved
> to ARMv8 architecture.  There are surely some IP sharing but only on basic
> peripheral devices such as i2c, usb and etc.   But due to the different targeting
> markets most of the peripheral devices are very different.  For example this
> DPAA framework, network interfaces and a lot of other accelerators will never
> be used in the i.mx products.  On the core architecture side we are working on
> SBSA compliance hardware and SBBA compliance software with UEFI and ACPI
> in the picture, which would be a overkill for microcontrollers.    In my opinion,
> the differences between i.MX and QorIQ products could be even bigger than the
> difference between QorIQ products and some server focused ARMv8 SoCs from
> other vendors.  The synergy for combining these two will be very limited.
> >
> 
> I'm fine with you send drivers/soc/fsl changes to Arnd directly, since we already
> have separate folders (drivers/soc/imx vs. drivers/soc/fsl) for i.MX and QorIQ.
> But as Arnd suggested, please keep me on copy, so that I can be aware of the
> changes which might be somehow related to arch/arm64/boot/dts/freescale/
> changes that I'm currently taking care of.  Thanks.

Hi Shawn,

Sure.  I will keep you copied.  Thanks for the understanding.

Regards,
Leo
