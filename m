From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 21 Feb 2015 16:45:45 -0800
Subject: [PATCH 2/2] ARM: shmobile: silk: add SDHI0/1 DT support
In-Reply-To: <2348421.LHyZ4ZOiiG@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2348421.LHyZ4ZOiiG@wasted.cogentembedded.com>
Message-ID: <CANqRtoRnDzTSvKYcNDHKHbeaN7jp1VvKnk1jTHDvNt1oyBzwKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sat, Feb 21, 2015 at 2:27 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the SILK board dependent parts of the SDHI0  (connected to SDIO Wi-Fi
> chip)  and SDHI1  (connected to micro-SD slot) device nodes along with the
> necessary voltage regulators.
>
> Based on the original patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch. One question - above you write that SDHI1 is micro-SD...

> @@ -100,3 +159,25 @@
>         non-removable;
>         status = "okay";
>  };
> +
> +&sdhi0 {
> +       pinctrl-0 = <&sdhi0_pins>;
> +       pinctrl-names = "default";
> +
> +       vmmc-supply = <&vcc_sdhi0>;
> +       vqmmc-supply = <&vccq_sdhi0>;
> +       cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpio6 7 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&sdhi1 {
> +       pinctrl-0 = <&sdhi1_pins>;
> +       pinctrl-names = "default";
> +
> +       vmmc-supply = <&vcc_sdhi1>;
> +       vqmmc-supply = <&vccq_sdhi1>;
> +       cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpio6 15 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};

... however here the WP signal is assigned.

I believe micro-SD doesn't use the WP signal, so either I'm wrong or
the patch needs to be updated to reflect reality. =)

Also, I doubt that an on-board SDIO module makes use of CD and/or WP signals?

Any ideas?

Thanks,

/ magnus
