From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 14:11:27 +0100
Subject: [PATCH 3/3] ARM: dts: OMAP3: Use MTD constants for OMAP3 boards
In-Reply-To: <51B74267.1000700@collabora.co.uk>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
 <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch>
 <51B74267.1000700@collabora.co.uk>
Message-ID: <20130612131127.9E13F3E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 17:29:43 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> On 06/11/2013 04:48 PM, Florian Vaussard wrote:
> > Use the MTD constants for NAND and OneNAND nodes used in OMAP3
> > DTS.
> > 
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> > ---
> >  arch/arm/boot/dts/omap3-devkit8000.dts |   10 +++++-----
> >  arch/arm/boot/dts/omap3-igep0020.dts   |   10 +++++-----
> >  arch/arm/boot/dts/omap3-igep0030.dts   |   10 +++++-----
> >  arch/arm/boot/dts/omap3430-sdp.dts     |   28 ++++++++++++++--------------
> >  4 files changed, 29 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> > index 5be71b1..08699cb 100644
> > --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> > +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> > @@ -143,27 +143,27 @@
> >  
> >  		x-loader at 0 {
> >  			label = "X-Loader";
> > -			reg = <0 0x80000>;
> > +			reg = <(0 * SZ_128K) (4 * SZ_128K)>;
> >  		};
> >  
> >  		bootloaders at 80000 {
> >  			label = "U-Boot";
> > -			reg = <0x80000 0x1e0000>;
> > +			reg = <(4 * SZ_128K) (15 * SZ_128K)>;
> >  		};
> >  
> >  		bootloaders_env at 260000 {
> >  			label = "U-Boot Env";
> > -			reg = <0x260000 0x20000>;
> > +			reg = <(19 * SZ_128K) (1 * SZ_128K)>;
> >  		};
> >  
> >  		kernel at 280000 {
> >  			label = "Kernel";
> > -			reg = <0x280000 0x400000>;
> > +			reg = <(20 * SZ_128K) (32 * SZ_128K)>;
> >  		};
> >  
> >  		filesystem at 680000 {
> >  			label = "File System";
> > -			reg = <0x680000 0xf980000>;
> > +			reg = <(52 * SZ_128K) MTDPART_SIZ_FULL>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> > index e8c4828..3476b3c 100644
> > --- a/arch/arm/boot/dts/omap3-igep0020.dts
> > +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> > @@ -97,23 +97,23 @@
> >  
> >  		partition at 0 {
> >  			label = "SPL";
> > -			reg = <0 0x100000>;
> > +			reg = <(0 * SZ_256K) (4 * SZ_256K)>;
> >  		};
> >  		partition at 0x80000 {
> >  			label = "U-Boot";
> > -			reg = <0x100000 0x180000>;
> > +			reg = <(4 * SZ_256K) (6 * SZ_256K)>;
> >  		};
> >  		partition at 0x1c0000 {
> >  			label = "Environment";
> > -			reg = <0x280000 0x100000>;
> > +			reg = <(10 * SZ_256K) (4 * SZ_256K)>;
> >  		};
> >  		partition at 0x280000 {
> >  			label = "Kernel";
> > -			reg = <0x380000 0x300000>;
> > +			reg = <(14 * SZ_256K) (12 * SZ_256K)>;
> >  		};
> >  		partition at 0x780000 {
> >  			label = "Filesystem";
> > -			reg = <0x680000 0x1f980000>;
> > +			reg = <(26 * SZ_256K) MTDPART_SIZ_FULL>;
> >  		};
> >  	};
> >  
> > diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> > index 644d053..e4f078c 100644
> > --- a/arch/arm/boot/dts/omap3-igep0030.dts
> > +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> > @@ -72,23 +72,23 @@
> >  
> >  		partition at 0 {
> >  			label = "SPL";
> > -			reg = <0 0x100000>;
> > +			reg = <(0 * SZ_256K) (4 * SZ_256K)>;
> >  		};
> >  		partition at 0x80000 {
> >  			label = "U-Boot";
> > -			reg = <0x100000 0x180000>;
> > +			reg = <(4 * SZ_256K) (6 * SZ_256K)>;
> >  		};
> >  		partition at 0x1c0000 {
> >  			label = "Environment";
> > -			reg = <0x280000 0x100000>;
> > +			reg = <(10 * SZ_256K) (4 * SZ_256K)>;
> >  		};
> >  		partition at 0x280000 {
> >  			label = "Kernel";
> > -			reg = <0x380000 0x300000>;
> > +			reg = <(14 * SZ_256K) (12 * SZ_256K)>;
> >  		};
> >  		partition at 0x780000 {
> >  			label = "Filesystem";
> > -			reg = <0x680000 0x1f980000>;
> > +			reg = <(26 * SZ_256K) MTDPART_SIZ_FULL>;
> >  		};
> >  	};
> >  };
> 
> Hi Florian,
> 
> I don't have access to my IGEP board so I can test it right now but the patch
> looks good to me.
> 
> In fact I wanted to use MTDPART_SIZ_FULL when added the NAND nodes since not all
> IGEP boards have 512MB flash but I didn't know that a value of 0 meant that.
> 
> So thanks a lot for doing this!
> 
> Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

However, the binding doesn't allow for that and so it is a bug in the
parser. Relying on '0' is not safe. Nor does it match device tree
convention for the reg property, so don't count on getting an extension
added to allow it.

NAK
