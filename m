From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 31 Jan 2013 15:40:29 +0000 (UTC)
Subject: OMAP4 PM bootloader dependency problems
In-Reply-To: <510A54F8.4090609@ti.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
 <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
 <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com>
Message-ID: <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 31 Jan 2013, Rajendra Nayak wrote:

> Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
> that it isn't enabled by default in omap2plus_defconfig. Also
> throw one when a suspend fails, saying bootloader *could be* a possible
> cause specifying the right version to be used.

In my view, these steps aren't sufficient, for the reasons described in 

http://marc.info/?l=linux-omap&m=135964568904053&w=2

Even with CONFIG_CPU_IDLE=n, it's still possible to attempt to enter 
full-chip retention idle on OMAP4 via 'echo mem > /sys/power/state', so it 
doesn't seem right to restrict a solution to that case.

regards,


- Paul
