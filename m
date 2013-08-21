From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Wed, 21 Aug 2013 22:11:17 +0300
Subject: [PATCH 1/3] ARM: vexpress_defconfig: Enable and automount
 devtmpfs filesystem
In-Reply-To: <1377082010.10707.6.camel@hornet>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
 <1377032563-4502-2-git-send-email-fathi.boudra@linaro.org>
 <1377082010.10707.6.camel@hornet>
Message-ID: <CAGNsrLCunsZEMyDkASHbuJ4O0uQP6emRJcCKpqE6V0EzS2BPdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2013 13:46, Pawel Moll <pawel.moll@arm.com> wrote:
> On Tue, 2013-08-20 at 22:02 +0100, Fathi Boudra wrote:
>> udev no longer creates device nodes under /dev and it has to be managed
>> by the kernel devtmpfs filesystem.
>>
>> This means that a kernel built with the current config will not boot on
>> a system with a recent udev:
>>
>> mount: mounting udev on /dev failed: No such device
>> W: devtmpfs not available, falling back to tmpfs for /dev
>>
>> Also, it is good to have /dev automatically mounted since some
>> non-initramfs based setups assumes this and don't manually mount it.
>>
>> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
>> ---
>>  arch/arm/configs/vexpress_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
>> index f2de51f..3f970f1 100644
>> --- a/arch/arm/configs/vexpress_defconfig
>> +++ b/arch/arm/configs/vexpress_defconfig
>> @@ -45,6 +45,8 @@ CONFIG_IP_PNP_BOOTP=y
>>  # CONFIG_IPV6 is not set
>>  # CONFIG_WIRELESS is not set
>>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>> +CONFIG_DEVTMPFS=y
>
> This makes sense...
>
>> +CONFIG_DEVTMPFS_MOUNT=y
>
> ... but I'm not so sure about this one. Normally it's up to the boot
> scripts to decide when to mount the devtmpfs. And yes - I know it's
> required to boot Ubuntu-based rootfs without initramfs, but that's
> Ubuntu's problem, really.

Sure, I can workaround in my build system but why is it an issue to enable it?
Obviously, it resolves my use case to boot test vexpress with Linaro
images and doesn't introduce a particular problem afaics.

>>  CONFIG_MTD=y
>>  CONFIG_MTD_CONCAT=y
>>  CONFIG_MTD_PARTITIONS=y
