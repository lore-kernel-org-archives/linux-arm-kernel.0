From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 25 Nov 2013 15:15:39 +0000 (UTC)
Subject: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
In-Reply-To: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Nov 2013, Paul Walmsley wrote:

> Boot to userspace:
>     FAIL ( 1/11): 37xxevm

An auto-bisect traced this to:

commit 95807689eab8441737572d1a9daaa1025429a908
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Oct 14 11:31:43 2013 -0700

    ARM: OMAP2+: Remove legacy booting support for omap3 EVM
    
    We now have pretty decent support with the device tree
    based booting. Patches to add more features are welcome.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>


So looks like this is due to the switchover to DT-based booting for 37xx 
EVM.  Will plug that in here and re-test.
  

- Paul
