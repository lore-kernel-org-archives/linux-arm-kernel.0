From: steev@pwnieexpress.com (Steev Klimaszewski)
Date: Sat, 7 Sep 2013 08:32:19 -0500
Subject: [patch 1/1] imx51.dtsi: fix PATA device clock
In-Reply-To: <20130907132507.353801753@rtp-net.org>
References: <20130907132507.353801753@rtp-net.org>
Message-ID: <CAKCjkJYjCMzroCw5mXJ3zpJhiBrgn3+jntB9bmhZyp0vtGiA1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor nit: It's Steev Klimaszewski, not Steve.

On Sat, Sep 7, 2013 at 8:23 AM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Commit 718a35006f3fa48540d69bd649ff76ea4cdc1ef2 adds pata support to the
> imx51.dtsi file and is using clock 161. The problem is that the right clock
> is 172, according to 5d530bb0ad84d403d1aac79a8a8acf2c2b0a8dd7.
> Using the clock 172 makes things work again (and kills a nasty system freeze)
>
>
> Tested-by: Steve Klimaszewski <steev@gentoo.org>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>
> Index: linux-next/arch/arm/boot/dts/imx51.dtsi
> ===================================================================
> --- linux-next.orig/arch/arm/boot/dts/imx51.dtsi        2013-09-07 15:08:05.042280170 +0200
> +++ linux-next/arch/arm/boot/dts/imx51.dtsi     2013-09-07 15:08:37.338278750 +0200
> @@ -490,7 +490,7 @@
>                                 compatible = "fsl,imx51-pata", "fsl,imx27-pata";
>                                 reg = <0x83fe0000 0x4000>;
>                                 interrupts = <70>;
> -                               clocks = <&clks 161>;
> +                               clocks = <&clks 172>;
>                                 status = "disabled";
>                         };
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
This e-mail and any attachments are for the sole use of the intended 
recipients(s) and may be confidential. Use of any Pwnie Express product 
signifies your agreement to the Rapid Focus Security EULA<http://pwnieexpress.com/pdfs/RFSEULA.pdf>and is subject to export controls under the U.S. Commerce Department's 
Export Administration Regulations ("EAR").
