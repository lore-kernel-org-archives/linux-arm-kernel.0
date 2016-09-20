From: robh@kernel.org (Rob Herring)
Date: Tue, 20 Sep 2016 09:34:00 -0500
Subject: [PATCH resend 1/5] input: touchscreen: Add generic touchscreen
 softbutton handling code
In-Reply-To: <20160911184408.11657-2-hdegoede@redhat.com>
References: <20160911184408.11657-1-hdegoede@redhat.com>
 <20160911184408.11657-2-hdegoede@redhat.com>
Message-ID: <20160920143400.GA20446@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 08:44:04PM +0200, Hans de Goede wrote:
> Some touchscreens extend over the display they cover and have a number
> of capacative softbuttons outside of the display the cover.
> 
> With some hardware these softbuttons simply report touches with
> coordinates outside of the normal coordinate space for touches on the
> display.
> 
> This commit adds a devicetree binding for describing such buttons in
> devicetree and a bunch of helper functions to easily add support for
> these to existing touchscreen drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/softbuttons.txt     |  58 +++++++++
>  drivers/input/touchscreen/Makefile                 |   2 +-
>  drivers/input/touchscreen/softbuttons.c            | 145 +++++++++++++++++++++
>  include/linux/input/touchscreen.h                  |   9 ++
>  4 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>  create mode 100644 drivers/input/touchscreen/softbuttons.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> new file mode 100644
> index 0000000..3eb6f4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> @@ -0,0 +1,58 @@
> +General Touchscreen Softbutton Properties:
> +
> +Some touchscreens extend over the display they cover and have a number
> +of capacative softbuttons outside of the display the cover.
> +
> +Some of these softbuttons simply report touches with coordinates outside of
> +the normal coordinate space for touches on the display. This binding is for
> +describing such buttons in devicetree.
> +
> +Each softkey is represented as a sub-node of the touchscreen node.
> +
> +Required subnode-properties:
> + - label			: Descriptive name of the key.
> + - linux,code			: Keycode to emit.
> + - softbutton-min-x		: X start of the area the softbutton area covers
> + - softbutton-max-x		: X end of the area the softbutton area covers
> + - softbutton-min-y		: Y start of the area the softbutton area covers
> + - softbutton-max-y		: Y end of the area the softbutton area covers

Please add the note about these values are signed.

With that,

Acked-by: Rob Herring <robh@kernel.org>

Rob
