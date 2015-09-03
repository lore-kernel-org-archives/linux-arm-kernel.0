From: robherring2@gmail.com (Rob Herring)
Date: Wed, 2 Sep 2015 19:13:24 -0500
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <1441229148-12095-1-git-send-email-dianders@chromium.org>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
Message-ID: <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2015 at 4:25 PM, Douglas Anderson <dianders@chromium.org> wrote:
> The ddc-i2c-bus property was missing from the veyron dtsi file since
> downstream the ddc-i2c-bus was still being specified in rk3288.dtsi and
> nobody noticed when the veyron dtsi was sent upstream.  Add it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Note: I noticed that this was wrong but I don't currently have
> graphics up and running on upstream on veyron.  Posting this anyway
> since it's pretty clear that it's needed.  If someone else wants to
> try it out that'd be nice, otherwise I'll put it on my list to figure
> out how to get myself setup for graphics upstream.  ;)

Based on your other patch, this is temporary, right?

I've been looking at DRM a lot lately. I think specifying the i2c bus
in the hdmi chip or IP block node is wrong. If the I2C host is
separate from the HDMI block, then it's only connection is to the HDMI
connector. So the I2C host to the connector relationship is what the
DT should describe. HPD gpio is similar. Now if the HDMI bridge
controls DDC and HPD directly, then we don't need to describe those
connections.

Rob

>
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 2fa7a0d..275c78c 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -158,6 +158,7 @@
>  };
>
>  &hdmi {
> +       ddc-i2c-bus = <&i2c5>;
>         status = "okay";
>  };
>
> --
> 2.5.0.457.gab17608
>
