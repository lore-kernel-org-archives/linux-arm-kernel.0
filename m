From: JOLLYS@xilinx.com (Jolly Shah)
Date: Tue, 13 Mar 2018 18:56:38 +0000
Subject: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <755770ba-d110-8b2e-3c1f-9b65686dc51f@arm.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
 <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
 <DM2PR0201MB07678A47B5380DC14E6F6126B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <755770ba-d110-8b2e-3c1f-9b65686dc51f@arm.com>
Message-ID: <DM2PR0201MB07676A546340135791F9F25EB8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Tuesday, March 13, 2018 3:16 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; gregkh at linuxfoundation.org;
> matt at codeblueprint.co.uk; hkallweit1 at gmail.com; michal.simek at xilinx.com;
> robh+dt at kernel.org; mark.rutland at arm.com; ard.biesheuvel at linaro.org;
> mingo at kernel.org; keescook at chromium.org; dmitry.torokhov at gmail.com;
> Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
> firmware
> 
> 
> 
> On 12/03/18 23:07, Jolly Shah wrote:
> > Hi Sudeep,
> 
> >>>> Do you foresee using SMC/HVC for this firmware even on future
> platforms?
> >>>> If not, I suggest to keep the protocol part separate from the transport i.e.
> >>>> smc/hvc via ATF. It could be replaced with mailbox or some h/w
> >>>> mechanism in future ?
> >>>>
> >>>
> >>> We have PSCI and EEMI interfaces exposed to linux from ATF. PSCI is
> >>> an EEMI client. We do not have current plans to switch to mailbox as
> >>> it will require 2 communication channels to PMU as PSCI is through ATF.
> >>>
> >>
> >> OK, but I just saw some bindings that has mailbox interface, honestly
> >> it's getting too confusing with multiple series on the same thing
> >> floating and hence I requested to put it together as one series.
> >
> > Mailbox binding is used for power management driver. Mailbox is only
> > used for PMU->APU communication. APU->PMU communication is always
> > through EEMI firmware interface which is using SMC/HVC.
> >
> 
> Ah OK, is it because there's no non-secure mailbox or to avoid races, all non-
> secure EEMI is channeled through SMC ?
> 

2 reasons:
1> Avoid multiple EEMI communication channels as PSCI is through ATF.
2> We have some secure operations handled in ATF because of memory constraints on PMU

> --
> Regards,
> Sudeep
