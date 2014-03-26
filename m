From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Mar 2014 09:28:42 -0500
Subject: [PATCH v5 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
In-Reply-To: <1395270762-6055-3-git-send-email-tinamdar@apm.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-3-git-send-email-tinamdar@apm.com>
Message-ID: <CAL_Jsq+XxAtUeNKFi0hH=ehb_fhFvkM0U1Zm_j1LdtQZbvSzfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 6:12 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> This patch adds the device tree nodes for APM X-Gene PCIe controller and
> PCIe clock interface. Since X-Gene SOC supports maximum 5 ports, 5 dts
> nodes are added.

[snip]

> +               pcie0: pcie at 1f2b0000 {
> +                       status = "disabled";
> +                       device_type = "pci";
> +                       compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       #address-cells = <3>;
> +                       reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
> +                               0xe0 0xd0000000 0x0 0x00200000>; /* PCI config space */

Where is the right place for config space? This binding has it here
and others have it in ranges. Given that config space type is defined
for ranges, I would think that is the right place. But Liviu's patches
do not process config space entries in ranges. Perhaps we need a
config space resource populated in the bridge struct.

Rob


> +                       reg-names = "csr", "cfg";
> +                       ranges = <0x01000000 0x00 0x00000000 0xe0 0x00000000 0x00 0x00010000   /* io */
> +                                 0x02000000 0x00 0x10000000 0xe0 0x10000000 0x00 0x80000000>; /* mem */
