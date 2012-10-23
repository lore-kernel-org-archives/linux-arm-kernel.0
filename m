From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Oct 2012 10:17:44 -0600
Subject: [PATCH v2] pinctrl/nomadik: use irq_create_mapping()
In-Reply-To: <1350981339-13316-1-git-send-email-linus.walleij@stericsson.com>
References: <1350981339-13316-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5086C328.2080705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 02:35 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Since in the DT case, the linear domain path will not allocate
> descriptors for the IRQs, we need to use irq_create_mapping()
> for mapping hwirqs to Linux IRQs, so these descriptors get
> created on-the-fly in this case.
> 
> ChangeLog v1->v2:
> 
> - Just use irq_create_mapping() in the .to_irq function since
>   this is called before unmasking or enabling any interrupt
>   lines, so irq_find_mapping() should be sufficient for the
>   IRQ handler function.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
