From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Wed, 21 Nov 2012 16:50:29 +0530
Subject: KEXEC on ARM cortex-a15
In-Reply-To: <20121121102244.GA11990@mudshark.cambridge.arm.com>
References: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
 <20121119144417.GH3290@n2100.arm.linux.org.uk>
 <20121119151327.GG3205@mudshark.cambridge.arm.com>
 <CAJXQGf+BQ18GhR3emhK-ejTivqx_o=gtaO3-FjTiE3BMGydgsw@mail.gmail.com>
 <CAJXQGf+wfXGZ=PWN585dJDMX1nH+sRexf6UZujyjKM6rJeDiXQ@mail.gmail.com>
 <20121120160219.GF26475@mudshark.cambridge.arm.com>
 <CAJXQGfL4PRW9=MQO1XbogA40sHUzXorbFMe1WkiJ751Ej-h7=g@mail.gmail.com>
 <20121121102244.GA11990@mudshark.cambridge.arm.com>
Message-ID: <CAJXQGfLA+SVfWPjXdbH=R0jF0xaLke1oK56HhsgYr1za15t1xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thank you very much.

Yes, I am using Versatile express target at Daughterboard Site 1:
V2P-CA15_A7 Cortex A15

1. I do not have the JTAG.  I will definitely try to order and get one.
2. I have tried with the following command line options
root at arm-cortex-a15:~# kexec -f zImage --dtb=vexpress.dtb
--append="root=/dev/nfs rw ip=dhcp
nfsroot=<Host-IP>:/mnt/sda3/nfs/cortexa15/core-image
console=ttyAMA0,38400n8 nosmp"
Starting new kernel
Bye!
Uncompressing Linux...

I will try to put some more printk and get more debug information.
vexpress.dtb is generated from vexpress-v2p-ca15_a7.dts file.

1. Is it possible to print the state of the CPU when the new kernel
image is entered (using printk) ?
2. Is it possible to use ATAGs for kexec feature as a temporary
solution on V2P-CA15_A7 Cortex A15 target ?

Thanks and Regards
-Naresh Bhat

On Wed, Nov 21, 2012 at 3:52 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Nov 21, 2012 at 08:21:21AM +0000, Naresh Bhat wrote:
>> Hi Will,
>>
>> I have disabled the SMP on host kernel.  But still I am facing the
>> issue as below
>>
>> bash-4.2# ls
>> uImage  vexpress.dtb
>> bash-4.2#
>> bash-4.2# kexec -f uImage --dtb=vexpress.dtb --command-line="console=ttyS0"
>
> Can you try using a zImage instead and also specifying the console as
> ttyAMA0, as it looks like you're using a vexpress?
>
>> Starting new kernel
>> Bye!
>> Uncompressing Linux...
>
> This isn't really very helpful -- some more debugging on your part would be
> appreciated to get an insight as to what's going wrong. You could either use
> JTAG or put some early prints in the decompressor to work out where it goes
> awry.
>
> Useful things to know would be: the state of the CPU when the new kernel
> image is entered (if you have JTAG, you could also look at the dtb in memory
> to see that it looks sane) and also at which point in the decompressor it
> goes wrong / takes an abort (usually it's when we enable the MMU).
>
> Will



-- 
"For things to change, we must change"
-Naresh Bhat
