From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 01 Nov 2014 09:45:46 +0100
Subject: [PATCH 1/2] regulator: Document binding for regulator suspend
 voltage
In-Reply-To: <1414813978-32233-1-git-send-email-dianders@chromium.org>
References: <1414813978-32233-1-git-send-email-dianders@chromium.org>
Message-ID: <54549DBA.5020102@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 11/01/2014 04:52 AM, Doug Anderson wrote:
> This patch builds upon (291d761 regulator: Document binding for
> regulator suspend state for PM state) to allow setting the uV in
> addition to the state at suspend time.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> index aaad615..4e7ed76 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -28,6 +28,8 @@ Optional properties:
>  - regulator-state-[mem/disk] node has following common properties:
>  	- regulator-on-in-suspend: regulator should be on in suspend state.
>  	- regulator-off-in-suspend: regulator should be off in suspend state.
> +	- regulator-suspend-microvolt: regulator should be set to this voltage
> +	  in suspend.

The patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On thing I wonder is if the binding should say that the suspend voltage is
independent of the runtime one and it may be outside of the runtime range?

Best regards,
Javier
