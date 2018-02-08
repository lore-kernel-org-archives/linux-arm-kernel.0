From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:54:16 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135416.GB10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

> @@ -366,6 +367,67 @@ static int print_events_table_entry(void *data, char *name, char *event,
>  	return 0;
>  }
>  
> +struct event_struct {
> +	char *name;
> +	char *event;
> +	char *desc;
> +	char *long_desc;
> +	char *pmu;
> +	char *filter;
> +	char *perpkg;
> +	char *unit;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	struct list_head list;
> +	char strings[];
> +};
> +
> +static LIST_HEAD(arch_std_events);
> +
> +#define ADD_EVENT_STRING(string) do { if (string) {		\
> +	es->string = strings;					\
> +	strings += snprintf(strings, len, "%s", string) + 1;	\
> +} } while (0)

please indent the code in macro like normal code

thanks,
jirka
