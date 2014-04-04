From: hannes@stressinduktion.org (Hannes Frederic Sowa)
Date: Fri, 4 Apr 2014 13:48:48 +0200
Subject: Inconsistent lock state introduced by ipv6/addrconf change
In-Reply-To: <20140404073455.GB29778@dragon>
References: <20140404073455.GB29778@dragon>
Message-ID: <20140404114848.GD13354@order.stressinduktion.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On Fri, Apr 04, 2014 at 03:34:56PM +0800, Shawn Guo wrote:
> I'm running into an inconsistent lock state warning on the final v3.14
> kernel (-rc8 is good) on Freescale i.MX6 platform with fec driver
> (drivers/net/ethernet/freescale/fec_main.c).  The git bisect points
> the finger to commit c15b1cc (ipv6: move DAD and addrconf_verify
> processing to workqueue).  Reverting the commit does fix the problem
> for me.  The image is built from arch/arm/configs/imx_v6_v7_defconfig.
> 
> The interesting part is the same warning shows up on mainline tree until
> net-next gets merged with commit cd6362b.  That's why Olof's autobooter
> keeps reporting failure on hummingboard and wandboard (both i.MX6 based)
> since v3.14 release [1], but reports success after commit cd6362b.
> 
> We're less concerned by the mainline tree, since the problem disappeared
> now (nice to know why though).  But we do still want to fix it for 3.14
> stable kernel.

The patch which fixes this is already queued up for -stable:

http://patchwork.ozlabs.org/patch/335536/

Sorry for the inconvenience,

  Hannes
