From: robh@kernel.org (Rob Herring)
Date: Sun, 26 Nov 2017 13:10:37 -0600
Subject: [PATCH 1/5] drm/panel: Add support for the EDT ETM0700G0BDH6
In-Reply-To: <20171123125600.41562-2-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171123125600.41562-2-jan.tuerk@emtrion.com>
Message-ID: <20171126191037.7zhb3c6c5ufmogp5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 01:55:51PM +0100, Jan Tuerk wrote:
> The Emerging Display Technology ETM0700G0BDH6 is exactly
> the same display as the ETM0700G0DH6, exept the pixelclock
> polarity. Therefore re-use the ETM0700G0DH6 modes. It is
> used by default on emtrion Avari based development kits.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  .../bindings/display/panel/edt,etm0700g0bdh6.txt          |  9 +++++++++
>  drivers/gpu/drm/panel/panel-simple.c                      | 15 +++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt
> new file mode 100644
> index 000000000000..099e30bfa17f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt
> @@ -0,0 +1,9 @@
> +Emerging Display Technology Corp. ETM0700G0BDH6 7.0" WVGA TFT LCD panel
> +
> +Required properties:
> +       compatible: "edt,etm0700g0bdh6"
> +
> +This panel is exactly the same as ETM0700G0DH6 except the pixelclock polarity.

Perhaps document them together.

> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
