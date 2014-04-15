From: heiko.stuebner@bq.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Apr 2014 00:16:37 +0200
Subject: [PATCH] dtc: add ability to make nodes conditional on them being
 referenced
In-Reply-To: <199290403.sj4aYrj8FC@diego>
References: <199290403.sj4aYrj8FC@diego>
Message-ID: <12484017.EBrG8OPNT6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 16. M?rz 2014, 22:22:02 schrieb Heiko St?bner:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> On i.MX, which carries a lot of pin-groups of which most are unused on
> individual boards, they noticed that this plethora of nodes also results
> in the runtime-lookup-performance also degrading [0].
> 
> A i.MX-specific solution defining the pingroups in the board files but
> using macros to reference the pingroup-data was not well received.
> 
> This patch is trying to solve this issue in a more general way, by
> adding the ability to mark nodes as needing to be referenced somewhere
> in the tree.
> 
> To mark a node a needing to be referenced it must be prefixed with
> /delete-unreferenced/. This makes dtc check the nodes reference-status
> when creating the flattened tree, dropping it if unreferenced.
> 
> For example, the i.MX6SL pingroup
> 
> 	/delete-unreferenced/ pinctrl_ecspi1_1: ecspi1grp-1 {
> 		fsl,pins = <
> 			MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO 0x100b1
> 			MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI 0x100b1
> 			MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK 0x100b1
> 
> 		>;
> 
> 	};
> 
> would only be included in the dtb if it got referenced somewhere
> as pingroup via
> 
> 	node {
> 		pinctrl-0 <&pinctrl_ecscpi1_1>;
> 	};
> 
> [0] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

ping?

Is this ok, bad, something else entirely? :-)


Thanks
Heiko
