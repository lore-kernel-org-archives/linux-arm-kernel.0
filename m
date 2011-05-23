From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 23 May 2011 12:20:46 +0530
Subject: [PATCH v2] ARM: smp_twd: Reconfigure clockevents after cpufreq
	change
In-Reply-To: <BANLkTikyGFVKTst1xJTGzHuwY_2GoG6NOw@mail.gmail.com>
References: <1305851091-10096-1-git-send-email-ccross@android.com>	<4DD75BC9.8040004@ti.com>
	<BANLkTikyGFVKTst1xJTGzHuwY_2GoG6NOw@mail.gmail.com>
Message-ID: <4DDA03C6.6050806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/23/2011 10:48 AM, Colin Cross wrote:
> On Fri, May 20, 2011 at 11:29 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On 5/20/2011 5:54 AM, Colin Cross wrote:
>>>
>>> The localtimer's clock changes with the cpu clock.  After a
>>> cpufreq transition, update the clockevent's frequency and
>>> reprogram the next clock event.
>>>
>>> Adds a clock called "smp_twd" that is used to determine the
>>> twd frequency, which can also be used at init time to
>>> avoid calibrating the twd frequency.
>>>
>>> Clock changes are based on Rob Herring's work.
>>>
>>> Change-Id: I413b5cd07fb2b79bc9fad8b4bf257332d1da7bcd
>>> Signed-off-by: Colin Cross<ccross@android.com>
>>> Cc: Thomas Gleixner<tglx@linutronix.de>
>>> Cc: Russell King<linux@arm.linux.org.uk>
>>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Rob Herring<robherring2@gmail.com>
>>> Tested-by: Linus Walleij<linus.walleij@linaro.org>
>>> ---
>>
>> Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>
>> What about the clock-node patches?
>> Do you want those to get merged via sub-arch tree's once this
>> patch + Thomas's new API gets merged ?
>
> The clock-node patches can be merged independently - twd scaling just
> won't work until they are both merged.
Yep. That should be ok.

Regards
Santosh
