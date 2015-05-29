From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 29 May 2015 15:08:39 +0900
Subject: [PATCH v6] serial: 8250_uniphier: add UniPhier serial driver
In-Reply-To: <1432652906.8736.44.camel@intel.com>
References: <1432525477-14051-1-git-send-email-yamada.masahiro@socionext.com>
 <1432545245.8736.5.camel@intel.com>
 <1432650518.13900.72.camel@linux.intel.com>
 <1432652906.8736.44.camel@intel.com>
Message-ID: <CAK7LNAQ6Q9OzTT0NN-uruGQhhXzt9d_n7gogXTtPYgH8PnzRrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-27 0:08 GMT+09:00 Shevchenko, Andriy <andriy.shevchenko@intel.com>:
> On Tue, 2015-05-26 at 15:28 +0100, Alan Cox wrote:
>> > > +
>> > > +#define UNIPHIER_UART_CHAR_FCR   3       /* Character / FIFO Control Register */
>> > > +#define UNIPHIER_UART_LCR_MCR    4       /* Line/Modem Control Register */
>> > > +#define   UNIPHIER_UART_LCR_SHIFT        8
>> >
>> > Indentation problem, needs to be fixed.
>>
>> If you are going to review a patch set at least look at the previous
>> reviews - the indentation was already discussed and is done that way to
>> show (as many drivers do) which are fields for which registers
>
> This is not exactly the field, the way how to get the field.
> In some cases it is even better to define something like
> _LCR(x)  ((x) << 8)


I want to shift the value for both read and write,
so I think LCR_SHIFT is handier than _LCR(x).

I think the indentation here is OK as it is.



>>
>> > > +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
>> > > +{
>> > > + int valshift = 0;
>> >
>> > Perhaps unsigned int?
>>
>> Why ? even if it mattered gcc is already realising that the value can
>> only be 0 or 8 and will be generating whatever works best for that.
>
> It's not about how gcc does, it's about what assumptions can be made
> from the reading of the source code. I think if we do a counter of shift
> value it would be nice to set an unsigned type explicitly.

int should work enough, but just in case, I added unsigned in v7.


-- 
Best Regards
Masahiro Yamada
