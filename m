From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Feb 2015 10:26:02 +0100
Subject: [PATCH] coresight-stm: adding driver for CoreSight STM component
In-Reply-To: <1423088550-15780-1-git-send-email-mathieu.poirier@linaro.org>
References: <1423088550-15780-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1423128362.27378.12.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-04 at 15:22 -0700, mathieu.poirier at linaro.org wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
> 
> This driver adds support for the STM CoreSight IP block,
> allowing any system compoment (HW or SW) to log and
> aggregate messages via a single entity.
> 
> The STM exposes an application defined number of channels
> called stimulus port.  Configuration is done using entries
> in sysfs and channels made available to userspace via devfs.
> 
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>[...]
> +/**
> + * struct stm_node - aggregation of channel information for userspace access
> + * @channel_id:		the channel number associated to this file descriptor.
> + * @options:		options for this channel - none, timestamped,
> +i			guaranteed.

Did you perhaps use vim?

> + * @drvdata:		STM driver specifics.
> + */
> +struct stm_node {
> +	int			channel_id;
> +	u32			options;
> +	struct stm_drvdata	*drvdata;
> +};


Paul Bolle
