From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 May 2016 21:36:52 -0300
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
 <4080948.V5DMHR9bsk@vostro.rjw.lan>
 <CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
 <CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
 <CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
 <CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com>
 <CAOMZO5C=v8AzSX7CNkJOkwtRM5dekZ8rpdAfZyggecbdcQK5gg@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
Message-ID: <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 9:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:

> What exactly do you mean by reverting here?  It surely cannot be
> reverted by itself and there are many things that depend on it.

Yes, it cannot be reverted cleanly on 4.6.

If I do 'git checkout 9be4fd2c7723a30' and then 'git revert
9be4fd2c7723a30' then the reboot command works.

>>> Is this an SMP board, actually?
>>
>> Yes, this is a single core CortexA7.
>
> Hmm.  Single core means non-SMP rather?

CONFIG_SMP can be set or not in the kernel config. With CONFIG_SMP=n
the issue does not happen.
