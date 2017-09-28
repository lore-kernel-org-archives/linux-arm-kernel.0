From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Sep 2017 12:28:30 +0200
Subject: [PATCH 0/3] Simple DVFS support for Allwinner A64 SoC
In-Reply-To: <9b3aeb6cb155bb2f9a7cee438de82ccb@aosc.io>
References: <20170923001531.14285-1-icenowy@aosc.io>
 <20170925101027.lghnnll4h6inreqm@flea.home>
 <27EF78BD-6285-4D8D-AA65-8294D797E2FB@aosc.io>
 <20170925102744.qixfwlheeimemhcf@flea.home>
 <9b3aeb6cb155bb2f9a7cee438de82ccb@aosc.io>
Message-ID: <20170928102830.uuicirbjb5q64vwz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 27, 2017 at 11:51:30AM +0000, icenowy at aosc.io wrote:
> ? 2017-09-25 18:27?Maxime Ripard ???
> > On Mon, Sep 25, 2017 at 10:12:09AM +0000, Icenowy Zheng wrote:
> > > ? 2017?9?25? GMT+08:00 ??6:10:27, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> ??:
> > > >Hi,
> > > >
> > > >On Sat, Sep 23, 2017 at 12:15:28AM +0000, Icenowy Zheng wrote:
> > > >> This patchset imports simple DVFS support for Allwinner A64 SoC.
> > > >>
> > > >> As the thermal sensor driver is not yet implemented and some boards
> > > >> have still no AXP PMIC support, now only two OPPs are present --
> > > >> 648MHz at 1.04V and 816MHz at 1.1V to prevent overheat or undervoltage.
> > > >>
> > > >> PATCH 1 is a fix to the CCU driver of A64, and the remaining patches
> > > >> set up the device tree bits of the DVFS on Pine64.
> > > >
> > > >How has this been tested?
> > > >
> > > >What tasks did you run, with what governor, etc...
> > > 
> > > I only tested manual frequency switching between 648MHz and
> > > 816MHz, and tested the PLL stuck issue by change the OPPs to
> > > some random value.
> > 
> > Ideally, we should test that it's actually reliable. Poorly chosen
> > OPPs might lead to corrupt data that you might not get before a while.
> > 
> > Please test using:
> > https://linux-sunxi.org/Hardware_Reliability_Tests#Reliability_of_cpufreq_voltage.2Ffrequency_settings
> > 
> > And post the report.
> 
> ```
> root at p64 [ cpuburn-arm at master ] # ./cpuburn-a53 &
> [1] 2543
> root at p64 [ cpuburn-arm at master ] # ./cpufreq-ljt-stress-test
> Creating './whitenoise-1920x1080.jpg' ... done
> CPU stress test, which is doing JPEG decoding by libjpeg-turbo
> at different cpufreq operating points.
> 
> Testing CPU 0
>   816 MHz ............................................................ OK
>   648 MHz ............................................................ OK
> 
> Testing CPU 1
>   816 MHz ............................................................ OK
>   648 MHz ............................................................ OK
> 
> Testing CPU 2
>   816 MHz ............................................................ OK
>   648 MHz ............................................................ OK
> 
> Testing CPU 3
>   816 MHz ............................................................ OK
>   648 MHz ............................................................ OK
> 
> Overall result : PASSED
> ```

Great, thanks!

Can you put that in your cover letter for the next version?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170928/065a9cb9/attachment.sig>
