From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 18:48:08 +0000
Subject: [alsa-devel] [PATCH v4 1/3] ASoC: samsung: Add machine driver
 for Trats2
In-Reply-To: <54C7C653.6080904@samsung.com>
References: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
 <1421989410-12490-2-git-send-email-ideal.song@samsung.com>
 <54C7C653.6080904@samsung.com>
Message-ID: <20150127184808.GK21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:09:39PM +0100, Sylwester Nawrocki wrote:
> On 23/01/15 06:03, Inha Song wrote:

> > +	priv->clk_mclk =  of_clk_get_by_name(codec_node, "MCLK1");
> > +	if (IS_ERR(priv->clk_mclk)) {
> > +		dev_err(&pdev->dev, "Failed to get mclk clock\n");
> > +		of_node_put(codec_node);
> > +		return PTR_ERR(priv->clk_mclk);
> > +	}

> Wouldn't it also work if we added clock handling into the wm8994 codec
> driver instead? Not sure if it is correct to retrieve the codec's clock
> in the machine driver like this. Or perhaps the MCLK1 (SoC CLKOUT) clock
> should be added to the sound DT node and handled only by the machine
> driver, together with the other (MCLK2) clock?

That's definitely where we should end up but there are practical issues
with that approach since it involves coordination with all the machine
drivers using the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/f8e115c4/attachment.sig>
