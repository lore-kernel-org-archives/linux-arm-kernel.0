From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 7 Dec 2016 22:21:27 +0100
Subject: [PATCH v5 3/3] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <1778a82d1989d13919b24e47fa09eeb56b2cb8e5.1481139171.git.stillcompiling@gmail.com>
References: <cover.1481139171.git.stillcompiling@gmail.com>
 <1778a82d1989d13919b24e47fa09eeb56b2cb8e5.1481139171.git.stillcompiling@gmail.com>
Message-ID: <20161207222127.23f6b8b4@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Dec 2016 13:04:40 -0800
Joshua Clayton stillcompiling at gmail.com wrote:
...
>+static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
>+				 const char *buf, size_t count)

there is a minor API change in linux-next [1]. struct fpga_image_info *
is passed instead of u32 flags. I assume this will be merged soon, so
please prepare this driver accordingly.

...
>+static int cyclonespi_write_complete(struct fpga_manager *mgr, u32 flags)

same here.

[1] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/fpga?id=1df2865f8dd9d56cb76aa7aa1298921e7bece2af

--
Anatolij
