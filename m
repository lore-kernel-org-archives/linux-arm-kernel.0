From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 19 Sep 2017 17:11:47 -0400 (EDT)
Subject: [PULL REQUEST] boot and linker script stuff
In-Reply-To: <nycvar.YSQ.7.76.1708302312230.2606@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1708302312230.2606@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1709191709390.4063@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Could you pull the repo below please?  Nothing has changed except for 
being rebased on v4.13 now.

Thanks.


On Wed, 30 Aug 2017, Nicolas Pitre wrote:

> Russell, please pull the following:
> 
>   http://git.linaro.org/people/nicolas.pitre/linux xip_zdata
> 
> This contains important fixes to the XIP linker script, some more linker 
> script cleanups, .bss clearing and .data copying speedups related to the 
> above, and an opt-in config option for XIP kernels that allows for 
> compressing .data in ROM that depend on those other patches to work 
> properly.
> 
> This is the same patches as the series titled "[PATCH v2 0/5] make XIP 
> kernel .data compressed in ROM" plus some ACKs and Tested-bys.
> 
> The diffstat against v4.13-rc4 is:
> 
>  arch/arm/Kconfig                    | 11 ++++
>  arch/arm/boot/Makefile              | 13 ++++-
>  arch/arm/boot/deflate_xip_data.sh   | 64 +++++++++++++++++++++
>  arch/arm/kernel/Makefile            |  5 ++
>  arch/arm/kernel/head-common.S       | 85 +++++++++++++++++-----------
>  arch/arm/kernel/head-inflate-data.c | 62 ++++++++++++++++++++
>  arch/arm/kernel/vmlinux-xip.lds.S   | 94 ++++++++++++++-----------------
>  arch/arm/kernel/vmlinux.lds.S       | 40 ++-----------
>  8 files changed, 256 insertions(+), 118 deletions(-)
> 
> Thanks.
> 
> 
> Nicolas
> 
> 
