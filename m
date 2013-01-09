From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Jan 2013 15:57:05 -0200
Subject: [RFC PATCH 0/5] Use SRC to reset IP modules on i.MX5 and i.MX6
In-Reply-To: <CAOMZO5C_v92S0kBt66a2SsHGGGSBjJSP18-CQfWQ=sz0YW7ztg@mail.gmail.com>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
 <CAOMZO5Cgem3xyYg9MawnxXx_tDKgtiA_g6odu2wtnAeXWjdfmA@mail.gmail.com>
 <1357753220.8747.3.camel@pizza.hi.pengutronix.de>
 <CAOMZO5C_v92S0kBt66a2SsHGGGSBjJSP18-CQfWQ=sz0YW7ztg@mail.gmail.com>
Message-ID: <CAOMZO5C28qgH5DVooxYg5p6tA7bsFJshr4qxZEyp05A1LR3JWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 3:53 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jan 9, 2013 at 3:40 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
>> I rebased them onto next-20130109 (with this base compile-tested only).
>
> Just tested it, but unfortunately I still get the crash.

Ok, since I am on mx51 I just added a:

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 1f5d45e..8380b14 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -67,6 +67,7 @@
                        compatible = "fsl,imx51-ipu";
                        reg = <0x40000000 0x20000000>;
                        interrupts = <11 10>;
+                       reset = <&src 2>;
                };

and now it works fine.

Thanks,

Fabio Estevam
