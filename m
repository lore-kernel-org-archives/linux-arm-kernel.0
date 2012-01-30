From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 30 Jan 2012 17:47:40 +0530
Subject: [PATCH 2/2] ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
In-Reply-To: <20120130094317.11027.82072.stgit@dusk>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094317.11027.82072.stgit@dusk>
Message-ID: <CAMQu2gwsj6h0FqfY74jrA9ZVbjV650SLEUticQRiB+dSOWgNsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 3:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Clean up a few different parts of omap_set_pwrdm_state():
>
> - Remove a superfluous call to pwrdm_state_switch(). ?Not needed
> ?unless LOWPOWERSTATECHANGE is used, because the state switch code is
> ?called by either clkdm_sleep() or clkdm_allow_idle().
>
Indeed

> - Add code to wait for the power state transition in the OMAP4+ low
> ?power state change. ?This is speculative, so I would particularly
> ?appreciate feedback on this part.
>
> - Remove a superfluous call to pwrdm_read_pwrst().
>
> - Update variable names to be more meaningful (hopefully) and precise.
>
> - Fix an error path bug that would not place the clockdomain back into
> ?hardware-supervised idle or sleep mode if the power state could not
> ?be programmed.
>
> The documentation for this function still needs major improvements;
> that's left for a later patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---

All the changes look fine to me from OMAP4
perspective. Would be good if Tero can try out this
patch and test CORE RET on OMAP4.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
santosh
