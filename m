From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 7 Jun 2013 17:30:41 +0800
Subject: [PATCH v2 3/6] clk: divider: add CLK_DIVIDER_HIWORD_MASK flag
In-Reply-To: <CACRpkdZJmUQPiZrkzpNP2kc=3opDtwju5W1i4Z8wtYBbbmnidQ@mail.gmail.com>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
 <1370358317-12768-4-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZJmUQPiZrkzpNP2kc=3opDtwju5W1i4Z8wtYBbbmnidQ@mail.gmail.com>
Message-ID: <CAD6h2NSSDy+d8U_ccHq4vmGhQ7Z-J5s+z=yNUgjZVYvwiYtkfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2013 17:15, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jun 4, 2013 at 5:05 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> In Hisilicon Hi3620 clock divider register, 16-bit HIWORD is mask field.
>> Support the HIWORD mask to reuse clock divider driver.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> I don't understand this...

The mux or divider register in Hi3620 is 32-bit. The lower 16-bit is used to
configure mux or divider, and the higher 16-bit is used to set mask of
the mux or divier.

If I need to set b01 in mux/divider register, I also need to set (b11 << 16) for
HIWORD mask in the same register. The reason to set (b11 << 16) is two bits
are changed in the mux/divider register.

>
>> + * CLK_DIVIDER_HIWORD_MASK - register contains high 16-bit as mask field
>
> Could you be a bit more verbose here on what this actually means,
> so other users of this flag will realize if they need to set it?
>
I didn't find a better name for this flag. :(

> In other cases in the clk subsystem where masks and shifts are
> used, the position and number of bits are stated, rather than a
> single flag indicating some 16 bits.
>
Those masks are different from mine because those're used to calculate
which bits should be set or clear.

Regards
Haojian
