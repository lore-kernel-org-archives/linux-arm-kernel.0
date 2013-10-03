From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 3 Oct 2013 18:37:43 +0200
Subject: [PATCH 1/4] ARM: socfpga: dts: Move common nodes to cyclone5 dtsi
In-Reply-To: <1380812321.7464.7.camel@linux-builds1>
References: <1380699333-558-1-git-send-email-s.trumtrar@pengutronix.de>
 <1380699333-558-2-git-send-email-s.trumtrar@pengutronix.de>
 <1380812321.7464.7.camel@linux-builds1>
Message-ID: <20131003163743.GB14042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Thu, Oct 03, 2013 at 09:58:41AM -0500, Dinh Nguyen wrote:
> On Wed, 2013-10-02 at 09:35 +0200, Steffen Trumtrar wrote:
> > +/include/ "socfpga_cyclone5.dtsi"
> > +
> > +/ {
> > +	model = "Altera SOCFPGA Cyclone V SoC Development Kit";
> > +	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS0,57600";
> 
> Thanks for doing this. It looks good. While you're at it can you make
> this 115200? 57600 was early in the bring-up stage.
> 

I can also completely remove this. The question is: does u-boot need this
line or does it add this line itself?
We added basic support for SoCFPGA to barebox (well, it will go live with the
october release AFAIK. With SoCKit and SoCrates boards) and we normally do not
need to put the bootargs in the DT. So, I would be okay to remove this line
OR if u-boot uses it, change it to 115200. What do you think?

> > +	};
> > +
> > +	memory {
> > +		name = "memory";
> > +		device_type = "memory";
> > +		reg = <0x0 0x40000000>; /* 1GB */
> > +	};
> > +
> > +	aliases {
> > +		/* this allow the ethaddr uboot environmnet variable contents
> > +		 * to be added to the gmac1 device tree blob.
> > +		 */
> > +		ethernet0 = &gmac1;
> > +	};
> > +};
> 
> With the change to 115200,
> 
> Acked-by: Dinh Nguyen <dinguyen@altera.com>
> 

Thanks.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
