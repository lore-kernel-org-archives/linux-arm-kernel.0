From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jul 2018 09:28:31 -0300
Subject: [PATCH 1/2] drm/panel: Add support for Armadeus ST0700 Adapt
In-Reply-To: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
References: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
Message-ID: <CAOMZO5Dr0zqy4Sf3s=L4qoqePRhZAXWpDk1oTOUidy4_TUQ=QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?bastien,

On Tue, Jul 17, 2018 at 4:23 AM, S?bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> This patch adds support for the Armadeus ST0700 Adapt. It comes with a
> Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
> that it can be connected on the TFT header of Armadeus Dev boards.
>
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>
> diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
> new file mode 100644
> index 000000000000..a30d63db3c8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
> @@ -0,0 +1,9 @@
> +Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with
> +an adapter board.
> +
> +Required properties:
> +- compatible: "armadeus,st0700-adapt"

Shouldn't this be named "santek,st0700i5y" instead?

Santek is the vendor of the panel and st0700i5y is the model.

Then you could add a "santek" entry in
Documentation/devicetree/bindings/vendor-prefixes.txt.

Regards,

Fabio Estevam
