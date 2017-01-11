From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 11 Jan 2017 14:04:38 +0100
Subject: [PATCHv4 3/8] rtc: add STM32 RTC driver
In-Reply-To: <1484138905-5903-1-git-send-email-amelie.delaunay@st.com>
References: <1484138905-5903-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170111130438.GA9327@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 01:48:25PM +0100, Amelie Delaunay wrote:
> This patch adds support for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/rtc/Kconfig     |  11 +
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-stm32.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 739 insertions(+)
>  create mode 100644 drivers/rtc/rtc-stm32.c

[...]
> +/* STM32_PWR_CR */
> +#define PWR_CR				0x00
> +/* STM32_PWR_CR bit field */
> +#define PWR_CR_DBP			BIT(8)
> +
> +static struct regmap *dbp;

Hello

Why using a global static struct ?
You could alloc a private structure in probe for storing it and use platform_set_drvdata()

Regards
