From: davem@davemloft.net (David Miller)
Date: Wed, 20 Nov 2013 17:15:25 -0500 (EST)
Subject: [PATCH RFC v1 0/7] net: phy: Ethernet PHY powerdown optimization
In-Reply-To: <528D217B.5020500@gmail.com>
References: <1384978913-8052-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131120.153642.2045230991917379052.davem@davemloft.net>
 <528D217B.5020500@gmail.com>
Message-ID: <20131120.171525.1584609970007162599.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Wed, 20 Nov 2013 21:54:19 +0100

> Right, as far as I understand BMCR powerdown, i.e. what is called in
> genphy_suspend/resume, powers down the PHY but _does_ retain PHY
> config.
> It is not resetting the device.
> 
> I haven't checked a lot of datasheets but [1] notes that "registers
> will
> preserve their configuration". Even if we have PHYs that do not
> preserve
> it, they should have a device specific callback for suspend/resume
> that
> takes care of preserving it.
> 
> [1] http://www.ti.com/lit/an/snoa463a/snoa463a.pdf

Thanks, that addresses my concerns.
