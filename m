From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 2 Mar 2012 07:59:20 +0100
Subject: [PATCH v3 22/30] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-23-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
 <1330658022-14559-23-git-send-email-robherring2@gmail.com>
Message-ID: <20120302065920.GA441@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/Kconfig                         |    1 -
>  arch/arm/mach-tegra/include/mach/io.h    |   46 ------------------------------
>  arch/arm/mach-tegra/include/mach/iomap.h |    3 ++
>  arch/arm/mach-tegra/io.c                 |    2 +
>  arch/arm/mach-tegra/pcie.c               |   41 ++------------------------
>  5 files changed, 9 insertions(+), 84 deletions(-)
>  delete mode 100644 arch/arm/mach-tegra/include/mach/io.h
[...]

This looks good to me. Moreover this gets rid of some of the ugly globals
initialized by the PCI support and should fit in nicely with the work I'm
doing to rewrite it as a driver and add device tree support.

Unfortunately I'm unable to test actual accesses because none of the PCI
devices that I use have I/O regions.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120302/04cf7d86/attachment-0001.sig>
