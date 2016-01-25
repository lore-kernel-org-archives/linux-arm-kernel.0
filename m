From: lho@apm.com (Loc Ho)
Date: Mon, 25 Jan 2016 13:25:00 -0800
Subject: [PATCH v4 2/2] acpi: apei: Enable APEI multiple GHES source to
 share an single external IRQ
In-Reply-To: <1453335459-3617-3-git-send-email-lho@apm.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
 <1453335459-3617-3-git-send-email-lho@apm.com>
Message-ID: <CAPw-ZTmmK1RvKQVpNLtP=X+cxMVj3wYqq78x1eZ+2w5+5Q1dYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On Wed, Jan 20, 2016 at 4:17 PM, Loc Ho <lho@apm.com> wrote:
> This patch allows APEI generic error source table with external
> IRQ to share an single IRQ.
>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/acpi/apei/ghes.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3dd9c46..76146c8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1011,7 +1011,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
>                                generic->header.source_id);
>                         goto err_edac_unreg;
>                 }
> -               rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
> +               rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
> +                                "GHES IRQ", ghes);
>                 if (rc) {
>                         pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
>                                generic->header.source_id);

Can this be pull into 4.5-rcX given that it was already ack'ed week back?

-Loc
