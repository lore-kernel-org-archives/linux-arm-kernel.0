From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 27 Mar 2013 18:36:46 +0800
Subject: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
In-Reply-To: <CACRpkdbg=ii1XjUmVd7GOOWF_FAMq_uUcvaGstbWjiGWGEbFLQ@mail.gmail.com>
References: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdbg=ii1XjUmVd7GOOWF_FAMq_uUcvaGstbWjiGWGEbFLQ@mail.gmail.com>
Message-ID: <CAGsJ_4xN6=1myOVyz6wTagd=JCvGgta1q4wwq0RFE0XcDokoSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Mar 18, 2013 at 8:22 AM, Barry Song <Barry.Song@csr.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> hardcode set i2c pin group to i2c function before, here we
>> move to use standard pinctrl API to get pins of the group.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>
> NAK.
>
> This is done by the device core as of commit
> ab78029ecc347debbd737f06688d788bd9d60c1d
> "drivers/pinctrl: grab default handles from device core".
>
> You only need to fetch pinctrl handles in drivers if you're
> using anything else than the default state.

well. missed this recent commit.
it should mean we hould drop all devm_pinctrl_get_select_default() if
the driver only takes the default pinctrl?

it looks like there are still a lot of drivers doing that. anyway, i
will drop them in SiRFsoc drivers. and involve you in the coming
patch.

>
> Yours,
> Linus Walleij
>

-barry
