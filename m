From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 07:23:06 +0200
Subject: [PATCH 1/3] mmc: mmci: Put power register deviations in variant
	data
In-Reply-To: <1317123725-29832-1-git-send-email-ulf.hansson@stericsson.com>
References: <1317123725-29832-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZoXmQiUJbLkzgTkRnjukS18RvcZASXzZshnuDSQDE1aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 1:42 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 4da20ec..32de82b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -53,6 +53,7 @@ static unsigned int fmax = 515633;
> ?* @st_clkdiv: true if using a ST-specific clock divider algorithm
> ?* @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
> ?* @non_power_of_2_blksize: true if block sizes can be other than power of two
> + * @pwrreg_powerup: power up value for MMCIPOWER register
> ?*/
> ?struct variant_data {
> ? ? ? ?unsigned int ? ? ? ? ? ?clkreg;
> @@ -64,18 +65,21 @@ struct variant_data {
> ? ? ? ?bool ? ? ? ? ? ? ? ? ? ?st_clkdiv;
> ? ? ? ?bool ? ? ? ? ? ? ? ? ? ?blksz_datactrl16;
> ? ? ? ?bool ? ? ? ? ? ? ? ? ? ?non_power_of_2_blksize;
> + ? ? ? unsigned int ? ? ? ? ? ?pwrreg_powerup;

This should probably be u32, no big deal but easy to fix.
Can be done when putting it into Russells patch tracker I guess.

Yours,
Linus Walleij
