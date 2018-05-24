From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 24 May 2018 09:16:28 -0700
Subject: [PATCH v3 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
In-Reply-To: <1527120924-12131-3-git-send-email-ray.jui@broadcom.com>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <20180524161628.GA28425@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 05:15:20PM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> index 0fa3629..1debea3 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> @@ -19,6 +19,8 @@ Required properties:
>  
>  Optional properties:
>  - interrupts:  Should specify WDT interrupt number
> +- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
> +               default timeout in the driver is 30 seconds

"... the default timeout is determined by the driver" might be better.
If you want to mandate a default here (not sure if that is a good idea),
I would suggest to use something like "should be 30 seconds".

Guenter

>  
>  Example:
>  	watchdog at 66090000 {
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
