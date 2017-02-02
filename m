From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 2 Feb 2017 13:20:31 -0600
Subject: [PATCH] ARM: dts: Add EMAC AXI settings for Arria10
In-Reply-To: <1486055345-2894-1-git-send-email-thor.thayer@linux.intel.com>
References: <1486055345-2894-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <CADhT+wc=peW0__N-aGm1DM+E=rEWC3MTT-nJvvAX9BCKTDmdTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 11:09 AM,  <thor.thayer@linux.intel.com> wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> Add the device tree entries needed to support the EMAC AXI
> bus settings on the Arria10 SoCFPGA chip.
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index f520cbf..f05dd15 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -400,6 +400,12 @@
>                                 };
>                 };
>
> +               socfpga_axi_setup: stmmac-axi-config {
> +                       snps,wr_osr_lmt = <0xf>;
> +                       snps,rd_osr_lmt = <0xf>;
> +                       snps,blen = <0 0 0 0 16 0 0>;
> +               };
> +
>                 gmac0: ethernet at ff800000 {
>                         compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
>                         altr,sysmgr-syscon = <&sysmgr 0x44 0>;
> @@ -416,6 +422,7 @@
>                         clock-names = "stmmaceth";
>                         resets = <&rst EMAC0_RESET>;
>                         reset-names = "stmmaceth";
> +                       snps,axi-config = <&socfpga_axi_setup>;

What about gmac1 and gmac2? They probably need this entry as well.

Dinh
