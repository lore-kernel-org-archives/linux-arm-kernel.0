From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 21:46:38 +0000
Subject: [PATCH 1/3] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <19296.16393.211432.933296@ipc1.ka-ro>
References: <cover.1264596212.git.baruch@tkos.co.il>
	<e62d43482b15f0d3f9a25a9868434cd34df0dd76.1264596212.git.baruch@tkos.co.il>
	<19296.16393.211432.933296@ipc1.ka-ro>
Message-ID: <20100127214638.GB29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 02:30:49PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Baruch Siach writes:
> > +	imxdi->clk = clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(imxdi->clk)) {
> > +		rc = -ENODEV;
> >
> rc = PTR_ERR(imxdi->clk);

Grr.

Why do people find the general principle that "if you have an error
code, propagate it upwards" is soo difficult to deal with?

We seem to have stuff like the above constantly appearing, or the evil
"lets return -1 because we can't be bothered to find an appropriate
error value" sillyness.

Why is this?

A suggestion - try thinking like this: "If I find myself typing
'return -1', immediate stop typing and take the time to find a better
value.  If I find myself typing IS_ERR() make sure I use PTR_ERR to
assign an error code."

Simples.
