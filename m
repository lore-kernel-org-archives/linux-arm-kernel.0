From: dyoung@redhat.com (Dave Young)
Date: Thu, 13 Nov 2014 16:37:06 +0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <1414797939.23621.38.camel@smoke>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <1414797939.23621.38.camel@smoke>
Message-ID: <20141113083706.GA8615@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/14 at 04:25pm, Geoff Levand wrote:
> Hi Dave,
> 
> Thanks for testing.
> 
> On Fri, 2014-10-31 at 15:52 +0800, Dave Young wrote:
> > I tested your patches. The macihne is using spin-table cpu enable method
> > so I tried maxcpus=1 as you suggested.
> > 
> > There's below issues for me, thoughts?
> > 
> > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> > to use.
> 
> You can supply a DTB with the kexec --dtb option, then kexec will not need
> /proc/device-tree.  Please try if you can and let me know what happens.
> 

In your kexec-tools code, by default it will create dtb1 from procfs, as for external
--dtb it will be dtb2 for comparing with dtb1.

Since dtb1 is a must so it will not work without /proc/device-tree.

There had some discussion about this in the thread. But I think we have no
conclusion where to go.

There maybe below possibilities:
1) unflattern dtb both for EFI/acpi booting even if acpi boot does not need it.

2) copy the bootloader passed dtb stub to somewhere, and export the stub to
 userspace ie. in debugfs or procfs
 like /proc/saved_dtb 

Thoughts to continue the discuss?

Thanks
Dave
