From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 12 Mar 2015 11:04:03 +0200
Subject: [PATCH v3 1/2] remoteproc: use a flag to detect the presence of
 IOMMU
In-Reply-To: <1420838519-15669-2-git-send-email-s-anna@ti.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com>
 <1420838519-15669-2-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbawMvc5Td-1+eEv3+BJWCUwHeZskJwDTPUaD66RT6EOxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 11:21 PM, Suman Anna <s-anna@ti.com> wrote:
> The remoteproc driver core currently relies on iommu_present() on
> the bus the device is on, to perform MMU management. However, this
> logic doesn't scale for multi-arch, especially for processors that
> do not have an IOMMU. Replace this logic instead by using a h/w
> capability flag for the presence of IOMMU in the rproc structure.
>
> This issue is seen on OMAP platforms when trying to add a remoteproc
> driver for a small Cortex M3 called the WkupM3 used for suspend /
> resume management on TI AM335/AM437x SoCs. This processor does not
> have an MMU. Same is the case with another processor subsystem
> PRU-ICSS on AM335/AM437x. All these are platform devices, and the
> current iommu_present check will not scale for the same kernel image
> to support OMAP4/OMAP5 and AM335/AM437x.
>
> The existing platform implementation drivers - OMAP remoteproc, STE
> Modem remoteproc and DA8xx remoteproc, are updated as well to properly
> configure the newly added rproc field.
>
> Cc: Robert Tivy <rtivy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Applied to remoteproc's for-next branch.

Thanks,
Ohad.
