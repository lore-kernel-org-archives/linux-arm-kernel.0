From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 28 Sep 2012 12:03:34 +0530
Subject: [PATCH V2] ARM: OMAP2+: Round of the carve out memory requested
 to section_size
In-Reply-To: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
References: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
Message-ID: <CAMQu2gwuQ6uht0iHtPuhFU4B9P+zgNHYazK+BqE-rnBfnhL2cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 12:44 PM, R Sricharan <r.sricharan@ti.com> wrote:
> memblock_steal tries to reserve physical memory during boot.
> When the requested size is not aligned on the section size
> then, the remaining memory available for lowmem becomes
> unaligned on the section boundary. There is a issue with this,
> which is discussed in the thread below.
>
> https://lkml.org/lkml/2012/6/28/112
>
> The final conclusion from the thread seems to
> be align the memblock_steal calls on the SECTION boundary.
> The issue comes out when LPAE is enabled, where the
> section size is 2MB.
>
> Boot tested this on OMAP5 evm with and without LPAE.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> ---
>  [V2] Corrected the subject and added one more description line.
>
Looks good.
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,
Can you take this into your next "fixes-noncritical" queue please ?

Regards,
Santosh
