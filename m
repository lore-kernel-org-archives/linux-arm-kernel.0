From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 15:35:57 +0800
Subject: [PATCH 2/6] clk: sunxi-ng: a83t: Fix audio PLL divider offset
In-Reply-To: <20170522072047.bffdbwkz2nqvhums@flea.lan>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-3-wens@csie.org>
 <20170522072047.bffdbwkz2nqvhums@flea.lan>
Message-ID: <CAGb2v65SUR2NvGOFFgzUpDh_9Dm6SAhzwC31KBOqFZubOhkK9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 3:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, May 22, 2017 at 02:25:48PM +0800, Chen-Yu Tsai wrote:
>> The divider of the audio PLL has an offset of 1.
>> Fix this in the driver.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied, thanks!

So even with this patch applied, the audio is still slow and off pitch.
It's even worse without this patch...

Maybe it's time we added a special class of clks for the audio PLL
to deal with sigma-delta modulation of the divider?

ChenYu
