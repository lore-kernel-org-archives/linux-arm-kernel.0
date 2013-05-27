From: dt.tangr@gmail.com (Daniel Tang)
Date: Mon, 27 May 2013 20:56:24 +1000
Subject: [RFC PATCHv4 4/6] clocksource: TI-Nspire timer support
In-Reply-To: <CACRpkda4Qe1e+dkcSgPLf5dcHASvOG=Y=Dvrnv=oGnon+FRzzg@mail.gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <1369480087-24786-5-git-send-email-dt.tangr@gmail.com>
 <CACRpkda4Qe1e+dkcSgPLf5dcHASvOG=Y=Dvrnv=oGnon+FRzzg@mail.gmail.com>
Message-ID: <69E1F2A1-CD4C-4B16-8664-6010C7217B8B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27/05/2013, at 8:53 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, May 25, 2013 at 1:08 PM, Daniel Tang <dt.tangr@gmail.com> wrote:
> 
>> Add clocksource and clockevent driver for the TI-Nspire.
>> 
>> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
> 
> This is *much* improved :-D

Awesome!

>> +               /* Disable timer interrupts */
>> +               writel(0, timer->interrupt_regs + IO_INTR_MSK);
>> +               writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
>> +               /* Stop timer */
>> +               writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
>> +               dev->mode = mode;
>> +               break;
>> +       }
> 
> Surely both the compiler and checkpatch is complaining that this
> switch does not contain a default: clause?

Neither in fact. checkpatch.pl gives me a all-clear.

But, I'll clean it up anyway - seems cleaner that way XD.

> 
> If you fix this you can add my:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Cheers,
Daniel Tang
