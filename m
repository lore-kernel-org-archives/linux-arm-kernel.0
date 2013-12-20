From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 17:05:33 -0700
Subject: [PATCH 4/6] ARM: DTS: tegra: add the DFLL IP block to the T114
 SoC file
In-Reply-To: <20131219123719.3226.44864.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123719.3226.44864.stgit@tamien>
Message-ID: <52B389CD.8010004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:49 AM, Paul Walmsley wrote:
> Add basic DT bindings for the DFLL IP block for the NVIDIA Tegra114 SoC.

> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt

> +- clocks : Must contain an array of two-cell arrays, one per clock.
> +           DFLL source clocks.  At minimum this should include the
> +           reference clock source and the IP block's main clock
> +           source.  Also it should contain the DFLL's I2C controller
> +           clock source.  The format is <&clock-provider-phandle
> +           clock-id>.

Entries in "clocks" aren't two cells, they're a phandle plus as many
cells as the node referenced by the phandle specifies.

> +
> +- clock-names : Must contain an array of strings, one per 'clocks'
> +                two-cell array.  The position in the array of these

clock-names defines the set of entries in clocks, not the other way around.

> +                strings must correspond to the position in the 'clocks'
> +                array (see above).  The DFLL driver currently requires
> +                the "soc", "ref", and "i2c" clock names to be populated.

The standard wording used by all the Tegra clock client bindings is now:

- clocks : Must contain an entry for each entry in clock-names.
  See clock-bindings.txt for details.
- clock-names : Must include the following entries:
  - soc
  - ref
  - i2c

For consistency, it'd be nice to adopt the same style here.

> +Optional properties:
> +
> +- status : device availability -- managed by the DT integration code, not
> +           the DFLL driver.  Should be set to "disabled" in the SoC
> +           DTS file.

That's such a core property that it's not worth documenting in every
single binding.

> +

Blank line at EOF.
