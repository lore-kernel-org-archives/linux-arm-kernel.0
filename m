From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 31 Jan 2012 09:16:56 +0530
Subject: [PATCH 2/2] ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
In-Reply-To: <20120130094317.11027.82072.stgit@dusk>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094317.11027.82072.stgit@dusk>
Message-ID: <4F276430.2020406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Monday 30 January 2012 03:13 PM, Paul Walmsley wrote:
> Clean up a few different parts of omap_set_pwrdm_state():
>
> - Remove a superfluous call to pwrdm_state_switch().  Not needed
>    unless LOWPOWERSTATECHANGE is used, because the state switch code is
>    called by either clkdm_sleep() or clkdm_allow_idle().
>
> - Add code to wait for the power state transition in the OMAP4+ low
>    power state change.  This is speculative, so I would particularly
>    appreciate feedback on this part.
>
> - Remove a superfluous call to pwrdm_read_pwrst().
>
> - Update variable names to be more meaningful (hopefully) and precise.
>
> - Fix an error path bug that would not place the clockdomain back into
>    hardware-supervised idle or sleep mode if the power state could not
>    be programmed.

All the changes look good. Thanks.
Acked-by: Rajendra Nayak <rnayak@ti.com>

regards,
Rajendra

>
