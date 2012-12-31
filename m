From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 31 Dec 2012 13:55:54 +0530
Subject: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI
 when a device is active
In-Reply-To: <20121230182829.30526.32914.stgit@dusk.lan>
References: <20121230182745.30526.47072.stgit@dusk.lan>
 <20121230182829.30526.32914.stgit@dusk.lan>
Message-ID: <50E14C12.5020105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Sunday 30 December 2012 11:58 PM, Paul Walmsley wrote:
> Apparently, on some OMAPs, the MPU can't be allowed to enter WFI while
> certain peripherals are active.  It's not clear why, and it's likely
> that there is simply some other bug in the driver or integration code.
> But since the likelihood that anyone will have the time to track these
> problems down in the future seems quite small, we'll provide a
> flag, HWMOD_BLOCK_WFI, to mark these issues in the hwmod data.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
This is more of question. If the limitation is w.r.t MPU power
state then shouldn't we just prevent the MPU power state rather
than blocking the WFI completely.

Can you please clarify if retaining MPU power state in ON can achieve
the same results ?

Regards
Santosh
