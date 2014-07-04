From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Jul 2014 10:53:39 -0300
Subject: [PATCH] ARM: dts: imx: correct sdma compatbile for imx6sl and
 imx6sx
In-Reply-To: <1404456361-8197-1-git-send-email-shawn.guo@freescale.com>
References: <1404456361-8197-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <CAOMZO5DWYxcXi8yRf7Toi-1CCnXgd2z+LQHWpu3yyNTiGPJarg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 3:46 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> The SDMA on imx6sl and imx6sx is more compatible with imx6q one than
> imx35.  Let's use "fsl,imx6q-sdma" instead of "fsl,imx35-sdma", so that
> SDMA ROM script on imx6sl and imx6sx can work for audio driver just like
> the case of imx6q.
>
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Thanks to Robin for finding this out.

Very good! Now I can play audio on mx6sl and mx6sx without the need of
loading the external SDMA firmware.

However, I still have a question: wouldn't it be better to describe
the compatible string as:
compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma", "fsl,imx35-sdma"; ?

Regards,

Fabio Estevam
