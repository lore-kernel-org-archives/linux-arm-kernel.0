From: joe@perches.com (Joe Perches)
Date: Wed, 18 Sep 2013 16:02:41 -0700
Subject: [PATCH v2] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <1379544219-23579-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379544219-23579-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1379545361.1787.87.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-09-18 at 15:43 -0700, Soren Brinkmann wrote:
> Add a driver for SILabs 570, 571, 598, 599 programmable oscillators.
> The devices generate low-jitter clock signals and are reprogrammable via
> an I2C interface.
[]
> v2:
[]
>  - use 10000 as MIN and MAX value in usleep_range
[]
> diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
[]
> +static int si570_set_frequency(struct clk_si570 *data, unsigned long frequency)
> +{
[]
> +	/* Applying a new frequency can take up to 10ms */
> +	usleep_range(10000, 10000);

Generally it's nicer to have an actual range for usleep_range.

Is there a bit you could periodically poll to see
if the new frequency has been set or is stable so
that a 10ms delay isn't always used?
