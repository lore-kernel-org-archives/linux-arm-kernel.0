From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 17:10:17 -0700
Subject: [PATCH 5/6] ARM: DTS: tegra: add DFLL integration to the Dalmore
 DTS file
In-Reply-To: <20131219124929.3226.79335.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219124929.3226.79335.stgit@tamien>
Message-ID: <52B38AE9.2030209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:49 AM, Paul Walmsley wrote:
> Expose the DFLL device on the NVIDIA Tegra114 Dalmore board, and connect
> the DFLL (and FCPU cluster) voltage regulator.

> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt

> +NVIDIA Tegra114 DFLL clocksource data in the board DTS file
> +
> +Optional properties:
> +
> +- status : device availability -- managed by the DT integration code, not
> +           the DFLL driver.  Should be set to "okay" if the DFLL is to be
> +           used on this board type.

There's certainly no need to document the same DT property twice. The DT
docs are about documenting the schema. If the DT author decides to split
the properties between a .dtsi and a .dts file, that's irrelevant to the
schema.
