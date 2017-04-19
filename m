From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Apr 2017 15:49:28 -0500
Subject: [PATCH v3 1/4] dt-bindings: net: Add TI WiLink shared transport
 binding
In-Reply-To: <CAHCN7x+G_jbQTDfyPBZ4Er8vz46tEojrWf29Eztq56c9zBnMeA@mail.gmail.com>
References: <20170413150353.7389-1-robh@kernel.org>
 <20170413150353.7389-2-robh@kernel.org>
 <CAHCN7x+HhwmXGxZn_31LuzdkEdoAnOSxukAdXULrGbSeKmrtRQ@mail.gmail.com>
 <CAHCN7xLHZmS_3+JygQgRxi_tX0mXL22D1Nj9T8jkrMz3-8eQDg@mail.gmail.com>
 <CAHCN7x+G_jbQTDfyPBZ4Er8vz46tEojrWf29Eztq56c9zBnMeA@mail.gmail.com>
Message-ID: <CAL_JsqLdeVnYRROmgj37Yh09h9eHtPWT8UhS_uTwjGj2FT2TYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 16, 2017 at 9:09 AM, Adam Ford <aford173@gmail.com> wrote:
>
>
> On Apr 13, 2017 10:04 AM, "Rob Herring" <robh@kernel.org> wrote:
>
> Add serial slave device binding for the TI WiLink series of Bluetooth/FM/GPS
> devices.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: netdev at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> ---
> v3:
> - rebase on bluetooth-next
>
>  .../devicetree/bindings/net/ti,wilink-st.txt       | 35
> ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,wilink-st.txt
>
> diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> new file mode 100644
> index 000000000000..cbad73a84ac4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> @@ -0,0 +1,35 @@
> +TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
> +
> +TI WiLink devices have a UART interface for providing Bluetooth, FM radio,
> +and GPS over what's called "shared transport". The shared transport is
> +standard BT HCI protocol with additional channels for the other functions.
> +
> +These devices also have a separate WiFi interface as described in
> +wireless/ti,wlcore.txt.
> +
> +This bindings follows the UART slave device binding in
> +../serial/slave-device.txt.
> +
> +Required properties:
> + - compatible: should be one of the following:
> +    "ti,wl1271-st"
> +    "ti,wl1273-st"
> +    "ti,wl1831-st"
> +    "ti,wl1835-st"
> +    "ti,wl1837-st"
> +
>
>
> Would you expect the wl1283 chipset too?

Probably, but I left it out as there's no public information.

> I can help test this if you like after the holiday weekend. I have a board
> with WL1283 and currently using pdata-quirks to support it.
