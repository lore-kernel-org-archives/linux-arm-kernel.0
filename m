From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 23 Feb 2015 10:42:12 +0100
Subject: [PATCH 3/3] clk: divider: fix calculation of initial best divider
 when rounding to closest
In-Reply-To: <1424515225-6929-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424515225-6929-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <54EAF5F4.3070509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 02/21/2015 11:40 AM, Uwe Kleine-K?nig wrote:
> Similar to the reasoning for the previous commit
>
> 	DIV_ROUND_CLOSEST(parent_rate, rate)
>
> might not be the best integer divisor to get a good approximation for
> rate from parent_rate (given the metric for CLK_DIVIDER_ROUND_CLOSEST).
>
> For example assume a parent rate of 1000 Hz and a target rate of 700.
> Using DIV_ROUND_CLOSEST the suggested divisor gets calculated to 1
> resulting in a target rate of 1000 with a delta of 300 to the desired
> rate. With choosing 2 as divisor however the resulting rate is 500 which
> is nearer to 700.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/clk/clk-divider.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>

This is correct. Thanks for fixing this.

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>


Best regards,
Maxime
