From: sha@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Nov 2009 10:46:50 +0100
Subject: [PATCH 00/25] imx cleanups
In-Reply-To: <20091116203406.GA6546@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
Message-ID: <20091118094650.GL30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 09:34:06PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series is the start of a big cleanup of the imx support.  The
> overall goal is to support all SoCs with a single image.  Therefor a few
> things need to/should be done:
> 
>   - clean up headers not to define the same constants (i.e. prefix
>     everything with the SoC's name)
>   - generalise device creation
>   - generalise static mappings
>   - probably much more
> 
> Here I start with the first two items.
> 
> On the way I plan to change all occurences of "mxc" to "imx".
> 
> I hope this all can happen without much breakage.
> 
> For now no #defines are removed only redefined.  So all code should
> continue to work as before.  Assuming this series is accepted new usage
> of the #defines without a SoC-prefix should be deprecated.  When all
> users are converted, the old #defines can go away.
> 
> git branch, shortlog and diffstat can be found below.  It merges nearly
> fine into Sascha's mxc-master.  There's only a trivial conflict in
> arch/arm/plat-mxc/Makefile .

I merged this series up to patch 15/25. I'm not sure with the device
generalisation as we currently need the device pointers for the IPU and
the regulator framework. So the nand device generalisation as is is not
suitable as a template on how device registration can work in the
future.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
