From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 10:57:02 -0200
Subject: [PATCH v3 4/6] ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM
 support
In-Reply-To: <1511785716-23492-5-git-send-email-narmstrong@baylibre.com>
References: <1511785716-23492-1-git-send-email-narmstrong@baylibre.com>
 <1511785716-23492-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOMZO5DXh1K4fnw0mCEwpXc0WFMUW1sCsjv==TUHM5vr3DqFaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 10:28 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:

> +&pcie {
> +       fsl,tx-swing-full = <103>;
> +       fsl,tx-swing-low = <103>;
> +       reset-gpio = <&gpio4 11 GPIO_ACTIVE_HIGH>;

This can only be active high if 'reset-gpio-active-high' property is
present, so what you
want here is:
  reset-gpio = <&gpio4 11 GPIO_ACTIVE_LOW>;

With this fixed:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
