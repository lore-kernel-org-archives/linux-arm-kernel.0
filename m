From: binmlist@gmail.com (Bin Liu)
Date: Thu, 14 May 2015 16:36:33 -0500
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <20150514212653.GC3338@piout.net>
References: <20150514170700.GN24269@saruman.tx.rr.com>
 <20150514174031.GP24269@saruman.tx.rr.com>
 <20150514174907.GQ24269@saruman.tx.rr.com>
 <20150514190429.GT24269@saruman.tx.rr.com>
 <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
 <20150514192125.GU24269@saruman.tx.rr.com>
 <CADYTM3bbEAVefFZtivJf5Z+2Q+1zDZEvNhqE5ytsOxDX7hjbdA@mail.gmail.com>
 <20150514192946.GV24269@saruman.tx.rr.com>
 <CADYTM3Zk2iD8YMj75CoLJn=4kpoXoXEKUWj2QzdXKGCJjtfG2A@mail.gmail.com>
 <CADYTM3a1QWnec1D=wT=fgZ-RCXAx_qZYYoFg5gWOy0yT4vovHA@mail.gmail.com>
 <20150514212653.GC3338@piout.net>
Message-ID: <CADYTM3baVqoEBdWoQb5JFyGR2_GKm1FHMYWST1YkZV=m=ZdycQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

On Thu, May 14, 2015 at 4:26 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 14/05/2015 at 16:16:12 -0500, Bin Liu wrote :
>> I think I found the root cause of the problem: board design issue - I
>> bet the custom board has too much cap on VBUS line. It should be <
>> 10uF.
>>
>
> We have a custom board that exhibits the issue but it only has a 100nF
> cap on VBUS.

Have you measured the VBUS discharging? Is there any way to share your
schematics?

Regards,
-Bin.

>
>> I just noticed I have the Jumper 36 on on my EVM, which adds 154.7uF
>> cap on VBUS causing discharge takes ~20sec. After removed the jumper,
>> which leaves only 4.7uF cap on VBUS, now it only takes ~0.4sec to
>> generate Disconnect IRQ. Here is the log.
>>
>> root@:~# [ 2504.893123] musb-hdrc musb-hdrc.0.auto: usbintr (1) epintr(0)
>> [ 2504.899198] musb-hdrc musb-hdrc.0.auto: <== DevCtl=99, int_usb=0x1
>> [ 2504.912751] zero gadget: suspend
>> [ 2504.916145] zero gadget: zero_suspend
>> [ 2505.303937] musb-hdrc musb-hdrc.0.auto: usbintr (20) epintr(0)
>> [ 2505.310072] musb-hdrc musb-hdrc.0.auto: <== DevCtl=88, int_usb=0x20
>> [ 2505.325355] zero gadget: reset config
>> [ 2507.303288] musb-hdrc musb-hdrc.0.auto: Poll devctl 80 (b_idle)
>>
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
