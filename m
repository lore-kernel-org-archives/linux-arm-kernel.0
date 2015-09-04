From: robherring2@gmail.com (Rob Herring)
Date: Fri, 4 Sep 2015 14:19:53 -0500
Subject: [PATCH v4 1/4] of/pci: Add of_pci_check_probe_only to parse
 "linux, pci-probe-only"
In-Reply-To: <1441385411-7624-2-git-send-email-marc.zyngier@arm.com>
References: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
 <1441385411-7624-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL_JsqKjXqgCvzUcTZkCfgpvub6uh_XzLTfyHpgSZzh4dJaOEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 11:50 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
> property to engage the PCI_PROBE_ONLY mode, and both have a subtle
> bug that can be triggered if the property has no parameter.
>
> Provide a generic, safe implementation that can be used by both.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/of/of_pci.c    | 28 ++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  3 +++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..5dd4966 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -118,6 +118,34 @@ int of_get_pci_domain_nr(struct device_node *node)
>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>
>  /**
> + * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
> + *                           is present and valid
> + *
> + * @node: device tree node that may contain the property (usually "chosen")

This line should be removed. Perhaps Bjorn will fix it up.

Rob
