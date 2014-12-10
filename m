From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Dec 2014 12:04:23 +0000
Subject: arm64 broken in -next by commit 08d53aa58cb1 (of/fdt: export fdt
 blob as /sys/firmware/fdt)
Message-ID: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard,

I noticed that linux-next no longer boots on Juno. Bisecting, I ended up
on your commit above and reverting it gets things going again. I
initially thought it has something to do with the hardware crypto since
you added some crc32_be() calls but disabling arm64 hw crypto didn't
make any difference.

Still investigating but I thought I should let you know early.

-- 
Catalin
