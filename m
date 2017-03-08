From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Mar 2017 09:24:01 +0100
Subject: next build: 208 builds: 21 failed, 187 passed, 53 errors, 406
 warnings (next-20170308)
In-Reply-To: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
References: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
Message-ID: <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 8, 2017 at 4:40 AM, kernelci.org bot <bot@kernelci.org> wrote:
> next build: 208 builds: 21 failed, 187 passed, 53 errors, 406 warnings
>
> allmodconfig (arm) ? PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
> :1325:2: warning: #warning syscall statx not implemented [-Wcpp]

The syscall was added to 4.11, and the warning will be resolved as soon
as all architectures add it to their tables.

> drivers/usb/gadget/udc/atmel_usba_udc.c:632:554: warning: 'ept_cfg' may be
> used uninitialized in this function [-Wmaybe-uninitialized]

I just resent my fix for the second time

> drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:743:178:
> warning: the address of '__func__' will always evaluate as 'true'
> [-Waddress]

A new regresssion as of today, won't be able to look myself, but this
should be trivial to address.

> bmips_be_defconfig (mips) ? FAIL, 1 error, 1 warning, 0 section mismatches
>
> Errors:
> arch/mips/kernel/smp-bmips.c:183:38: error: implicit declaration of function
> 'task_stack_page' [-Werror=implicit-function-declaration]

A new regression from the end of the merge window, also present in mainline.
I sent a fix yesterday, addressing various mips build failures.

> cavium_octeon_defconfig (mips) ? FAIL, 4 errors, 4 warnings, 0 section
> mismatches
> Warnings:
> drivers/staging/octeon/ethernet-rx.c:339:28: warning: unused variable 'priv'
> [-Wunused-variable]

I sent the patch on Feb 17, resent the same one today

> defconfig (arm64) ? PASS, 0 errors, 4 warnings, 0 section mismatches
>
> Warnings:
> :1325:2: warning: #warning syscall statx not implemented [-Wcpp]
> fs/overlayfs/inode.c:322:30: warning: 'ovl_i_mutex_key' defined but not used
> [-Wunused-variable]
> fs/overlayfs/inode.c:323:30: warning: 'ovl_i_mutex_dir_key' defined but not
> used [-Wunused-variable]

New regression as of today, haven't looked but seems trivial

> defconfig+CONFIG_KASAN=y (x86) ? PASS, 0 errors, 5 warnings, 0 section
> mismatches
>
> Warnings:
> net/wireless/nl80211.c:1415:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:4443:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:5743:1: warning: the frame size of 2064 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1904:1: warning: the frame size of 3784 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> drivers/tty/vt/keyboard.c:1472:1: warning: the frame size of 2344 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]

This is an old bug, I sent a first version of a longer patch series last
week, will need to be updated next week, but I hope to get this into v4.11.

    Arnd
