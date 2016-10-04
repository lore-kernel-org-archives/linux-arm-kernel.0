From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Oct 2016 18:09:54 +0200
Subject: [PATCH 06/14] ASoC: Add sun8i digital audio codec
In-Reply-To: <20161004144008.0d07d18c@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004144008.0d07d18c@free-electrons.com>
Message-ID: <20161004160954.GN5228@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 04, 2016 at 02:40:08PM +0200, Thomas Petazzoni wrote:
> > +	scodec->clk_apb = devm_clk_get(&pdev->dev, "apb");
> > +	if (IS_ERR(scodec->clk_apb)) {
> > +		dev_err(&pdev->dev, "Failed to get the apb clock\n");
> > +		return PTR_ERR(scodec->clk_apb);
> > +	}
> > +	if (clk_prepare_enable(scodec->clk_apb))
> > +		pr_err("err:open failed;\n");
> 
> Ditto. + unprepare/disable the previous clock.

Ideally, that would be even not be part of the runtime_pm
hooks. Ideally, that would be great if that driver supports it.

We'll have to go through all the drivers to support it, that would be
one less to do (and ASoC makes it very easy, you can have a look at
the sun4i-i2s driver).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/3a347edd/attachment.sig>
