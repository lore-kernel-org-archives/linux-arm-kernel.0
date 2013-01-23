From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 23 Jan 2013 11:58:51 +0100
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <50FFA620.50008@ti.com>
References: <50FEC503.2080602@wwwdotorg.org><CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com><50FFA620.50008@ti.com>
Message-ID: <20130123.125851.1450151123804323961.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> wrote @ Wed, 23 Jan 2013 09:58:08 +0100:

> On Tuesday 22 January 2013 10:34 PM, Olof Johansson wrote:
> > On Tue, Jan 22, 2013 at 8:57 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 01/21/2013 11:07 PM, Santosh Shilimkar wrote:
> >>> On Tuesday 22 January 2013 11:22 AM, Hiroshi Doyu wrote:
> >>>> Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.
> >>>>
> >>>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> >>>> ---
> >>> Looks fine. I will also update OMAP code with the new
> >>> interface. Thanks.
> >>
> >> OK, so patch 1/2 at least needs to get into a stable arm-soc branch
> >> then. Unless there are violent objections, I'll forward patch 1/2 to
> >> arm-soc and request it be added into a branch so that Tegra and OMAP can
> >> both merge it into their branches as a dependency. I guess patch 2/2
> >> could also be included; I don't think it has any complex dependencies
> >> that'd prevent that, and would help to show how patch 1/2 gets used.
> >>
> >> Hiroshi, is this series the only dependency you need for your Tegra114
> >> series? So, I could merge your Tegra114 series once this series is applied?
> >
> > For something like this, it might make more sense for us to just apply
> > the patches for OMAP on top, i.e. we'll pull the short branch from
> > you, and then we can just apply patches (with maintainer acks) on top,
> > instead of doing a bunch of single-patch pulls.
> >
> In case you decide to apply patches, you can use patch in the end
> of the email for OMAP. Attached the same in case mailer damages it.
> 
> Btw, I noticed the build error with patch 1/1. Since I wasn't using
> the first interface in OMAP code, I just bypassed it for testing.
> I might be missing some dependent patch which added
> read_cpuid_part_number().

The following one, which is in "next-20130123", is also necessary.

commit 59530adc3f1b802c275f0197fc3ac72dc014267a
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Tue Dec 18 04:06:37 2012 +0000

    ARM: Define CPU part numbers and implementors
