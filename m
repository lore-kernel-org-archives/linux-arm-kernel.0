From: harninder.rai@nxp.com (Harninder Rai)
Date: Fri, 13 May 2016 12:45:04 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <20160511005334.GA8417@linaro.org>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
 <DB5PR04MB1688F09062B2A5ECACCA4D80E6710@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160511005334.GA8417@linaro.org>
Message-ID: <DB5PR04MB1688C3F122091109E6BD9B68E6740@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Takahiro Akashi,

> 
> Apparently lack of memory is a cause of OOM killer, but the core file has
> nothing to do with this issue.
> I think that you don't have enough memory for the system yet.
> 
> -Takahiro AKASHI


I moved to SD card based rootfs for booting the crash kernel but when I try to load the dump kernel, I get the following message
Is there limitation with kexec that the crash kernel cannot be booted from anything apart from RAM?

kexec -p ./vmlinux --initrd=./ramdisk_ls1012_openwrt.cpio.gz --append='console=ttyS1,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0600ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 crashkernel=64M at 2240M memblock=debug'
Memory for crashkernel is not reserved
Please reserve memory by passing"crashkernel=X at Y" parameter to kernel
Then try to loading kdump kernel

Regards
Harry++
