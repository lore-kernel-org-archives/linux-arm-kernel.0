From: philip@balister.org (Philip Balister)
Date: Thu, 27 Dec 2012 13:53:37 -0500
Subject: OT:zynx on zedboard.org hr timer problem with dts
In-Reply-To: <20121220172301.GC27361@kryptos>
References: <201212201744.43678.tim01@vlsi.informatik.tu-darmstadt.de>
 <20121220172301.GC27361@kryptos>
Message-ID: <50DC9931.5070500@balister.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 12:23 PM, Josh Cartwright wrote:
> On Thu, Dec 20, 2012 at 05:44:42PM +0100, Tim Sander wrote:
>> Hi
>>
>> This is probably not the right list but in lack of knowing a better place:
>> I am using the xilinx git repository (git://git.xilinx.com/linux-xlnx.git)
>> with the attached dts file. Most stuff works fine but there is a error message
>> on startup:
>> Zynq clock init
>> xlnx,ps7-ttc-1.00.a #0 at 0xe0800000, irq=43
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/kernel/smp_twd.c:389 time_init+0x20/0x30()
>> twd_local_timer_of_register failed (-22)
>> Modules linked in:
>> [<c001417c>] (unwind_backtrace+0x0/0x11c) from [<c0020aac>] (warn_slowpath_common+0x4c/0x64)
>> [<c0020aac>] (warn_slowpath_common+0x4c/0x64) from [<c0020b44>] (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0020b44>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0486080>] (time_init+0x20/0x30)
>> [<c0486080>] (time_init+0x20/0x30) from [<c04826c0>] (start_kernel+0x1b4/0x2f0)
>> [<c04826c0>] (start_kernel+0x1b4/0x2f0) from [<00008044>] (0x8044)
>> ---[ end trace 0000000000000001 ]---
>> and hrtimers are not working although they are enabled in the .config.
>
> Hey Tim-
>
> A better place to ask questions about the Xilinx tree will likely be on
> their Embedded Linux forum [1].
>

I find the forum to be painful to use and it is very difficult to track 
multiple conversations. And it looks like there is only one arm kernel 
guy there on a regular basis.

Philip

>> I am sure this is an error in the attached dts but i am to knew to this device tree
>> stuff to find the error. So any hint would be apreciated.
>
> On first glance, it looks like you've specified a node for the twd, but
> neglected to specify interrupts.  See Documentation/devicetree/bindings/arm/twd.txt.
>
>> 		swdt at f8005000 {
>> 			device_type = "watchdog";
>> 			compatible = "arm,cortex-a9-twd-timer";
>> 			reg = <0xf8005000 0x100>;
>> 			clock-frequency = <111111111>;
>> 		};
>
> Good luck,
>       Josh
>
> [1]: http://forums.xilinx.com/t5/Embedded-Linux/bd-p/ELINUX
>
