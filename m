From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 20 Oct 2017 22:04:07 +0000
Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
In-Reply-To: <CAK8P3a3cyiOgFXAyADH==L=0P621ucp3Xy0F3kBezV5EW9WdDQ@mail.gmail.com>
References: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
 <CAK8P3a3cyiOgFXAyADH==L=0P621ucp3Xy0F3kBezV5EW9WdDQ@mail.gmail.com>
Message-ID: <AM4PR0401MB1699CA477F157A2C7618492D8F430@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: Friday, October 20, 2017 4:02 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm-soc <arm@kernel.org>; Linux ARM <linux-arm-
> kernel at lists.infradead.org>; Catalin Marinas <catalin.marinas@arm.com>; Roy
> Pledge <roy.pledge@nxp.com>; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>
> Subject: Re: [GIT PULL] updates to soc/fsl drivers for v4.14
> 
> On Fri, Sep 22, 2017 at 9:37 PM, Li Yang <leoyang.li@nxp.com> wrote:
> > Hi arm-soc maintainers,
> >
> > This pull request includes updates to the QMAN/BMAN drivers to make
> > them work on the arm/arm64 architectures in addition to the power
> > architecture and a few minor update/bug-fix to the soc/fsl drivers.
> >
> > We got the Reviewed-by from Catalin on the ARM architecture side.
> >
> > DPAA (Data Path Acceleration Architecture) is a set of hardware
> > components used on some FSL/NXP QorIQ Networking SoCs, it provides the
> > infrastructure to support simplified sharing of networking interfaces
> > and accelerators by multiple CPU cores, and the accelerators
> > themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
> > infrastructural components within the DPAA framework.  They are used
> > to manage queues and buffers for various I/O interfaces, hardware
> > accelerators.
> >
> > More information can be found via link:
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> > nxp.com%2Fproducts%2Fmicrocontrollers-and-processors%2Fpower-architect
> > ure-processors%2Fqoriq-platforms%2Fdata-path-
> acceleration%3AQORIQ_DPAA
> >
> &data=01%7C01%7Cleoyang.li%40nxp.com%7Cf061078c92744067077808d517f
> dcb6
> >
> 2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=ffs5czr8VeyjFb6PFnIAc
> iZ
> > W0S4GWvk7G9YeB0oJ404%3D&reserved=0
> 
> Hi Leo,
> 
> Sorry for the long delay in processing this. I've pulled the branch into our
> next/drivers branch now, after taking another look at the contents.
> The code looks fine to me in this version, but I have  a couple of comments
> about the submission:

Hi Arnd,

Thanks for the effort for reviewing the patches and merge them.

> 
> - We should come to an agreement on how we do these in the future.
>   Usually I expect any Freescale/NXP/ARM changes to come through the
>   i.MX maintainers (Shawn and Sascha), not directly from other developers.
>   There is usually some degree of coordination required between the
>   SoC drivers and the DT files and platform code, so it's really best to
>   have someone be aware of all the components, and I prefer to have
>   a smaller number of people sending me pull requests. If you already
>   talked to Shawn about it and he prefers you to send the pull request
>   to us directly, that's fine too, but please at least keep him on Cc.

I would like to share some more background information on this.  The microcontroller business(produces i.mx product line) and the networking business(produces qoriq product line) are completely two different business units within Freescale/NXP.  There are separate hardware design teams and software development teams due to the different targeting markets.  The hardware design are almost completely different.  Historically, the microcontroller product line focused on m68k and armv7 architectures while the networking product line focused on PowerPC architecture and recently moved to ARMv8 architecture.  There are surely some IP sharing but only on basic peripheral devices such as i2c, usb and etc.   But due to the different targeting markets most of the peripheral devices are very different.  For example this DPAA framework, network interfaces and a lot of other accelerators will never be used in the i.mx products.  On the core architecture side we are working on SBSA compliance hardware and SBBA compliance software with UEFI and ACPI in the picture, which would be a overkill for microcontrollers.    In my opinion, the differences between i.MX and QorIQ products could be even bigger than the difference between QorIQ products and some server focused ARMv8 SoCs from other vendors.  The synergy for combining these two will be very limited.

> 
> - You have a very nice detailed description of the contents above,
>    but the signed tag only has a single line saying 'This adds the
>    DPAA QBMan support for ARM SoCs and a few minor fixes/updates'.
>    I decided to just take your long description as the merge commit
>    since it explains the contents better. It would be good to have
>    a long description like that in the tag next time to keep it in the
>    git history.

Thanks for extra effort.  I will keep the long description also in the pull request next time.

Regards,
Leo
