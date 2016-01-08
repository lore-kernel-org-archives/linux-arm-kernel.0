From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 8 Jan 2016 15:17:19 -0800
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
In-Reply-To: <20160108225032.GO19062@n2100.arm.linux.org.uk>
References: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
 <20160108225032.GO19062@n2100.arm.linux.org.uk>
Message-ID: <CANMBJr6DR=y2oOqnEyUAxhzhXn1twXozGacOpcVRx8NcWf-mfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2016 at 14:50, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 08, 2016 at 02:33:39PM -0800, Tyler Baker wrote:
>> After a bit of investigation, I determined that CONFIG_BLK_DEV_RAM was
>> causing the issue and disabling it fixed the boot issue. Essentially,
>> the kernel cannot find the initrd that has been loaded into memory by
>> CFE bootloader with this option enabled as I inject the following
>> command line into the DT before it's loaded over tftp.
>>
>> Loaded in CFE by: 'load -raw -tftp -addr=0x4000000 -max=0x900000
>> 192.168.2.2:tmpqC9zOv/ramdisk.cpio.gz'
>>
>> Kernel arguments injected into DT: 'console=ttyS0,115200
>> initrd=0x4000000,8M root=/dev/ram0 ip=dhcp'
>
> What is the problem that the kernel is reporting?

The kernel complaining that there is no file system to mount, and
panics. Here is a plain text version of the issue if you want to have
a look[1].

> I'm asking because kernelci.org uses javascript, which is not elinks
> friendly, and it otherwise means I need to walk over to a different
> machine to look at it, and then return to a different machine to finish
> writing the email - as a result, I hardly ever look at the kernelci.org
> results, and just rely on Olof's results.

Apologies, we are trying our best to find a happy medium for all
users, and clearly we aren't there yet. We have the ability to provide
plain text e-mail, instead of the multi-part html ones we typically
send out. If that is helpful for you at all, we can setup a hook to
send the plain text e-mails directly to you. Unfortunately, there
isn't much we can do about the javascript elink issue without
re-writing the front end :\

Cheers,

Tyler

[1]http://storage.kernelci.org/arm-soc/v4.4-rc3-1097-g80f7f7e00215/arm-multi_v7_defconfig/lab-tbaker/boot-bcm4708-smartrg-sr400ac.txt
