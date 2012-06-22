From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 22 Jun 2012 22:45:19 +0800
Subject: GPMI NAND on MX28 with DT.with
In-Reply-To: <4FE39F19.9090105@grid-net.com>
References: <4FE39F19.9090105@grid-net.com>
Message-ID: <CAMiH66HMCte-8BAqZiPu0T=U9MzCEfyznND0Hwm7TsctzJe9UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
  yes, the gpmi-nand has bugs now.
I will try to fix it when I am free.

thanks
Huang Shijie


On Fri, Jun 22, 2012 at 6:24 AM, Subodh Nijsure <snijsure@grid-net.com> wrote:
> Has anyone gotten the latest GPMI NAND patches for MX28 with device-tree to
> work?
>
> I came across this thread where Huang Shijie reported that it has some
> issues with ECC.
>
> Our attempt to attach fail as shown below, anybody else encountered these
> errors?
>
> cat /proc/mtd
> dev: ? ?size ? erasesize ?name
> mtd0: 00a00000 00020000 "boot"
> mtd1: 0f200000 00020000 "data"
> mtd2: 00400000 00020000 "boot-config"
>
> ubiformat /dev/mtd1
> ubiformat: mtd1 (nand), size 253755392 bytes (242.0 MiB), 1936 eraseblocks
> of 131072 bytes (128.0 KiB), min. I/O size 2048 bytes
> libscan: scanning eraseblock 1935 -- 100 % complete
> ubiformat: 1933 eraseblocks have valid erase counter, mean value is 3
> ubiformat: 3 bad eraseblocks found, numbers: 264, 468, 1593
> ubiformat: formatting eraseblock 1935 -- 100 % complete
> / # ubiattach /dev/ubi_ctrl -m 1
> [ ?185.560000] UBI error: vtbl_check: bad CRC at record 0: 0x2b4f6dd5, not
> 0x000000
> [ ?185.560000] UBI error: vtbl_check: bad CRC at record 0: 0x2b4f6dd5, not
> 0x000000
> [ ?185.560000] UBI error: process_lvol: both volume tables are corrupted
> [ ?185.560000] UBI error: ubi_attach_mtd_dev: failed to attach mtd1, error
> -22
> ubiattach: error!: cannot attach mtd1
> ? ? ? ? ? error 22 (Invalid argument)
>
>
> -Subodh Nijsure
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
