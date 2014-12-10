From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Dec 2014 12:13:26 +0000
Subject: arm64 broken in -next by commit 08d53aa58cb1 (of/fdt: export fdt
 blob as /sys/firmware/fdt)
In-Reply-To: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
References: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
Message-ID: <20141210121325.GC13994@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 12:04:23PM +0000, Catalin Marinas wrote:
> Ard,
> 
> I noticed that linux-next no longer boots on Juno. Bisecting, I ended up
> on your commit above and reverting it gets things going again. I
> initially thought it has something to do with the hardware crypto since
> you added some crc32_be() calls but disabling arm64 hw crypto didn't
> make any difference.

Commenting out crc32_be() in early_init_dt_verify() allows it to boot.
Some printk, it shows:

initial_boot_params = 0xffffffc01fe00000
fdt_totalsize(initial_boot_params) = 2108105

Isn't it quite big?

-- 
Catalin
