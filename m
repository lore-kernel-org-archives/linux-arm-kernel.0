From: horms@verge.net.au (Simon Horman)
Date: Fri, 20 Nov 2015 10:34:51 -0800
Subject: [PATCH] ARM: shmobile: alt: Add pfc pins to DT
In-Reply-To: <564F0DE5.6040100@cogentembedded.com>
References: <1447787440-11080-1-git-send-email-horms+renesas@verge.net.au>
 <564F0DE5.6040100@cogentembedded.com>
Message-ID: <20151120183451.GD29534@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 03:11:17PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/17/2015 10:10 PM, Simon Horman wrote:
> 
> >PFC is already enabled on the r8a7794.
> >This adds pins for devices already enabled in DT on
> >the r8a7794 based alt board.
> >
> >Based on work by Mitsuhiro Kimura and Hisashi Nakamura.
> >
> >Cc: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> >Cc: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> >---
> >Tested
> >---
> >  arch/arm/boot/dts/r8a7794-alt.dts | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> >index 928cfa641475..2e889991ce8f 100644
> >--- a/arch/arm/boot/dts/r8a7794-alt.dts
> >+++ b/arch/arm/boot/dts/r8a7794-alt.dts
> >@@ -39,6 +39,23 @@
> >  	clock-frequency = <20000000>;
> >  };
> >
> >+&pfc {
> >+	scif2_pins: serial2 {
> >+		renesas,groups = "scif2_data";
> >+		renesas,function = "scif2";
> >+	};
> >+
> >+	ether_pins: ether {
> >+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
> >+		renesas,function = "eth";
> >+	};
> >+
> >+	ether_b_pins: ether {
> >+		renesas,groups = "eth_link_b", "eth_mdio_b", "eth_rmii_b";
> >+		renesas,function = "eth";
> >+	};
> >+};
> >+
> >  &cmt0 {
> >  	status = "okay";
> >  };
> 
>    Why add unreferenced pins? How have you tested this?

Thanks for pointing out that oversight. I'll see about filling in the gaps.
