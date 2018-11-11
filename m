From: davem@davemloft.net (David Miller)
Date: Sun, 11 Nov 2018 09:38:03 -0800 (PST)
Subject: [PATCH net-next v3 0/2] net: phy: replace PHY_HAS_INTERRUPT
 with a check for config_intr and ack_interrupt
In-Reply-To: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
Message-ID: <20181111.093803.1220111720420778659.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Fri, 9 Nov 2018 18:15:31 +0100

> Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
> using interrupts isn't possible if a driver defines neither
> config_intr nor ack_interrupts callback. So we can replace checking
> flag PHY_HAS_INTERRUPT with checking for these callbacks.
> This allows to remove this flag from all driver configs.
> 
> v2:
> - add helper for check in patch 1
> - remove PHY_HAS_INTERRUPT from all drivers, not only Realtek
> - remove flag PHY_HAS_INTERRUPT completely
> 
> v3:
> - rebase patch 2

Series applied, but please sort out that one driver which is preventing
us requiring both config_intr && ack_interrupt.

Thanks.
