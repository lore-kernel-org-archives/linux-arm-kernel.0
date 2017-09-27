From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Wed, 27 Sep 2017 10:40:57 +0000
Subject: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
In-Reply-To: <AM5PR0401MB2545129D07EE9263BA4D16DA9A970@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1504171424-15536-1-git-send-email-Bharat.Bhushan@nxp.com>
 <06c57ca4-edaa-df26-b1d9-1906141c5065@arm.com>
 <AM5PR0401MB2545B7C55F634D7B9CABAE629A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <10be1849-8071-64fc-5ee2-b6e429c64b9e@arm.com>
 <AM5PR0401MB2545043022CAE0CDECA6267E9A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <AM5PR0401MB2545BB069D90520FFE9CD3499A920@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <901dee07-d1ee-63cc-59a0-bdf37cd7d937@arm.com>
 <AM5PR0401MB2545129D07EE9263BA4D16DA9A970@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Message-ID: <AM5PR0401MB2545F32CF49FB1CDAAA997AC9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Bharat Bhushan
> Sent: Wednesday, September 06, 2017 12:47 PM
> To: Robin Murphy <robin.murphy@arm.com>; Marc Zyngier
> <marc.zyngier@arm.com>; robh+dt at kernel.org; Mark Rutland
> <mark.rutland@arm.com>; will.deacon at arm.com; oss at buserror.net; Gang
> Liu <gang.liu@nxp.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> catalin.marinas at arm.com
> Subject: RE: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
> 
> Hi Robin,
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy at arm.com]
> > Sent: Friday, September 01, 2017 4:29 PM
> > To: Bharat Bhushan <bharat.bhushan@nxp.com>; Marc Zyngier
> > <marc.zyngier@arm.com>; robh+dt at kernel.org; Mark Rutland
> > <mark.rutland@arm.com>; will.deacon at arm.com; oss at buserror.net;
> Gang
> > Liu <gang.liu@nxp.com>; devicetree at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > catalin.marinas at arm.com
> > Subject: Re: [PATCH] RM64: dts: ls208xa: Add iommu-map property for
> > pci
> >
> > On 01/09/17 11:13, Bharat Bhushan wrote:
> > >
> > >
> > >> -----Original Message----- From: linux-kernel-owner at vger.kernel.org
> > >> [mailto:linux-kernel- owner at vger.kernel.org] On Behalf Of Bharat
> > >> Bhushan Sent: Thursday, August 31, 2017 4:53 PM To: Marc Zyngier
> > >> <marc.zyngier@arm.com>; robh+dt at kernel.org; Mark Rutland
> > >> <mark.rutland@arm.com>; will.deacon at arm.com; oss at buserror.net;
> > Gang
> > >> Liu <gang.liu@nxp.com>; devicetree at vger.kernel.org;
> > >> linux-arm-kernel at lists.infradead.org; linux-
> > >> kernel at vger.kernel.org; catalin.marinas at arm.com Subject: RE:
> > >> [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
> > >>
> > >>
> > >>
> > >>> -----Original Message----- From: Marc Zyngier
> > >>> [mailto:marc.zyngier at arm.com] Sent: Thursday, August 31, 2017
> > >>> 4:20 PM To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > >>> robh+dt at kernel.org;
> > >> Mark
> > >>> Rutland <mark.rutland@arm.com>; will.deacon at arm.com;
> > >> oss at buserror.net;
> > >>> Gang Liu <gang.liu@nxp.com>; devicetree at vger.kernel.org;
> > >>> linux-arm-kernel at lists.infradead.org; linux-
> > >>> kernel at vger.kernel.org; catalin.marinas at arm.com Subject: Re:
> > >>> [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
> > >>>
> > >>> [Fixing Mark's address...]
> > >>>
> > >>> On 31/08/17 11:41, Bharat Bhushan wrote:
> > >>>>
> > >>>>> -----Original Message----- From: Marc Zyngier
> > >>>>> [mailto:marc.zyngier at arm.com] Sent: Thursday, August 31, 2017
> > >>>>> 3:02 PM To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > >>>>> robh+dt at kernel.org; ark.rutland at arm.com; will.deacon at arm.com;
> > >>>>> oss at buserror.net; Gang
> > >>> Liu
> > >>>>> <gang.liu@nxp.com>; devicetree at vger.kernel.org; linux-arm-
> > >>>>> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > >>>>> catalin.marinas at arm.com Subject: Re: [PATCH] RM64: dts:
> > >>>>> ls208xa: Add iommu-map property for pci
> > >>>>>
> > >>>>> On 31/08/17 10:23, Bharat Bhushan wrote:
> > >>>>>> This patch adds iommu-map property for PCIe, which enables
> > SMMU
> > >>>>>> for these devices on LS208xA devices.
> > >>>>>>
> > >>>>>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com> ---
> > >>>>>> arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++ 1 file
> > >>>>>> changed, 4 insertions(+)
> > >>>>>>
> > >>>>>> diff --git
> > >>>>>> a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > >>>>>> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi index
> > >>>>>> 94cdd30..67cf605 100644 ---
> > >>>>>> a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi +++
> > >>>>>> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi @@ -606,6
> > >>>>>> +606,7 @@ num-lanes = <4>; bus-range = <0x0 0xff>;
> > >>>>>> msi-parent = <&its>; +			iommu-map = <0
> &smmu 0
> > 1>;	/* This
> > >>>>>> is fixed-up by
> > >>>>> u-boot */
> > >>>>>
> > >>>>> What does this do when your version of u-boot doesn't fill this
> > >>>>> in for
> > >> you?
> > >>>>
> > >>>> Good question, frankly I have not thought of this case before.
> > >>>> But if we pass length = 0 in above property then no fixup happen
> > >>>> with happen with older u-boot. In this case
> > >>>> of_iommu_configure() will return NULL iommu-ops and it switch to
> > >>>> swio-tlb. Will that work?
> > >>> I really don't like this. You rely on having invalid data in the
> > >>> DT, and that seems just wrong.
> > >>>
> > >>> Why can't u-boot just generate that property, and we leave the DT
> > >>> alone?
> > >>
> > >> We do not have smmu phandle allowing uboot to generate this.
> > >>
> > >>> Or even better, you provide the right information for the few
> > >>> boards that are based on this SoC, not relying on u-boot for
> > >>> anything that is in the kernel tree?
> > >>
> > >> On our platforms we have a h/w table which converts RID->Device-Id.
> > >> I will check what will happen if that table is not initialized, can
> > >> RID be equal to device-id is that case. If that will be allowed
> > >> than we can give right information that will work with u-boot not
> > >> updating this property.
> > >
> > > U-boot uses a stream-id allocator and programs the h/w mapping table
> > > (rid to sid mapping table). Also it updates iommu-map property
> > > accordingly. But If u-boot does not update iommu-map than we cannot
> > > have a valid full proof solution as stream-id allocation can change
> > > in u-boot.
> > >
> > > So the other option of u-boot generating this entry seems correct
> > > solution. This requires u-boot to know iommu-phandle, something
> > > similar to "msi-parent" used for "msi-map" Device-tree binding need
> > > change to add iommu-phandle/iommu-parent for this.
> >
> > From what I know of this hardware, it's going to be rather difficult
> > to concoct a DT which reflects the initial hardware state accurately
> > *and* works correctly without updating u-boot in lockstep. IIRC, I
> > believe the accurate description for an unprogrammed LUT would be
> > "everything comes out on the default ID, which defaults to 0", i.e.:
> >
> > 	iommu-map-mask = <0x0>;
> > 	iommu-map = <0x0 &smmu 0x0 0x1>;
> 
> These changes are not enough to make PCI devise working with LUT
> disabled, also needed msi-map maps all requester-id to "0", using "msi-map-
> mask = 0x0".
> 
> Why we assume that no "msi-map" property means untranslated requested-
> id, why not consider that translated to "0".
> 
> >
> > (assuming the SMMU has stream-id-mask set appropriately too)
> >
> > That's OK except if u-boot updates the map without removing the mask,
> > whereupon things will go wrong, and I guess that would be the case
> > with current u-boot :(
> >
> > However, the existing MSI description is already bogus - if u-boot
> > didn't program the LUT, the ITS driver would treat the invalid
> > "msi-parent" property as this:
> >
> > 	msi-map = <0x0 &its 0x0 0xffff>;
> >
> > which means that nobody other than 0:0.0 has working MSIs anyway.
> 
> We can have following version of u-boot:
>  1) No LUT setup, does not generate msi-map and does not update/generate
> iommu-map (older u-boot)
> 
>      For this case the working device tree changes can be:
>                        iommu-map-mask = <0>;
>                        iommu-map = <0x0 &smmu 0 0x1>;
>                        msi-map-mask = <0x0>;
>                        msi-map = <0x0 &its 0 0x1>;
> 
>      But these changes will not work with current version of u-boot (below (2))
> 
> 2) LUT setup and msi-map generated but no iommu-map generated (current
> case)
> 
>     I do not see we can have a working device tree for this.
>     Probably generating iommu-map in u-boot is better, with that msi-map and
> iommu-map will be consistent (below (4))
> 
> 3) LUT setup, "msi-map" generated and iommu-map updated
> 
>       We can have below change is device tree.
>        	         iommu-map = <0x0 &smmu 0 0x1>;
> 
>        But this change will not work with (1) and (2) above.
> 
> 4) LUT setup, "msi-map" generated and iommu-map also generated by u-
> boot.
>     There is no iommu-map entry needed in device tree but u-boot need to
> know iommu phandle.
>     While iommus is supposed to be used in iommu-node and not in pci node.
> 
> Looking for suggestion

Below properties as suggested by you are correct from h/w behavior perspective

                        iommu-map-mask = <0>;
                        iommu-map = <0x0 &smmu 0 0x1>;

Are you ok with these changes?

Thanks
-Bharat

> 
> Thanks
> -Bharat
> 
> >
> > If you want an obviously-invalid placeholder equivalent to the use of
> > "msi- parent" then I'd suggest just:
> >
> > 	iommus = <&smmu>;
> >
> > which would be ignored by Linux for PCI devices, so provided you
> > didn't disable bypass at the SMMU things might in theory still work in
> > the "u-boot does nothing" case. Otherwise, the implied identity map is
> > probably slightly preferable to the unit-length map, i.e.:
> >
> > 	iommu-map = <0x0 &smmu 0x0 0xffff>;
> >
> > which is at least equally broken as MSIs in the same situation.
> >
> > Robin.
