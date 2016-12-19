From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Dec 2016 15:38:48 +0100
Subject: [PATCH 1/4] net: dsa: mv88e6xxx: Allow mv88e6xxx_smi_init() to
 be used at address 0x1
In-Reply-To: <20161219141610.30934-2-romain.perier@free-electrons.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-2-romain.perier@free-electrons.com>
Message-ID: <20161219143848.GA10048@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 03:16:06PM +0100, Romain Perier wrote:
> Currently, the function mv88e6xxx_smi_init() returns -EINVAL if the bit
> zero of sw_addr is 0x1. However, on some platforms, ethernet switches
> are configured in Multi chip addressing mode and available at MDIO
> address 0x1.

Hi Romain

What branch is this against? net-next?

Please see:

https://www.spinics.net/lists/netdev/msg409156.html

It would be nicer to use Volodymyr, since it has been reviewed. 

Volodymyr, what happened to your version 2? Did David accept it?

	   Andrew
