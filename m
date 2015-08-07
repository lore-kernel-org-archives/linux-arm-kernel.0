From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 7 Aug 2015 18:11:02 +0100
Subject: [Xen-devel] [PATCH v3 00/20] xen/arm64: Add support for 64KB page
In-Reply-To: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55C4E6A6.3010808@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 17:46, Julien Grall wrote:
> Hi all,
> 
> ARM64 Linux is supporting both 4KB and 64KB page granularity. Although, Xen
> hypercall interface and PV protocol are always based on 4KB page granularity.
> 
> Any attempt to boot a Linux guest with 64KB pages enabled will result to a
> guest crash.
> 
> This series is a first attempt to allow those Linux running with the current
> hypercall interface and PV protocol.
> 
> This solution has been chosen because we want to run Linux 64KB in released
> Xen ARM version or/and platform using an old version of Linux DOM0.
> 
> There is room for improvement, such as support of 64KB grant, modification
> of PV protocol to support different page size... They will be explored in a
> separate patch series later.
> 
> TODO list:
>     - Convert swiotlb to 64KB
>     - Convert xenfb to 64KB
>     - Check if backend in QEMU works with DOM0 64KB
>     - It may be possible to move some common define between
>     netback/netfront and blkfront/blkback in an header
> 
> All patches has been built tested for ARM32, ARM64, x86. But I haven't tested
> to run it on x86 as I don't have a box with Xen x86 running. I would be
> happy if someone give a try and see possible regression for x86.
> 
> A branch based on the latest linux/master can be found here:

Sorry, I forgot to update this bits in the cover letter.

It's based on xentip for-linus-4.3 and depends on "Use correctly the Xen
memory terminologies". The v3 has been sent few minutes ago [1]


> 
> git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v3
> 
> Comments, suggestions are welcomed.
> 
> Sincerely yours,

[1] http://lists.xen.org/archives/html/xen-devel/2015-08/msg00619.html


-- 
Julien Grall
