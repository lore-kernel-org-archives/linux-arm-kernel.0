From: jonathan@jonmasters.org (Jon Masters)
Date: Wed, 10 Oct 2012 22:34:48 -0400
Subject: alignment faults in 3.6
In-Reply-To: <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk> <506ED18C.3010009@gmail.com>
 <20121005140556.GQ4625@n2100.arm.linux.org.uk> <506EEFBB.3060705@gmail.com>
 <507619FA.6080001@jonmasters.org> <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
Message-ID: <50763048.6020502@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2012 10:27 PM, M?ns Rullg?rd wrote:

> There are exactly two possible solutions:
> 
> 1. Change the networking code so those structs are always aligned.  This
>    might not be (easily) possible.
> 2. Mark the structs __packed and fix any typecasts like the ones seen in
>    this thread.  This will have an adverse effect in cases where the
>    structs are in fact aligned.
> 
> Both solutions lie squarely in the networking code.  It's time to
> involve that list, or we'll never get anywhere.

Sure, please do let's figure out the plan. But my question is tangential
- I am after input from rmk on whether that patch he posted to fix the
atomicity of missaligned faults is going to be something we should plan
to be pulling into 3.6 for Fedora (after there's an official version) to
correct the might_fault warnings, etc.

Meanwhile, a separate fix of some kind is still likely to be needed
because we don't want to take a large number of alignment traps.

Jon.
