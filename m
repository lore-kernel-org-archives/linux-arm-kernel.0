From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jul 2013 21:16:47 +0300
Subject: OMAP baseline test results for v3.10-rc7
In-Reply-To: <20130701204236.GA805@arwen.pp.htv.fi>
References: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
 <20130701204236.GA805@arwen.pp.htv.fi>
Message-ID: <20130702181647.GA9216@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 01, 2013 at 11:42:36PM +0300, Felipe Balbi wrote:
> On Mon, Jul 01, 2013 at 07:48:50PM +0000, Paul Walmsley wrote:
> > Boot to userspace:
> >     FAIL ( 2/12): 37xxevm, am335xbonelt
> 
> <quoting part of [1]>
> | U-Boot# tftp 0x82000000 am335x-boneblack.dtb
> | link up on port 0, speed 100, full duplex
> | Using cpsw device
> | TFTP from server 192.168.57.1; our IP address is 192.168.57.138
> | Filename 'am335x-boneblack.dtb'.
> 
> Where are you taking am335x-boneblack.dtb from ? It's not in mainline
> v3.10-rc7 kernel:
> 
> $ ls arch/arm/boot/dts/am33*.dts
> arch/arm/boot/dts/am335x-bone.dts  arch/arm/boot/dts/am335x-evm.dts
> arch/arm/boot/dts/am335x-evmsk.dts
> $ git grep -e boneblack arch/arm/
> $ echo $
> 1
> $ git show
> commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Jun 22 09:47:31 2013 -1000
> 
>     Linux 3.10-rc7
> 
> diff --git a/Makefile b/Makefile
> index c6863b5..0142c93 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  VERSION = 3
>  PATCHLEVEL = 10
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc6
> +EXTRAVERSION = -rc7
>  NAME = Unicycling Gorilla
>  
>  # *DOCUMENTATION*
> 
> [1] http://www.pwsan.com/omap/testlogs/test_v3.10-rc7/20130630191558/boot/am335xbonelt/am335x-bone/am335xbonelt_log.txt

just a gentle ping here, wondering if you still have some garbage DTBs
left in your tree.


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/6599572e/attachment-0001.sig>
