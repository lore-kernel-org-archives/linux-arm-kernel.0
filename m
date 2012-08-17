From: alanbutty12@gmail.com (Alan M Butler)
Date: Fri, 17 Aug 2012 14:01:43 +0000
Subject: Issues with all kernels after 3.3.7
In-Reply-To: <20120817132629.GA2232@pengutronix.de>
References: <CADhrpJ7r4PPM2nOD7Wch9H+usaDUJ5XYeim6THUKEDTz=-Zyig@mail.gmail.com>
 <20120817132629.GA2232@pengutronix.de>
Message-ID: <CADhrpJ63XMer2zQ+wBQxGGLYwfU8hJ=ejDTwYktFtmE6OY+dPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2012 13:26, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Aug 17, 2012 at 01:47:06PM +0100, alan butler wrote:
>> I have been trying all kernels after 3.3.7 (except for the 3.5 series)
>> on my ix2-200
>> and have found that on every kernel 3.3.8, 3.4, 3.4.2, 3.4.4 =>3.4.7
>> and now even on 3.6 rc1
>> and the next dated today 17 august that when i use git for example:
>>
>> git clone git://git.videolan.org/x264
>>
>> my system just crash's / hangs and even through the serial port i get
>> no response.
>> This also happens when i try to access a web interface for example the
>> serviio java webui.
>>
>> The second issue i have noticed is that my raid 0 array hangs / pauses
>> when being mounted
>> at system startup. (for approximatly 30 seconds maybe more maybe less
>> im not certain).
>> But again on the 3.3.7 kernel there was no issue and no hang.
>>
>> If i return to 3.3.7 everything works fine with no other modifications
>> to the os or kernels.
>> I am using debian wheezy at the moment but also tried debian squeeze
>> so it does not
>> seem to be related to the specific linux version just the kernel.
> Can you bisect your problem? Doing that between 3.3.7 and 3.3.8 seems to
> be the obvious range to test.
>
> You can also try to enable the various debugging options like
>
>         CONFIG_DETECT_HUNG_TASK
>         CONFIG_PROVE_LOCKING
>         CONFIG_DEBUG_ATOMIC_SLEEP
>         CONFIG_MAGIC_SYSRQ
>
> or try https://lkml.org/lkml/2012/5/26/83.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

i enabled the options you said there and i see alot of the following
popping up while connected through serial:

 BUG: sleeping function called from invalid context at
include/linux/freezer.h:46
[  126.896958] in_atomic(): 0, irqs_disabled(): 128, pid: 2180, name:
console-kit-dae
[  126.904566] no locks held by console-kit-dae/2180.
[  126.909378] irq event stamp: 27643
[  126.912797] hardirqs last  enabled at (27642): [<c03781ac>]
_raw_spin_unlock_irqrestore+0x3c/0x5c
[  126.921735] hardirqs last disabled at (27643): [<c00090cc>]
ret_fast_syscall+0xc/0x38
[  126.929618] softirqs last  enabled at (25565): [<c001bc20>]
irq_exit+0x54/0xb8
[  126.936890] softirqs last disabled at (25558): [<c001bc20>]
irq_exit+0x54/0xb8
[  126.944185] [<c000ea8c>] (unwind_backtrace+0x0/0xe0) from
[<c000b414>] (do_signal+0x84/0x5c0)
[  126.952764] [<c000b414>] (do_signal+0x84/0x5c0) from [<c000be0c>]
(do_notify_resume+0x18/0x60)
[  126.961430] [<c000be0c>] (do_notify_resume+0x18/0x60) from
[<c0009120>] (work_pending+0x24/0x28)

there seems to be alot more of them when i have serviio upnp server running.
