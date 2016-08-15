From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Aug 2016 18:59:41 +0200
Subject: [PATCH] pinctrl: exynos: remove duplicate calls in irq handler
In-Reply-To: <1471256227-6282-1-git-send-email-strongbox8@zoho.com>
References: <1471256227-6282-1-git-send-email-strongbox8@zoho.com>
Message-ID: <20160815165941.GA3769@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 06:17:07PM +0800, perr wrote:
> Because chained_irq_enter() has already called chip->irq_mask() and
> chip->irq_ack(), also chained_irq_exit() will call chip->irq_unmask(),
> so it's not necessary to call chip->irq_*() here.
> 
> Signed-off-by: perr <strongbox8@zoho.com>
> 
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>


Looks correct so for the patch itself:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

However, your name "Perr" confuses me a little bit. For the
Signed-off-by statement, as mentioned in
Documentation/SubmittingPatches, a real name is required. The name
should match the author.

Would you be so kind as to use a full, real name? Unless Perr is your
full, real name... then sorry for the trouble.

Best regards,
Krzysztof
