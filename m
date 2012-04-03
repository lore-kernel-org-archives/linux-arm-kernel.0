From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 3 Apr 2012 19:23:28 +0530
Subject: [PATCH] arm: omap4: hsmmc: check for null pointer
In-Reply-To: <1333460858-9324-1-git-send-email-balajitk@ti.com>
References: <1333460858-9324-1-git-send-email-balajitk@ti.com>
Message-ID: <CAMQu2gxR1nKsYsEh3qSOouLHjp+fh+faDGVU6ybPr4TyOY=cwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2012 at 7:17 PM, Balaji T K <balajitk@ti.com> wrote:
> platform_device pdev can be NULL if CONFIG_MMC_OMAP_HS is not set.
> Add check for NULL pointer
>
> Fixes the following boot crash seen with omap4sdp and omap4panda
> when MMC is disabled.
>
> Unable to handle kernel NULL pointer dereference at virtual address 0000008c
> pgd = c0004000
> [0000008c] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 ? ?Not tainted ?(3.4.0-rc1-05971-ga4dfa82 #4)
> PC is at omap_4430sdp_init+0x184/0x410
> LR is at device_add+0x1a0/0x664
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for the fix Balaji.
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
