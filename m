From: mpfj-list@mimc.co.uk (Mark Jackson)
Date: Tue, 30 Oct 2012 10:55:34 +0000
Subject: OMAP baseline test results for v3.7-rc3
In-Reply-To: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
Message-ID: <508FB226.20604@mimc.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/12 02:36, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.7-rc3.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc3/20121028162003/
> 
> 
> Passing tests
> -------------
> 
> Boot to userspace: 2420n800, 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
>                    4430es2panda, 5912osk, am335xbone
> 
> PM ret/off, suspend + dynamic idle: (none)
> 
> 
> Failing tests: fixed by posted patches
> --------------------------------------
> 
> Boot tests:
> 
> * 2430sdp: vfp_reload_hw oops during MMC initialization
>   - Kernel attempts to save FP registers that don't exist; fix posted:
>     - http://www.spinics.net/lists/arm-kernel/msg200646.html
>     - added to rmk's patch system as 7566/1
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - Due to GPMC missing support for DT
>   - Temporary workaround at http://www.spinics.net/lists/arm-kernel/msg200787.html
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2

At what point is booting from MMC on the BeagleBone going to start working ?

I only ask, since, by default, a new BeagleBone is setup to boot from MMC, so anyone testing a new
kernel will probably expect the same setup to work.

Cheers
Mark JACKSON
