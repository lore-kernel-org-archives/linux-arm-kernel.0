From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 23 Jul 2012 13:23:50 +0000
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device
 tree data
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 12:36:48, AnilKumar, Chimata wrote:
> On Fri, Jul 20, 2012 at 17:08:06, Mark Brown wrote:
> > On Fri, Jul 20, 2012 at 11:27:36AM +0000, AnilKumar, Chimata wrote:
> > > On Fri, Jul 20, 2012 at 15:29:36, Mark Brown wrote:
> > 
> > > > Every regulator here has a rather large voltage range specified with no
> > > > consumers added.  Are you sure these voltage ranges make sense in your
> > > > design and you've not just cut'n'pasted the entire voltage range that
> > > > your regulator supports without reference to what your board can do?
> > 
> > > tps65217.dtsi is a generic file to be used by the SoCs so these constraints
> > > were taken from the regulator itself. SoC specific limits can be added in
> > > SoC specific .dts file to tighten the constraints to require limit. I have
> > > tested the driver with this approach.
> > 
> > No, this is not a sane approach.  You've no idea if any of these
> > settings are safe or sane for the board.  Boards should enable things
> > they know are safe, not remove those they know are broken.
> > 
> 
> Unsterstood, I will send v2 with constraints updated.
> 

By the way, if we look at all the regulator added (DT supported) till now have
the similar problem.

arch/arm/boot/dts/imx6q.dtsi
arch/arm/boot/dts/twl4030.dtsi
arch/arm/boot/dts/twl6030.dtsi
arch/arm/boot/dts/db8500.dtsi

Regards
AnilKumar
