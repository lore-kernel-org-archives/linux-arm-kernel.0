From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 6 Mar 2013 09:27:46 -0800
Subject: RFC: Zynq Clock Controller
In-Reply-To: <1362570681.5269.98.camel@coredoba.hi.pengutronix.de>
References: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
 <1362570681.5269.98.camel@coredoba.hi.pengutronix.de>
Message-ID: <f288874c-d0ae-4581-8d0f-2b9abe4d3117@CO9EHSMHS002.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,
 
what a small world. Good to hear from you.

On Wed, Mar 06, 2013 at 12:51:21PM +0100, Jan L?bbe wrote:
> Hi S?ren,
> 
> On Tue, 2013-03-05 at 12:04 -0800, S?ren Brinkmann wrote:
> > For this reasons, I'd like to propose moving Zynq into the same
> > direction. I.e. adding a clock controller with the following DT
> > description (details may change but the general idea should become
> > clear):
> > 	clkc: clkc {
> >                 #clock-cells = <1>;
> >                 compatible = "xlnx,ps7-clkc";
> >                 ps_clk_frequency = <33333333>;	# board x-tal
> >                 # optional props
> >                 gem0_emio_clk_freq = <125000000>;
> >                 gem1_emio_clk_freq = <50000000>;
> >                 can_mio_clk_freq_xx = <1234>; # this is possible 54 times with xx = 00..53
> >         };
> 
> The clock controller should only contain properties for input frequency
> (which can obviously not be calculated at run-time).
> 
> Are the gem*, can* properties inputs? If they are actually outputs, the
> corresponding frequencies should be requested by the clock consumers and
> not hard-coded in DT.
They are inputs. GEM and CAN have the option to be clocked through (E)MIO pins, i.e. some external clock input which cannot be derived from ps_clk like all other clocks. I plan to register a fixed rate, root clock for each of those properties, if present.

> 
> Please keep in mind that DT properties use dashes instead of
> underscores.
Okay, I'll make that substitution.

	S?ren
