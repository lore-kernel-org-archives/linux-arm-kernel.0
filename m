From: B47053@freescale.com (Xiubo Li-B47053)
Date: Fri, 18 Oct 2013 03:19:42 +0000
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131017114208.595a4224@ipc1.ka-ro>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131017114208.595a4224@ipc1.ka-ro>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82865423@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	sai->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(sai->base)) {
> > +		ret = PTR_ERR(sai->base);
> > +		return ret;
> >
> could be:
> 		return PTR_ERR(sai->base);
>

Yes?This looks better.

 
> > +#define FSL_SAI_DMABUF_SIZE	(32 * 1024)
> > +#define TCD_NUMBER		4
> > +#define EDMA_PRIO_HIGH          6
> > +
> strange indentation with mixed spaces and tabs.
> 

This will be revised in the next version.



> > +#define SAI_CR2_MSEL_MCLK3	(BIT(26)|BIT(27))
> >
> spaces around '|'?
> 

And this too.




--
BRS,
Xiubo
