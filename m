From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 27 Oct 2017 17:33:17 +0000
Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
In-Reply-To: <CAK8P3a3ePm25vEnTTLpKAwj_GZf3Hc-VivTJZCvhsH0ivwTMaQ@mail.gmail.com>
References: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
 <CAK8P3a3cyiOgFXAyADH==L=0P621ucp3Xy0F3kBezV5EW9WdDQ@mail.gmail.com>
 <AM4PR0401MB1699CA477F157A2C7618492D8F430@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <20171023011115.GF8700@dragon>
 <CAK8P3a3ePm25vEnTTLpKAwj_GZf3Hc-VivTJZCvhsH0ivwTMaQ@mail.gmail.com>
Message-ID: <AM4PR0401MB16998510F0829600808638A08F5A0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: Friday, October 27, 2017 2:48 AM
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: Leo Li <leoyang.li@nxp.com>; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Roy
> Pledge <roy.pledge@nxp.com>; arm-soc <arm@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Linux
> ARM <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [GIT PULL] updates to soc/fsl drivers for v4.14
> 
> On Mon, Oct 23, 2017 at 1:11 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > Hi Leo,
> >
> > On Fri, Oct 20, 2017 at 10:04:07PM +0000, Leo Li wrote:
> >> > - We should come to an agreement on how we do these in the future.
> >> >   Usually I expect any Freescale/NXP/ARM changes to come through the
> >> >   i.MX maintainers (Shawn and Sascha), not directly from other developers.
> >> >   There is usually some degree of coordination required between the
> >> >   SoC drivers and the DT files and platform code, so it's really best to
> >> >   have someone be aware of all the components, and I prefer to have
> >> >   a smaller number of people sending me pull requests. If you already
> >> >   talked to Shawn about it and he prefers you to send the pull request
> >> >   to us directly, that's fine too, but please at least keep him on Cc.
> >>
> >> I would like to share some more background information on this.  The
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
> 
> I'm obviously aware of your product lines and the differences, it was just a bit
> surprising to get the pull request from you after we had earlier agreed that
> Shawn would help you handle the pull requests for all NXP products, as he did
> with the changes to arch/arm/ (LS1021A) and arch/arm64 for various
> Layerscape products we support (LS1012a, LS1043a, LS1088a, and LS2XXXa so
> far).

My understanding of the previous agreement was that it only covers device tree patches which doesn't need too much detail knowledge of the device itself as long as it follows the existing bindings; while the drivers for on-chip devices are still handled by us (previously Scott Wood) as it requires a lot more knowledge about the device internal.

> 
> Again, this is mostly about clear communication about what I should expect and
> when things change, as long as everybody is ok with the way we do it.

This does help to make it clear, thanks.

- Leo
