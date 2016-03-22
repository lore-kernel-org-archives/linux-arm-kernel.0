From: harninder.rai@nxp.com (Harninder Rai)
Date: Tue, 22 Mar 2016 17:49:53 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <CAB5YjtCoX5FoRbOYTPCETbbBGmEvs=1Xm6Giho78TH_a7u=eXw@mail.gmail.com>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB1688B860F637096FC8D4A59CE68F0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCoX5FoRbOYTPCETbbBGmEvs=1Xm6Giho78TH_a7u=eXw@mail.gmail.com>
Message-ID: <DB5PR04MB16880EDB87EE70B0274E7C21E6800@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Booting Linux on physical CPU 0x0
> [ ? ?0.000000] Linux version 4.5.0-rc6-00038-gae2804a-dirty (hrai at nmglablinux22) (gcc version 4.8.3 20140401 (prerelease) (Linaro GCC 4.8-2014.04) ) #2 SMP PREEMPT Fri Mar 11 14:45:30 IST 2016
> [ ? ?0.000000] Boot CPU: AArch64 Processor [411fd071]
> [ ? ?0.000000] Ignoring memory range 0x80000000 - 0x8c000000
> [ ? ?0.000000] earlycon: Early serial console at MMIO 0x21c0600 (options '')
> [ ? ?0.000000] bootconsole [uart0] enabled
> [ ? ?0.000000] efi: Getting EFI parameters from FDT:
> [ ? ?0.000000] efi: UEFI not found.
> [ ? ?0.000000] crashkernel has wrong address or size
This implies a root cause. (See arch/arm64/mm/init.c)
Hint: add memblock=debug to kernel parameters of crash dump kernel

Thanks for the hint. I will try this out
One thing which comes to my mind is that I am using the production kernel image for crash kernel and Documentation/kdump doesn't mention that arm64 supports that. Can this be a cause for the above problem?

Regards
Harry++
