From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 9 Sep 2017 08:48:49 -0300
Subject: [PATCH v3] ARM: dts: Add initial Pistachio i.mx6q board support.
In-Reply-To: <1504949308-13552-1-git-send-email-onlywig@gmail.com>
References: <1504949308-13552-1-git-send-email-onlywig@gmail.com>
Message-ID: <CAOMZO5Bsiw0z5Ab1oJ_MzsBeTueuEp1oZ3MpowwB8igKQApvew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 9, 2017 at 6:28 AM, Wig C <onlywig@gmail.com> wrote:

> +&usdhc2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc2>;
> +       bus-width = <4>;
> +       vmmc-supply = <&wlan_en_reg>;
> +       no-1-8-v;
> +       keep-power-in-suspend;
> +  non-removable;
> +  cap-power-off-card;

As I mentioned previously the indentation is not correct here.

You should use tab instead of spaces.

checkpatch also complains about it:

WARNING: please, no spaces at the start of a line
#699: FILE: arch/arm/boot/dts/imx6q-pistachio.dts:654:
+  non-removable;$

WARNING: please, no spaces at the start of a line
#700: FILE: arch/arm/boot/dts/imx6q-pistachio.dts:655:
+  cap-power-off-card;$

> +&wdog1 {
> +       status = "okay";
> +};

Why don't you use like this as you intended in the original patch?

&wdog1 {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_wdog>;
    fsl,ext-reset-output;
    status = "okay";
};
