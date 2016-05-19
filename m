From: harninder.rai@nxp.com (Harninder Rai)
Date: Thu, 19 May 2016 13:53:56 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <20160519110307.GA4941@linaro.org>
References: <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
 <DB5PR04MB1688F09062B2A5ECACCA4D80E6710@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160511005334.GA8417@linaro.org>
 <DB5PR04MB1688C3F122091109E6BD9B68E6740@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160519110307.GA4941@linaro.org>
Message-ID: <DB5PR04MB168870DA264FEA88763A84ADE64A0@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> I don't know what you did here exactly, but I don't think that there is such
> a limitation.
Ok. Thanks for the confirmation
> 
> > kexec -p ./vmlinux --initrd=./ramdisk_ls1012_openwrt.cpio.gz --
> append='console=ttyS1,115200 root=/dev/mmcblk0p1
> earlycon=uart8250,mmio,0x21c0600ramdisk_size=0x2000000 default_hugepagesz=2m
> hugepagesz=2m hugepages=256 crashkernel=64M at 2240M memblock=debug'
> > Memory for crashkernel is not reserved
> 
> This message is a hint. You have got the same one before, right?
> Please check /proc/iomem and a dmesg log from the first kernel with
> memblock=debug.
I did check /proc/iomem and everything looks there. This is very strange since if I keep everything same and just move the rootfs from RAM based to SD based, I start getting this issue. 

Regards
Harry++
