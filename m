From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jan 2017 11:43:40 +0100
Subject: [PATCH] rtc: stm32: use 0 instead of ~PWR_CR_DBP in
 regmap_update_bits
In-Reply-To: <1484557058-21601-1-git-send-email-amelie.delaunay@st.com>
References: <1484557058-21601-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170117104340.rn2upxp3z7zzmg32@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/2017 at 09:57:38 +0100, Amelie Delaunay wrote :
> Using the ~ operator on a BIT() constant results in a large 'unsigned long'
> constant that won't fit into an 'unsigned int' function argument on 64-bit
> architectures, resulting in a harmless build warning in x86 allmodconfig:
> 
> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
> drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>   regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
> 
> As PWR_CR_DBP mask prevents other bits to be cleared, replace all
> ~PWR_CR_DBP by 0.
> 
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
