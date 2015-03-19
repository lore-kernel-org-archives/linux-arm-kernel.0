From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 19 Mar 2015 18:35:30 +0100
Subject: [PATCH v3 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <550AE41C.8070803@hurleysoftware.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
 <1426197361-19290-11-git-send-email-maxime.coquelin@st.com>
 <CAHp75Vd7+oLiLLuyocYh95TebtocWrRho6xNjuSUt8fYGp8npg@mail.gmail.com>
 <CALszF6BWuUYRh+3rWnSQLApkAHA5dQXw=6x6D_evRtb+5B_ukA@mail.gmail.com>
 <CAHp75Vdf6=z1d5+eYJ+QGTko9kkZf-oPfoWaf8FRoTdqcdWxjw@mail.gmail.com>
 <CALszF6A5Zu7i0hxSLTS-nfOAXmd0__jLjB=fHxK93Ex5Vbi9LA@mail.gmail.com>
 <550AE41C.8070803@hurleysoftware.com>
Message-ID: <CALszF6DX2pz_US6uqQwBjmZhfgjw5PP1UAy9H+c-_Kgkk_Z72w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-19 15:58 GMT+01:00 Peter Hurley <peter@hurleysoftware.com>:
> On 03/19/2015 09:55 AM, Maxime Coquelin wrote:
>>>>>> +static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
>>>>>> +                           struct ktermios *old)
> [...]
>>>>>> +       usardiv = (port->uartclk * 25) / (baud * 4);
>>>>>> +       mantissa = (usardiv / 100) << USART_BRR_DIV_M_SHIFT;
>>>>>> +       fraction = DIV_ROUND_CLOSEST((usardiv % 100) * 16, 100);
>>>>>> +       if (fraction & ~USART_BRR_DIV_F_MASK) {
>>>>>> +               fraction = 0;
>>>>>> +               mantissa += (1 << USART_BRR_DIV_M_SHIFT);
>>>>>> +       }
> [...]
>> Really, I would prefer keeping this fractional divider as it is
>> implemented today.
>
> You have to admit that's basically an unintelligible mess;
> how would anyone ever be able to refactor and replace that with a
> common divider implementation?
>
> At the very least, please comment on the formula and format.

Ok, I will refactor the implementation, and comment it.

Regards,
Maxime

>
> Regards,
> Peter Hurley
