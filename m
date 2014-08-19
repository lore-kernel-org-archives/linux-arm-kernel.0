From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 19 Aug 2014 15:39:29 +0900
Subject: [PATCH v2 1/5] ARM: shmobile: r8a7740: Add CMT1 device to DT
In-Reply-To: <1407801882-2561-2-git-send-email-horms+renesas@verge.net.au>
References: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
 <1407801882-2561-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoTBJOZEFoOg+YmfyovCGDTa43Qs77OW-qd9YQLFq3tQ3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Laurent,

On Tue, Aug 12, 2014 at 9:04 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add the CMT1 counters to the r8a7740 device tree and make it
> disabled by default.
>
> Based on work by Magnus Damm.
>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v2
> * Corrected copy-paste-error: CMT0 -> CMT1

Thanks for breaking out, brushing up and submitting code based on my
earlier hack!

I've got one minor comment (see below ) and I also made sure to CC
Laurent that wrote the DT bindings.

Laurent, can you please check if this is the way you want us to use
the CMT bindings?

>  arch/arm/boot/dts/r8a7740.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 6cd6a46..1067a96 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -41,6 +41,18 @@
>                 interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> +       cmt1: timer at e6138000 {
> +               compatible = "renesas,cmt-48";

Do we want to have the "r8a7740" in the compatible string somewhere?

Cheers,

/ magnus
