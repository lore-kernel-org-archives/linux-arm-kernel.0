From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 11 Sep 2012 15:25:07 +0200
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <504ECF11.2000206@wwwdotorg.org>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
 <20120910155224.GE31430@game.jcrosoft.org>
 <504E28B0.5040404@gmail.com>
 <20120911044907.GF31430@game.jcrosoft.org>
 <504ECF11.2000206@wwwdotorg.org>
Message-ID: <20120911132507.GH31430@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:41 Mon 10 Sep     , Stephen Warren wrote:
> On 09/10/2012 10:49 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:51 Mon 10 Sep     , Rob Herring wrote:
> >> On 09/10/2012 10:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>> On 15:12 Thu 06 Sep     , Rob Herring wrote:
> >>>> From: Rob Herring <rob.herring@calxeda.com>
> >>>>
> >>>> In preparation to support multi-platform kernels, move all the dtb targets
> >>>> out of the mach Makefile.boot and into the arch/arm/boot/dts/Makefile
> >>>> which is closer to the sources.
> >>>>
> >>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >>>> Cc: Russell King <linux@arm.linux.org.uk>
> >>>> Cc: Andrew Victor <linux@maxim.org.za>
> >>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> >>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
> >>>> Cc: Sascha Hauer <kernel@pengutronix.de>
> >>>> Cc: Jason Cooper <jason@lakedaemon.net>
> >>>> Cc: Andrew Lunn <andrew@lunn.ch>
> >>>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> >>>> Cc: Shawn Guo <shawn.guo@linaro.org>
> >>>> Cc: Viresh Kumar <viresh.linux@gmail.com>
> >>>> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> >>>> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> >>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
> >>>> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> >>>> Cc: Linus Walleij <linus.walleij@linaro.org>
> >>>> ---
> >>>>  arch/arm/boot/Makefile                |    2 ++
> >>>>  arch/arm/boot/dts/Makefile            |   41 +++++++++++++++++++++++++++++++++
> >>>>  arch/arm/mach-at91/Makefile.boot      |   24 -------------------
> >>>>  arch/arm/mach-exynos/Makefile.boot    |    3 ---
> >>>>  arch/arm/mach-imx/Makefile.boot       |    7 ------
> >>>>  arch/arm/mach-kirkwood/Makefile.boot  |   11 ---------
> >>>>  arch/arm/mach-lpc32xx/Makefile.boot   |    2 --
> >>>>  arch/arm/mach-mvebu/Makefile.boot     |    2 --
> >>>>  arch/arm/mach-mxs/Makefile.boot       |    9 --------
> >>>>  arch/arm/mach-spear13xx/Makefile.boot |    3 ---
> >>>>  arch/arm/mach-spear3xx/Makefile.boot  |    4 ----
> >>>>  arch/arm/mach-spear6xx/Makefile.boot  |    2 --
> >>>>  arch/arm/mach-tegra/Makefile.boot     |    8 -------
> >>>>  arch/arm/mach-ux500/Makefile.boot     |    2 --
> >>>>  arch/arm/mach-vexpress/Makefile.boot  |    5 ----
> >>>>  15 files changed, 43 insertions(+), 82 deletions(-)
> >>>>  create mode 100644 arch/arm/boot/dts/Makefile
> >>>>
> >>>> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> >>>> index c877087..3fdab01 100644
> >>>> --- a/arch/arm/boot/Makefile
> >>>> +++ b/arch/arm/boot/Makefile
> >>>> @@ -15,6 +15,8 @@ ifneq ($(MACHINE),)
> >>>>  include $(srctree)/$(MACHINE)/Makefile.boot
> >>>>  endif
> >>>>  
> >>>> +include $(srctree)/arch/arm/boot/dts/Makefile
> >>>> +
> >>>>  # Note: the following conditions must always be true:
> >>>>  #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
> >>>>  #   PARAMS_PHYS must be within 4MB of ZRELADDR
> >>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>>> new file mode 100644
> >>>> index 0000000..e59586b
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/boot/dts/Makefile
> >>>> @@ -0,0 +1,41 @@
> >>>> +dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
> >>>
> >>> sorry I see no need of the dtb-y
> >>>
> >>> just do all the time
> >>
> >> That's not how it works today. dtb's only for all enabled platforms are
> >> built. Changing the behavior should be a different patch.
> >
> > no I see no point to check if the platform is enable or not just build all
> > 
> > This will allow to check them
> 
> Why would I want to build 100 .dtbs that I don't care about? If I want
> to check them, I can either build all the defconfigs, or simply write a
> trivial sh for loop to loop over *.dts in the boot/dts directory.
I do not like this idea to just build the dts per platform

It save nearly no time to compile

it just make it fragile to maintain

Best Regards,
J.
