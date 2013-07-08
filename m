From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 8 Jul 2013 06:12:47 -0700
Subject: [lm-sensors] [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for
 lm90
In-Reply-To: <51DA6BD4.1040300@nvidia.com>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com>
 <1372928979-26938-2-git-send-email-wni@nvidia.com>
 <51D70483.70203@wwwdotorg.org> <51DA6BD4.1040300@nvidia.com>
Message-ID: <20130708131247.GA21638@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 03:35:48PM +0800, Wei Ni wrote:
> On 07/06/2013 01:38 AM, Stephen Warren wrote:
> > On 07/04/2013 03:09 AM, Wei Ni wrote:
> >> Enable thermal sensor lm90 for t30 cardhu.
> > 
> >> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> > 
> >> +		nct1008: nct1008 {
> >> +			compatible = "lm90,nct1008";
> > 
> > "lm90" isn't a valid vendor prefix. I believe the value you want is
> > "onnn,nct1008". Same comment for patch 2/2.
> > 
> The lm90 doesn't support device tree very well. In the DT, we need to
> named as "lm90" so that the lm90 driver can be loaded, and we also need
> to add "nct1008" to indicate this is the nct1008 device, so that the
> lm90 driver can be loaded with the right i2c_device_id->driver_data.
> 
> I set the " compatible = "lm90,nct1008" ", this is the simplest way, and
> we doesn't need to change the lm90.c.
> 
Did you really test "onn,nct1008" or, for that matter, "anything,nct1008" ?

I have been using 
	maxim,max1137
	maxim,max1139
	maxim,max6697
	dallas,ds1621
	linear,ltc3880
	linear,ltc2978
	intersil,zl2006
	ti,tmp421
	ti,tmp431

without problems, and without having to add code to the respective drivers.
I would be quite surprised if "onn,nct1008" would not work.

Guenter
