From: nm@ti.com (Nishanth Menon)
Date: Tue, 17 Jun 2014 10:38:48 -0500
Subject: [RFC PATCH 0/7] ARM: OMAP4+: PRM: minor cleanups and dt support
 of interrupts
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Message-ID: <53A06108.9010108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 10:35 PM, Nishanth Menon wrote:
> 
> Hi,
> 
> The following series is a minimal set of cleanups and generalization
> in the direction of supporting daisychain wakeup on all OMAP4+
> platforms. We cannot still add IO_WAKEUP ability for OMAP5/DRA7/AM437x
> yet pending further pinctrl patches.
> 
> These do have a few cosmetic issues, but hope is to get a view about
> the approach. Also note that documentation of bindings for ti,dra7-prm
> etc are still pending.
> 
> Nishanth Menon (7):
>   ARM: OMAP4+: prminst: provide function to find prm_dev instance
>     offset
>   ARM: OMAP4: prm use the generic prm_inst to allow logic to be
>     abstracted
>   ARM: OMAP4+: PRM: remove "wkup" event
>   ARM: OMAP4+: PRM: register interrupt information from DT
>   ARM: dts: OMAP4: Add PRM interrupt
>   ARM: dts: OMAP5: add PRM interrupt
>   ARM: dts: DRA7: add PRM interrupt
> 
>  arch/arm/boot/dts/dra7.dtsi       |    1 +
>  arch/arm/boot/dts/omap4.dtsi      |    1 +
>  arch/arm/boot/dts/omap5.dtsi      |    1 +
>  arch/arm/mach-omap2/prm44xx.c     |   89 ++++++++++++++++++++++++++++++++-----
>  arch/arm/mach-omap2/prminst44xx.c |   41 ++++++++++-------
>  arch/arm/mach-omap2/prminst44xx.h |    3 ++
>  6 files changed, 111 insertions(+), 25 deletions(-)
> 
Gentle ping on this series? are we ok with this approach?

-- 
Regards,
Nishanth Menon
