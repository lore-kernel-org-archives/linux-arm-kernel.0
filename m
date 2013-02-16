From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Sat, 16 Feb 2013 18:28:06 +0530
Subject: [RFC PATCH 06/18] davinci: replace V4L2_OUT_CAP_CUSTOM_TIMINGS by
 V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <697f2939eac3755e4b5d74433d160d44672ab7ca.1361006882.git.hans.verkuil@cisco.com>
References: <a9599acc7829c431d88b547de87c500968ccb86a.1361006882.git.hans.verkuil@cisco.com>
 <1361006901-16103-1-git-send-email-hverkuil@xs4all.nl>
 <697f2939eac3755e4b5d74433d160d44672ab7ca.1361006882.git.hans.verkuil@cisco.com>
Message-ID: <CA+V-a8tH8GLKz50i216S4TFkNjPpn1D1tNaRkuLfvDE_JO9N5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ed Sekhar, DLOS, LAK.

Sekhar Can you Ack this patch ? Or maybe you can take this patch through
your tree ?

On Sat, Feb 16, 2013 at 2:58 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> From: Hans Verkuil <hans.verkuil@cisco.com>
>
> The use of V4L2_OUT_CAP_CUSTOM_TIMINGS is deprecated, use DV_TIMINGS instead.
> Note that V4L2_OUT_CAP_CUSTOM_TIMINGS is just a #define for
> V4L2_OUT_CAP_DV_TIMINGS.
>
> At some point in the future these CUSTOM_TIMINGS defines might be removed.
>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Prabhakar Lad <prabhakar.csengg@gmail.com>

Acked-by: Lad, Prabhakar <prabhakar.lad@ti.com>

Regards,
--Prabhakar

> ---
>  arch/arm/mach-davinci/board-dm646x-evm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index 6e2f163..43f35d6 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -514,7 +514,7 @@ static const struct vpif_output dm6467_ch0_outputs[] = {
>                         .index = 1,
>                         .name = "Component",
>                         .type = V4L2_OUTPUT_TYPE_ANALOG,
> -                       .capabilities = V4L2_OUT_CAP_CUSTOM_TIMINGS,
> +                       .capabilities = V4L2_OUT_CAP_DV_TIMINGS,
>                 },
>                 .subdev_name = "adv7343",
>                 .output_route = ADV7343_COMPONENT_ID,
> --
> 1.7.10.4
>
