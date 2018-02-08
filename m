From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:54:09 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135409.GA10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

> +static void fixup_field(char *from, char **to)
> +{
> +	*to = malloc(strlen(from));
> +
> +	strcpy(*to, from);
> +}
> +
> +#define EVENT_PREFIX "event="
> +
> +#define TRY_FIXUP_FIELD(string)	do { if (es->string && !*string)\
> +			fixup_field(es->string, string);	\
> +} while (0)

please indent the code in the macro like normal code

> +
> +static int
> +try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> +	  char **name, char **long_desc, char **pmu, char **filter,
> +	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
> +	  char **metric_group)
> +{
> +	/* try to find matching event from arch standard values */
> +	struct event_struct *es;
> +
> +	list_for_each_entry(es, &arch_std_events, list) {
> +		if (!strcmp(arch_std, es->event+strlen(EVENT_PREFIX))) {

you could use just sizeof(EVENT_PREFIX). no need to call strlen

jirka
