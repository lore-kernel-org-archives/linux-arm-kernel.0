From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 19 Sep 2017 08:36:07 -0500
Subject: [PATCH 2/2] tee: optee: allow selection of ti-smc as a calling
 method
In-Reply-To: <20170918205005.30235-2-afd@ti.com>
References: <20170918205005.30235-1-afd@ti.com>
 <20170918205005.30235-2-afd@ti.com>
Message-ID: <CAL_JsqJ00f3i3BQKjuVUXO8Rc_EC8BaycQi1Z_9OyRff7_kDpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 3:50 PM, Andrew F. Davis <afd@ti.com> wrote:
> On TI platforms OP-TEE must be called using a modified SMC call,
> allow the selection of this though DT.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt | 2 ++
>  drivers/tee/optee/core.c                                           | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> index d38834c67dff..a3275ecdf186 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> @@ -20,6 +20,8 @@ the reference implementation maintained by Linaro.
>                     "hvc" : HVC #0, with the register assignments specified
>                            in drivers/tee/optee/optee_smc.h
>
> +                   "ti-smc" : Similar to "smc" with TI specific register
> +                             adjustments

Sigh, really? IMO, this should be determined from the compatible
string. Then the next TI (or any vendor) specific thing can be handled
without a DT change.

Maybe some day we'll figure out that not just h/w needs to be
probe-able, but all the firmware pieces do too.

Rob
