From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 29 Jun 2015 16:27:49 +0530
Subject: [RFC PATCH v4 0/4] arm64:numa: Add numa support for arm64
 platforms.
In-Reply-To: <1421924755-26029-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1421924755-26029-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <CAFpQJXXZc0sop601wrmTe5Ng0SiSGfT9AA2Dpf=X9bgGN9srrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will, Mark,

can you please have a look of numa patches and share your review comments.


thanks
Ganapat

On Thu, Jan 22, 2015 at 4:35 PM, Ganapatrao Kulkarni
<gkulkarni@caviumnetworks.com> wrote:
> v4:
> done changes as per Arnd review comments.
>
> v3:
> Added changes to support numa on arm64 based platforms.
> Tested these patches on cavium's multinode(2 node topology) platform.
> In this patchset, defined and implemented dt bindings for numa mapping
> for core and memory using device node property arm,associativity.
>
> v2:
> Defined and implemented numa map for memory, cores to node and
> proximity distance matrix of nodes to each other.
>
> v1:
> Initial patchset to support numa on arm64 platforms.
>
> Hi Arnd,
>    there are not many common functions to pull to of driver from
>    powerpc and arm.
>
> thanks
> Ganapat
>
> Ganapatrao Kulkarni (4):
>   arm64: defconfig: increase NR_CPUS range to 2-4096.
>   Documentation: arm64/arm: dt bindings for numa.
>   arm64:thunder: Add initial dts for Cavium's Thunder SoC in 2     Node
>     topology.
>   arm64:numa: adding numa support for arm64 platforms.
>
>  Documentation/devicetree/bindings/arm/numa.txt | 212 +++++++
>  arch/arm64/Kconfig                             |  36 +-
>  arch/arm64/boot/dts/thunder-88xx-2n.dts        |  78 +++
>  arch/arm64/boot/dts/thunder-88xx-2n.dtsi       | 790 +++++++++++++++++++++++++
>  arch/arm64/include/asm/mmzone.h                |  32 +
>  arch/arm64/include/asm/numa.h                  |  43 ++
>  arch/arm64/kernel/Makefile                     |   1 +
>  arch/arm64/kernel/dt_numa.c                    | 302 ++++++++++
>  arch/arm64/kernel/setup.c                      |   8 +
>  arch/arm64/kernel/smp.c                        |   2 +
>  arch/arm64/mm/Makefile                         |   1 +
>  arch/arm64/mm/init.c                           |  34 +-
>  arch/arm64/mm/numa.c                           | 522 ++++++++++++++++
>  13 files changed, 2053 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
>  create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dts
>  create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dtsi
>  create mode 100644 arch/arm64/include/asm/mmzone.h
>  create mode 100644 arch/arm64/include/asm/numa.h
>  create mode 100644 arch/arm64/kernel/dt_numa.c
>  create mode 100644 arch/arm64/mm/numa.c
>
> --
> 1.8.1.4
>
