From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Tue, 20 Nov 2012 20:32:17 +0530
Subject: KEXEC on ARM cortex-a15
In-Reply-To: <CAJXQGf+BQ18GhR3emhK-ejTivqx_o=gtaO3-FjTiE3BMGydgsw@mail.gmail.com>
References: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
 <20121119144417.GH3290@n2100.arm.linux.org.uk>
 <20121119151327.GG3205@mudshark.cambridge.arm.com>
 <CAJXQGf+BQ18GhR3emhK-ejTivqx_o=gtaO3-FjTiE3BMGydgsw@mail.gmail.com>
Message-ID: <CAJXQGf+wfXGZ=PWN585dJDMX1nH+sRexf6UZujyjKM6rJeDiXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I downloaded, compiled and installed bleeding edge GIT repository
http://horms.net/projects/kexec/ on my Cortex-a15 target.
After execution of below command the target hangs.

bash-4.2# kexec -f uImage --dtb=vexpress.dtb
--command-line="root=/dev/nfs rw ip=dhcp -serial stdio
console=ttyAMA0"
Starting new kernel
Bye!
Uncompressing Linux...

Any idea why it is happening ?

i appreciate your help/any comments.

My kernel version is v3.4 from kernel.org
vexpress.dtb - Is generated from vexpress-v2p-ca15_a7.dts

Thanks and Regards
-Naresh Bhat

On Mon, Nov 19, 2012 at 9:08 PM, Naresh Bhat <nareshgbhat@gmail.com> wrote:
> Hi Will Deacon,
>
> Thank you very much.  I appreciate your help.
>
> Yes, it looks like it is added on Sep 7th
>
> commit f0839230276d32a67b5a4a65e199c1937adb3643
> Author: Matthew Leach <matthew.leach@arm.com>
> Date:   Fri Sep 7 10:11:26 2012 +0100
>
>     ARM: Add device tree support to the ARM platform
>
>     To allow newer ARM platforms to use kexec, pass device tree
>     information to the kernel during boot.
>
>     By default the dtb is found from /proc/device-tree. A user can specify
>     a dtb file or use legacy ATAGs
> ............
> .....................
>
> I will test will latest tools tomorrow.
>
> Regards
> -Naresh Bhat
>
> On Mon, Nov 19, 2012 at 8:43 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Mon, Nov 19, 2012 at 02:44:17PM +0000, Russell King - ARM Linux wrote:
>>> On Mon, Nov 19, 2012 at 07:57:10PM +0530, Naresh Bhat wrote:
>>> > I can see the below question on dmesg "No ATAGs ?"
>>> > ...........
>>> > ...............
>>> > CPU1: Unknown IPI message 0x1
>>> > Brought up 2 CPUs
>>> > SMP: Total of 2 processors activated (3981.31 BogoMIPS).
>>> > NET: Registered protocol family 16
>>> > No ATAGs?
>>>
>>> That is the procfs initialization of ATAGs producing that message.  If
>>> you're not booting with ATAGs but instead using DT, then you will get
>>> this message, and it's harmless... in which case kexec should be passing
>>> the DT blob to the next kernel.
>>>
>>> If it isn't, then its a kexec bug.
>>
>> Naresh, please try using a bleeding-edge copy of kexec tools. Support
>> for device-tree on ARM was only added there in the last month or so.
>>
>> Will
>
>
>
> --
> "For things to change, we must change"
> -Naresh Bhat



-- 
"For things to change, we must change"
-Naresh Bhat
