From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 20:39:33 +0100
Subject: [Xen-devel] [PATCH v4 00/20] xen/arm64: Add support for 64KB
 page in Linux
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55F32DF5.5050504@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A quick update on the TODO.

On 07/09/15 16:33, Julien Grall wrote:
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

Sent http://lists.xen.org/archives/html/xen-devel/2015-09/msg01292.html

>     - Convert xenfb to 64KB
>     - Support for multiple page ring support
>     - Support for 64KB in gnttdev
>     - Support of non-indirect grant with 64KB frontend

Sent http://lists.xen.org/archives/html/xen-devel/2015-09/msg01577.html

>     - It may be possible to move some common define between
>     netback/netfront and blkfront/blkback in an header
> 
> I've got most of the patches for the TODO items. I'm planning to send them as
> a follow-up as it's not a requirement for a basic guests.
> 
> All patches has been built tested for ARM32, ARM64, x86. But I haven't tested
> to run it on x86 as I don't have a box with Xen x86 running. I would be
> happy if someone give a try and see possible regression for x86.
> 
> I know that Konrad as a test-suite for x86. Konrand, would it be possible to
> give a run to for this series?
> 
> A branch based on the latest xentip/for-linus-4.3 can be found here:
> 
> git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v4

I will resend a new version when 4.3-rc1 is out in order to fix any
possible conflict with linux/master. I already know that the netback
patch (#18) is conflicting with 1d5d48523900a4b0f25d6b52f1a93c84bd671186
"xen-netback: require fewer guest Rx slots when not using GSO".

If the 2 series above are completely acked/reviewed, I will fold them in
this series.

Regards,

-- 
Julien Grall
