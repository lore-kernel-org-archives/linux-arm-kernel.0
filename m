From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 8 Apr 2014 23:00:59 -0700
Subject: [PATCH 07/15] mtd: st_spi_fsm: Extend fsm_clear_fifo to handle
 unwanted bytes
In-Reply-To: <1395851969-13520-8-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
 <1395851969-13520-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20140409060059.GD3131@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 04:39:21PM +0000, Lee Jones wrote:
> From: Angus Clark <angus.clark@st.com>
...
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index 8c56b94..9df59e7 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
...
> +	dev_dbg(fsm->dev, "cleared %d byte(s) from the data FIFO\n", 4 - i);
> +}
> +
>  static int stfsm_write_fifo(struct stfsm *fsm, uint32_t *buf, uint32_t size)

This patch does not apply to l2-mtd.git, and neither do several of the
following patches. You probably didn't rebase onto the patches regarding
the above line (adding 'const').

>  {
>  	uint32_t words = size >> 2;

Brian
