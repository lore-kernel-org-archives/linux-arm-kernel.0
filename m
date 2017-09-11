From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Sep 2017 08:25:31 -0300
Subject: [PATCH v4 4/6] ARM: dts: imx6dl-icore: Add LVDS support
In-Reply-To: <1505121145-9507-4-git-send-email-jteki@openedev.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
 <1505121145-9507-4-git-send-email-jteki@openedev.com>
Message-ID: <CAOMZO5B0RAjdupLSe=S+tDEA-hpf-Si_4qjkcKC_ECX86PLScQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

On Mon, Sep 11, 2017 at 6:12 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:

> +&ldb {
> +       status = "okay";
> +
> +       lvds-channel at 0 {
> +               fsl,data-mapping = "spwg";
> +               fsl,data-width = <18>;
> +               status = "okay";
> +
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency = <60000000>;
> +                               hactive = <800>;
> +                               vactive = <480>;
> +                               hback-porch = <30>;
> +                               hfront-porch = <30>;
> +                               vback-porch = <5>;
> +                               vfront-porch = <5>;
> +                               hsync-len = <64>;
> +                               vsync-len = <20>;

Please add the support of this panel to drivers/gpu/drm/panel/panel-simple.c.

Then you can refer its compatible in your board dts.
