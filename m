From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Apr 2014 23:45:44 +0800
Subject: [PATCH 4/4] pinctrl: sirf: move to use irq_get_handler_data
In-Reply-To: <CACRpkdYz+JdAbhdR_s9h4m_3JNcpLo-2VzoXYoEd21myB4yZtg@mail.gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-5-git-send-email-21cnbao@gmail.com>
 <CACRpkdbDeF5gBVv=hQSdX1i9fw=7Or+=qN=g4OXHvHkZKr7vcQ@mail.gmail.com>
 <CAGsJ_4y=zNNWAvVOK6zGaY-bufUCbOcZtwE=SuWJ=QpF9rBNHg@mail.gmail.com>
 <CACRpkdYz+JdAbhdR_s9h4m_3JNcpLo-2VzoXYoEd21myB4yZtg@mail.gmail.com>
Message-ID: <CAGsJ_4zBC6wkRVwLWs4i3Vav-+CXJmVNp4cRbeLm-5KtzqohDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-24 20:59 GMT+08:00, Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Apr 24, 2014 at 12:59 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>>> If you want to use some other handler data than the gpiochip,
>>> you should just use irq_set_chained_handler() and
>>> irq_set_handler_data() directly.
>>
>> i think this should be fixed in the general API but not use one more
>> function call to over-write the handler_data which has been filled in
>> the API.
>> since we have the chance for drivers to set either the whole chip for
>> a simple chip,  or bank-specific data for a chip which has multiple
>> parent IRQs.
>
> I don't think it's worth it for saving one line. The helper is intended
> for the simple case, i.e. where it's enough to just get the gpio_chip
> as handler data. Other alternatives need to be open coded.
>

gpiochip_set_chained_irqchip() only save one line for simple gpiochip too.
it is not worth as well. people can realize what he should set as irq_handler.

> I'm even considering removing this helper if it's confusing, it doesn't
> really add much, gpiochip_irqchip_add() is the important function
> to use, not gpiochip_set_chained_irqchip().
>
> Yours,
> Linus Walleij

-barry
