From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 22 Jan 2013 02:24:44 +0000 (UTC)
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <87boci9str.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
Message-ID: <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi guys,

Regarding the AM33xx test failures with appended DTBs, it would be very 
helpful if especially the TI people could try reproducing the problem.
Otherwise it's going to cause problems with merging any new AM33xx 
patches, since I won't be able to test them without additional work.  
Plus, this is something that used to work up until d01e4afd, so something 
isn't right.

You'll need to use the bootloader that TI originally shipped with the 
BeagleBones:

U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)

This is because many folks don't replace their bootloader.  I do plan to 
add a test with a recent version of u-boot, but the kernel should not be 
dependent on the bootloader in any way to work correctly.  If it is, then 
we need to document what u-boot version the kernel started to work with.

The Kconfig that I use is here:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/build/am33xx_only/am33xx_only

It's possible that there's something wrong with the Kconfig.  It's 
basically just omap2plus_defconfig, but with all OMAP support for 
non-AM33xx turned off, and with the appended DTB and ATAG compatibility 
options turned on.

Let's try to do this ASAP.  That way, if it's some bootloader dependency 
or bug in the kernel, some fix can be merged during the v3.8-rc series, 
which is rapidly drawing to a close.


- Paul
