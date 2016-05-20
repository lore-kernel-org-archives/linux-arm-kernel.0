From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 20 May 2016 23:59:06 +0200
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
 <4080948.V5DMHR9bsk@vostro.rjw.lan>
 <CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
 <CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
 <CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
Message-ID: <CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 11:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, May 20, 2016 at 6:48 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> So what about if you comment out the cpufreq_suspend() line in
>> device_shutdown() (after applying the patch)?
>
> Then it reboots fine :-) Thanks

But that probably means that irq_work_sync() doesn't work on your system.

Can you please try to boot and change the cpufreq governor to
performance and back and see if that works?

Is this an SMP board, actually?
