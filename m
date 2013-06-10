From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 18:13:10 +0200
Subject: [PATCH 3/6] ARM: SAMSUNG: pm: Adjust for pinctrl- and DT-enabled
 platforms
In-Reply-To: <62314159.5vrvK4k2Mm@amdc1227>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-4-git-send-email-t.figa@samsung.com>
 <62314159.5vrvK4k2Mm@amdc1227>
Message-ID: <CACRpkdYA72YsASjPKPK6+N=okprRyQ5W6N-wUtgZ9c6uWq1a3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 4:45 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Friday 17 of May 2013 18:24:29 Tomasz Figa wrote:
>> This patch makes legacy code on suspend/resume path being executed
>> conditionally, on non-DT platforms only, to fix suspend/resume of
>> DT-enabled systems, for which the code is inappropriate.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/plat-samsung/pm.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> It seems like this patch did not make it into 3.10-rc5, while rest of patches
> did, which ended up with suspend/resume still being broken.
>
> What should we do in this case?

I did not apply this patch to the pinctrl tree because it begins
with ARM: but it appears I promised to carry it anyway...

I need an ACK from the ARM SoC people to do that though,
or you can take it through ARM SoC fixes directly.

I would just ask Olof/Arnd to apply it directly as a separate
patch.

Yours,
Linus Walleij
