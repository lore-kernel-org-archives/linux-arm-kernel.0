From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Nov 2014 16:00:14 +0200
Subject: [PATCH 2/4] Documentation: DT: Add documentation for ti,opa362
 bindings
In-Reply-To: <1415051968-4878-3-git-send-email-marek@goldelico.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-3-git-send-email-marek@goldelico.com>
Message-ID: <546367EE.3040600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/14 23:59, Marek Belisko wrote:
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  .../devicetree/bindings/video/ti,opa362.txt        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/ti,opa362.txt b/Documentation/devicetree/bindings/video/ti,opa362.txt
> new file mode 100644
> index 0000000..d7ed11a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/ti,opa362.txt
> @@ -0,0 +1,38 @@
> +OPA362 analog video amplifier
> +
> +Required properties:
> +- compatible: "ti,opa362"
> +- gpio: enable/disable output gpio
> +
> +Required node:
> +- Video port 0 for opa362 input
> +- Video port 1 for opa362 output
> +
> +Example:
> +
> +tv_amp: opa362 {
> +	 compatible = "ti,opa362";
> +	 gpios = <&gpio1 23 0>;  /* GPIO to enable video out amplifier */
> +	 
> +	label = "opa362";

opa shouldn't have label property. label is meant for the
end-of-the-chain component, like the connector.

> +	 ports {

Hmm, I think there is extra space before 'ports', maybe below also.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/7e4334b3/attachment.sig>
