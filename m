From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:33:34 +0100
Subject: [GIT PULL] STM32 defconfig updates for v4.6 #1
In-Reply-To: <CALszF6Cgng3Yr_vrag7LY9zYunV_Fca0oHKX45w6t29DFqC5gA@mail.gmail.com>
References: <56D6C623.8030908@gmail.com> <2216821.q30YMIK6pX@wuerfel>
 <CALszF6Cgng3Yr_vrag7LY9zYunV_Fca0oHKX45w6t29DFqC5gA@mail.gmail.com>
Message-ID: <1624048.IcI7yXPN7a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 09:59:35 Maxime Coquelin wrote:
> 2016-03-02 23:21 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 02 March 2016 11:53:23 Maxime Coquelin wrote:
> >> Highlights:
> >> -----------
> >>   - Enable GPIO led driver in stm32_defconfig
> >>   - Introduce a config fragment to override RAM base address
> >>
> >
> > Our first config fragment 
> 
> Yes! Out of curiosity, did you see the question I asked you about fragments?
> See "Re: [PATCH v3 4/4] ARM: STM32: Enable Ethernet in stm32_defconfig".
> (https://lkml.org/lkml/2016/3/1/474)
> 
> This is not urgent, it can wait for after the merge window, but I will
> be happy to have your view on this.
> 

No, I missed that. Generally, I'd say we should limit the use of Kconfig
fragments to more fundamental settings, it should not replace the
manual configuration that users apply to pick the set of drivers
they want. In the end there is not much difference between someone
locally turning on CONFIG_INET when they need it, or using a fragment
that does the same.

Please just pick one default here (ethernet and ipv4 both enabled or
both disabled) that makes sense for most users, and have the others
change it manually.

	Arnd
