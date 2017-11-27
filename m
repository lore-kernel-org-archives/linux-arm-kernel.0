From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 27 Nov 2017 14:47:20 +0800
Subject: [PATCH] pinctrl: sunxi: Fix A80 interrupt pin bank
In-Reply-To: <20171125121948.24012-1-andre.przywara@arm.com>
References: <20171125121948.24012-1-andre.przywara@arm.com>
Message-ID: <CAGb2v65LUmqe6pFzPBkp5rC0iNG+PXLqyHVjye0emu4yvtt-BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 8:19 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> On the A80 the pins on port B can trigger interrupts, and those are
> assigned to the second interrupt bank.
> Having two pins assigned to the same interrupt bank/pin combination does
> not look healthy (instead more like a copy&paste bug from pins PA14-PA16),
> so fix the interrupt bank for pins PB14-PB16, which is actually 1.
>
> I don't have any A80 board, so could not test this.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
Fixes: d5e9fb31baa2 ("pinctrl: sunxi: Add A80 pinctrl muxing options")
