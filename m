From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Oct 2015 14:14:15 +0100
Subject: [PATCH 09/13] clk: versatile-icst: add device tree support
In-Reply-To: <20151015192626.GO4558@codeaurora.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
 <20151015192626.GO4558@codeaurora.org>
Message-ID: <CACRpkdZUzTsMcFrudF6RRU5_1Njr=8L_XRUEmAWqvEnoJQ96Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 9:26 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/15, Linus Walleij wrote:
>> +
>> +     if (of_device_is_compatible(np, "arm,syscon-icst525"))
>> +             icst_desc.params = &icst525_params;
>> +     else if (of_device_is_compatible(np, "arm,syscon-icst307"))
>> +             icst_desc.params = &icst307_params;
>
> I guess if we add anymore here we should use an of_device_id
> array instead.

As it happens those two are gonna be it.

ARM never created any more integrated ICST devices, and
they stopped using them since. Those two are the required
ones.

(Fixing all other comments.)

Yours,
Linus Walleij
