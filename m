From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 1 Oct 2012 17:34:02 +0530
Subject: [PATCH v2 4/7] ARM: davinci: Add support for an L3RAM gen_pool
In-Reply-To: <1348861072-14507-5-git-send-email-mporter@ti.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
 <1348861072-14507-5-git-send-email-mporter@ti.com>
Message-ID: <506986B2.1030000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On 9/29/2012 1:07 AM, Matt Porter wrote:
> L3RAM (shared SRAM) is needed for use by several drivers.
> This creates a genalloc pool and a hook for the platform code
> to provide the struct gen_pool * in platform data.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>

I am not sure if any of the DaVinci devices have a need to allocate from
*both* ARM RAM and shared RAM. Shared RAM is not present on all DaVinci
devices AFAIR, and on DA850, there is just 8KB ARM RAM so I am not sure
if there is much point in trying to allocate from there.

Can you instead see if Ben's earlier patch[1] to use shared RAM for SRAM
allocation on DA850 makes sense for your case? If yes, can you repost
with Ben's patch included in your series instead of this patch? I would
prefer that over creating a new pool for shared RAM.

Thanks,
Sekhar

[1] https://patchwork.kernel.org/patch/840552/

Thanks,
Sekhar
