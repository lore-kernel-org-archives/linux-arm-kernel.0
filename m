From: xvzhaobin@gmail.com (zhaobin xv)
Date: Wed, 24 Jul 2013 09:12:30 +0800
Subject: linux setup
In-Reply-To: <alpine.LFD.2.03.1307231530080.15022@syhkavp.arg>
References: <CANEcUBXMPhTjgVYbRN7NY+EUjh7DDGpKnZ8_LXY-ZLcfbH65Ug@mail.gmail.com>
 <20130723102554.GD3748@MacBook-Pro.local>
 <alpine.LFD.2.03.1307231530080.15022@syhkavp.arg>
Message-ID: <CANEcUBVaVBCfaE1iY-cHzYfxhmOQdN80ttqHrGrwD7esNtn=DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thank you for your answer,

2013/7/24 Nicolas Pitre <nico@fluxnic.net>:
> On Tue, 23 Jul 2013, Catalin Marinas wrote:
>
>> On Mon, Jul 22, 2013 at 02:28:50PM +0100, zhaobin xv wrote:
>> > I recently read lernel source .
>> > I have a question:In
>> > folder:linux/arch/arm/boot/compressed/head.S(linux2.6.22.6):
>> >
>> >
>> > start:
>> >         .type    start,#function
>> >         .rept    8
>> >         mov    r0, r0
>> >         .endr
>> >
>> >         b    1f
>> >         .word    0x016f2818        @ Magic numbers to help the loader
>> >         .word    start            @ absolute load/run zImage address
>> >         .word    _edata            @ zImage end address
>> > 1:        mov    r7, r1            @ save architecture ID
>> >         mov    r8, r2            @ save atags pointer
>> >
>> >
>> > I don't kown why the ?mov r0 r0 ? repeated  emergence 8 times.
>>
>> I think some people used that in the past to be able to modify the
>> zImage binary directly and work around wrong register values passed by
>> the boot loader. I've never used it myself but I saw it mentioned once.
>
> The whole reason for this is because in a distant past the kernel image
> was an a.out binary containing a 32-bytes header.  Those nops are simply
> padding so to be compatible with those bootloaders expecting the kernel
> code to start at an offset of 32.
>
>
> Nicolas
