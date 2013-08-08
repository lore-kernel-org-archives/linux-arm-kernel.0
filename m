From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 11:37:27 -0600
Subject: [PATCH v2 3/3] Documentation: dt: hwmon: add OF document for lm90
In-Reply-To: <1375944991-29182-4-git-send-email-wni@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-4-git-send-email-wni@nvidia.com>
Message-ID: <5203D757.8000208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 12:56 AM, Wei Ni wrote:
> Add OF document for lm90 in Documentation/devicetree/.

> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt

> +Required node properties:
> +- compatible: manufacture and chip name,
> +              which are listed in the Documentation/hwmon/lm90

You need to specify the exact values here. DT binding documentations
should be OS-agnostic, and hence can't depend on Linux-specific
documentation or other details.

> +Optional properties:
> +- vdd-supply: vdd regulator for the supply voltage. If this is not set,

s/set/present/.

> +- interrupts: lm90 can support interrupt mode, you can set interrupt here.

You might want to mention that a single entry ("specifier") is expected
in the list.
