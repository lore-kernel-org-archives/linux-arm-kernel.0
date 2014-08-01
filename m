From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 13:24:12 -0700
Subject: [PATCH v5 03/10] ARM: dts: Clean up exynos5250-snow
In-Reply-To: <1406868897-26874-4-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-4-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=W2XJzv4NpB=27AFjX94VkH8dYXxAPBL58ntXL2WvRCoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Use the new style of referencing inherited nodes and use symbolic names.
> Reorder one pinctrl node in GPIO order.
>
> Goal is the alignment of all exynos5250 based device trees for comparison.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4 -> v5:
>  * Introduced labels to consistently use new referencing style (Tomasz)
>  * Use IRQ_TYPE_* constants
>  * Use some more GPIO_ACTIVE_*
>
>  v3 -> v4: Unchanged
>
>  v3: New (Doug Anderson)
>
>  arch/arm/boot/dts/exynos5250-snow.dts | 291 +++++++++++++++++-----------------
>  arch/arm/boot/dts/exynos5250.dtsi     |  20 +--

As much as possible it's nice to touch the main exynos dtsi file and
specific board files in different patches.  Among other things it
makes backporting the patch and resolving merge conflicts easier (if
someone doesn't care about snow they could just pick up the main dtsi,
for instance).

I'm not a total stickler and I'd love to see this land quickly to
avoid conflicts, though...


> +&sd3_clk {
> +       samsung,pin-drv = <0>;
> +};
> +
> +&sd3_cmd {
> +       samsung,pin-pud = <3>;
> +       samsung,pin-drv = <0>;
> +};
> +
> +&sd3_bus4 {

Itty bitty bitty nit that "bus" sorts alphabetically above "clk".  ;)
Maybe Kukjin would be willing to sort these when he applies?


Thank you for all your hard work on this one.  Things look MUCH MUCH
nicer!  I did a pretty thorough review of your changes and it all
looks good.

Reviewed-by: Doug Anderson <dianders@chromium.org>
