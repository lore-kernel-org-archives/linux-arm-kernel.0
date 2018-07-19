From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jul 2018 09:45:56 -0300
Subject: [PATCH] ARM: dts: vf610: Add ZII CFU1 board
In-Reply-To: <20180719005941.10458-1-andrew.smirnov@gmail.com>
References: <20180719005941.10458-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5D1rKH+_wuJrhD6Cr4psQwnk7CHVWm6qi0Jv7vnTiazUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Wed, Jul 18, 2018 at 9:59 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +/ {
> +       model = "ZII VF610 CFU1 Board";
> +       compatible = "zii,vf610cfu1", "zii,vf610dev", "fsl,vf610";
> +
> +       chosen {
> +               stdout-path = &uart0;
> +       };
> +
> +       memory {

memory at 80000000 to avoid dtc warnings with W=1, please.

Please make sure that this patch does not introduce any W=1 warning.

With this fixed:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
