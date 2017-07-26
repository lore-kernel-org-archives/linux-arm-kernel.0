From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Wed, 26 Jul 2017 20:35:27 +0800
Subject: [PATCH] memory: mtk-smi: Use of_device_get_match_data helper
In-Reply-To: <1d31eedd-fdab-bd6f-65b1-c0e8b79a8888@arm.com>
References: <1501063150-8778-1-git-send-email-honghui.zhang@mediatek.com>
 <1d31eedd-fdab-bd6f-65b1-c0e8b79a8888@arm.com>
Message-ID: <1501072527.20860.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-07-26 at 11:36 +0100, Robin Murphy wrote:
> On 26/07/17 10:59, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 

> >  	 * for mtk smi gen 1, we need to get the ao(always on) base to config
> >  	 * m4u port, and we need to enable the aync clock for transform the smi
> >  	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
> >  	 * base.
> >  	 */
> > -	smi_gen = (enum mtk_smi_gen)of_id->data;
> > -	if (smi_gen == MTK_SMI_GEN1) {
> > +	smi_gen = of_device_get_match_data(dev);
> 
> The data you're retrieving is the exact same thing as of_id->data was,
> i.e. an enum mtk_smi_gen cast to void*, so dereferencing it is not a
> good idea. The first patch was almost right; you just need to keep the
> cast in the assignment to smi_gen.
> 
> Robin.
> 
Hi, Robin, thanks very much.
I will send a new version.

> > +	if (*smi_gen == MTK_SMI_GEN1) {
> >  		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  		common->smi_ao_base = devm_ioremap_resource(dev, res);
> >  		if (IS_ERR(common->smi_ao_base))
> > 
> 
