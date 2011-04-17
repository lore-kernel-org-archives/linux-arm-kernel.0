From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 17 Apr 2011 23:46:23 +0800
Subject: [PATCH v2 03/12] mmc: mmc_test: add test for none blocking
	transfers
In-Reply-To: <1302116833-24540-4-git-send-email-per.forlin@linaro.org>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302116833-24540-4-git-send-email-per.forlin@linaro.org>
Message-ID: <20110417154622.GC17935@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 09:07:04PM +0200, Per Forlin wrote:
[...]
> +static int mmc_test_rw_multiple(struct mmc_test_card *test,
> +				struct mmc_test_multiple_rw *tdata,
> +				unsigned int reqsize, unsigned int size)
> +{
> +	unsigned int dev_addr;
> +	struct mmc_test_area *t = &test->area;
> +	int ret = 0;
> +	int max_reqsize = max(t->mem->size_min_cmn *
> +			      min(t->max_segs, t->mem->cnt), t->max_tfr);
> +
The 'max(..., t->max_tfr)' probably should be 'min(..., t->max_tfr)'.
Otherwise, I see mmc_test failure on my mxs-mmc setup.

mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 64 x 2048 sectors (64 x 1024 KiB) took 5.412563314 seconds (12
398 kB/s, 12108 KiB/s, 11.82 IOPS)
mmc0: Failed to map sg list
[mmc_test_rw_multiple] error
mmc0: Result: ERROR (-22)

-- 
Regards,
Shawn
