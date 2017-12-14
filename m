From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 14 Dec 2017 19:13:06 +0100
Subject: [patch v14 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1513268971-13518-2-git-send-email-oleksandrs@mellanox.com>
References: <1513268971-13518-1-git-send-email-oleksandrs@mellanox.com>
 <1513268971-13518-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CAOFm3uHd7VJWRiYPSuTbEmeh1YohUC_9Gr2AiP8qdpUPcY83nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oleksandr,

On Thu, Dec 14, 2017 at 5:29 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> Initial patch for JTAG driver
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.
>
> Driver exposes set of IOCTL to user space for:
> - XFER:
> - SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
> - SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
>   number of clocks).
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
>
> Driver core provides set of internal APIs for allocation and
> registration:
> - jtag_register;
> - jtag_unregister;
> - jtag_alloc;
> - jtag_free;
>
> Platform driver on registration with jtag-core creates the next
> entry in dev folder:
> /dev/jtagX
>
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> ---
> v13->v14
> Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
> - Change style of head block comment from /**/ to //
>
> v12->v13
> Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
> - Change jtag.c licence type to
>   SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>   and reorder line with license in description
> v11->v12
> Comments pointed by Greg KH <gregkh@linuxfoundation.org>
> - Change jtag.h licence type to
>   SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>   and reorder line with license in description

Thanks for the SPDX bits: for this part you have my ack:

Acked-by: Philippe Ombredanne <pombredanne@nexB.com?

-- 
Cordially
Philippe Ombredanne
