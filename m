From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jan 2017 11:43:52 +0100
Subject: [PATCH] rtc: stm32: fix comparison warnings
In-Reply-To: <1484561333-12087-1-git-send-email-amelie.delaunay@st.com>
References: <1484561333-12087-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170117104352.65velakwiaia36xq@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/2017 at 11:08:53 +0100, Amelie Delaunay wrote :
> This patches fixes comparison between signed and unsigned values as it
> could produce an incorrect result when the signed value is converted to
> unsigned:
> 
> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_valid_alrm':
> drivers/rtc/rtc-stm32.c:404:21: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>   if ((((tm->tm_year > cur_year) &&
> ...
> 
> It also fixes comparison always true or false due to the fact that unsigned
> value is compared against zero with >= or <:
> 
> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_init':
> drivers/rtc/rtc-stm32.c:514:35: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>   for (pred_a = pred_a_max; pred_a >= 0; pred_a-- ) {
> 
> drivers/rtc/rtc-stm32.c:530:44: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>      (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?
> 
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/rtc/rtc-stm32.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
