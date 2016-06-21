From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 21 Jun 2016 14:33:35 +0000
Subject: SMMU driver and stall vs terminate mode
In-Reply-To: <5768150D.2070705@arm.com>
References: <HE1PR04MB1641B0F8442061E3437037628D2A0@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <5768150D.2070705@arm.com>
Message-ID: <HE1PR04MB1641D09BBF8029ED98BE18D38D2B0@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Monday, June 20, 2016 11:09 AM
> To: Stuart Yoder <stuart.yoder@nxp.com>; Will Deacon <Will.Deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org; iommu at lists.linux-foundation.org; Nipun Gupta
> <nipun.gupta@nxp.com>; Bharat Bhushan <bharat.bhushan@nxp.com>; Brian Starkey <brian.starkey@arm.com>
> Subject: Re: SMMU driver and stall vs terminate mode
> 
> Hi Stuart,
> 
> On 20/06/16 16:28, Stuart Yoder wrote:
> > Robin/Will,
> >
> > Right now the SMMU driver is hardcoded to configure 'stall' mode for
> > context faults:
> >
> >        /* SCTLR */
> >        reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
> >
> > We are running into an issue with a device where it seems behave sanely
> > when SCTLR_CFCFG=0 ...i.e. 'terminate' mode, but in stall mode seems to be
> > unaware that an access violation occurred.
> 
> Does the device keep issuing transactions after the initial faulting
> one, by any chance?

In the case we are seeing, it is a unit test type scenario and I think
there is only one transaction, so software doesn't try to continue issuing
transactions.

Stuart
