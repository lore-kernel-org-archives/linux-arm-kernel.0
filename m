From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 Oct 2014 23:43:27 -0200
Subject: [BISECT] v3.18-rc1 doesn't boot on nitrogen6x i.MX6 board
In-Reply-To: <CAOMZO5CaWzfqjj2orX4nh8Vjk2o8bS_sQ7vPA_SwwfdFpFwXDQ@mail.gmail.com>
References: <20141023203034.GR12732@glaurung.lavos.net>
 <CAOMZO5CaWzfqjj2orX4nh8Vjk2o8bS_sQ7vPA_SwwfdFpFwXDQ@mail.gmail.com>
Message-ID: <CAOMZO5Bbm_C-2p=XQwN0rxfW+vL0MNMWwHvqgTggGbz_waY95g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 6:46 PM, Fabio Estevam <festevam@gmail.com> wrote:

>> I really haven't looked into what might be wrong, I just wanted to let
>> you know that this fix apparently breaks some boards.
>
> Adding Eric and Troy in case they could comment. I don't know why this
> commit would cause failure on nitrogen board.

Ok, so I am able to reproduce this issue on a mx6qsabresd if I don't
pass the PCI gpio reset (like in nitrogen):

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -521,7 +521,6 @@
 &pcie {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_pcie>;
-       reset-gpio = <&gpio7 12 0>;
        status = "okay";
 };


Richard Zhu sent a fix for this, but it has not been applied yet:
http://www.spinics.net/lists/linux-pci/msg34748.html

With his patch applied the kernel can boot fine.

Regards,

Fabio Estevam
