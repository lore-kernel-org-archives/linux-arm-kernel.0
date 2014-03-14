From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Mar 2014 11:32:15 -0500
Subject: [PATCH v2 2/4] documentaion: DT: allow a A5 compatible string in
 global timer
In-Reply-To: <1394792302-24451-3-git-send-email-matthew.leach@arm.com>
References: <1394792302-24451-1-git-send-email-matthew.leach@arm.com>
 <1394792302-24451-3-git-send-email-matthew.leach@arm.com>
Message-ID: <CAL_JsqL89P6YfVCThxXmZic6usxsOERT5kDMj1M54j0fwh-ObQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 5:18 AM, Matthew Leach <matthew.leach@arm.com> wrote:
> The global timer is present on the Cortex A5. Add a compatibility
> string to the DT binding to allow a Cortex A5 global timer.
>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/global_timer.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> index 1e54898..bdae3a8 100644
> --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> @@ -4,8 +4,11 @@
>
>  ** Timer node required properties:
>
> -- compatible : Should be "arm,cortex-a9-global-timer"
> -               Driver supports versions r2p0 and above.
> +- compatible : should contain
> +            * "arm,cortex-a5-global-timer" for Cortex-A5 global timers.
> +            * "arm,cortex-a9-global-timer" for Cortex-A9 global
> +                timers or any compatible implementation. Note: driver
> +                supports versions r2p0 and above.
>
>  - interrupts : One interrupt to each core
>
> --
> 1.8.5.3
>
>
