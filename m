From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 19:45:50 +0200
Subject: [PATCH 4/4] ARM: dts: Enable emac node on the rk3188-radxarock
 boards
In-Reply-To: <CABgxDoJOJ9bM2CgXyXjPvsv2DN_QO+HPAzCwfjdyKFDpUAOtOw@mail.gmail.com>
References: <1409740036-8117-1-git-send-email-romain.perier@gmail.com>
 <CAFnsNoSmHwN3nJ5ZJL5fc_-kaECCoLBvpdBYQxkyLcUzLx5MTw@mail.gmail.com>
 <CABgxDoJOJ9bM2CgXyXjPvsv2DN_QO+HPAzCwfjdyKFDpUAOtOw@mail.gmail.com>
Message-ID: <2909336.qILuPbXDGe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 18:37:16 PERIER Romain wrote:
> It is an optional property used by arc-emac (the core driver), if it
> is not present the core driver generates one for you.
> Problem being that with this property two radxa rock boards connected
> on the same local network might have the same mac address.
> 
> In this case it would be probably better to remove this property. What
> do you think ?
> 

It would typically be filled in by the boot loader, and be all-zeroes
in the kernel-supplied dts file. I don't see a point in hardcoding
a particular MAC address in the dts file, since that won't work
unless it's the only device of that type in the network segment.

	Arnd
