From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Oct 2012 23:51:25 +0200
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <CAOh2x=mr4jQ1WQTC50H6OsN_E+7gtVSy_UMwjrt6Rj-QbQRtOA@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
 <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
 <CACRpkdYjA8QUh4HqvE1rsnXcGA4WafTkMq_wLNJ__gXEnEYrow@mail.gmail.com>
 <CAOh2x=mr4jQ1WQTC50H6OsN_E+7gtVSy_UMwjrt6Rj-QbQRtOA@mail.gmail.com>
Message-ID: <CACRpkdZvO3Df58UxFDc_T10JDhE=O5KKHZTzd9g0BOn60NWZcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 7:07 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Thu, Oct 11, 2012 at 9:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> And the block layer of the subsystem should take care
>> of only handing the driver buffers that are contiguous
>
> But why should that be a constraint on block layer? It is working in virtual
> space and is concerned about that onlly.

Not the block layer, the block layer of the subsystem.

It has to pick out the chunks that get transferred down to the drivers.

For example drivers/mmc/card/block.c will convert transfers into
sglists and pass down to the MMC drivers. mmc_queue_map_sg()
calls blk_rq_map_sg() to do the job. It's even documented in
Documentation/block/biodoc.txt

I don't know how that works in MTD...

Yours,
Linus Walleij
