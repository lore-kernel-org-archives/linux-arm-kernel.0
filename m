From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 14 Apr 2016 17:46:43 +0100
Subject: [PATCH v2 2/3] devicetree: leds: Introduce "panic-indicator"
 optional property
In-Reply-To: <1460570899-24642-3-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1460570899-24642-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1460570899-24642-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <570FC973.2040708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 13/04/16 19:08, Ezequiel Garcia wrote:
> It's desirable to specify which LEDs are to be blinked on a kernel
> panic. Therefore, introduce a devicetree boolean property to mark
> which LEDs should be treated this way, if possible.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>   Documentation/devicetree/bindings/leds/common.txt | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 68419843e32f..7b646a7808ce 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -37,6 +37,9 @@ Optional properties for child nodes:
>                        property is mandatory for the LEDs in the non-flash modes
>                        (e.g. torch or indicator).
>
> +- panic-indicator : This properties specifies that the LED should be used,

s/properties/property/

Maybe phrasing it as "should also be used" might make the intention a 
bit clearer, as well.

Robin.

> +		    if at all possible, as a panic indicator.
> +
>   Required properties for flash LED child nodes:
>   - flash-max-microamp : Maximum flash LED supply current in microamperes.
>   - flash-max-timeout-us : Maximum timeout in microseconds after which the flash
>
