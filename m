From: geoff@infradead.org (Geoff Levand)
Date: Thu, 13 Nov 2014 15:50:48 -0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141113083706.GA8615@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <1414797939.23621.38.camel@smoke>
 <20141113083706.GA8615@darkstar.nay.redhat.com>
Message-ID: <1415922648.15847.107.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-11-13 at 16:37 +0800, Dave Young wrote:
> In your kexec-tools code, by default it will create dtb1 from procfs, as for external
> --dtb it will be dtb2 for comparing with dtb1.
> 
> Since dtb1 is a must so it will not work without /proc/device-tree.

I changed that to allow for no /proc/device-tree if --dtb is passed
since it will also allow a kernel built with CONFIG_PROC_FS=n to do
kexec re-boot.

Please try it and let me know.

> There had some discussion about this in the thread. But I think we have no
> conclusion where to go.
> 
> There maybe below possibilities:
> 1) unflattern dtb both for EFI/acpi booting even if acpi boot does not need it.
> 
> 2) copy the bootloader passed dtb stub to somewhere, and export the stub to
>  userspace ie. in debugfs or procfs
>  like /proc/saved_dtb 
> 
> Thoughts to continue the discuss?

Some progress has been made, let's see what they come up with.

-Geoff
