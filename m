From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jul 2014 09:41:36 -0700
Subject: [PATCH] drivers: CCI: Correct use of ! and &
In-Reply-To: <9hhvbqg1jra.fsf@arm.com>
References: <20140707140538.GA4204@himangi-Dell> <9hhwqb42k63.fsf@arm.com>
 <20140723150518.GD27677@arm.com> <9hhvbqg1jra.fsf@arm.com>
Message-ID: <CAOesGMjUZgvpMoKivoZcAsMTZbfBrBToRPZmQyQNLHtxWNa5wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 4:34 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> Hi Arnd,
>
> Will Deacon <will.deacon@arm.com> writes:
>
>> On Wed, Jul 23, 2014 at 04:01:56PM +0100, Punit Agrawal wrote:
>>> > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>>> > index 5a86da9..7af78df 100644
>>> > --- a/drivers/bus/arm-cci.c
>>> > +++ b/drivers/bus/arm-cci.c
>>> > @@ -397,7 +397,8 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
>>> >            hw_counter = &event->hw;
>>> >
>>> >            /* Did this counter overflow? */
>>> > -          if (!pmu_read_register(idx, CCI_PMU_OVRFLW) & CCI_PMU_OVRFLW_FLAG)
>>> > +          if (!(pmu_read_register(idx, CCI_PMU_OVRFLW) &
>>> > +                CCI_PMU_OVRFLW_FLAG))
>>> >                    continue;
>>>
>>>
>>> Going back to the manual, this fix looks correct.
>>>
>>> Acked-by: Punit Agrawal <punit.agrawal@arm.com>
>>>
>>> Will, would this go via your tree?
>>
>> Given that you're happy with it, I don't mind which tree it goes in.
>> Probably deserves a CC stable on it too.
>
> The CCI PMU patches went via arm-soc. Are you happy to pick this fix with
> the Ack and a Cc to stable.

Yeah, we've been merging most of the CCI patches.

Please resend the patch to arm at kernel.org if you want us to apply it.


Thanks,

-Olof
