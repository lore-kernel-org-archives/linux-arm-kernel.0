From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Sep 2017 11:22:19 +0200
Subject: [PATCH 4/7] drm/pl111: Enable PL110 variant
In-Reply-To: <CACvgo51zbo1vA6s+c9db9yS-8L=fpQUGDptk7XjxjXUY8ZndqA@mail.gmail.com>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
 <20170830180711.2791-5-linus.walleij@linaro.org>
 <20170831101913.sjs32rsmbfal5xj3@imgtec.com>
 <CACvgo51zbo1vA6s+c9db9yS-8L=fpQUGDptk7XjxjXUY8ZndqA@mail.gmail.com>
Message-ID: <CACRpkdZL=j1zPqX4zfqpepBsDuxsiu0jDUsezJOsqi_j_DeQ0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 1, 2017 at 10:23 AM, Emil Velikov <emil.l.velikov@gmail.com> wrote:

>>Eric E:
>>> +struct pl111_variant_data pl110_variant = {
>>
>> I think this (and `pl111_variant` below) can be `static const`, right?
>>
> Static - yes, const - I don't think so.
> Struct amba_id::data lacks the constness, so the const qualifier will
> get discarded.

I fixed it with a (void*) cast so we can have it right in the driver.

> In practise everyone considers/uses ::data as const, so that could be
> tweaked with separate patch.

I think it is not necessarily possible to make that const since the amba_id
is used in several dynamically generated board files. But I may
be wrong.

Yours,
Linus Walleij
