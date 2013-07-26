From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 26 Jul 2013 21:32:34 +0200
Subject: [PATCH] ARM: dts: imx53-qsb: Make USBH1 functional
In-Reply-To: <1374787113-6628-1-git-send-email-fabio.estevam@freescale.com>
 (Fabio Estevam's message of "Thu, 25 Jul 2013 18:18:33 -0300")
References: <1374787113-6628-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <87ehalunfx.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <fabio.estevam@freescale.com> writes:
Hi,

[...]

> @@ -302,7 +312,9 @@
>  };
>  
>  &usbh1 {
> -       status = "okay";
> +	vbus-supply = <&reg_usb_vbus>;
> +	phy_type = "utmi";
> +	status = "okay";
>  };
>  
>  &usbotg {

why not putting the vbus supply on the otg node too ?

Other than this point, works for me.

Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
