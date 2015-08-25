From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 25 Aug 2015 12:21:06 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <CAOiHx=kExyKAoGW4ciWHHxGNosNR0VdvHHrSqeo7RH1rNOXgig@mail.gmail.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de> <55DB4EA6.9090807@atmel.com>
 <201508241945.33577.marex@denx.de>
 <CAOiHx=kExyKAoGW4ciWHHxGNosNR0VdvHHrSqeo7RH1rNOXgig@mail.gmail.com>
Message-ID: <55DC4192.6060906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/08/2015 11:46, Jonas Gorski a ?crit :
> On Mon, Aug 24, 2015 at 7:45 PM, Marek Vasut <marex@denx.de> wrote:
>> On Monday, August 24, 2015 at 07:04:38 PM, Cyrille Pitchen wrote:
>>> Hi Marek,
>>
>> Hi!
>>
>>> Le 24/08/2015 13:03, Marek Vasut a ?crit :
>>>> On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
>>>>> This driver add support to the new Atmel QSPI controller embedded into
>>>>> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
>>>>> controller.
>>
>> [...]
>>
>>>>> +  /* Compute address parameters */
>>>>> +  switch (cmd->enable.bits.address) {
>>>>> +  case 4:
>>>>> +          ifr |= QSPI_IFR_ADDRL;
>>>>> +          /*break;*/ /* fallback to the 24bit address case */
>>>>
>>>> What's this commented out bit of code for ? :-)
>>>
>>> I just wanted to stress out there was no missing "break;".
>>> I've reworded the comment to:
>>> /* No "break" on purpose: fallback to the 24bit address case. */
>>
>> Oh, the address is in bytes . I see, yes, it makes sense to be more
>> explicit here about the purpose of the fallback. I think this change
>> in the comment will make it easier for everyone who comes back in a
>> few years and reads this code.
> 
> I think you are looking for the term "(switch case) fallthrough", not
> "fallback". "Fallback" makes it sound like there is something missing,
> or an invalid state.
> 
> 
> Jonas
> 

will be modified in the next series, thanks for the review!
