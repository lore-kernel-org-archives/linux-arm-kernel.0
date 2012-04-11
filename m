From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 11 Apr 2012 18:35:17 +0200
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
In-Reply-To: <4F856D0E.5040802@atmel.com>
References: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
 <20120408180906.GA13348@samfundet.no>
 <CAF8ieYVvWJDEkVheGrCuQ+4Ucx_WV-M3qXia1-Y97vqCmeeETQ@mail.gmail.com>
 <CAFumwP38ghv91gwZ55pQeDDD67_t+61pLqBkvX8wzZk5R-3z5w@mail.gmail.com>
 <4F856D0E.5040802@atmel.com>
Message-ID: <CAGhQ9VxxS7fZ1X4rKiTaWoS7TK0goaJ1nCw3UDC4CCzsSJVudw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 1:37 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 04/08/2012 11:55 PM, Andrew Victor :
>> hi,
>>
>>> Yeah, as far as I know, nobody ever used this functionality on AVR32.
>>> In fact, I can't even think of a reason to use it.
>>>
>>> But I seem to recall submitting a patch to remove this functionality a
>>> long time ago, and it was struck down. I don't remember the reason,
>>> but there's a chance it might still be valid.
>>
>> Some of the SAN People / Multenet AT91RM9200 boards needed it....
>> We needed to use GPIO pins for some of the modem-control signals -
>> couldn't use the standard pins since the alternate pin function was
>> being used.
>>
>> Regards,
>> ?Andrew Victor
>
> Hi Andrew,
>
> Well if it is of some interest on your side, I am in favor of keeping
> this feature. It is not a so big amount of code and seems quite easy to
> maintain...

It's not a big deal for me whether the code stays or not. The only reason I
bumped into it was while trying to get atmel_serial to compile as a module
and the serial_at91.h header generated some build error.

But still, why keep a feature with no mainline users. A new kernel feature
is never accepted without any users.

I also think it's hard to maintain the code without any users. I may be easy
to preserve the code but you can never change/improve the code since
you can't change the users of the code.

regards
Joachim Eastwood
