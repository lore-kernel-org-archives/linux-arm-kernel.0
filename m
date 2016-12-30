From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Dec 2016 15:55:58 -0200
Subject: [PATCH v2] mfd: mc13xxx: Set the irq type.
In-Reply-To: <1483112613-18092-1-git-send-email-lilja.magnus@gmail.com>
References: <1483112613-18092-1-git-send-email-lilja.magnus@gmail.com>
Message-ID: <CAOMZO5Baio43HUT-0y_8WaXezmzrj9HoA0EWfjM4orsDs5C4rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 1:43 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:
> Commit 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for
> interrupts") removed the passing of the IRQF_TRIGGER_HIGH flag when
> registering the interrupt.
> This commit fixes that problem by setting the IRQF_TRIGGER_HIGH flag in
> case no irq type is set via irqd framework (e.g. device tree). In the
> latter case the irq flag from irqd is used.
>
> Tested on i.MX31 PDK hardware.
>
> Fixes: 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for interrupts")
> Cc: <stable@vger.kernel.org> # 3.18.x
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
