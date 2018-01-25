From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Thu, 25 Jan 2018 03:11:32 -0800
Subject: [PATCH v3] net: ethernet: cavium: Correct Cavium Thunderx NIC
 module and driver names
In-Reply-To: <20180124.162737.1427515957453841771.davem@davemloft.net>
References: <1516290789-3585-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1516630407-23161-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20180124.162737.1427515957453841771.davem@davemloft.net>
Message-ID: <20180125111132.GA6458@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 04:27:37PM -0500, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Mon, 22 Jan 2018 06:13:27 -0800
> 
> > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > 
> > It was found that ethtool provides unexisting module name while
> > it queries the specified network device for associated driver
> > information. Then user tries to unload that module by provided
> > module name and fails.
> > 
> > This happens because ethtool reads value of DRV_NAME macro,
> > while module name is defined at the driver's Makefile.
> > 
> > This patch is to correct Cavium CN88xx Thunder NIC driver modules
> > names 'nicvf' to 'thunder_nicvf' and 'nicpf' to 'thunder_nicpf' along
> > with updating DRV_NAME macro values accordingly.
> > 
> > Signed-off-by: Dean Nelson <dnelson@redhat.com>
> > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> Once your driver has been deployed in a real upstream release you
> should never change the driver module name.
> 
> So if you want to fix things, you'll have to fix them the other
> way around, by not changing the module name but changing the
> strings that ethtool ends up with instead.
> 
> Thank you.

Ok, understood.
Will update patch and re-send.

Thank you.
Vadim
