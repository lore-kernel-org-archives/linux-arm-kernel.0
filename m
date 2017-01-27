From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Jan 2017 16:03:57 -0600
Subject: [PATCH V6 3/5] OF: Add missing I/O range exception for
 indirect-IO  devices
In-Reply-To: <1485241525-201782-4-git-send-email-yuanzhichang@hisilicon.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-4-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <20170127220357.3lpavvyeymlhvlfg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 03:05:23PM +0800, zhichang.yuan wrote:
> There are some special ISA/LPC devices that work on a specific I/O range where
> it is not correct to specify a 'ranges' property in DTS parent node as cpu
> addresses translated from DTS node are only for memory space on some
> architectures, such as Arm64. Without the parent 'ranges' property, current
> of_translate_address() return an error.
> Here we add special handlings for this case.
> During the OF address translation, some checkings will be perfromed to
> identify whether the device node is registered as indirect-IO. If yes, the I/O
> translation will be done in a different way from that one of PCI MMIO.
> In this way, the I/O 'reg' property of the special ISA/LPC devices will be
> parsed correctly.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Shouldn't this be Reviewed-by?

Otherwise, looks fine to me.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/address.c | 87 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 71 insertions(+), 16 deletions(-)
> 
