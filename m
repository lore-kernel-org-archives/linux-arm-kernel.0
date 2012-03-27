From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 27 Mar 2012 16:57:40 +0300
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for
 v3.4
In-Reply-To: <87pqchv1pc.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
 <20120311204232.GC3171@opensource.wolfsonmicro.com>
 <87399dzq5e.fsf@ti.com>
 <20120312173215.GL3110@opensource.wolfsonmicro.com>
 <87pqchv1pc.fsf@ti.com>
Message-ID: <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 1:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tony, updated pull request below. ?This includes all the TWL depencies
> merged from the 'topic/twl' tag in Mark's tree.
>

Has this been lost now? It seems regulator parts got merged, but
voltage parts are missing from Arnd's pull requests and are not
showing up in linux-next.
Was looking forward for voltage control in 3.4 to achieve higher clock
rates on our aging OMAP3 hardware.

>
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
>
> ?Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/pm/smps-regulator
>
> for you to fetch changes up to 39358f2b57f37fe079eff4159307c844a0bfb176:
>
> ?Merge branch 'pm-wip/smps-regulator' into for_3.4/pm/smps-regulator (2012-03-12 15:36:45 -0700)
>
> ----------------------------------------------------------------
>
> Kevin Hilman (3):
> ? ? ?ARM: OMAP2+: voltage: ensure voltage used is exact voltage from OPP table
> ? ? ?Merge tag 'topic/twl' into for_3.4/pm/smps-regulator
> ? ? ?Merge branch 'pm-wip/smps-regulator' into for_3.4/pm/smps-regulator
>
> Laxman Dewangan (1):
> ? ? ?regulator: twl6030: Fix voltage selection logic
>
> Peter Ujfalusi (2):
> ? ? ?regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
> ? ? ?mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS
>
> Rajendra Nayak (1):
> ? ? ?regulator: twl: adapt twl-regulator driver to dt
>
> Tero Kristo (6):
> ? ? ?arm: omap3: voltage: fix channel configuration
> ? ? ?arm: omap3: add common twl configurations for vdd1 and vdd2
> ? ? ?arm: omap3: twl: add external controllers for core voltage regulators
> ? ? ?arm: omap4: add common twl configurations for vdd1, vdd2 and vdd3
> ? ? ?regulator: twl4030: add support for external voltage get/set
> ? ? ?regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators
>
> ?.../bindings/regulator/twl-regulator.txt ? ? ? ? ? | ? 68 ++++
> ?arch/arm/mach-omap2/twl-common.c ? ? ? ? ? ? ? ? ? | ?147 +++++++++
> ?arch/arm/mach-omap2/vc3xxx_data.c ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-omap2/voltage.c ? ? ? ? ? ? ? ? ? ? ?| ? 21 +-
> ?drivers/mfd/twl-core.c ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 41 ++-
> ?drivers/regulator/twl-regulator.c ? ? ? ? ? ? ? ? ?| ?327 +++++++++++++++-----
> ?include/linux/i2c/twl.h ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 14 +-
> ?7 files changed, 532 insertions(+), 87 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html


--
Gra?vydas
