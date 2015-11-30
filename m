From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 14:47:00 +0100
Subject: [PATCH v2 1/5] of/irq: export of_irq_find_parent again
In-Reply-To: <1448273816-11290-2-git-send-email-carlo@caione.org>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-2-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdaN4t3dkXegbbn4E42Xt9M9BQQLhY3=WgFNzvH97Jv05A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 11:16 AM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> of_irq_find_parent was made static since it had no users outside of
> of_irq.c. Export it again since we are going to use it again.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/of/irq.c       | 2 +-
>  include/linux/of_irq.h | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 902b89b..45735d5 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -53,7 +53,7 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
>   * Returns a pointer to the interrupt parent node, or NULL if the interrupt
>   * parent could not be determined.
>   */
> -static struct device_node *of_irq_find_parent(struct device_node *child)
> +struct device_node *of_irq_find_parent(struct device_node *child)

If you're making this public you should also
EXPORT_SYMBOL_GPL(of_irq_find_parent)

I need an ACK from Rob if this should be merged through
the GPIO tree. If it is going through the OF tree we'll have
to defer the resto of the stuff to the next merge window or
set it up on an immutable branch I can pull.

Yours,
Linus Walleij
