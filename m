From: schen@mvista.com (Steve Chen)
Date: Wed, 26 May 2010 15:11:24 -0500
Subject: using openocd + gdb to debug linux kernel on arm926ejs
In-Reply-To: <4BFD7BBF.1090100@gmail.com>
References: <4BFD72AD.4010005@gmail.com>
	<AANLkTikwrs3PUS2zNR8daxfVkSCKLUvRtDYkXicXcTXq@mail.gmail.com>
	<4BFD7BBF.1090100@gmail.com>
Message-ID: <AANLkTikfGIBaYnFskW4_TUzfWXBIy9fIqziNcedQwE8M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 2:51 PM, f. achkar <fachkar.datawind@gmail.com> wrote:
> On 05/26/2010 03:41 PM, Steve Chen wrote:
>> On Wed, May 26, 2010 at 2:12 PM, f. achkar <fachkar.datawind@gmail.com> wrote:
>>
>>> hi,
>>> This is my second posting (I'm not sure the first one passed the filter) sorry for that ...
>>>
>>> I'm newbie and have a s3c2450 based board (arm926ejs), I have a working compressed kernel image
>>> zImage, this image boots properly via u-boot-1.1.6, however I simply
>>> failed to debug remotely the vmlinux (root directory of linux source tree) via openocd-0.4.0 with a j-link segger.
>>> is there a good reference on how to properly debug the linux kernel via openocd/gdb for an arm target on a linux hot machine?
>>>
>> Actually, Nicolas Pitre posted an response in your first try. ?In
>> summary, use uImage for uboot. ?vmlinux won't work.
>>
>> Regards,
>>
>> Steve
>>
> Steve,
> thanks, ?I'm not sure I got what you mean! ?if I do the following:
> gdb arch/arm/boot/uImage
> GNU gdb (GDB) 6.8.50.20090417
> ...
> "/home/ferar/DW-SB02-linux-final/arch/arm/boot/uImage": not in
> executable format: File format not recognized
> (gdb) target remote localhost:3333
> Remote debugging using localhost:3333
> 0xc0008164 in ?? ()
> 0xc0008164: ? ?b ? ?0xc0008160
> (gdb) set remote hardware-breakpoint-limit 2
> (gdb) set remote hardware-watchpoint-limit 2
> (gdb) load
> No executable file specified.
> Use the "file" or "exec-file" command.
>
> Note it is not executable format, I need to load and debug the kernel
> not just boot (I don't have booting issues) I'm having trouble trying to
> debug the kernel via jtag (openocd) ?gdb as outlined in the detail part
> of my previous post! I wonder if you people got that portion of the post?
> thanks,
> ferar
>

I have never used gdb to debug the kernel, so I'm not qualify to
answer your questions.  In general, if you need to use gdb (actually
more accurately kgdb), you need to something like

1.  Enable kgdb in the kernel config.
2.  Boot your kernel as usual.
3.  run cross-gdb on your host machine.
4.  Do remote debugging in gdb from your host via either serial or
Ethernet depends on how you have it configured.

Regards,

Steve
