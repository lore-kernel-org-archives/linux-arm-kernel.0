From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Mar 2013 12:18:16 +0100
Subject: [PATCH 1/6] clk: sunxi: Add support for AXI, AHB, APB0 and APB1
 gates
In-Reply-To: <51502441.8090708@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1363962042-29536-2-git-send-email-emilio@elopez.com.ar>
 <51501C42.70207@free-electrons.com> <51502441.8090708@elopez.com.ar>
Message-ID: <51503278.8070302@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Le 25/03/2013 11:17, Emilio L?pez a ?crit :
> El 25/03/13 06:43, Maxime Ripard escribi?:
>>> +  * APB1 gates ("allwinner,sunxi-apb1-gates-clk")
>>> +
>>> +    TWI0                                                                0
>>> +    TWI1                                                                1
>>> +    TWI2                                                                2
>>
>> I'd rather see here I2C. I know that it's called TWI in the datasheet,
>> but the term I2C is more commonly used in the kernel.
> 
> Ok, I'll change it. Do you want me to rename the gate names on the DT
> too to match? ("apb1_twi0" -> "apb1_i2c0")

Yes, it would be nice.

>>> +    CAN                                                                 4
>>> +    SCR                                                                 5
>>> +    PS20                                                                6
>>> +    PS21                                                                7
>>> +
>>> +    UART0                                                               16
>>> +    UART1                                                               17
>>> +    UART2                                                               18
>>> +    UART3                                                               19
>>> +    UART4                                                               20
>>> +    UART5                                                               21
>>> +    UART6                                                               22
>>> +    UART7                                                               23
>>> +
>>> +Notation:
>>> + [*]:  The datasheet didn't mention these, but they are present on AW code
>>> + [**]: The datasheet had this marked as "NC" but they are used on AW code
>>
>> I'm really happy with the general documentation, thanks for this.
>> However, all of this is true only for the A10, could you mention it
>> somewhere?
> 
> I could add a note saying so. We could also rename this file to
> sun4i.txt and then and add a sun5i.txt with the A13 gate descriptions
> too; what would you prefer?

>From what we've seen so far, A10 and A13 will share a lot except the
gates in the documentation, so maybe you can keep this sunxi.txt file
with the generic comments, and add a note at the bottom saying to refer
to either sun4i.txt or sun5i.txt files for details.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
