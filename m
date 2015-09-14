From: roger.pau@citrix.com (=?UTF-8?Q?Roger_Pau_Monn=c3=a9?=)
Date: Mon, 14 Sep 2015 10:56:41 +0200
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55F68BC9.6020509@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 07/09/15 a les 17.33, Julien Grall ha escrit:
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
>     - Support for multiple page ring support
>     - Support for 64KB in gnttdev
>     - Support of non-indirect grant with 64KB frontend
>     - It may be possible to move some common define between
>     netback/netfront and blkfront/blkback in an header
> 
> I've got most of the patches for the TODO items. I'm planning to send them as
> a follow-up as it's not a requirement for a basic guests.
> 
> All patches has been built tested for ARM32, ARM64, x86. But I haven't tested
> to run it on x86 as I don't have a box with Xen x86 running. I would be
> happy if someone give a try and see possible regression for x86.

Do you have figures regarding if/how much performance penalty do the
blkfront/blkback patches add to the traditional 4KB scenario (frontend
and backend running on guests using 4KB pages)?

Since there's been no design document about this and the TODO list
doesn't contain it, I would like to know which plans do we have in order
to fix this properly.

Roger.
