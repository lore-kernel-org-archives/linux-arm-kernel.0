From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 24 Nov 2012 10:00:04 -0500
Subject: [PATCH 3/4] ARM: Dove: Convert to DT GPIO and pinctrl
In-Reply-To: <20121124080240.3f600e89@skate>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353317996-20841-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20121124023942.GO15800@titan.lakedaemon.net>
 <20121124080240.3f600e89@skate>
Message-ID: <20121124150004.GQ15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 08:02:40AM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Fri, 23 Nov 2012 21:39:42 -0500, Jason Cooper wrote:
> > > +		pinctrl: pinctrl at d0200 {
> > > +			compatible = "marvell,dove-pinctrl";
> > > +			reg = <0xd0200 0x10>;
> > > +			clocks = <&gate_clk 22>;
> > 
> > The above line broke the dtbs build target for dove_defconfig.  I have
> > removed it.  Please let me know if that is not the correct answer.  This
> > was the only occurence of 'clk' in arch/arm/boot/dts/dove* .
> 
> Are you sure you merged
> 
>  [PATCH 7/8] ARM: dove: switch to DT clock providers ?
> 
> This one clearly adds gate_clk in dove.dtsi. This patch was part of the
> pull request:
> 
> Subject: [GIT PULL v3] core, cpu and gated clocks for mvebu
> Date: Tue, 20 Nov 2012 15:31:08 +0100

Yes, so that's what I thought happened.  This would have made orion/dt
depend upon mvebu/everything.  It already had two other dependencies.
Not ideal.

The good thing is, the build is not broken.  Once v3.8-rc1 drops with
all of our stuff merged, I'll post a fixup patch adding this back in.

thx,

Jason.
