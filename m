From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Aug 2015 00:43:23 +0200
Subject: [PATCH 3/4] ARM: nomadik: move l2x0 setup to device tree
In-Reply-To: <20150802220626.GG7557@n2100.arm.linux.org.uk>
References: <1438552593-4578-1-git-send-email-linus.walleij@linaro.org>
 <20150802220626.GG7557@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZAU8Mjs=uTGs4iFLQ6xYcK1ZUeyh_jL0VbTpRn8yyV2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 3, 2015 at 12:06 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Aug 02, 2015 at 11:56:33PM +0200, Linus Walleij wrote:
>> -     /* At full speed latency must be >=2, so 0x249 in low bits */
>> -     .l2c_aux_val    = 0x00700249,
>> -     .l2c_aux_mask   = 0xfe0fefff,
>> +     .l2c_aux_val    = 0x0,
>> +     .l2c_aux_mask   = ~0x0UL,
>
> It always amazes me by the things people come up with... what prompted
> the addition of "UL" on that constant?  Why do you think it needs it?

Good old mindless cut'n'paste.
Will fix, thanks!

Yours,
Linus Walleij
