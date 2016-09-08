From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 8 Sep 2016 08:45:35 -0500
Subject: [PATCH 3/3] of: pci: remove unused MSI controller helpers
In-Reply-To: <1472744284-18305-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472744284-18305-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472744284-18305-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAL_JsqJHN3VCzs4k_FpQSGr=69B_YcCJDhZxi=poZW-2QNMRvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 10:38 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> All the users of the small MSI controller API have been migrated to use
> the generic MSI infrastructure instead. We no longer need a global
> chained list of msi_controller. Instead, MSI controllers are now
> represented as irq domains attached to OF nodes, and the resolution
> between a device requesting an MSI and the corresponding MSI controller
> is done by the generic interrupt resolution logic.
>
> Therefore, this API is now completely useless, and can be removed from
> the kernel.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 45 ---------------------------------------------
>  include/linux/of_pci.h | 11 -----------
>  2 files changed, 56 deletions(-)

This is to both Bjorn and me, but I'm assuming you want Bjorn to take
the series.

Acked-by: Rob Herring <robh@kernel.org>

Rob
