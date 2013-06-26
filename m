From: balbi@ti.com (Felipe Balbi)
Date: Wed, 26 Jun 2013 08:23:54 +0300
Subject: [PATCH v2 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
In-Reply-To: <51CA0FE1.9090107@gmail.com>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <20130625150649.GA21334@arwen.pp.htv.fi>
 <51C9D714.4000703@samsung.com>
 <20130625205452.GC9748@arwen.pp.htv.fi>
 <51CA0FE1.9090107@gmail.com>
Message-ID: <20130626052353.GA12640@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:47:13PM +0200, Sylwester Nawrocki wrote:
> Hi,
> 
> On 06/25/2013 10:54 PM, Felipe Balbi wrote:
> >>>>+static int exynos_video_phy_probe(struct platform_device *pdev)
> >>>>>  >>  +{
> >>>>>  >>  +	struct exynos_video_phy *state;
> >>>>>  >>  +	struct device *dev =&pdev->dev;
> >>>>>  >>  +	struct resource *res;
> >>>>>  >>  +	struct phy_provider *phy_provider;
> >>>>>  >>  +	int i;
> >>>>>  >>  +
> >>>>>  >>  +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> >>>>>  >>  +	if (!state)
> >>>>>  >>  +		return -ENOMEM;
> >>>>>  >>  +
> >>>>>  >>  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>>>  >>  +
> >>>>>  >>  +	state->regs = devm_ioremap_resource(dev, res);
> >>>>>  >>  +	if (IS_ERR(state->regs))
> >>>>>  >>  +		return PTR_ERR(state->regs);
> >>>>>  >>  +
> >>>>>  >>  +	dev_set_drvdata(dev, state);
> >>>>  >
> >>>>  >  you can use platform_set_drvdata(pdev, state);
> >>>
> >>>  I had it in the previous version, but changed for symmetry with
> >>>  dev_set_drvdata(). I guess those could be replaced with
> >>>  phy_{get, set}_drvdata as you suggested.
> >
> >hmm, you do need to set the drvdata() to the phy object, but also to the
> >pdev object (should you need it on a suspend/resume callback, for
> >instance). Those are separate struct device instances.
> 
> Indeed, I somehow confused phy->dev with with phy->dev.parent. I'm going
> to just drop the above call, since the pdev drvdata is currently not
> referenced anywhere.

ok cool :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/dc970476/attachment.sig>
