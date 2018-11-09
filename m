From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Nov 2018 21:13:07 +0100
Subject: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
In-Reply-To: <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
Message-ID: <20181109201307.GV5259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiner

> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> +{
> +	return phydrv->config_intr || phydrv->ack_interrupt;
> +}

Should this be && not || ? I thought both needed to be provided for
interrupts to work. 

	   Andrew
