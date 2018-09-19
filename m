From: MNARANI@xilinx.com (Manish Narani)
Date: Wed, 19 Sep 2018 05:14:51 +0000
Subject: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <20180918075522.GC22202@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
Message-ID: <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks for your continuous guidance.

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Tuesday, September 18, 2018 1:25 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; mchehab at kernel.org;
> Michal Simek <michals@xilinx.com>; leoyang.li at nxp.com;
> sudeep.holla at arm.com; amit.kucheria at linaro.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> edac at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v7 2/7] edac: synps: Add platform specific structures for
> ddrc controller
> 
> On Mon, Sep 17, 2018 at 07:55:00PM +0530, Manish Narani wrote:
> > Add platform specific structures, so that we can add different IP
> > support later using quirks.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/edac/synopsys_edac.c | 91
> > +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 65 insertions(+), 26 deletions(-)
> 
> ...
> 
> > @@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
> >   */
> >  static int synps_edac_mc_probe(struct platform_device *pdev)  {
> > +	const struct synps_platform_data *p_data;
> >  	struct edac_mc_layer layers[2];
> >  	struct synps_edac_priv *priv;
> >  	struct mem_ctl_info *mci;
> > @@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct
> platform_device *pdev)
> >  	if (IS_ERR(baseaddr))
> >  		return PTR_ERR(baseaddr);
> >
> > -	if (!edac_get_eccstate(baseaddr)) {
> > +	p_data = of_device_get_match_data(&pdev->dev);
> > +	if (!(p_data->get_eccstate(baseaddr))) {
> 
> From last review round:
> 
> "Too many parentheses:
> 
>         if (!p_data->...
> 
> is enough."
> 
> So I'm going to stop reviewing this patchset until you go through the old review
> round again and make sure you've incorporated *all* review feedback and
> haven't forgotten some, like the one above.
> 
Okay, I will double check again for the comments from previous review and rectify the same in v8. Can you please review the remaining patches so that I can accommodate any changes for them in v8? I regret the inconvenience caused to you in this.

Thanks,
Manish
