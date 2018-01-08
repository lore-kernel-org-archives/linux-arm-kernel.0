From: jolsa@redhat.com (Jiri Olsa)
Date: Mon, 8 Jan 2018 15:08:40 +0100
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <850a0774-9442-c836-f457-69e1e0d72fb2@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
 <20171208122918.GE2799@krava>
 <afd7bf2a-4d94-0db0-640d-b1c93c8ba230@huawei.com>
 <20171209073104.GB14297@krava>
 <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
 <20171221193917.GB1105@krava>
 <850a0774-9442-c836-f457-69e1e0d72fb2@huawei.com>
Message-ID: <20180108140840.GB17156@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 05:17:56PM +0000, John Garry wrote:

SNIP

> 
> 
> Hi Jirka,
> 
> Sorry for the slow reply.

np, just got back from holidays anyway ;-)

> 
> > > > Won't this all potentially have a big maintainence cost?
> > as Andi said it's mostly just the disk space,
> > which is not big deal
> > 
> > I'm not doing JSON file updates, but I think having
> > simple single dir for platform/cpu could save us some
> > confusion in future
> 
> Understood. But for ARM, which has very standardised architecture events, it
> is good to reduce this event duplication between platforms.
> 
> > 
> > however I won't oppose if you want to add this logic,
> > but please:
> >   - use the list_head ;-)
> 
> Of course
> 
> >   - leave the process_one_file function simple
> >     and separate the level0 processing
> 
> ok, this is how it should look already, albeit a couple of
> process_one_file() modifications. I'll re-check this.
> 
> >   - you are using 'EventCode' as an unique ID to find
> >     the base, but it's not unique for x86, you'll need
> >     to add some other ID scheme that fits to all archs
> 
> Right, so you mentioned earlier using a new keyword token to identify
> whether we use the standard event, so we can go his way - ok?

yes, something like that

> I would also like to mention at this point why I did the event
> pre-processing in jevents, and not a separate script:
> - current build does not transverse the arch tree
> 	- tree transversal for JSON processing is done in jevents
> - a script would mean derived objects, which means:
> 	- makefile changes for derived objects
> 	- jevents would have to deal with derived objects
> - jevents already has support for JSON processing
> 
> The advantage of using a script is that we keep the JSON processing in
> jevents simple.

I don't mind the extra functionality in jevents as long as the current
one keeps on working and the new one works for all archs ;-)

thanks,
jirka
