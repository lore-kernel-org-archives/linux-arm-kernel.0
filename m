From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 3 Jul 2018 15:41:39 +0200
Subject: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180703134139.GB3728@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:

SNIP

> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
> +static int perf_event_set_drv_config(struct perf_event *event, void __user *arg)
> +{
> +	int ret = -EINVAL;
> +	char *config_str;
> +
> +	config_str = strndup_user(arg, PAGE_SIZE);
> +	if (IS_ERR(config_str))
> +		return PTR_ERR(config_str);
> +
> +	if (has_drv_config(event))

would it be better to make this check before
the alloc/copy data from user takes place?

jirka
