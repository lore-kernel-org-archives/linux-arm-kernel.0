From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 13:24:49 +0200
Subject: [PATCH 23/29] ARM: orion5x: use DT to describe NOR on edmini_v2
In-Reply-To: <534BC330.90206@gmail.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BC330.90206@gmail.com>
Message-ID: <20140414132449.6eae17fa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Mon, 14 Apr 2014 13:14:56 +0200, Sebastian Hesselbarth wrote:

> > +		devbus-bootcs {
> 
> Node label reference?
> 
> > +			status = "okay";
> > +
> > +			/* Read parameters */
> > +			devbus,bus-width    = <8>;
> > +			devbus,turn-off-ps  = <90000>;
> > +			devbus,badr-skew-ps = <0>;
> > +			devbus,acc-first-ps = <186000>;
> > +			devbus,acc-next-ps  = <186000>;
> > +
> > +			/* Write parameters */
> > +			devbus,wr-high-ps  = <90000>;
> > +			devbus,wr-low-ps   = <90000>;
> > +			devbus,ale-wr-ps   = <90000>;
> > +
> > +			/*
> > +			 * Currently the MTD code does not recognize
> > +			 * the MX29LV400CBCT as a bottom-type
> > +			 * device. This could cause risks of
> > +			 * accidentally erasing critical flash
> > +			 * sectors. We thus define a single,
> > +			 * write-protected partition covering the
> > +			 * whole flash.  TODO: once the flash part
> > +			 * TOP/BOTTOM detection issue is sorted out in
> > +			 * the MTD code, break this into at least
> > +			 * three partitions: 'u-boot code', 'u-boot
> > +			 * environment' and 'whatever is left'.
> > +			 */
> > +			nor at 0 {
> 
> ePAPR suggests a generic node name. I talked to Olof on IRC, he prefers
> generic names all over. I confirmed that this means "flash" node name
> for both the controller _and_ the device.

While I'm fine with changing the nor at 0 node name to flash at 0, I'm
clearly not ok with changing devbus-bootcs to something that refers to
a "flash", because the Device Bus controller is not only a flash
controller. It can be used for many other memory mapped devices, such
as FPGAs and so on.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
