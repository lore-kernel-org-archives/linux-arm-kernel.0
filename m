From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 22 Nov 2015 12:41:34 +0300
Subject: [PATCH 10/13] ARM: mvebu: add buffer manager nodes to
 armada-38x.dtsi
In-Reply-To: <1448178839-3541-11-git-send-email-mw@semihalf.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <1448178839-3541-11-git-send-email-mw@semihalf.com>
Message-ID: <56518DCE.2010309@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/22/2015 10:53 AM, Marcin Wojtas wrote:

> Armada 38x network controller supports hardware buffer management (BM).
> Since it is now enabled in mvneta driver, appropriate nodes can be added
> to armada-38x.dtsi - for the actual common BM unit (bm at c8000) and its
> internal SRAM (bm-bppi), which is used for indirect access to buffer
> pointer ring residing in DRAM.
>
> Pools - ports mapping, bm-bppi entry in 'soc' node's ranges and optional
> parameters are supposed to be set in board files.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>   arch/arm/boot/dts/armada-38x.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index b7868b2..b9f4ce2 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -539,6 +539,14 @@
>   				status = "disabled";
>   			};
>
> +			bm: bm at c8000 {

    The ePAPR standard tells us to give generic names to the device nodes, 
hence this should be named "buffer-manager" (?).

[...]
> @@ -617,6 +625,16 @@
>   			#size-cells = <1>;
>   			ranges = <0 MBUS_ID(0x09, 0x15) 0 0x800>;
>   		};
> +
> +		bm_bppi: bm-bppi {

    And this one "memory" (?).

[...]

MBR, Sergei
