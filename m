From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Tue, 14 Mar 2017 14:19:18 -0700
Subject: [PATCH] firmware: ti_sci: fix strncat length check
In-Reply-To: <20170314211157.3424031-1-arnd@arndb.de>
References: <20170314211157.3424031-1-arnd@arndb.de>
Message-ID: <4e3a448e-da7e-4da5-96bf-327da2a8c7d0@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/14/17 2:11 PM, Arnd Bergmann wrote:
> gcc-7 notices that the length we pass to strncat is wrong:
>
> drivers/firmware/ti_sci.c: In function 'ti_sci_probe':
> drivers/firmware/ti_sci.c:204:32: error: specified bound 50 equals the size of the destination [-Werror=stringop-overflow=]
>
> Instead of the total length, we must pass the length of the
> remaining space here.
>
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Originally submitted on Jan 11, patch is still needed on Linux-4.11-rc2.

Looks fine to me Arnd. Will you be applying it to SOC driver branch ?

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
