From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 25 Jul 2013 10:30:29 +0100
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
 <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
Message-ID: <51F0F035.8010705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 20:32, Linus Walleij wrote:
> On Tue, Jul 23, 2013 at 5:42 PM, Jonathan Austin
> <jonathan.austin@arm.com> wrote:
>
>> The order of arguments in the call to vco_set() for the ICST clocks appears to
>> have been switched in error, which results in the VCO not being initialised
>> correctly. This in turn stops the integrated LCD on things like Integrator/CP
>> from working correctly.
>>
>> This patch fixes the order and restores the expected functionality.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>
> Good catch! Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> You should probably mark this for stable as well.
>

Mike, will you add Cc: stable when you take the fix or shall I resubmit 
the patch somehow else?

> What I don't understand is why my CLCD VGA output has
> been working all the time :-(
>

No, this confuses me too - perhaps the display you've got it plugged in 
to is really lenient about modes and just made the best of it?

> I thought this VCO was necessary for that as well,  but apparently
> it works with the defaults.

Certainly I can't get anything out of the display on my integrator or 
via the VGA port without this fix and the other one in the series.

Jonny
>
> Yours,
> Linus Walleij
>
