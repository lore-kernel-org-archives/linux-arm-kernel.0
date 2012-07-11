From: hs@denx.de (Heiko Schocher)
Date: Wed, 11 Jul 2012 11:08:58 +0200
Subject: [RFC] kernel, logbuf: add support for external log buffer
In-Reply-To: <1339395188-10166-1-git-send-email-hs@denx.de>
References: <1339395188-10166-1-git-send-email-hs@denx.de>
Message-ID: <4FFD42AA.8090301@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11.06.2012 08:13, Heiko Schocher wrote:
> This merges support for the previously DENX-only kernel
> feature of specifying an alternative, "external" buffer
> for kernel printk messages and their associated metadata.
> This patch is based on DENX-only kernel commit:
>
> commit 212f61c7fd3b952a81d1459dd32a86a32ddfd4ce
> Author: Igor Lisitsin<igor@emcraft.com>
> Date:   Wed Apr 18 14:55:19 2007 +0400
>
> Add support for external log buffer.
>
> Add support for external log buffer, for example passed by U-Boot,
> which may already contain messages (from the boot loader and/or POST).
>
> Signed-off-by: Igor Lisitsin<igor@emcraft.com>
>
> see:
> http://git.denx.de/?p=linux-denx.git;a=commit;h=212f61c7fd3b952a81d1459dd32a86a32ddfd4ce
>
> When this option is enabled, an architecture- or machine-specific log
> buffer is used for all printk messages. This allows entities such as
> boot loaders (e.g. U-Boot) to place printk-compatible messages into
> this buffer and for the kernel to coalesce them with its normal
> messages. This patch support this feature for arch/arm based
> boards.
>
> Signed-off-by: Heiko Schocher<hs@denx.de>
> Cc: Wolfgang Denk<wd@denx.de>
> Cc: Igor Lisitsin<igor@emcraft.com>
> Cc: Grant Erickson<gerickson@nuovations.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: Tim Bird<tim.bird@am.sony.com>
> Cc: CE Linux Developers List<celinux-dev@lists.celinuxforum.org>
> Cc: Kay Sievers<kay@vrfy.org>
>
> ---
> restage prior discussion from lkml:
>
> https://lkml.org/lkml/2009/1/21/250
>
> Discussion stopped, and I want to reanimate it, also there is a
> Project Proposal on the "CE Linux Developers List" for such a feature,
> see here:
>
> http://www.mail-archive.com/celinux-dev at lists.celinuxforum.org/msg00103.html
>
> Maybe it is now the time to discuss this again?
>
> Is it worth to try to get this old code in current kernel, or
> should we investigate Kay Sievers proposal for a structured logging
> system, which will alter the format of the messages as they are
> stored in the log buffer, and discuss for this a "logbuffer support"?
>
> See this discussion here:
>
> http://thread.gmane.org/gmane.linux.kernel/1277619
>
>   arch/arm/mm/init.c      |   25 ++++++++++
>   include/linux/logbuff.h |   51 ++++++++++++++++++++
>   init/Kconfig            |   12 +++++
>   init/main.c             |    5 ++
>   kernel/printk.c         |  117 +++++++++++++++++++++++++++++++++++++++++++++--
>   5 files changed, 206 insertions(+), 4 deletions(-)
>   create mode 100644 include/linux/logbuff.h

ping? I got no respond to this RFC ... no chance to get this to
mainline?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
