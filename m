From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 24 Jan 2013 09:57:04 -0600
Subject: OMAP4 randconfig failure: Zynq
In-Reply-To: <20130124111117.GU23505@n2100.arm.linux.org.uk>
References: <20130124111117.GU23505@n2100.arm.linux.org.uk>
Message-ID: <20130124155704.GJ11970@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 11:11:17AM +0000, Russell King - ARM Linux wrote:
> The OMAP4 randconfig build last night failed with this error:
> 
> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)
> 
> Full details at the usual place - 
> http://www.arm.linux.org.uk/developer/build/

Curious.  This doesn't look like a valid config to me.

In particular, both ARCH_MULTIPLATFORM and ARCH_OMAP are selected, even
though those selections should be mutually exclusive, since they fall
under the same:

    choice
    	prompt "ARM system type"
    	default ARCH_MULTIPLATFORM

Perhaps it's because CONFIG_ARCH_OMAP=y was setup in the seed?

oldconfig seems to complain, too:

      .config:340:warning: override: ARCH_OMAP changes choice state

  Josh
