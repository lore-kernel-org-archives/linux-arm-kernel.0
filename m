From: dyoung@redhat.com (Dave Young)
Date: Mon, 17 Nov 2014 11:49:12 +0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <1415922648.15847.107.camel@smoke>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <1414797939.23621.38.camel@smoke>
 <20141113083706.GA8615@darkstar.nay.redhat.com>
 <1415922648.15847.107.camel@smoke>
Message-ID: <20141117034912.GB3160@darkstar.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/14 at 03:50pm, Geoff Levand wrote:
> On Thu, 2014-11-13 at 16:37 +0800, Dave Young wrote:
> > In your kexec-tools code, by default it will create dtb1 from procfs, as for external
> > --dtb it will be dtb2 for comparing with dtb1.
> > 
> > Since dtb1 is a must so it will not work without /proc/device-tree.
> 
> I changed that to allow for no /proc/device-tree if --dtb is passed
> since it will also allow a kernel built with CONFIG_PROC_FS=n to do
> kexec re-boot.
> 
> Please try it and let me know.

Tested the master branch or your kexec-tools, I got below with
"mount -o bind /root /proc" because there's some other issues for my customized
kernel to boot: 

arch_process_options:95: initrd: (null)
arch_process_options:96: dtb: apm-mustang.dtb
arch_process_options:97: lite: 1
arch_process_options:99: port: 0x0
kernel: 0x3ff9cbb0010 kernel_size: 0x602c947
unrecoverable error: could not scan "/proc/device-tree/": No such file or directory

Thanks
Dave
