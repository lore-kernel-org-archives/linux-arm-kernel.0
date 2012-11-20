From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 20 Nov 2012 05:00:15 +0000
Subject: [PATCH 0/3] can: Add D_CAN raminit support to am335x-evm
In-Reply-To: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA75C73@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 23:38:22, AnilKumar, Chimata wrote:
> This patch series adds d_can raminit support to c_can/d_can driver,
> which is required to init/de-init D_CAN message RAM (holds message
> objects). Added corresponding DT changes to get resource of RAMINIT
> register and device instance.
> 
> These patches were tested on AM335x-EVM along with pinctrl data addition
> patch, which is not added to am335x-evm.dts (only supports CPLD profile#0)
> because d_can1 is supported under CPLD profile#1.

Hi Mark,

Gentle remainder to this series

Thanks
AnilKumar
 
> AnilKumar Ch (3):
>   can: c_can: Add d_can raminit support
>   ARM: dts: AM33XX: Add d_can instances to aliases
>   ARM: dts: AM33XX: Add memory resource to d_can node
> 
>  arch/arm/boot/dts/am33xx.dtsi          |    8 ++++++--
>  drivers/net/can/c_can/c_can.c          |   12 +++++++++++
>  drivers/net/can/c_can/c_can.h          |    3 +++
>  drivers/net/can/c_can/c_can_platform.c |   34 +++++++++++++++++++++++++++++++-
>  4 files changed, 54 insertions(+), 3 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> 
