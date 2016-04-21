From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 21 Apr 2016 15:48:44 +0200
Subject: [PATCH 3/8] gpio: stmpe: fix edge and rising/falling edge
 detection
In-Reply-To: <CACRpkdZWmYo-QgVgYaoHwUV7t=e5MGi-Ge5oWjKAi46+h1JMWg@mail.gmail.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-4-git-send-email-patrice.chotard@st.com>
 <CACRpkdZWmYo-QgVgYaoHwUV7t=e5MGi-Ge5oWjKAi46+h1JMWg@mail.gmail.com>
Message-ID: <5718DA3C.6060304@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/20/2016 04:37 PM, Linus Walleij wrote:
> On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:
>
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> By cross-checking STMPE 610/801/811/1601/2401/2403 datasheets,
>> it appears that edge detection and rising/falling edge detection
>> is not supported by all STMPE variant:
>>
>>             GPIO              GPIO
>>        Edge detection     rising/falling
>>                           edge detection
>>   610 |      X        |         X       |
>>   801 |               |                 |
>>   811 |      X        |         X       |
>> 1600 |               |                 |
>> 1601 |      X        |         X       |
>> 1801 |               |         X       |
>> 2401 |      X        |         X       |
>> 2403 |      X        |         X       |
>>
>> Rework stmpe_dbg_show_one() and stmpe_gpio_irq to correctly
>> take these cases into account.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Very nice.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I expect this to go into the MFD tree with the rest, I guess
> Lee will cook me an immutable branch for the whole thing
> once he's happy with it.
>
> Yours,
> Linus Walleij

Hi Linus

I will send a v2 as warnings as been detected by kbuild test robot

Thanks

Patrice
