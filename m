From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Mar 2013 17:50:51 +0530
Subject: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
In-Reply-To: <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
 <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org>
 <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com>
Message-ID: <51558723.1050904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 05:26 PM, Amit Kucheria wrote:
> On Fri, Mar 29, 2013 at 4:15 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
>>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>>>> The driver is initialized several times. This is wrong and if the
>>>> return code of the function was checked, it will return -EINVAL.
>>>>
>>>> Move this initialization out of the loop.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>> Fix for this is already and v2 of the patch is here [1]
>>
>> Ah, ok. Thanks for reviewing the patch.
>>
>> Can we find a solution to have a single entry point to sumbit patches
>> for all the cpuidle drivers ?
>>
>> Otherwise, consolidating them is a pain: a patch for the samsung tree,
>> another one for the at91 tree, etc ... and wait for all the trees to
>> sync before continuing to consolidate the code.
>>
>> Wouldn't be worth to move these drivers under the PM umbrella instead of
>> the SoC specific code ?
>>
>> Any idea to simplify the cpuidle consolidation and maintenance ?
> 
> Adding Arnd and Olof to this discussion since atleast the ARM drivers
> go through their arm-soc tree.
> 
> Given the work you're putting in to consolidate the drivers, perhaps
> they can insist that idle drivers get acked by you?
> 
Not to create controversy but as a general rule there is nothing
like *insisting* ack on patches for merge apart from the official
maintainers(gate keepers).

Having said that, its always good to get more reviews and acks so
that better code gets merged.

This just my personal opinion.

Regards,
Santosh
