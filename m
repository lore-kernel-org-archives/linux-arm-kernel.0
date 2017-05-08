From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 8 May 2017 14:53:38 -0700
Subject: [PATCH] net: mdio-mux: bcm-iproc: call mdiobus_free() in error
 path
In-Reply-To: <1494280115-9252-1-git-send-email-jon.mason@broadcom.com>
References: <1494280115-9252-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <43692ac5-6db4-2ab1-737c-424be7db20f7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2017 02:48 PM, Jon Mason wrote:
> If an error is encountered in mdio_mux_init(), the error path will call
> mdiobus_free().  Since mdiobus_register() has been called prior to
> mdio_mux_init(), the bus->state will not be MDIOBUS_UNREGISTERED.  This
> causes a BUG_ON() in mdiobus_free().  To correct this issue, add an
> error path for mdio_mux_init() which calls mdiobus_unregister() prior to
> mdiobus_free().
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Fixes: 98bc865a1ec8 ("net: mdio-mux: Add MDIO mux driver for iProc SoCs")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
