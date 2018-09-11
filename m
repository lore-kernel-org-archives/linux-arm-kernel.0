From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 11 Sep 2018 18:07:10 +0530
Subject: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2018 at 9:58 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Sunil Goutham <sgoutham@marvell.com>
>
> Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> PF0 is called administrative / admin function (AF) and has privilege access
> to registers to provision different RVU functional blocks to each of
> PF/VF.
>
> This admin function (AF) driver acts as a configuration / administrative
> software which provisions functional blocks to a PF/VF on demand for them
> to work as one of the following
>  - A basic network controller (i.e NIC).
>  - NIC with packet filtering, shaping and scheduling capabilities.
>  - A crypto device.
>  - A combination of above etc.
>
> PF/VFs communicate with admin function via a shared memory region.
> This patch series adds logic for the following
>  - RVU AF driver with functional blocks provisioning support
>  - Mailbox infrastructure for communication between AF and PFs.
>  - CGX driver which provides information about physcial network
>    interfaces which AF processes and forwards required info to
>    PF/VF drivers.
>
> This is the first set of patches out of 70 odd patches.
>
> Note: This driver neither receives any data nor processes it i.e no I/O,
>       just does the hardware configuration.
>
> Changes from v2:
>  No changes, submitted again with netdev mailing list in loop.
>    - Suggested by Arnd Bergmann and Andrew Lunn
>
> Changes from v1:
>  1 Merged RVU admin function and CGX drivers into a single module
>    - Suggested by Arnd Bergmann
>  2 Pulled mbox communication APIs into a separate module to remove
>    admin function driver dependency in a VM where AF is not attached.
>    - Suggested by Arnd Bergmann
>

Hi Arnd,

Didn't receive any feedback for the v3 patch series over a week's time.
Can you please pick up these patches to merge into arm-soc ?

Thanks,
Sunil.
