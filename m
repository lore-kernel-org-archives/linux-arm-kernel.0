From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 29 Jul 2014 13:57:10 +0300
Subject: [PATCH 1/2] remoteproc: use a flag to detect the presence of IOMMU
In-Reply-To: <1404836521-59637-2-git-send-email-s-anna@ti.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
 <1404836521-59637-2-git-send-email-s-anna@ti.com>
Message-ID: <CAK=Wgbawdik3ZB0Zbeaa7eXd7M+9ev9u713GcfOc4Gy0+O80Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Tue, Jul 8, 2014 at 7:22 PM, Suman Anna <s-anna@ti.com> wrote:
> The remoteproc driver core currently relies on iommu_present() on
> the bus the device is on, to perform MMU management. However, this
> logic doesn't scale for multi-arch, especially for processors that
> do not have an IOMMU.

Is there a specific hw/scenario where you need this? Can you please
provide more details about it?

Ideally we should add them to the commit log as well.

> The individual platform implementations are required to set this
> flag appropriately. The default setting is to not have an MMU.

Let's explicitly set the default please so this would be clear for
users reading the code.

> Cc: Sjur Br?ndeland <sjur.brandeland@stericsson.com>

Sjur is no longer with STE, so no point in cc'ing his old email address.

> +       /*
> +        * All existing OMAP IPU and DSP processors do have an MMU, and
> +        * are expected to use MMU, so this statement suffices.
> +        * XXX: Replace this logic if and when a need arises.

The last XXX comment is always true for any kernel code, so I'd drop it.

Thanks,
Ohad.
