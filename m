From: Minghuan.Lian@freescale.com (Lian M.H.)
Date: Thu, 10 Sep 2015 01:52:59 +0000
Subject: [PATCH v2 04/10] doc/bindings: Update PCIe devicetree binding
 documentation for LS2080A
In-Reply-To: <CADRPPNRekyv3dSEroh-n2e6p5nV7Q6tAW1VKHWn=Gqnc+MSs+g@mail.gmail.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <80094129.LHZFOe1ZPU@wuerfel>
 <CADRPPNR-cSSQC5sLMmoqcxX46J6hdULa_V4v2BK7T8s8pcX0cg@mail.gmail.com>
 <5383634.Mln7J3sdWP@wuerfel>
 <CADRPPNRekyv3dSEroh-n2e6p5nV7Q6tAW1VKHWn=Gqnc+MSs+g@mail.gmail.com>
Message-ID: <DM2PR0301MB064012F20C5AF07E71EECF1EE2510@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo and Bergmann,

Please see my comments inline.

> -----Original Message-----
> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com] On Behalf Of Li Yang
> Sent: Thursday, September 10, 2015 7:50 AM
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Mark
> Rutland <mark.rutland@arm.com>; Sharma Bhupesh-B45370
> <bhupesh.sharma@freescale.com>; Catalin.Marinas at arm.com;
> olof at lixom.net; will.deacon at arm.com; Lian Minghuan-B31939
> <Minghuan.Lian@freescale.com>; marc.zyngier at arm.com; Bhupesh SHARMA
> <bhupesh.linux@gmail.com>; linux-clk at vger.kernel.org
> Subject: Re: [PATCH v2 04/10] doc/bindings: Update PCIe devicetree binding
> documentation for LS2080A
> 
> On Wed, Sep 9, 2015 at 4:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 08 September 2015 15:06:16 Li Yang wrote:
> >> On Mon, Sep 7, 2015 at 6:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Friday 04 September 2015 12:27:46 Bhupesh Sharma wrote:
> >> >> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis
> >> >> Designware PCIe IP  and thus inherits all the common properties
> defined in designware-pcie.txt.
> >> >>
> >> >>  Required properties:
> >> >> -- compatible: should contain the platform identifier such as
> "fsl,ls1021a-pcie"
> >> >> +- compatible: should contain the platform identifier such as
> >> >> +"fsl,ls1021a-pcie",
> >> >> +  "fsl,ls2080a-pcie".
> >> >>  - reg: base addresses and lengths of the PCIe controller
> >> >>  - interrupts: A list of interrupt outputs of the controller. Must contain
> an
> >> >>    entry for each entry in the interrupt-names property.
> >> >>
> >> >
> >> > Are the two PCIe hosts mutually compatible? If they are, you should
> >> > mandate one of the strings as the base model for identification,
> >> > with the additional model being optional for identification of the specific
> SoC.
> >>
> >> It seems that controllers on these chips are not exactly the same.
> >> They will get different driver data by matching the compatible
> >> strings.  Probably we could define a more generic compatible string,
> >> such as "fsl,layerscape-pcie" or "fsl,ls-pcie".
> >>
> >> >
> >> > It would also be good to add a string with the specific version
> >> > number of the designware PCIe block that is being used there.
> >>
> >> The binding has mentioned to reference the designware-pcie.txt.  But
> >> it might be more clear to mention the designware compatible string
> >> "snps,dw-pcie" again in the compatible part.  Currently there is no
> >> version number defined in the designware-pcie binding.  It might be
> >> hard to get this information for some SoCs.
> >
> > For most of them, the information is available and then it should be
> > added. Obviously if you can't find it out, it's hard to guess and you
> > have to leave it out for that particular chip.
> 
> Actually I don't know any approach to get the version number of the
> designware block used.  Maybe they are actually using the same version of
> the IP block, and the differences in the driver are actually caused by the
> differences in SoC integration.
> 
> >
> > A lot of devices also have some internal version register that you can
> > read out.
> 
> There doesn't seem to be this kind of register for the PCIe block.
> 
[Lian Minghuan-B31939]  Yes. There is no register to show PCIe block version according to reference manual.
I agree that differences in the driver are caused by the differences in SoC integration.

> Minghuan,
> 
> Please correct me if you know more. :)
> 
> Regards,
> Leo
