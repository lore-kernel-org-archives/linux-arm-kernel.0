From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 11 Nov 2016 11:01:23 -0500
Subject: ??
In-Reply-To: <CAG2=9p_3nLD6MuLXPsbfC8LqK76LbwD3BDRUjX3uEUrijZnYCg@mail.gmail.com>
References: <CAG2=9p_3nLD6MuLXPsbfC8LqK76LbwD3BDRUjX3uEUrijZnYCg@mail.gmail.com>
Message-ID: <20161111110123.019fc088@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Nov 2016 11:38:45 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:


What happened to the subject?

> >>> +static void
> >>> +trace_process_export(struct trace_export *export,
> >>> +            struct ring_buffer_event *event)
> >>> +{
> >>> +     struct trace_entry *entry;
> >>> +     unsigned int size = 0;
> >>> +
> >>> +     entry = ring_buffer_event_data(event);
> >>> +
> >>> +     size = ring_buffer_event_length(event);
> >>> +
> >>> +     if (export->write)
> >>> +             export->write((char *)entry, size);  
> >>
> >> Is there ever going to be a time where export->write wont be set?  
> >
> > There hasn't been since only one trace_export (i.e. stm_ftrace) was
> > added in this patch-set , I just wanted to make sure the write() has
> > been set before registering trace_export like what I added in 2/3 of
> > this series.
> >  
> >>
> >> And if there is, this can be racy. As in
> >>
> >>
> >>         CPU 0:                  CPU 1:
> >>         ------                  ------
> >>         if (export->write)
> >>
> >>                                 export->write = NULL;  
> >
> > Is there going to be this kind of use case? Why some one needs to
> > change export->write() rather than register a new trace_export?
> >
> > I probably haven't understood your point thoroughly, please correct me
> > if my guess was wrong.
> >  
> 
> Any further comments? :)

I don't remember which patch series this goes to, so right now, no.

-- Steve
