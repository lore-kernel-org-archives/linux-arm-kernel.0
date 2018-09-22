From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Sep 2018 21:54:55 +0800
Subject: [PATCH 14/27] drm/bridge/synopsys: dw-hdmi: Enable workaround for
 v2.12a
In-Reply-To: <20180902072643.4917-15-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-15-jernej.skrabec@siol.net>
Message-ID: <CAGb2v679T6eqUcgRtR0Tw6Njq4GupCAmHhvq=K1EAGYkryWYyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> It turns out that even new DW HDMI controllers exhibits same mangenta

magenta?

Otherwise, FWIW,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> line issues as older versions.
>
> Enable workaround for v2.12a.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5971976284bf..df1c7a2d6961 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1664,6 +1664,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>         case 0x131a:
>         case 0x132a:
>         case 0x201a:
> +       case 0x212a:
>                 count = 1;
>                 break;
>         default:
> --
> 2.18.0
>
