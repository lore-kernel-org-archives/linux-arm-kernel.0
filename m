From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 18 Jan 2017 20:00:44 +0200
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
 <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
Message-ID: <CAHp75VcLL9zvRXGCy2ynjhYFUgbYwJvLpCiUxjtsKmXjVFHmKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 6:46 PM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> ACPI extended IRQ resources may contain a ResourceSource to specify
> an alternate interrupt controller. Introduce acpi_irq_get and use it
> to implement ResourceSource/IRQ domain mapping.
>
> The new API is similar to of_irq_get and allows re-initialization
> of a platform resource from the ACPI extended IRQ resource, and
> provides proper behavior for probe deferral when the domain is not
> yet present when called.
>

Care to use -M -C when prepare this patch?

>  drivers/acpi/gsi.c      |  98 -----------------
>  drivers/acpi/irq.c      | 282 ++++++++++++++++++++++++++++++++++++++++++++++++

-- 
With Best Regards,
Andy Shevchenko
