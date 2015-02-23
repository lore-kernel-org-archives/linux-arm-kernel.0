From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 23 Feb 2015 10:46:44 +0100
Subject: [PATCH 2/3] clk: divider: fix selection of divider when rounding
 to closest
In-Reply-To: <1424515225-6929-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424515225-6929-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <54EAF704.9030706@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

On 02/21/2015 11:40 AM, Uwe Kleine-K?nig wrote:
> It's an invalid approach to assume that among two divider values
> the one nearer the exact divider is the better one.
>
> Assume a parent rate of 1000 Hz, a divider with CLK_DIVIDER_POWER_OF_TWO
> and a target rate of 89 Hz. The exact divider is ~ 11.236 so 8 and 16
> are the candidates to choose from yielding rates 125 Hz and 62.5 Hz
> respectivly. While 8 is nearer to 11.236 than 16 is, the latter is still
> the better divider as 62.5 is nearer to 89 than 125 is.
>
> Fixes: 774b514390b1 (clk: divider: Add round to closest divider)
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/clk/clk-divider.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

For this one too, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
