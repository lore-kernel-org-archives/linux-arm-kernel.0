From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 23 May 2018 11:57:25 +0100
Subject: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
In-Reply-To: <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/18 19:47, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> index edc4f0e..f898a86 100644
> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> @@ -19,6 +19,8 @@ Required properties:
>   
>   Optional properties:
>   - interrupts : Should specify WDT interrupt number.
> +- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
> +                default timeout is 30 seconds

According to the SP805 TRM, the default interval is dependent on the 
rate of WDOGCLK, but would typically be a lot longer than that :/

On a related note, anyone have any idea why we seem to have two subtly 
different SP805 bindings defined?

Robin.

>   
>   Examples:
>   
> 
