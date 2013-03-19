From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 19 Mar 2013 05:39:53 +0000 (UTC)
Subject: OMAP baseline test results for v3.9-rc2
In-Reply-To: <alpine.DEB.2.00.1303141858320.28203@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303141858320.28203@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1303190537230.11826@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

restating these to reflect some bugfixes in the test log parsing scripts.

On Thu, 14 Mar 2013, Paul Walmsley wrote:

> vmlinux object size
> (delta in bytes from test_v3.9-rc1 
> (6dbe51c251a327e012439c4772097a13df43c5b8)):
>    text     data      bss    total  kernel
>  +13528      +64        0   +13592  omap1_defconfig
>   +9440     +120        0    +9560  omap2plus_defconfig
>  +13472     +128        0   +13600  omap2plus_defconfig_cpupm
>  +13472     +128        0   +13600  omap2plus_defconfig_omap2_4_only
>   +9756     +120        0    +9876  omap2plus_defconfig_omap3_4_only
>    +704      -64     -188     +452  rmk_omap3430_ldp_allnoconfig
>    +556      -64        0     +492  rmk_omap4430_sdp_oldconfig

The correct and complete delta should be:

vmlinux object size
(delta in bytes from test_v3.9-rc1 
(6dbe51c251a327e012439c4772097a13df43c5b8)):
   text     data      bss    total  kernel
   +620      -72       +4     +552  n800_multi_omap2xxx
  +5860     +648      +12    +6520  n800_only_a
  +9180      +88        0    +9268  omap1_defconfig_1510innovator_only
  +9440     +120        0    +9560  omap2plus_defconfig
 +13472     +128        0   +13600  omap2plus_defconfig_cpupm
 +13528      +64        0   +13592  omap2plus_defconfig_no_pm
 +13472     +128        0   +13600  omap2plus_defconfig_omap2_4_only
  +9756     +120        0    +9876  omap2plus_defconfig_omap3_4_only
   +704      -64     -188     +452  rmk_omap3430_ldp_allnoconfig
   +656      -64        0     +592  rmk_omap3430_ldp_oldconfig
   +704      -64     -188     +452  rmk_omap4430_sdp_allnoconfig
   +556      -64        0     +492  rmk_omap4430_sdp_oldconfig


- Paul
