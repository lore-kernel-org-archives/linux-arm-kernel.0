From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 May 2018 02:15:03 +0200
Subject: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
In-Reply-To: <20180523000450.9384-1-f.fainelli@gmail.com>
References: <20180523000450.9384-1-f.fainelli@gmail.com>
Message-ID: <20180523001503.GA16062@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 05:04:49PM -0700, Florian Fainelli wrote:
> On newer PHYs, we need to select the expansion register to write with
> setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
> to being migrated to generic code under bcm-phy-lib.c which
> unfortunately used the older implementation from the BCM54xx days.

Hi Florian

Does selecting the expansion register affect access to the standard
registers? Does this need locking like the Marvell PHY has when
changing pages?

Thanks
	 Andrew
