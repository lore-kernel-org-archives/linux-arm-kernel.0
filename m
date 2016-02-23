From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 23 Feb 2016 10:31:57 +0800
Subject: [PATCH v2 0/6] arm64: Add support of KVM with ACPI
In-Reply-To: <1455204804-31830-1-git-send-email-julien.grall@arm.com>
References: <1455204804-31830-1-git-send-email-julien.grall@arm.com>
Message-ID: <20160223023156.GA11645@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 03:33:18PM +0000, Julien Grall wrote:
> Hello,
>
> This small series allows an ARM64 ACPI based platform to use KVM.
>
> Currently the KVM code has to parse the firmware table to get the necessary
> information to setup the virtual timer and virtual GIC.
>
> However the parsing of those tables are already done in the GIC and arch
> timer drivers.
>
> This patch series introduces different helpers to retrieve the information
> from different drivers avoiding to duplicate the parsing code.
>
> Note there is patch series ([1] and [2]) adding support of KVM on ACPI,
> although the approach chosen is completely different. The code to parse
> the firmware tables are duplicated which I think make more complex to
> support new firmware tables.
>
> See the changes since v1 in the different patches.
>
> Regards,
>
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-February/018482.html
> [2] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-February/018355.html
>
> Julien Grall (6):
>   KVM: arm/arm64: arch_timer: Gather KVM specific information in a
>     structure
>   KVM: arm/arm64: arch_timer: Rely on the arch timer to parse the
>     firmware tables
>   irqchip/gic-v2: Gather ACPI specific data in a single structure
>   irqchip/gic-v2: Parse and export virtual GIC information
>   irqchip/gic-v3: Parse and export virtual GIC information
Beside this patch (I do not have the gic-v3 hardware now), I tested this patch set with my JUNo-r1 board
with kvmtool. It works fine.

Tested-by: Huang Shijie <shijie.huang@arm.com>



>   KVM: arm/arm64: vgic: Rely on the GIC driver to parse the firmware
>     tables
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
