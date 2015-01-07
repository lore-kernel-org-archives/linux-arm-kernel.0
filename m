From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 15:00:07 -0800
Subject: [PATCH 00/11] ARM: OMAP3: legacy clock data move under clk driver
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Message-ID: <20150107230006.GE13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [141216 08:22]:
> Hi,
> 
> These patches move the legacy clock data for omap3 under drivers/clk/ti.
> After these patches are applied, it should be possible to get rid of
> clk-private.h (long pending project for Mike.)
> 
> Testing done (on top of 3.18-rc1):
> 
> omap3-beagle: boot / suspend-resume (ret/off) / cpuidle (ret/off)
> omap3-beagle-xm: boot upto fs mount (see note below)
> sdp3430: boot
> n900: boot
> 
> Note: beagle-xm failed with FS mount on the board I have access to, but
>       this happens with clean 3.18-rc1 and linux-next also at the moment.
>       The board has probably corrupted filesystem image but I am unable
>       to fix this atm (remote board.)
> 
> Test branch:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.18-rc1-omap3-clk-rework

Great, hopefully this will finally allow Mike to make the
generic struct clk private to drivers/clk :)

Seems to boot just fine based on a quick legacy booting test
on n900.

Mike, assuming no other issues, can you please apply these into a
immutable branch against v3.19-rc1 that Paul and I can also merge
in as needed?

Please also feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
