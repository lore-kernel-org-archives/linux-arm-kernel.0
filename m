From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Aug 2014 12:57:36 -0400
Subject: [PATCH] irqchip: gic-v3: Only define gic_peek_irq() when
 building SMP
In-Reply-To: <1406480224-24628-1-git-send-email-broonie@kernel.org>
References: <1406480224-24628-1-git-send-email-broonie@kernel.org>
Message-ID: <20140817165736.GD12769@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Sun, Jul 27, 2014 at 05:57:04PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> If building with CONFIG_SMP disbled (for example, with allnoconfig) then
> GCC complains that the static function gic_peek_irq() is defined but not
> used since the only reference is in the SMP initialisation code. Fix this
> by moving the function definition inside the ifdef.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Applied to irqchip/urgent with Mark's Ack.

thx,

Jason.
