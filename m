From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 18 May 2015 12:24:19 +0900
Subject: [PATCH] serial: 8250_uniphier: add UniPhier serial driver
In-Reply-To: <CABuKBeJnMcyH7TGtYcUToRhLnu_qcxHtwEedS2JgGjX8EiX1Gw@mail.gmail.com>
References: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
 <CABuKBeJnMcyH7TGtYcUToRhLnu_qcxHtwEedS2JgGjX8EiX1Gw@mail.gmail.com>
Message-ID: <CAK7LNAT6AEog7u9C3kAyMJc3OqP5WOcZVe=30PXN1+dGQiSfmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,


2015-05-16 18:17 GMT+09:00 Matthias Brugger <matthias.bgg@gmail.com>:

>> +/*
>> + * The register map is slightly different from that of 8250.
>> + * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
>> + */
>> +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
>> +{
>> +       int valshift = 0;
>> +
>> +       switch (offset) {
>> +       case UART_LCR:
>> +               valshift = 8;
>
> Please use a define for the value. Something like UNIPHIER_UART_LCR_SHIFT maybe.
>


Will do in v2.

Thank you!


-- 
Best Regards
Masahiro Yamada
