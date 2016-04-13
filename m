From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 13 Apr 2016 13:05:10 -0300
Subject: [PATCH] PCI: imx6: Implement reset sequence for i.MX6+
In-Reply-To: <1460562685-15168-1-git-send-email-asmirnov@spaceflightindustries.com>
References: <1460562685-15168-1-git-send-email-asmirnov@spaceflightindustries.com>
Message-ID: <CAOMZO5Bppic3N+wmYWCOc1nFNPLF4TADTTx41V-mqpgce5EXLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Wed, Apr 13, 2016 at 12:51 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
> instead of a regular reset sequence since using the latter will hang the
> SoC.
>
> This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
>
> Signed-off-by: Andrey Smirnov <asmirnov@spaceflightindustries.com>
> ---
>  arch/arm/boot/dts/imx6qp.dtsi               |  3 ++

Please put the ARM change into a separate patch.

>  static const struct of_device_id imx6_pcie_of_match[] = {
>         { .compatible = "fsl,imx6q-pcie", },
> +       { .compatible = "fsl,imx6qp-pcie", },

Please base your patch against
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6

,as there is mx6sx support now in this branch.
