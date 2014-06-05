From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Jun 2014 00:09:28 +0200
Subject: [PATCH 1/4] pinctrl: Add NVIDIA Tegra XUSB pad controller support
In-Reply-To: <5390A426.1050307@wwwdotorg.org>
References: <1401894990-30092-1-git-send-email-thierry.reding@gmail.com>
 <5390A426.1050307@wwwdotorg.org>
Message-ID: <20140605220927.GB28817@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 11:08:54AM -0600, Stephen Warren wrote:
> On 06/04/2014 09:16 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The XUSB pad controller found on NVIDIA Tegra SoCs provides several pads
> > that lanes can be assigned to in order to support a variety of interface
> > options: USB 2.0, USB 3.0, PCIe and SATA.
> > 
> > In addition to the pin controller used to assign lanes to pads two PHYs
> > are exposed to allow the bricks for PCIe and SATA to be powered up and
> > down by PCIe and SATA drivers.
> 
> > +#define TEGRA124_GROUP(_funcs)						\
> > +	{								\
> > +		.num_funcs = ARRAY_SIZE(tegra124_##_funcs##_functions),	\
> > +		.funcs = tegra124_##_funcs##_functions,			\
> > +	}
> > +
> > +static const struct tegra_xusb_padctl_group tegra124_groups[] = {
> > +	TEGRA124_GROUP(otg),
> > +	TEGRA124_GROUP(usb),
> > +	TEGRA124_GROUP(pci),
> > +};
> 
> I'm not sure what this set of groups is for.
> 
> pinctrl muxes functions onto groups, so given that each pin in padctl is
> individually configurable, we need 1 group per pin. As far as I can
> tell, tegra_xusb_padctl_get_groups_count()/name() implement this
> correctly, and this array isn't used anywhere?

Indeed, there seems to be no need for this anymore. Probably left-over
from some prior version.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/a29bd0dd/attachment.sig>
