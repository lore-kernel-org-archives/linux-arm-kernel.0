From: robh@kernel.org (Rob Herring)
Date: Tue, 20 Sep 2016 09:40:23 -0500
Subject: [PATCH resend 2/5] input: touchscreen: Add LED trigger support
 to the softbutton code
In-Reply-To: <20160911184408.11657-3-hdegoede@redhat.com>
References: <20160911184408.11657-1-hdegoede@redhat.com>
 <20160911184408.11657-3-hdegoede@redhat.com>
Message-ID: <20160920144023.GA31922@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 08:44:05PM +0200, Hans de Goede wrote:
> In some hardware there are 1 or more LEDs behind the touchscreen
> softbuttons, which are intended to provide visual feedback to the
> user that the softbutton has been pressed, this commit adds support
> for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/softbuttons.txt     |  4 ++
>  drivers/input/touchscreen/softbuttons.c            | 49 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> index 3eb6f4c..b425b95 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> @@ -17,6 +17,10 @@ Required subnode-properties:
>   - softbutton-min-y		: Y start of the area the softbutton area covers
>   - softbutton-max-y		: Y end of the area the softbutton area covers
>  
> +Optional subnode-properties:
> +- linux,led-trigger		: String for a LED trigger for providing visual
> +				  feedback that the softbutton has been pressed

This should just be a phandle to the LED if you want to describe the 
link. Or standardize the trigger naming (in the kernel) for buttons and 
just use the existing 'linux,default-trigger' in the LED node.

Rob
