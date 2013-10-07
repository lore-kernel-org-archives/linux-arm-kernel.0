From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Oct 2013 13:28:44 -0600
Subject: [PATCH v7 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <1380904635-18113-2-git-send-email-acourbot@nvidia.com>
References: <1380904635-18113-1-git-send-email-acourbot@nvidia.com>
 <1380904635-18113-2-git-send-email-acourbot@nvidia.com>
Message-ID: <52530B6C.8050605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 10:37 AM, Alexandre Courbot wrote:
> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked using the same SMC-based API on all supported
> platforms. This patch adds initial basic support for Trusted
> Foundations using the ARM firmware API. Current features are limited
> to the ability to boot secondary processors.
> 
> Note: The API followed by Trusted Foundations does *not* follow the SMC
> calling conventions. It has nothing to do with PSCI neither and is only
> relevant to devices that use Trusted Foundations (like most Tegra-based
> retail devices).

Hmmm. This patch didn't get sent to the DT maintainers. I'm CC'ing them
all in this reply, and hence quoting the two relevant files in full. I'm
looking for an ack to take this patch through the Tegra tree.

I'm also looking for an ack from perhaps Russell on the code changes in
the patch.

> diff --git a/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> new file mode 100644
> index 0000000..3954bbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> @@ -0,0 +1,17 @@
> +Trusted Foundations
> +
> +Boards that use the Trusted Foundations secure monitor can signal its
> +presence by declaring a node compatible with "tl,trusted-foundations"
> +under the root node.
> +
> +Required properties:
> +- compatible : "tl,trusted-foundations"
> +- version-major : major version number of Trusted Foundations firmware
> +- version-minor: minor version number of Trusted Foundations firmware
> +
> +Example:
> +	firmware {
> +		compatible = "tl,trusted-foundations";
> +		version-major = <2>;
> +		version-minor = <8>;
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2956800..a374eaa 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -66,6 +66,7 @@ ste	ST-Ericsson
>  stericsson	ST-Ericsson
>  toumaz	Toumaz
>  ti	Texas Instruments
> +tl	Trusted Logic
>  toshiba	Toshiba Corporation
>  v3	V3 Semiconductor
>  via	VIA Technologies, Inc.
