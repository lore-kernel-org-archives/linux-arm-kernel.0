From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Mar 2017 14:57:48 +0200
Subject: [PATCH net-next v2] net: mvneta: set rx mode during resume if
 interface is running
In-Reply-To: <20170329084719.3596-1-jszhang@marvell.com>
References: <20170329084719.3596-1-jszhang@marvell.com>
Message-ID: <20170329125748.GD28922@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 04:47:19PM +0800, Jisheng Zhang wrote:
> I found a bug by:
> 
> 0. boot and start dhcp client
> 1. echo mem > /sys/power/state
> 2. resume back immediately
> 3. don't touch dhcp client to renew the lease
> 4. ping the gateway. No acks
> 
> Usually, after step2, the DHCP lease isn't expired, so in theory we
> should resume all back. But in fact, it doesn't. It turns out
> the rx mode isn't resumed correctly. This patch fixes it by adding
> mvneta_set_rx_mode(dev) in the resume hook if interface is running.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
