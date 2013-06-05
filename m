From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Jun 2013 14:12:17 -0700
Subject: [PATCH v2] ARM: exynos: add debug_ll_io_init() call in
 exynos_init_io()
In-Reply-To: <1370465793-7997-1-git-send-email-dianders@chromium.org>
References: <1370397539-21653-1-git-send-email-dianders@chromium.org>
 <1370465793-7997-1-git-send-email-dianders@chromium.org>
Message-ID: <CAOesGMhQX9ip=nb9AQa5fcDFRNpZZSxUO0N0GTX051dakWZD9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 1:56 PM, Doug Anderson <dianders@chromium.org> wrote:
> If the early MMU mapping of the UART happens to get booted out of the
> TLB between the start of paging_init() and when we finally re-add the
> UART at the very end of s3c_init_cpu(), we'll get a hang at bootup if
> we've got early_printk enabled.  Avoid this hang by calling
> debug_ll_io_init() early.
>
> Without this patch, you can reliably reproduce a hang when early
> printk is enabled by adding flush_tlb_all() at the start of
> exynos_init_io().  After this patch the hang goes away.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>


Kukjin, this seems appropriate for 3.10. Do you have other fixes
queued or should I apply this directly?


-Olof
