From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 24 Aug 2017 00:41:08 +0200
Subject: [PATCH v2 1/9] PM / ACPI: Restore acpi_subsys_complete()
In-Reply-To: <1503499329-28834-2-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <1503499329-28834-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0iAanGEvRF=J-wL9jKoBpZoGGc7+BXokt4PLWKxi85ctA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 4:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have
> been reset by firmware"), made PCI's and ACPI's ->complete() callbacks to
> be assigned to a new API called pm_complete_with_resume_check(), which was
> introduced in the same change.
>
> Later it turned out that using pm_complete_with_resume_check() isn't good
> enough for PCI, as it needs additional PCI specific checks, before deciding
> whether runtime resuming the device is needed when running the ->complete()
> callback.
>
> This leaves ACPI being the only user of pm_complete_with_resume_check().

I would say "the ACPI PM domain" instead of just "ACPI" here, because
in fact this is only about the ACPI PM domain.

This more-or-less applies to all of the changelogs in this series and
to some comments added by it too: please be specific that it is *only*
about the ACPI PM domain.

The patch itself is fine.

Thanks,
Rafael
