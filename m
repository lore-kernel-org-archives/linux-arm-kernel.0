From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 21 May 2016 02:30:27 +0200
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <CAOMZO5C=v8AzSX7CNkJOkwtRM5dekZ8rpdAfZyggecbdcQK5gg@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
 <4080948.V5DMHR9bsk@vostro.rjw.lan>
 <CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
 <CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
 <CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
 <CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com>
 <CAOMZO5C=v8AzSX7CNkJOkwtRM5dekZ8rpdAfZyggecbdcQK5gg@mail.gmail.com>
Message-ID: <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2016 at 2:12 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, May 20, 2016 at 6:59 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> Can you please try to boot and change the cpufreq governor to
>> performance and back and see if that works?
>
> I cannot change to governor with 9be4fd2c7723a305.
>
> After running 'cat performance >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
> the system hangs silently.

So this means that irq_work doesn't really work on your system at all.
It looks like queuing up an irq_work sort of works (because the
IRQ_WORK_BUSY), but then the queue is never processed.

> Reverting 9be4fd2c7723a305 allows me to change to performace.

What exactly do you mean by reverting here?  It surely cannot be
reverted by itself and there are many things that depend on it.

>> Is this an SMP board, actually?
>
> Yes, this is a single core CortexA7.

Hmm.  Single core means non-SMP rather?
