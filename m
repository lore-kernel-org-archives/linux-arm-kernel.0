From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Tue, 08 Apr 2014 12:14:22 +0300
Subject: Big endian working?
In-Reply-To: <20140408095446.0520dd28@skate>
References: <20140408095446.0520dd28@skate>
Message-ID: <5343BDEE.4010005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 10:54 AM, Thomas Petazzoni wrote:
> Hello Taras,
>
> I'm currently trying to get ARM BE to work on Armada XP. I'm pretty
> sure it used to work on 3.13, but now I'm testing 3.13 and 3.14 and it
> doesn't boot here (it hangs even before "Uncompressing kernel...",
> apparently while relocating the kernel image before decompression).
>
> Ben Dooks told me that the ARM BE kernel works for you. Can you confirm
> which kernel version you're using, and if you've applied any patch?
> Also, can you confirm which toolchain and toolchain version you're
> using?

Hi Tom

To boot BE kernel from LE u-boot I'm using a few patches on top of 
upstream kernel.

git://git.linaro.org/people/taras.kondratiuk/linux.git arm-be-boot-le

----------------------------------------------------------------
Ben Dooks (1):
       ARM: add CPU_BE8_BOOT_LE configuration

Nico Pitre (1):
       ARM: ensure loader information in LE format for BE kernels

  arch/arm/boot/compressed/Makefile       |    5 ++++-
  arch/arm/boot/compressed/head.S         |    7 ++++---
  arch/arm/boot/compressed/vmlinux.lds.in |   14 ++++++++++++++
  arch/arm/mm/Kconfig                     |    7 +++++++
  4 files changed, 29 insertions(+), 4 deletions(-)

-- 
Taras Kondratiuk
