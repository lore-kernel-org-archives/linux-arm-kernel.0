From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 3 Nov 2014 08:34:42 -0600
Subject: Crash on ARM: 8148/1 flush TLS and thumbee register
In-Reply-To: <20141102221401.GA4042@n2100.arm.linux.org.uk>
References: <CAGhQ9VzyK3qW2pr-YOFywUS7=9RLDzrj6wOFFhnvyDkks_2VCA@mail.gmail.com>
 <5425DA4D.4040301@mentor.com> <3b91528704d24eb119ec6d80ad6ba07f@agner.ch>
 <20141102221401.GA4042@n2100.arm.linux.org.uk>
Message-ID: <54579282.8030309@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2014 04:14 PM, Russell King - ARM Linux wrote:
> On Sun, Nov 02, 2014 at 11:03:14PM +0100, Stefan Agner wrote:
>> Hi all,
>>
>> While working on Vybrid (vf610) Cortex-M4 support I also hit this crash
>> observed by Joachim:
>>
>> ...
>> Freeing unused kernel memory: 16K (8800a000 - 8800e000)
>>
>> Unhandled exception: IPSR = 00000005 LR = fffffff1
>> CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc1-00041-ga30465a #216
>> task: 8b838000 ti: 8b82a000 task.ti: 8b82a000
>> PC is at flush_thread+0x32/0x40
>> LR is at flush_thread+0x21/0x40
>> pc : [<8f00157a>]    lr : [<8f001569>]    psr: 4100000b
>> sp : 8b82be20  ip : 00000000  fp : 8b83c000
>> r10: 00000001  r9 : 88018c84  r8 : 8bb85000
>> r7 : 8b838000  r6 : 00000000  r5 : 8bb77400  r4 : 8b82a000
>> r3 : ffff0ff0  r2 : 8b82a000  r1 : 00000000  r0 : 88020354
>> xPSR: 4100000b
>> CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc1-00041-ga30465a #216
>> [<8f002bc1>] (unwind_backtrace) from [<8f002033>] (show_stack+0xb/0xc)
>> [<8f002033>] (show_stack) from [<8f00265b>] (__invalid_entry+0x4b/0x4c)
>>
>> Can reproduce it on 3.18-rc1, as well as 3.17.
> 
> Hmm, I think KUSER_HELPERS needs to depend on MMU.  Nathan?

Yes.  I'll send a patch today.
