From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 10 Apr 2014 21:31:21 -0700
Subject: [PATCH] ARM: imx: propagate DI clock changes up the clock tree to
 PLL5
In-Reply-To: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
References: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
Message-ID: <CAJ+vNU1uzKCZxjsr+inuOi_VJbs+iR14uqXKOCr_32ZS__HrZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 8:39 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Allows clk_set_rate() on the DI clocks to propagate up to PLL5.
>
> This allows imx-drm to produce the exact clock rate required with no
> modulation due to the fractional divider.  Modulation of the clock rate
> can and does prevent TVs from locking to the HDMI signal - they will
> report no signal rather than trying to lock to such a signal.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I still have this patch which is required so that imx-drm is capable of
> producing HDMI clocks which are close enough to the HDMI defined
> frequencies such that TVs and similar can recognise the signal.  Without
> this, I don't get any kind of output on my TV desite imx-drm being set
> to the correct mode.  I have proven that this is because the HDMI clock
> is *very* wrong without this patch.
>
>  arch/arm/mach-imx/clk-imx6q.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Hi Russell,

This fixed HDMI on the boards I'm testing it on (Gateworks Ventana).
Without it I encounter the same issue you describe above.

Tested-by: Tim Harvey <tharvey@gateworks.com>

Tim
