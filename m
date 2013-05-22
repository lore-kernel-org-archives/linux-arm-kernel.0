From: B45370@freescale.com (Sharma Bhupesh-B45370)
Date: Wed, 22 May 2013 06:54:17 +0000
Subject: [PATCH v3] tty: serial: add Freescale lpuart driver support
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
Message-ID: <A1A6EA40F8503D48BB002B42BD65974E2AC5CF@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Jin Zhengxiong-R64188
> Sent: Wednesday, May 22, 2013 12:10 PM
> To: Shawn Guo; Lu Jingchang-B35083
> Cc: gregkh at linuxfoundation.org; s.hauer at pengutronix.de; linux-arm-
> kernel at lists.infradead.org; linux-serial at vger.kernel.org
> Subject: RE: [PATCH v3] tty: serial: add Freescale lpuart driver support
> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawn.guo at linaro.org]
> > Sent: Monday, May 20, 2013 11:05 AM
> > To: Lu Jingchang-B35083
> > Cc: linux-serial at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org;
> > gregkh at linuxfoundation.org; s.hauer at pengutronix.de
> > Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver
> > support
> >
> > On Thu, May 16, 2013 at 02:18:15PM +0800, Jingchang Lu wrote:
> > > Add Freescale lpuart driver support. The lpuart device can be
> > > founded on Vybrid MVF600 and Layerscape LS-1 SoCs.
> > >
> > > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > > ---
> > > v3:
> > >   change the uart driver name from mvf to lpuart for further share
> > between SoCs.
> >
> > I do not think it's going to be a problem to name the IP with mvf
> > family name even though it will be used on LS-1 too.  That can simply
> > telling the history that the IP is firstly used on mvf family and then
> > get reused on LS-1.  But I'm fine you name the driver in a generic
> > way, purely using the IP name, if you feel like to do that strongly ...
> >
> [Jason Jin-R64188] Reuse the same LPUART on LS-1 with the compatible
> strings 'fsl,mvf600-lpuart' is technically OK, But it will fuss the route
> map of the product Line. The general name can show that the IP is shared
> between several product lines, and the history for which SOC firstly used
> the IP is not very important. With general compatible name, We can setup
> the general dts for the shared IPs.
> 
> That's also the case for the IPs used on Power platform, Take the IFC for
> example, this IP implemented on Power platform will also be reused LS-1,
> The compatible string is set as  "fsl,ifc", "simple-bus" but not the soc
> name on which the IP first used.
> 
>  Another example, though a little different, the nor flash driver, which
> is used for many platform, the compatible "cfi-flash" will be more
> reasonable than the soc/board name.
> 
> With the general name for the compatible string in the driver, if there
> is minor difference for the different implementation of the same IP, we
> can add the soc related compatible string to the driver to pass different
> .data structure for that soc.
> 
> Jason
> 

It's better to use the generic name lpuart in the compatible string as it provides
much closer association with the lpuart driver which can be generic across SoCs.

As Jason pointed out, minor differences in IP implementation across SoCs can be
handled by passing the soc related compatible string.

Regards,
Bhupesh
