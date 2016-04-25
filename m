From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Apr 2016 17:20:38 +0200
Subject: [PATCH 0/6] Add Shared MDIO framework for iProc based SoCs
In-Reply-To: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160425152038.GJ6575@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 02:48:37PM +0530, Pramod Kumar wrote:
> Broadcom iProc based SoCs uses MDIO bus for programming PHYs belonging to
> different I/O subsystem like USB, SATA, PCIe, ETHERNET etc. Every subsystem
> is referred as "Master" When a master is selected, all PHYs belonging to
> this subsystem get active on the MDIO bus and responds to MDIO transaction.
> In this way one MDIO controller is shared among all masters hence named as
> "Shared MDIO controller".
> 
> We have two important entities in "Shared MDIO Bus" framework:
> 1) shared_mdio_master and
> 2) shared_mdio_driver.
> 
> The shared MDIO controller driver is registered as platform driver and it
> creates shared_mdio_master instances and adds them to "Shared MDIO Bus"
> framework.

Hi Pramod

What i'm missing is an explanation why the existing MDIO bus framework
cannot be used. I recently made it more generic so that you can hang
any type of device off it, not just PHYs.

    Thanks
	Andrew
