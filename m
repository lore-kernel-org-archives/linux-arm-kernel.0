From: davem@davemloft.net (David Miller)
Date: Wed, 24 Jan 2018 16:27:37 -0500 (EST)
Subject: [PATCH v3] net: ethernet: cavium: Correct Cavium Thunderx NIC
 module and driver names
In-Reply-To: <1516630407-23161-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1516290789-3585-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1516630407-23161-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180124.162737.1427515957453841771.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Mon, 22 Jan 2018 06:13:27 -0800

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
> This patch is to correct Cavium CN88xx Thunder NIC driver modules
> names 'nicvf' to 'thunder_nicvf' and 'nicpf' to 'thunder_nicpf' along
> with updating DRV_NAME macro values accordingly.
> 
> Signed-off-by: Dean Nelson <dnelson@redhat.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

Once your driver has been deployed in a real upstream release you
should never change the driver module name.

So if you want to fix things, you'll have to fix them the other
way around, by not changing the module name but changing the
strings that ethtool ends up with instead.

Thank you.
