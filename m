From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 11 Sep 2015 15:27:13 +0200
Subject: mysterious crashes on OMAP5 uevm
In-Reply-To: <20150910083026.GA21098@n2100.arm.linux.org.uk>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
Message-ID: <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 10:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 10, 2015 at 08:42:57AM +0200, Dr. H. Nikolaus Schaller wrote:
>> ...
>>
>> Now, disabling CONFIG_ARCH_MULTI_V6 also makes the bug go away and adding the
>> >> #if 0 //__LINUX_ARM_ARCH__ >= 7
>> makes it re-appear.
>>
>> A while ago I tried to debug running the x-server under strace and could find that it also has
>> something to do with SIGALRM.
>>
>> And that is very consistent with ?enable/disable? by modifying arch/arm/kernel/signal.c
>
> It would be really nice if someone could diagnose what's going on here.
> What exception is causing the X server to be killed (someone said a
> segfault)?  What is the register state at the point that happens?  What
> does the code look like  Is it happening inside the SIGALRM handler, or
> when the SIGALRM handler has returned?
>
> I'd suggest attaching gdb to the X server, but remember to set gdb to
> ignore SIGPIPEs.

It's actually pretty random, see some debug sessions in [1].
The first one is the most useful one, but I haven't though of checking
what pixman_rasterize_edges() was doing when the signal arrived, and
most often the "less useful" segfaults occur. However from the
disassembly (see debug1_libpixman.gz) it can be seen that the signal
arrived right after IT.

[1] http://notaz.gp2x.de/tmp/thumb_segfault/

Gra?vydas
