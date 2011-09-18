From: martin@neutronstar.dyndns.org (martin at neutronstar.dyndns.org)
Date: Sun, 18 Sep 2011 22:13:36 +0200
Subject: [PATCH v2] arm: omap3evm: Add support for an MT9M032 based
	camera board.
In-Reply-To: <201109180008.21254.laurent.pinchart@ideasonboard.com>
References: <1316252097-4213-1-git-send-email-martin@neutronstar.dyndns.org>
	<4E751870.5080605@gmail.com>
	<201109180008.21254.laurent.pinchart@ideasonboard.com>
Message-ID: <1316376816.669188.9350@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2011 at 12:08:20AM +0200, Laurent Pinchart wrote:
> On Sunday 18 September 2011 00:00:16 Sylwester Nawrocki wrote:
> > On 09/17/2011 11:34 AM, Martin Hostettler wrote:
> > > Adds board support for an MT9M032 based camera to omap3evm.
> > 
> > ...
> > 
> > > +
> > > +static int __init camera_init(void)
> > > +{
> > > +	int ret = -EINVAL;
> > > +
> > > +	omap_mux_init_gpio(nCAM_VD_SEL, OMAP_PIN_OUTPUT);
> > > +	if (gpio_request(nCAM_VD_SEL, "nCAM_VD_SEL")<  0) {
> > > +		pr_err("omap3evm-camera: Failed to get GPIO nCAM_VD_SEL(%d)\n",
> > > +		       nCAM_VD_SEL);
> > > +		goto err;
> > > +	}
> > > +	if (gpio_direction_output(nCAM_VD_SEL, 1)<  0) {
> > > +		pr_err("omap3evm-camera: Failed to set GPIO nCAM_VD_SEL(%d)
> > > direction\n", +		       nCAM_VD_SEL);
> > > +		goto err_vdsel;
> > > +	}
> > 
> > How about replacing gpio_request + gpio_direction_output with:
> > 
> > 	gpio_request_one(nCAM_VD_SEL, GPIOF_OUT_INIT_HIGH, "nCAM_VD_SEL");
> 
> I'd even propose gpio_request_array().
> 

Nice interface. Apart from a bit less detailed error reporting it nicely
simplifies the code. I'll make a new patch using that soon.

 - Martin Hostettler
