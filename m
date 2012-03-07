From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 14:22:25 +0100
Subject: [PATCH v9] Regulator: Add Anatop regulator driver
In-Reply-To: <1331126658-26926-1-git-send-email-paul.liu@linaro.org>
References: <1331126658-26926-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120307132225.GB17745@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:24 Wed 07 Mar     , Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is an integrated regulator inside i.MX6 SoC.
> There are 3 digital regulators which controls PU, CORE (ARM), and SOC.
> And 3 analog regulators which controls 1P1, 2P5, 3P0 (USB).
> This patch adds the Anatop regulator driver.
> 
> Signed-off-by: Nancy Chen <Nancy.Chen@freescale.com>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  .../bindings/regulator/anatop-regulator.txt        |   28 +++
>  drivers/regulator/Kconfig                          |    8 +
>  drivers/regulator/Makefile                         |    1 +
>  drivers/regulator/anatop-regulator.c               |  231 ++++++++++++++++++++
>  4 files changed, 268 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.txt
>  create mode 100644 drivers/regulator/anatop-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
> new file mode 100644
> index 0000000..500463e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
> @@ -0,0 +1,28 @@
> +Anatop Voltage regulators
> +
> +Required properties:
> +- compatible: Must be "fsl,anatop-regulator"
> +- vol-bit-shift: Bit shift for the register
> +- vol-bit-width: Number of bits used in the register
> +- min-bit-val: Minimum value of this register
> +- min-voltage: Minimum voltage of this regulator
> +- max-voltage: Maximum voltage of this regulator
specific properites need to be prefix by the vendor

Best Regards,
J.
