From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Nov 2018 00:11:36 +0800
Subject: [PATCH v2 1/3] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
In-Reply-To: <20181105074842.21988-1-jagan@amarulasolutions.com>
References: <20181105074842.21988-1-jagan@amarulasolutions.com>
Message-ID: <CAGb2v65aJ0LVq8ic1Ru65qhoOHVw21eH8r4p_0Vxzz_83Xgi2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 3:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> MUX bits for MMC clock register range are 25:24 where 24 is shift
> and 2 is width So fix the width number from 3 to 2.
>
> Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

However, given that most of the other module clocks have bits 26:24 as
their mux bits, and the mmc clocks use 3 bits to denote the values and
corresponding clock parents, I would have appreciated you actually doing
tests to confirm which of these errors is the actual error, and not just
say "the user manual says so", because it is not always completely correct.
