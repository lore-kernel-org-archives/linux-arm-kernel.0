From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Mar 2014 08:08:38 -0300
Subject: [PATCH v3][ 5/9] ARM: dts: imx25.dtsi: Fix USB support.
In-Reply-To: <1394618518-13803-5-git-send-email-denis@eukrea.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
 <1394618518-13803-5-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5A5BOgoJwtrxYEVJ9pzyS-6hobzf02i6Wf3Xu2BG29bAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Wed, Mar 12, 2014 at 7:01 AM, Denis Carikli <denis@eukrea.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> This patch was adapted from the thread named
> "USB Host support for mx25" on linux-usb at vger.kernel.org
>

As you add me in the From field, you also need to add:

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com> above your
Signed-off-by line.

> Signed-off-by: Denis Carikli <denis@eukrea.com>
> +
> +       usbphy {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "simple-bus";

I made this comment earlier: why do we place usbphy0/1 under simple-bus?

This is not documented in the the bindings.

> +
> +               usbphy0: usbphy at 0 {
> +                       reg = <0>;
> +                       compatible = "usb-nop-xceiv";
> +               };
> +
> +               usbphy1: usbphy at 1 {
> +                       reg = <1>;
> +                       compatible = "usb-nop-xceiv";
> +               };
> +       };

Regards,

Fabio Estevam
