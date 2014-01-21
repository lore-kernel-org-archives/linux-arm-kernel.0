From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 Jan 2014 19:59:33 -0500
Subject: [PATCHv2] ARM: mvebu: fix compilation warning on Armada 370
 (i.e. non-SMP)
In-Reply-To: <87txcy8goq.fsf@natisbad.org>
References: <87txcy8goq.fsf@natisbad.org>
Message-ID: <20140121005933.GY29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 10:52:05PM +0100, Arnaud Ebalard wrote:
> 
> The following appears during compilation for an Armada 370 target
> because 'irq_controller_lock' is used only when CONFIG_SMP is
> enabled:
> 
>  drivers/irqchip/irq-armada-370-xp.c:62:8: warning: 'irq_controller_lock' defined but not used [-Wunused-variable]
> 
> Fix that warning by moving declaration of 'irq_controller_lock'
> inside existing #ifdef.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> 
> Changes since v1:
>  - moved declaration inside existing #ifdef as suggested by Arnd,
>    instead of adding a new one.
> 
>  drivers/irqchip/irq-armada-370-xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
