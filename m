From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 29 Mar 2016 20:15:05 +0800
Subject: [PATCH 0/3] Entend cpuinfo
In-Reply-To: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <56FA71C9.7030806@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

According to the explain of Mark and Dave, please ignore this patches.
No need do this in kernel, do it in userspace.

Thanks,
Kefeng

On 2016/3/25 17:30, Kefeng Wang wrote:
> The patches aimed at enhencing cpuinfo.
> 
> * ARMv8 supports several different types of physical/virtual address bits,
>   up to 52bit in ARMv8.2 especially, it's better to expose it.
> 
> * Show the name of chip vendor and CPU model to customers, identify them
>   by CPU implementer and part is not intuitive(compared with x86).
> 
> Ideally, add new line to cpuinfo won't break userspace, I hope so, the cpuinfo
> shown in qemu with patches,
> 
> root at linux$ cat /proc/cpuinfo 
> processor	: 0
> vendor_id	: ARM
> model name	: Cortex-A57 rev 0 (aarch64)
> BogoMIPS	: 125.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32
> CPU implementer	: 0x41
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0xd07
> CPU revision	: 0
> address sizes	: 44 bits physical, 48 bits virtual
> 
> processor	: 1
> vendor_id	: ARM
> model name	: Cortex-A57 rev 0 (aarch64)
> BogoMIPS	: 125.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32
> CPU implementer	: 0x41
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0xd07
> CPU revision	: 0
> address sizes	: 44 bits physical, 48 bits virtual
> 
> Kefeng Wang (3):
>   arm64: Append more field of id_aa64mmfr2 for cpufeature
>   arm64: Expose physical/virtual address bits through cpuinfo
>   arm64: Expose cpu vender id and model name through cpuinfo
> 
>  arch/arm64/include/asm/cpu.h        |  2 ++
>  arch/arm64/include/asm/cpufeature.h | 18 ++++++++++
>  arch/arm64/include/asm/sysreg.h     |  4 +++
>  arch/arm64/kernel/cpufeature.c      |  4 +++
>  arch/arm64/kernel/cpuinfo.c         | 68 ++++++++++++++++++++++++++++++++++++-
>  5 files changed, 95 insertions(+), 1 deletion(-)
> 
