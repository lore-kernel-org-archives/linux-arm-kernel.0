From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Mar 2014 13:05:58 +0100
Subject: [PATCH v3 6/7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <1394028474.28803.172.camel@smile.fi.intel.com>
References: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393949884-892-7-git-send-email-maxime.ripard@free-electrons.com>
 <1394028474.28803.172.camel@smile.fi.intel.com>
Message-ID: <20140310120558.GF2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andriy,

On Wed, Mar 05, 2014 at 02:07:55PM +0000, Shevchenko, Andriy wrote:
> > +		return PTR_ERR(pll6);
> > +	}
> > +
> > +	ret = clk_set_parent(mux, pll6);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Couldn't reparent AHB1 on PLL6\n");
> > +		return ret;
> > +	}
> > +
> > +	devm_clk_put(&pdev->dev, mux);
> > +	devm_clk_put(&pdev->dev, pll6);
> 
> Since you put those here, would it be better to use plain
> clk_get/clk_put ?

Actually, this allows to have no exit path for the case where one of
the calls between the first clk_get, and here. devm_clk_* makes error
handling much easier here, that's just all

I'll fix the other comments you had, and send a new version.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/580c7192/attachment-0001.sig>
