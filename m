From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jun 2013 12:36:53 +0100
Subject: ARM : Kexec fails with kernel 3.10 on ARM Versatile TC2
In-Reply-To: <CALicx6sYQ19Jx_HuwLeoXNiNFSNvCUc+XKMZsf6vAasPhxOVSg@mail.gmail.com>
References: <CALicx6sYQ19Jx_HuwLeoXNiNFSNvCUc+XKMZsf6vAasPhxOVSg@mail.gmail.com>
Message-ID: <20130621113653.GF7766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 12:32:34PM +0100, Vijay Kilari wrote:
> Hi,
> 
>   With Kernel 3.10 SMP kernel, on versatile TC2 board, Kexec hangs.
> 
> 
> arm-cortex-a15 login: kexec -f /boot/uImage
> --command-line="root=/dev/nfs rw ip=bootp console=ttyS0,38400n8"
> Modified cmdline:root=/dev/nfs rw ip=bootp console=ttyS0,38400n8
> Starting new kernel
> Bye!
> Uncompressing Linux... done, booting the kernel
> 
> Can you please provide your inputs?

SMP kexec isn't possible on TC2 because there's no way to kill off the
secondary CPUs with mainline Linux. You could take a look at the recent
patches from Stephen Warren (19ab428f4b79 ["ARM: 7759/1: decouple CPU
offlining from reboot/shutdown"], but you'd still need to implement the
various hotplug parts (a software pen is not enough) to get SMP working
safely.

If you're just using this for something like a bootloader, then you could
use a UP kernel as the first stage.

Will
