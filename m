From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Tue, 25 Jun 2013 13:22:37 +0530
Subject: ARM : Kexec fails with kernel 3.10 on ARM Versatile TC2
In-Reply-To: <20130621113653.GF7766@mudshark.cambridge.arm.com>
References: <CALicx6sYQ19Jx_HuwLeoXNiNFSNvCUc+XKMZsf6vAasPhxOVSg@mail.gmail.com>
 <20130621113653.GF7766@mudshark.cambridge.arm.com>
Message-ID: <CALicx6uQiJedZCx-G+_C50x8tEwToB=M7uEb07cny_9Wb+=AZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 5:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jun 21, 2013 at 12:32:34PM +0100, Vijay Kilari wrote:
>> Hi,
>>
>>   With Kernel 3.10 SMP kernel, on versatile TC2 board, Kexec hangs.
>>
>>
>> arm-cortex-a15 login: kexec -f /boot/uImage
>> --command-line="root=/dev/nfs rw ip=bootp console=ttyS0,38400n8"
>> Modified cmdline:root=/dev/nfs rw ip=bootp console=ttyS0,38400n8
>> Starting new kernel
>> Bye!
>> Uncompressing Linux... done, booting the kernel
>>
>> Can you please provide your inputs?
>
> SMP kexec isn't possible on TC2 because there's no way to kill off the
> secondary CPUs with mainline Linux. You could take a look at the recent
> patches from Stephen Warren (19ab428f4b79 ["ARM: 7759/1: decouple CPU
> offlining from reboot/shutdown"], but you'd still need to implement the
> various hotplug parts (a software pen is not enough) to get SMP working
> safely.
>

   In the mainline linux, I see for versatile, on hotplugging the CPU,
it is kept in WFI unlike in other
platforms where CPU is power down and clocked off. Does it mean for
Versatile platform there is no support
in HW for hotplugging the CPU completely? and hence kexec is not
possible at all?

> If you're just using this for something like a bootloader, then you could
> use a UP kernel as the first stage.
>
> Will
