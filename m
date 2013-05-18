From: davem@davemloft.net (David Miller)
Date: Fri, 17 May 2013 17:36:44 -0700 (PDT)
Subject: [PATCHv6 0/3] Add support for velocity network driver on
 platform devices
In-Reply-To: <20130517.141938.2120801813213703422.davem@davemloft.net>
References: <1368768078-16121-1-git-send-email-linux@prisktech.co.nz>
 <20130517.141938.2120801813213703422.davem@davemloft.net>
Message-ID: <20130517.173644.1877140985770026320.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Fri, 17 May 2013 14:19:38 -0700 (PDT)

> 
> Series applied, thanks.

I'm reverting this, you're not using the correct types for the PM
functions you're hooking up.

drivers/net/ethernet/via/via-velocity.c:3238:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/net/ethernet/via/via-velocity.c:3238:8: warning: (near initialization for ?velocity_pm_ops.suspend?) [enabled by default]
drivers/net/ethernet/via/via-velocity.c:3238:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/net/ethernet/via/via-velocity.c:3238:8: warning: (near initialization for ?velocity_pm_ops.freeze?) [enabled by default]
drivers/net/ethernet/via/via-velocity.c:3238:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/net/ethernet/via/via-velocity.c:3238:8: warning: (near initialization for ?velocity_pm_ops.poweroff?) [enabled by default]
