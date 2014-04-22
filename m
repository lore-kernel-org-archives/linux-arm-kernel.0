From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 14:52:10 +0200
Subject: [PATCH RESEND 2/5] pinctrl: berlin: add a pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <5347EF8A.8040600@gmail.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-3-git-send-email-antoine.tenart@free-electrons.com>
 <5347AFF4.3050607@gmail.com> <20140411123737.GA5903@kwain>
 <5347EF8A.8040600@gmail.com>
Message-ID: <CACRpkdb1eijF-4e=KyhS=9S868NALdyJJaNnzjUubXnapWEeMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 3:35 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 04/11/2014 02:37 PM, Antoine T?nart wrote:
>> On Fri, Apr 11, 2014 at 11:03:48AM +0200, Sebastian Hesselbarth wrote:
>>> On 04/10/2014 03:07 PM, Antoine T?nart wrote:

>>> Having said that, the above assumes that each function is unique
>>> but IIRC the idea of the function table was to group pins/groups
>>> with the same function, e.g. function "gpio", groups 1,7,25,...
>>
>> Most of the functions you can use on the Berlin they will be unique and
>> would
>> only be used in one group, except for the 'gpio' one.
>
> Yeah, I had a similar discussion about it back then for mvebu. IIRC, the
> correct answer is: Have a list of functions with groups assigned to it
> no matter if there is only one group per function (or 40 per function as
> it will be for gpio).
>
> Maybe Linus can give an update on how to deal with it?

Have you considered implementing pinmux_ops
.gpio_request_enable(), .gpio_set_direction() and
.gpio_disable_free() instead of defining groups for each
and every GPIO?

Yours,
Linus Walleij
