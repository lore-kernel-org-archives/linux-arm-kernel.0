From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Apr 2014 06:59:29 +0800
Subject: [PATCH 4/4] pinctrl: sirf: move to use irq_get_handler_data
In-Reply-To: <CACRpkdbDeF5gBVv=hQSdX1i9fw=7Or+=qN=g4OXHvHkZKr7vcQ@mail.gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-5-git-send-email-21cnbao@gmail.com>
 <CACRpkdbDeF5gBVv=hQSdX1i9fw=7Or+=qN=g4OXHvHkZKr7vcQ@mail.gmail.com>
Message-ID: <CAGsJ_4y=zNNWAvVOK6zGaY-bufUCbOcZtwE=SuWJ=QpF9rBNHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-24 4:17 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> we set bank as handler_data, now we can get bank in ISR directly
>> instead of looking-up.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> If you want to use some other handler data than the gpiochip,
> you should just use irq_set_chained_handler() and
> irq_set_handler_data() directly.

i think this should be fixed in the general API but not use one more
function call to over-write the handler_data which has been filled in
the API.
since we have the chance for drivers to set either the whole chip for
a simple chip,  or bank-specific data for a chip which has multiple
parent IRQs.

>
> Yours,
> Linus Walleij

-barry
