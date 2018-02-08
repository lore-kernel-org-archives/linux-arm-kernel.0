From: john.garry@huawei.com (John Garry)
Date: Thu, 8 Feb 2018 15:31:24 +0000
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <20180208140250.43a10b84@alans-desktop>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135423.GC10234@krava> <20180208140250.43a10b84@alans-desktop>
Message-ID: <7d5b53dd-2e86-da0e-a7b6-9dd94ebcb49c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2018 14:02, Alan Cox wrote:
> On Thu, 8 Feb 2018 14:54:23 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
>
>> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
>>
>> SNIP
>>
>>>  static void print_events_table_suffix(FILE *outfp)
>>>  {
>>>  	fprintf(outfp, "{\n");
>>> @@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
>>>  	return event;
>>>  }
>>>
>>> +static void fixup_field(char *from, char **to)
>>> +{
>>> +	*to = malloc(strlen(from));
>>> +
>>> +	strcpy(*to, from);
>>> +}
>>
>> could you just call '*to = strdup(from)' in here?

Right

>
> And check for malloc returning NULL.
>

Right again,

> Alan
>

I should have concentrated on the coding as much as the feature being 
added...

Thanks,
John
> .
>
