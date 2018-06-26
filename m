From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Jun 2018 20:09:54 +0530
Subject: [PATCH] ARM: davinci: board-da850-evm: fix WP pin polarity for
 MMC/SD
In-Reply-To: <20180518012052.31345-1-aford173@gmail.com>
References: <20180518012052.31345-1-aford173@gmail.com>
Message-ID: <29c2c428-4334-bca4-0600-680878782ce4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 May 2018 06:50 AM, Adam Ford wrote:
> When booting from MMC/SD in rw mode, the system crashes because

... in rw mode on DA850 EVM, .. 

> the write protect pin should be active high and not active low.
> This patch fixes the polarity of the WP pin.
> 
> Fixes: 67c6b6ff221f ("ARM: davinci: board-da850-evm: fix GPIO
> lookup for MMC/SD")

Fixes: bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc pins")

is more appropriate since thats where the bug was actually introduced 
and thats how far back you want the patch backported.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

With these changes, applied to fixes for v4.18.

Thanks,
Sekhar
