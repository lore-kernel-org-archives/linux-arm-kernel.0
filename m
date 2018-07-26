From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Jul 2018 23:54:46 -0700
Subject: [GIT PULL] dts changes to use ti-sysc driver for omap4 l4
In-Reply-To: <pull-1532403550-185479@atomide.com>
References: <pull-1532403550-185479@atomide.com>
Message-ID: <20180726065446.i2xehwfacss4r6tf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 08:40:03PM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 91f6278bfa3966529c61808bd3cb8f05d7ed5dc6:
> 
>   ARM: dts: am335x: add am335x-sancloud-bbe board support (2018-07-17 01:05:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/dt-pt3-signed
> 
> for you to fetch changes up to ab8b1fdd012f41b27f85a6bb271389fd7ff349ea:
> 
>   Merge branch 'omap-for-v4.19/dt-sysc-v2' into omap-for-v4.19/dt (2018-07-20 22:22:08 -0700)
> 
> ----------------------------------------------------------------
> Start using ti-sysc with device tree data for omap4 l4 devices
> 
> With ti-sysc driver working for most use cases, we can start converting
> the omap variant SoCs to use device tree data for the interconnect target
> modules instead of the legacy hwmod platform data.
> 
> We start with omap4 l4 devices excluding the ones that still depend on
> a reset controller driver like DSP MMU. And we don't yet convert the l4
> ABE instance as that needs a bit more work.
> 
> We also add a proper interconnect hierarchy for the devices while at it
> to make further work on genpd easier and to avoid most deferred probe
> issues.
> 
> At this point we are not dropping any platform data, and we initially
> still use it to validate the dts data. Then in later merge cycles we
> can start dropping the related platform data.
> 

Nice! Merged, thanks.


-Olof
