From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 9 Nov 2018 21:22:55 +0100
Subject: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
In-Reply-To: <20181109201307.GV5259@lunn.ch>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
Message-ID: <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.11.2018 21:13, Andrew Lunn wrote:
> Hi Heiner
> 
>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>> +{
>> +	return phydrv->config_intr || phydrv->ack_interrupt;
>> +}
> 
> Should this be && not || ? I thought both needed to be provided for
> interrupts to work. 
> 
> 	   Andrew
> 
I've seen at least one driver which configures interrupts in
config_init and doesn't define a config_intr callback
(ack_interrupt callback is there)
Intention of this check is not to ensure that the driver defines
everything to make interrupts work. All it states:
If at least one of the irq-related callbacks is defined, then
we interpret this as indicator that the PHY supports interrupts.

Heiner
