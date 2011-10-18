From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Oct 2011 14:43:20 +0530
Subject: [PATCH 1/3] spi/pl022: fix build warnings
In-Reply-To: <1318857142-32127-1-git-send-email-linus.walleij@stericsson.com>
References: <1318857142-32127-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E9D4330.3020107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2011 6:42 PM, Linus WALLEIJ wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> The driver build complains with newer compilers unless you
> initialize this struct properly.
> 
> Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index debdaeb..91700bb 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1930,7 +1930,7 @@ static int pl022_setup(struct spi_device *spi)
>  {
>  	struct pl022_config_chip const *chip_info;
>  	struct chip_data *chip;
> -	struct ssp_clock_params clk_freq = {0, };
> +	struct ssp_clock_params clk_freq = { .cpsdvsr = 0, .scr = 0};
>  	int status = 0;
>  	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
>  	unsigned int bits = spi->bits_per_word;

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
