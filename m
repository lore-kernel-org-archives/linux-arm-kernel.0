From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Mar 2013 19:24:02 +0100
Subject: [PATCH 2/2] ARM: remove mach .init_irq for irqchip_init users
In-Reply-To: <20130328124228.GA29616@verge.net.au>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364463704-13692-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130328124228.GA29616@verge.net.au>
Message-ID: <51548AC2.1010802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Le 28/03/2013 13:42, Simon Horman a ?crit :
> On Thu, Mar 28, 2013 at 10:41:44AM +0100, Maxime Ripard wrote:
>> Now that the arm core code calls irqchip_init, we can remove it from all
>> the machines that were using it.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/mach-bcm/board_bcm.c                  |    1 -
>>  arch/arm/mach-msm/board-dt-8660.c              |    1 -
>>  arch/arm/mach-msm/board-dt-8960.c              |    1 -
>>  arch/arm/mach-nomadik/cpu-8815.c               |    1 -
>>  arch/arm/mach-picoxcell/common.c               |    1 -
>>  arch/arm/mach-prima2/common.c                  |    1 -
>>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 -
>>  arch/arm/mach-shmobile/setup-emev2.c           |    1 -
>>  arch/arm/mach-shmobile/setup-sh73a0.c          |    1 -
>>  arch/arm/mach-spear/spear1310.c                |    1 -
>>  arch/arm/mach-spear/spear1340.c                |    1 -
>>  arch/arm/mach-spear/spear300.c                 |    1 -
>>  arch/arm/mach-spear/spear310.c                 |    1 -
>>  arch/arm/mach-spear/spear320.c                 |    1 -
>>  arch/arm/mach-spear/spear6xx.c                 |    1 -
>>  arch/arm/mach-vexpress/v2m.c                   |    1 -
>>  arch/arm/mach-virt/virt.c                      |    1 -
>>  arch/arm/mach-zynq/common.c                    |    1 -
>>  18 files changed, 18 deletions(-)
> 
> mach-shmobile portion:
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Thanks!

> 
> I have some new users of this queued up for v3.10.
> How should we handle that?

Since the old behaviour is preserved, I guess it doesn't matter much,
and one of us can always make a followup patch on top of these patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
