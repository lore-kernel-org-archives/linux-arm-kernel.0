From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 16:30:24 -0600
Subject: [PATCH v2 02/16] pwm: pxa: update documentation regarding
 pwm-cells
In-Reply-To: <1515766983-15151-3-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-3-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180119223024.m5kuc6467xmgkgac@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 04:22:49PM +0200, Claudiu Beznea wrote:
> pwm-cells should be at least 2 to provide channel number and period value.
> 
> Cc: Mike Dunn <mikedunn@newsguy.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> index 5ae9f1e3c338..a0e20edeeebc 100644
> --- a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -10,7 +10,7 @@ Required properties:
>    Note that one device instance must be created for each PWM that is used, so the
>    length covers only the register window for one PWM output, not that of the
>    entire PWM controller.  Currently length is 0x10 for all supported devices.
> -- #pwm-cells: Should be 1.  This cell is used to specify the period in
> +- #pwm-cells: Should be 2.  This cell is used to specify the period in
>    nanoseconds.

What's the new cell? channel? Does the PXA PWM have more than one 
channel? If not, then you shouldn't add a cell.

Rob
