From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Feb 2017 21:39:04 -0200
Subject: [PATCH] serial: imx: Only enable UART DMA on i.MX6Q and i.MX53
In-Reply-To: <81fbfca6-78d5-73f1-b216-25990d666d77@denx.de>
References: <20170204213931.3566-1-marex@denx.de>
 <DB6PR0402MB2743C709F162BDE52429DF49E3410@DB6PR0402MB2743.eurprd04.prod.outlook.com>
 <CAOMZO5D8_vE+t=V6wHMKt590jZqJJRzeJ+_MLgqbLp=6gwsmyQ@mail.gmail.com>
 <e7f91dac-03a0-d6d1-5b12-cafcc45314f1@denx.de>
 <CAOMZO5AkbtWn65p6mj=7AxCh3-v18XPuRqR07NHCSiQY82QG=g@mail.gmail.com>
 <81fbfca6-78d5-73f1-b216-25990d666d77@denx.de>
Message-ID: <CAOMZO5DJacCF+E8LmpAE1xYpk-QxV7Wug9kji5qgPBWv6AwcnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 5:43 PM, Marek Vasut <marex@denx.de> wrote:

> Well given that the DMA does not work on 6SX, I guess it's not really
> compatible with 6Q.

They have the same programming model, so yes, mx6sx.dtsi should list
fsl,imx6q-uarti in the uart compatible.

I will send a patch doing that.

As Clemens explained, the DMA transaction error is not mx6sx specific.
