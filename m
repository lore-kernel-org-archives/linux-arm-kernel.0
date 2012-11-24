From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 24 Nov 2012 08:02:40 +0100
Subject: [PATCH 3/4] ARM: Dove: Convert to DT GPIO and pinctrl
In-Reply-To: <20121124023942.GO15800@titan.lakedaemon.net>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353317996-20841-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20121124023942.GO15800@titan.lakedaemon.net>
Message-ID: <20121124080240.3f600e89@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 23 Nov 2012 21:39:42 -0500, Jason Cooper wrote:
> > +		pinctrl: pinctrl at d0200 {
> > +			compatible = "marvell,dove-pinctrl";
> > +			reg = <0xd0200 0x10>;
> > +			clocks = <&gate_clk 22>;
> 
> The above line broke the dtbs build target for dove_defconfig.  I have
> removed it.  Please let me know if that is not the correct answer.  This
> was the only occurence of 'clk' in arch/arm/boot/dts/dove* .

Are you sure you merged

 [PATCH 7/8] ARM: dove: switch to DT clock providers ?

This one clearly adds gate_clk in dove.dtsi. This patch was part of the
pull request:

Subject: [GIT PULL v3] core, cpu and gated clocks for mvebu
Date: Tue, 20 Nov 2012 15:31:08 +0100

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
