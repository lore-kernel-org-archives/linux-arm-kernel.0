From: robherring2@gmail.com (Rob Herring)
Date: Mon, 10 Mar 2014 11:27:09 -0500
Subject: [PATCH 2/4] documentaion: DT: allow a A5 compatible string in
 global timer
In-Reply-To: <1394452294-24552-3-git-send-email-matthew.leach@arm.com>
References: <1394452294-24552-1-git-send-email-matthew.leach@arm.com>
 <1394452294-24552-3-git-send-email-matthew.leach@arm.com>
Message-ID: <CAL_JsqLE6pWJMRvXbOOca4fFb9OUieMimnuxxo4AFKkSMiFvsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 6:51 AM, Matthew Leach <matthew.leach@arm.com> wrote:
> The global timer is present on the Cortex A5. Add a compatibility
> string to the DT binding to allow a Cortex A5 global timer.
>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/global_timer.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> index 1e54898..0932891 100644
> --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> @@ -4,8 +4,10 @@
>
>  ** Timer node required properties:
>
> -- compatible : Should be "arm,cortex-a9-global-timer"
> -               Driver supports versions r2p0 and above.

Shouldn't you keep this information for the A9?

> +- compatible : should contain
> +            * "arm,cortex-a5-global-timer" for Cortex-A5 global timers.
> +            * "arm,cortex-a9-global-timer" for Cortex-A9 global timers
> +                or any compatible implementation.
>
>  - interrupts : One interrupt to each core
>
> --
> 1.8.5.3
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
