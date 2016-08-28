From: jolsa@redhat.com (Jiri Olsa)
Date: Sun, 28 Aug 2016 16:16:16 +0200
Subject: [PATCH V6 5/5] perf tools: adding sink configuration for cs_etm
 PMU
In-Reply-To: <1472156445-24283-6-git-send-email-mathieu.poirier@linaro.org>
References: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
 <1472156445-24283-6-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160828141616.GB32293@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:20:45PM -0600, Mathieu Poirier wrote:

SNIP

>  	return NULL;
>  }
> +
> +static FILE *cs_device__open_file(const char *name)
> +{
> +	struct stat st;
> +	char path[PATH_MAX];
> +	const char *sysfs;
> +
> +	sysfs = sysfs__mountpoint();
> +	if (!sysfs)
> +		return NULL;
> +
> +	snprintf(path, PATH_MAX,
> +		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
> +
> +	printf("path: %s\n", path);

should this be pr_info ?

jirka
