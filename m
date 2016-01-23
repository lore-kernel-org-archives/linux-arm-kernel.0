From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 23 Jan 2016 18:50:40 +0800
Subject: [PATCH RFC 12/15] ARM: dts: sun9i: Use sun9i specific mmc
 compatible
In-Reply-To: <20160122204402.GE3682@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-13-git-send-email-wens@csie.org>
 <20160122204402.GE3682@lukather>
Message-ID: <CAGb2v671vypQxPcmnWa86ipCgRd0prqeTcTkbH_G+Q+AM71zFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 4:44 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jan 21, 2016 at 01:26:39PM +0800, Chen-Yu Tsai wrote:
>> sun9i/A80 MMC controllers have a larger FIFO, and the FIFO DMA
>> trigger levels can be increased. Also, the mmc module clock parent
>> has a higher clock rate, and the sample and output delay phases
>> are different.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied, thanks!
>
> Does that count as a fix, or does the A80 board can safely operate
> without it?

The compatible was added in v4.3, in commit 51424b286067 ("mmc:
sunxi: Fix clk-delay settings").

I've not tested using the old compatibles with 50/52 MHz DDR. They
do work just fine with the transfer modes we already supported.

Either way its been there for a while so i don't see any need to
pick it out as a fix.

ChenYu
