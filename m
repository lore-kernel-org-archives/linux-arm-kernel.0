From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 1 Feb 2016 10:45:04 -0600
Subject: [PATCH] infiniband: cxgb4: use %pR format string for printing
 resources
In-Reply-To: <2278867.O0SM8nbQp0@wuerfel>
References: <2278867.O0SM8nbQp0@wuerfel>
Message-ID: <025701d15d0f$e67ed760$b37c8620$@opengridcomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: [PATCH] infiniband: cxgb4: use %pR format string for printing resources
> 
> The cxgb4 prints an MMIO resource using the "0x%x" and "%p" format
> strings on the length and start, respective, but that
> triggers a compiler warning when using a 64-bit resource_size_t
> on a 32-bit architecture:
> 
> drivers/infiniband/hw/cxgb4/device.c: In function 'c4iw_rdev_open':
> drivers/infiniband/hw/cxgb4/device.c:807:7: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>        (void *)pci_resource_start(rdev->lldi.pdev, 2),
> 
> This changes the format string to use %pR instead, which pretty-prints
> the resource, avoids the warning and is shorter.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is an old warning I see rarely on ARM randconfig builds.


Acked-by: Steve Wise <swise@opengridcomputing.com>
