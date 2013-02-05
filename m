From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 15:43:58 +0800
Subject: [PATCH V3  0/5] W1: Support onewire master on i.MX53
In-Reply-To: <20130130130157.GB2757@S2101-09.ap.freescale.net>
References: <20130129154608.5184.46101.stgit@localhost>
 <20130130130157.GB2757@S2101-09.ap.freescale.net>
Message-ID: <20130205074356.GB16787@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 09:02:00PM +0800, Shawn Guo wrote:
> On Tue, Jan 29, 2013 at 04:46:08PM +0100, Martin Fuzzey wrote:
> > W1: Support onewire master on i.MX53
> > 	* Add device tree and pinctrl support to the MXC master driver
> > 	* Convert to use devm_
> > 	* Add i.MX53 clocks
> > 	* Add i.MX53 device tree entries
> 
> Applied, thanks.
> 
> I changed the patch order a little bit, moving dts change to the last,
> and also fix the patch subject prefix.
> 
>       W1: Add device tree support to MXC onewire master.
>       W1: Convert MXC onewire master to devm_ functions.

I have to drop this one, as I see patch e5279ff
(drivers/w1/masters/mxc_w1.c: use devm_ functions) on linux-next,
which does the same thing.

>       W1: Add pinctrl support to MXC onewire master.

And I would drop this one too, because patch ab78029 (drivers/pinctrl:
grab default handles from device core) will have it handled globally
at driver core level.

Shawn

>       ARM: i.MX53: Add clocks for i.mx53 onewire master.
>       ARM: dts: Add device tree entry for onewire master on i.MX53
