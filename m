From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 8 Feb 2018 14:02:50 +0000
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <20180208135423.GC10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135423.GC10234@krava>
Message-ID: <20180208140250.43a10b84@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Feb 2018 14:54:23 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
> 
> SNIP
> 
> >  static void print_events_table_suffix(FILE *outfp)
> >  {
> >  	fprintf(outfp, "{\n");
> > @@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
> >  	return event;
> >  }
> >  
> > +static void fixup_field(char *from, char **to)
> > +{
> > +	*to = malloc(strlen(from));
> > +
> > +	strcpy(*to, from);
> > +}  
> 
> could you just call '*to = strdup(from)' in here?

And check for malloc returning NULL.

Alan
