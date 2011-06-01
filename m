From: hans-christian.egtvedt@atmel.com (Hans-Christian Egtvedt)
Date: Wed, 01 Jun 2011 15:32:09 +0200
Subject: [PATCH] ATMEL, AVR32: inline nand partition table access
In-Reply-To: <1306676962-22308-1-git-send-email-dbaryshkov@gmail.com>
References: <1306676962-22308-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1306935129.1097.3.camel@hcegtvedt.norway.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-05-29 at 17:49 +0400, Dmitry Eremin-Solenikov wrote:
> Currently atmel_nand driver used by AT91 and AVR32 calls a special callback
> which return nand partition table and number of partitions. However in all
> boards this callback returns just static data. So drop this callback and
> make atmel_nand use partition table provided statically via platform_data.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Thanks for this update, always nice seeing code being optimized. I
really can't recall why it was made like this in the first place...

For the AVR32 related parts:

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

<snipp diff>

Will this go through the linux-mtd tree (since it spans two archs) or
should it go through an arch tree?

-- 
Hans-Christian Egtvedt
