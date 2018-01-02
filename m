From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jan 2018 17:33:08 +0000
Subject: [PATCH] [v2] ARM: B15: fix unused label warnings
In-Reply-To: <608efeca-c913-5f38-565f-9f792b51fae3@gmail.com>
References: <20171218165307.1472231-1-arnd@arndb.de>
 <608efeca-c913-5f38-565f-9f792b51fae3@gmail.com>
Message-ID: <20180102173308.GF28752@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 05:21:24PM -0800, Florian Fainelli wrote:
> On 12/18/2017 08:52 AM, Arnd Bergmann wrote:
> > The new conditionally compiled code leaves some labels and one
> > variable unreferenced when CONFIG_HOTPLUG_CPU and CONFIG_PM_SLEEP
> > are disabled:
> > 
> > arch/arm/mm/cache-b15-rac.c: In function 'b15_rac_init':
> > arch/arm/mm/cache-b15-rac.c:353:1: error: label 'out_unmap' defined but not used [-Werror=unused-label]
> >  out_unmap:
> >  ^~~~~~~~~
> > arch/arm/mm/cache-b15-rac.c:351:1: error: label 'out_cpu_dead' defined but not used [-Werror=unused-label]
> >  out_cpu_dead:
> >  ^~~~~~~~~~~~
> > At top level:
> > arch/arm/mm/cache-b15-rac.c:53:12: error: 'rac_config0_reg' defined but not used [-Werror=unused-variable]
> > 
> > This replaces the existing #ifdef conditionals with IS_ENABLED()
> > checks that let the compiler figure out for itself which code to
> > drop.
> > 
> > Fixes: 55de88778f4b ("ARM: 8726/1: B15: Add CPU hotplug awareness")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thanks Arnd!
> -- 
> Florian

Arnd, can you throw this at the patch system please?

Note that its now possible to add the "KernelVersion" tag in the email
headers as well as anywhere in the body.  The difference is that git
tools can add headers via standard options.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
