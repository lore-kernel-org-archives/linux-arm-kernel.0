From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:54:23 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135423.GC10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

>  static void print_events_table_suffix(FILE *outfp)
>  {
>  	fprintf(outfp, "{\n");
> @@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
>  	return event;
>  }
>  
> +static void fixup_field(char *from, char **to)
> +{
> +	*to = malloc(strlen(from));
> +
> +	strcpy(*to, from);
> +}

could you just call '*to = strdup(from)' in here?

jirka
