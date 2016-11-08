From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 8 Nov 2016 14:32:11 +0000
Subject: [PATCH v5 6/8] Documentation: bindings: add compatible specific
 to legacy SCPI protocol
In-Reply-To: <1478148731-11712-7-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <1478148731-11712-7-git-send-email-sudeep.holla@arm.com>
Message-ID: <7870a99c-c0a7-a39e-62c9-de1139d03846@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 03/11/16 04:52, Sudeep Holla wrote:
> This patch adds specific compatible to support legacy SCPI protocol.
>

Sorry for messing it up before, I think this version is much better.

Only this patch introduces new compatible, while 5,7,8/8 are just
reorganization to move the platform specific stuff out of the generic
SCPI bindings. It would be good if you can have a quick look and
provide ack if you are happy with these patches.

-- 
Regards,
Sudeep

> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> index d1882c4540d0..ebd03fc93135 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -7,7 +7,9 @@ by Linux to initiate various system control and power operations.
>
>  Required properties:
>
> -- compatible : should be "arm,scpi"
> +- compatible : should be
> +	* "arm,scpi" : For implementations complying to SCPI v1.0 or above
> +	* "arm,legacy-scpi" : For implementations complying pre SCPI v1.0
>  - mboxes: List of phandle and mailbox channel specifiers
>  	  All the channels reserved by remote SCP firmware for use by
>  	  SCPI message protocol should be specified in any order
>
