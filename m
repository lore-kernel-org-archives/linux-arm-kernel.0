From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 24 Sep 2018 10:29:44 +0000
Subject: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
In-Reply-To: <20180924092226.GA20187@zn.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
 <20180924092226.GA20187@zn.tnic>
Message-ID: <DM6PR02MB5227D961C992C3BB6A4421B7C1170@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks for the review.

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Monday, September 24, 2018 2:52 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; mchehab at kernel.org;
> Michal Simek <michals@xilinx.com>; leoyang.li at nxp.com;
> sudeep.holla at arm.com; amit.kucheria at linaro.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> edac at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP
> DDRC
> 
> On Mon, Sep 17, 2018 at 07:55:02PM +0530, Manish Narani wrote:
> > Add macro defines for ZynqMP DDR controller. These macros will be used
> > for ZyqnMP ECC operations.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/edac/synopsys_edac.c | 168
> > +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >
> > diff --git a/drivers/edac/synopsys_edac.c
> > b/drivers/edac/synopsys_edac.c index eb458e5..6bf7959 100644
> > --- a/drivers/edac/synopsys_edac.c
> > +++ b/drivers/edac/synopsys_edac.c
> > @@ -97,6 +97,174 @@
> >  #define SCRUB_MODE_MASK		0x7
> >  #define SCRUB_MODE_SECDED	0x4
> >
> > +/* DDR ECC Quirks */
> > +#define DDR_ECC_INTR_SUPPORT		BIT(0)
> > +#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
> 
> All those new additions are one column further to the left than the old ones.
> Why?
> 
> Is there some significance here or can they all be vertically aligned?
Should I increase the alignment of the existing macros in the 'code formatting' patches? New macros will need an increased indentation.

Thanks,
Manish
