From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 13 Mar 2018 22:59:58 +1100
Subject: [linux-sunxi] [PATCH v2 1/6] ASoC: sun4i-i2s: Add slot width
 override
In-Reply-To: <20180312155753.9478-2-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-2-codekipper@gmail.com>
Message-ID: <CAGRGNgURstWzK9vgSTxHiKfu4=wKEt67geKn407ahh_vnqniLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On Tue, Mar 13, 2018 at 2:57 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Some codecs require a different amount of a bit clocks per frame
> than what is calculated by using the sample width. Use a slot
> width override property to provide this mechanism.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sun4i-i2s.txt |  5 +++++
>  sound/soc/sunxi/sun4i-i2s.c                           | 15 ++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index b9d50d6cdef3..48addef65b8f 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -28,6 +28,11 @@ Required properties for the following compatibles:
>         - "allwinner,sun8i-h3-i2s"
>  - resets: phandle to the reset line for this codec
>
> +Optional properties:
> +- allwinner,slot-width-override:if this property is present then the dai is
> +                               configured to extend the slot width to the
> +                               value specified. Min 8, Max 32.
> +

This sounds like something that would be useful for other I2S controllers.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
