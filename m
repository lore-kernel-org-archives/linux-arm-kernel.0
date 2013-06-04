From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Jun 2013 10:25:26 -0700
Subject: [PATCH V5 5/5] ARM: dts: Update Samsung I2S documentation
In-Reply-To: <1370348890-6645-6-git-send-email-padma.v@samsung.com>
References: <1370348890-6645-1-git-send-email-padma.v@samsung.com>
 <1370348890-6645-6-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=U9Fc=TTcbLCjTSvbk7pV5OdnBUwyxAss1_DX1dfKUQxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Tue, Jun 4, 2013 at 5:28 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> This patch updates the samsung i2s documentation for pinmux and
> clock entries.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt      |   40 ++++++-------------
>  1 files changed, 13 insertions(+), 27 deletions(-)

Whoops, just asked for this and now saw it.  Thanks for posting!

One note: don't use the "dts" tag for this commit.  That should be
only for things that are touching dts / dtsi files, not for updating
docs.


> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> index 3070046..6f9d29f 100644
> --- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> @@ -8,6 +8,10 @@ Required SoC Specific Properties:
>  - dmas: list of DMA controller phandle and DMA request line ordered pairs.
>  - dma-names: identifier string for each DMA request line in the dmas property.
>    These strings correspond 1:1 with the ordered pairs in dmas.
> +- clocks: from common clock binding. Handle to iis clock and RCLK src clk.
> +- clock-names: from common clock binding: Should be "iis","i2s_opclk0" and
> +  "i2s_opclk1". "iis" is the i2s bus clock and i2s_opclk selects the src of
> +  RCLK which is a mux inside i2s controller.

>From your other patch apparently opclk0 and/or opclk1 are not
required.  Two of your i2c nodes don't have either, though I suspect
that you at least need opclk0.  See my comments there.

-Doug
