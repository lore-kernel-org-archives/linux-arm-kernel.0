From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 30 Jan 2012 16:24:28 +0530
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <20120130094312.11027.31050.stgit@dusk>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk>
Message-ID: <CAMQu2gz+Wp-2cJEYnzbJKQGewA9BW_S=KUP5R5Gmf0W2z324kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 3:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
> pwrdm_pre_transition(), which appears a few lines after these calls,
> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
> need to do it twice.
>
> N.B.: some of us have observed that accesses to the previous
> powerstate registers seem to be quite slow. ?Although the writes
> removed by this patch should be buffered by the write buffer, there is
> a read to a PRM register immediately afterwards. ?That will block the
> OMAP3 MPU until all of those writes complete. ?So this patch should
> result in a minor performance improvement during idle entry.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
Nice clean-up
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
