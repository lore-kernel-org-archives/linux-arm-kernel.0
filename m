From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Wed, 06 Mar 2013 12:51:21 +0100
Subject: RFC: Zynq Clock Controller
In-Reply-To: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
References: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
Message-ID: <1362570681.5269.98.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

On Tue, 2013-03-05 at 12:04 -0800, S?ren Brinkmann wrote:
> For this reasons, I'd like to propose moving Zynq into the same
> direction. I.e. adding a clock controller with the following DT
> description (details may change but the general idea should become
> clear):
> 	clkc: clkc {
>                 #clock-cells = <1>;
>                 compatible = "xlnx,ps7-clkc";
>                 ps_clk_frequency = <33333333>;	# board x-tal
>                 # optional props
>                 gem0_emio_clk_freq = <125000000>;
>                 gem1_emio_clk_freq = <50000000>;
>                 can_mio_clk_freq_xx = <1234>; # this is possible 54 times with xx = 00..53
>         };

The clock controller should only contain properties for input frequency
(which can obviously not be calculated at run-time).

Are the gem*, can* properties inputs? If they are actually outputs, the
corresponding frequencies should be requested by the clock consumers and
not hard-coded in DT.

Please keep in mind that DT properties use dashes instead of
underscores.

Best regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
