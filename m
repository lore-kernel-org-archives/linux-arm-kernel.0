From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 21 May 2014 14:52:16 +0200
Subject: [PATCH] clk: divider: Fix table round up function
In-Reply-To: <CAOMZO5C9iqLj34mJdztqZsyLNR6oHztyN2GxDY0ORp+0xU1+LA@mail.gmail.com>
References: <1399481332-9550-1-git-send-email-maxime.coquelin@st.com>
 <CAOMZO5C9iqLj34mJdztqZsyLNR6oHztyN2GxDY0ORp+0xU1+LA@mail.gmail.com>
Message-ID: <537CA180.4050907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 05/15/2014 03:28 PM, Fabio Estevam wrote:
> Hi Mike,
>
> On Wed, May 7, 2014 at 1:48 PM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:
>> Commit 1d9fe6b97 ("clk: divider: Fix best div calculation for power-of-two and
>> table dividers") introduces a regression in its _table_round_up function.
>>
>> When the divider passed to this function is greater than the max divider
>> available in the table, this function returns table's max divider.
>> Problem is that it causes an infinite loop in clk_divider_bestdiv() because
>> _next_div() will never return a value greater than maxdiv.
>>
>> Instead of returning table's max divider, this patch returns INT_MAX.
>>
>> Reported-by: Fabio Estevam <festevam@gmail.com>
>> Reported-by: Shawn Guo <shawn.guo@freescale.com>
>> Tested-by: Fabio Estevam <festevam@gmail.com>
>> Cc: Mike Turquette <mike.turquette@linaro.org>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>
> Any comments on this one? It does fix a regression.
>

This patch is important as it fixes a regression, could you review it 
please?

Thanks,
Maxime
