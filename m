From: davem@davemloft.net (David Miller)
Date: Mon, 29 Jan 2018 12:22:32 -0500 (EST)
Subject: [PATCH v4] net: ethernet: cavium: Correct Cavium Thunderx NIC
 driver names accordingly to module name
In-Reply-To: <1516880297-6636-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1516630407-23161-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1516880297-6636-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180129.122232.1135976323173289174.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Thu, 25 Jan 2018 03:38:17 -0800

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> It was found that ethtool provides unexisting module name while
> it queries the specified network device for associated driver
> information. Then user tries to unload that module by provided
> module name and fails.
> 
> This happens because ethtool reads value of DRV_NAME macro,
> while module name is defined at the driver's Makefile.
> 
> This patch is to correct Cavium CN88xx Thunder NIC driver names
> (DRV_NAME macro) 'thunder-nicvf' to 'nicvf' and 'thunder-nic'
> to 'nicpf', sync bgx and xcv driver names accordingly to their
> module names.
> 
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

Applied to net-next, thank you.
