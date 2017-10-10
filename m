From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Wed, 11 Oct 2017 08:13:59 +0900
Subject: defconfig'ed v4.13 does not boot on ThunderX
In-Reply-To: <20171004134414.GF23092@leverpostej>
References: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
 <dfecaf11-d133-91c2-c630-0b08356cebd9@arm.com>
 <20171004134414.GF23092@leverpostej>
Message-ID: <c59970ab-b3e4-8ff1-3de8-ce13613acdde@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebuilding v4.13 kernel using the config-4.5.0-25.el7.aarch64 gets me to 
the prompt
at least.

I'll be happy to test the updated defconfig once ThunderX changes 
accepted upstream.

On 10/4/17 10:44 PM, Mark Rutland wrote:
> On Wed, Oct 04, 2017 at 02:38:58PM +0100, Robin Murphy wrote:
>> On 04/10/17 08:25, Itaru Kitayama wrote:
>>> Hi,
>>>
>>> defconfig'ed kernel v4.13 does not boot on ThunderX, leaving only
>>> messages below:
>>>
>>> EFI stub: Booting Linux Kernel...
>>> EFI stub: Using DTB from configuration table
>>> EFI stub: Exiting boot services and installing virtual address map...
>>>
>>> Our HW is by GIGABYTE, the model is R150 T62 rev 100:
>>>
>>> http://b2b.gigabyte.com/ARM-Server/R150-T62-rev-100#ov
>>>
>>> The BIOS we're on is T43. Has anyone testing upstream kernels seen a
>>> similar issue like this?
>> FWIW defconfig does *not* enable most of the ThunderX drivers (most
>> importantly, PCI and networking will be missing).
> .... it's a bit worrying if earlycon doesn't work without those, though.
> It shouldn't be dependendent on either. :/
>
>> I've just built the v4.13 tag with the appropriate drivers added and
>> booted it on a different ThunderX box - the net core throws some
>> warnings from __dev_xdp_attached() but it gets to userspace OK for me.
> Given these seem to exist out in the field, we should probably enable
> those drivers in defconfig.
>
> Thanks,
> Mark.
