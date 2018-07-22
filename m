From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Jul 2018 17:12:47 +0900
Subject: UG_ON(!may_use_simd()); hit in kernel_neon_begin(); on 4.17.5
In-Reply-To: <a1494fa6-682d-8a95-ca14-5dd9979b6ae9@babibo.de>
References: <a1494fa6-682d-8a95-ca14-5dd9979b6ae9@babibo.de>
Message-ID: <CAKv+Gu_usN_4eR_izonf7+ZeQ32vRdYAxBrNX8E9qdqvYnekzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2018 at 16:26, Thomas Bach <hacking@babibo.de> wrote:
> Hi list,
>
> I reported this bug on NixOS issue tracker:
>
> https://github.com/NixOS/nixpkgs/issues/43808
>
> where I was suggested to report this here:
>
> I want add an additional device to an existing btrfs and convert data
> and metadata to raid1. The existing btrfs is currently on a plain
> partition, the added device resides on LUKS. During `btrfs balance` I
> observe the attached error-log in the journal and the process stalls.
> This happens on a RaspberryPi 3
>
> # uname -a
> Linux host 4.17.5 #1-NixOS SMP PREEMPT Sun Jul 8 13:32:21 UTC 2018
> aarch64 GNU/Linux
>
> This is reproducible on my system.
>

Thanks for the report.

Could you please check whether your kernel has this patch

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2fd8eb4ad87104c54800ef3cea498c92eb15c78a

and if it doesn't, whether applying it fixes your issue?

Thanks,
Ard.
