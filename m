From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 10 Jan 2011 16:43:44 -0600
Subject: [PATCH 3/5] ARM: pxa: Use cpu_has_ipr() consistently in irq.c
In-Reply-To: <1294615746-27668-3-git-send-email-marek.vasut@gmail.com>
References: <1294615746-27668-1-git-send-email-marek.vasut@gmail.com>
	<1294615746-27668-3-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTikX767106D6uCtqLq9NiLrnWBbgxj5p7K6wajv8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 9, 2011 at 5:29 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/irq.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 54e91c9..78f0e0c 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -226,7 +226,7 @@ static int pxa_irq_resume(struct sys_device *dev)
> ? ? ? ? ? ? ? ?__raw_writel(0, base + ICLR);
> ? ? ? ?}
>
> - ? ? ? if (!cpu_is_pxa25x())
> + ? ? ? if (cpu_has_ipr())
> ? ? ? ? ? ? ? ?for (i = 0; i < pxa_internal_irq_nr; i++)
> ? ? ? ? ? ? ? ? ? ? ? ?__raw_writel(saved_ipr[i], IRQ_BASE + IPR(i));
>
> --
> 1.7.2.3
>
>
