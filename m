From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 23 May 2017 10:21:49 +0900
Subject: [DT Question] "simple-mfd" DT binding
In-Reply-To: <CACRpkdY88Zdp2zqabWPfYPnTwSzYuCqSQHQg9vF_+Zd=TFOvaA@mail.gmail.com>
References: <CAK7LNARQmfX+3RwFgwtvf2Qu79XNX1zh0O741-pPFWS6npytLw@mail.gmail.com>
 <CACRpkdY88Zdp2zqabWPfYPnTwSzYuCqSQHQg9vF_+Zd=TFOvaA@mail.gmail.com>
Message-ID: <CAK7LNAQ+DimarhHJOg=BqbH+EB19s+wgtRqJ8-XuLKW6_0FFaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee, Linus,

Thanks for your comments!

2017-05-22 17:43 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, May 22, 2017 at 3:29 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> Because "simple-bus" indicates that child nodes are
>> simply memory mapped, but the node "register-bit-led"
>> can not be memory-mapped.
>> So, "simple-mfd" can not be replaced "simple-bus" here.
>
> Yeah... just like Lee points out, you are spot on, this is exactly
> the reason why we created "simple-mfd" in the first place
> IIRC.

OK, Linux treats simple-bus and simple-mfd in the same way
as far as I see drivers/of/platform.c

Perhaps, can we document the difference between simple-bus and
simple-mfd clearly?
For example, "Unlike simple-bus, it is legitimate that simple-mfd has
subnodes without reg property"


I think this is typical when "simple-mfd" is used together with "syscon".
The child devices will use regmap of the parent node.
I'd like to be sure this is valid usage.


-- 
Best Regards
Masahiro Yamada
