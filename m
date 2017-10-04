From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Wed, 4 Oct 2017 22:40:13 +0900
Subject: defconfig'ed v4.13 does not boot on ThunderX
In-Reply-To: <dfecaf11-d133-91c2-c630-0b08356cebd9@arm.com>
References: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
 <dfecaf11-d133-91c2-c630-0b08356cebd9@arm.com>
Message-ID: <92046b52-7363-0489-6961-5708e8e4b32c@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin,
Could I have your .config off the list?

Thanks,

Itaru

On 2017/10/04 22:38, Robin Murphy wrote:
> On 04/10/17 08:25, Itaru Kitayama wrote:
>> Hi,
>>
>> defconfig'ed kernel v4.13 does not boot on ThunderX, leaving only
>> messages below:
>>
>> EFI stub: Booting Linux Kernel...
>> EFI stub: Using DTB from configuration table
>> EFI stub: Exiting boot services and installing virtual address map...
>>
>> Our HW is by GIGABYTE, the model is R150 T62 rev 100:
>>
>> http://b2b.gigabyte.com/ARM-Server/R150-T62-rev-100#ov
>>
>> The BIOS we're on is T43. Has anyone testing upstream kernels seen a
>> similar
>> issue like this?
> 
> FWIW defconfig does *not* enable most of the ThunderX drivers (most
> importantly, PCI and networking will be missing).
> 
> I've just built the v4.13 tag with the appropriate drivers added and
> booted it on a different ThunderX box - the net core throws some
> warnings from __dev_xdp_attached() but it gets to userspace OK for me.
> 
> Robin.
> 
