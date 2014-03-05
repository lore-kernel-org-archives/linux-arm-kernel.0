From: tinamdar@apm.com (Tanmay Inamdar)
Date: Tue, 4 Mar 2014 17:49:13 -0800
Subject: [PATCH v5 5/7] pci: Use parent domain number when allocating
 child busses.
In-Reply-To: <1393948204-11555-6-git-send-email-Liviu.Dudau@arm.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948204-11555-6-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CACoXjcmKKObSFignRWZAuOmmvfFtLf5O04Y5romJ=c6a9Jriqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 4, 2014 at 7:50 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> pci_alloc_child_bus() uses the newly allocated child bus to figure
> out the domain number that is going to use for setting the device
> name. A better option is to use the parent bus domain number.
>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 26237a0..a12cda5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -677,7 +677,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>          * now as the parent is not properly set up yet.
>          */
>         child->dev.class = &pcibus_class;
> -       dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
> +       dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(parent), busnr);
>
>         /*
>          * Set up the primary, secondary and subordinate
> --
> 1.9.0
>

This patch is not required after the fix in pci_domain_nr for arm64.
