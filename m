From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Aug 2012 16:46:39 -0300
Subject: [PATCH] ARM: dts: imx: fix gpio interrupts property
In-Reply-To: <1343917434-4358-1-git-send-email-shawn.guo@linaro.org>
References: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
 <1343917434-4358-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5A3hRp1f-244cPPE15Ur-V6stANrQ2QrS5j58J3BMRnXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2012 at 11:23 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Commit 88cde8b (ARM: dts: imx: update #interrupt-cells for gpio nodes)
> changes gpio #interrupt-cells from 1 to 2 without updating the users.
> It causes the gpio irq requesting call failing in client driver's probe
> function.
>
> Add the irq type cell for those gpio interrupt users to fix their
> driver probe failure.
>
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Still see an issue with gpio-key, but I guess it is because
http://patches.linaro.org/2743/
is missing.

Thanks,

Fabio Estevam
