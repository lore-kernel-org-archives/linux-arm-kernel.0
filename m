From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 13 Apr 2015 12:02:01 -0700
Subject: [PATCH 2/6] ARM: keystone2: move update of the phys-to-virt
 constants into generic code
In-Reply-To: <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk>
Message-ID: <552C12A9.5080008@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 2:45 AM, Russell King wrote:
> Make the init_meminfo function return the offset to be applied to the
> phys-to-virt translation constants.  This allows us to move the update
> into generic code, along with the requirements for this update.
>
> This avoids platforms having to know the details of the phys-to-virt
> translation support.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/include/asm/mach/arch.h  |  2 +-
>   arch/arm/mach-keystone/keystone.c | 27 ++++++++++-----------------
>   arch/arm/mm/mmu.c                 | 26 ++++++++++++++++++++++----
>   3 files changed, 33 insertions(+), 22 deletions(-)
>
You already identified couple of improvements on offset calculations.
Apart from that, patch look fine by me.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
