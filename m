From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 16 Aug 2012 17:19:11 +0200
Subject: [PATCH 13/14] arm: at91: dt: at91sam9 add nand pinctrl support
In-Reply-To: <CACRpkdZXjFE7UsRneskNqnN7DFERHxgAt-FCXtL2A52xKgEA=w@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-13-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZXjFE7UsRneskNqnN7DFERHxgAt-FCXtL2A52xKgEA=w@mail.gmail.com>
Message-ID: <CACQ1gAhWdwrXEkicy4ij=rukzS-v98bZRr433Qq5M_Dan5JAog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/15 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> (...)
>> +                               nand {
>> +                                       pinctrl_nand: nand-0 {
>> +                                               atmel,pins =
>> +                                                       <2 13 0x0 0x1   /* PC13 gpio RDY pin pull_up */
>> +                                                        2 14 0x0 0x1>; /* PC14 gpio enable pin pull_up */
>> +                                       };
>> +                               };
>
> Again magic hex I don't understand so skipping this patch -> Nicolas.

Maybe it will be more readable if we use something like :
atmel,pull-up;
atmel,multidrive;
atmel,mux="GPIO"
atmel,mux="A"
...
just my 2 cents...


Richard.
