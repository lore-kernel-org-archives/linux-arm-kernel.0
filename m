From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 19 Dec 2017 13:28:13 +0300
Subject: [PATCH v2] IPI performance benchmark
In-Reply-To: <CAOFm3uGjeT3waQaC+Ak=gmNkLFsFO6HshyEwsYA5QX2RjK0XNw@mail.gmail.com>
References: <20171219085010.4081-1-ynorov@caviumnetworks.com>
 <CAOFm3uGjeT3waQaC+Ak=gmNkLFsFO6HshyEwsYA5QX2RjK0XNw@mail.gmail.com>
Message-ID: <20171219102813.73fjhlde3t5nw6ee@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 10:26:02AM +0100, Philippe Ombredanne wrote:
> Dear Yury,
> 
> On Tue, Dec 19, 2017 at 9:50 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > This benchmark sends many IPIs in different modes and measures
> > time for IPI delivery (first column), and total time, ie including
> > time to acknowledge the receive by sender (second column).
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/kernel/ipi_benchmark.c
> > @@ -0,0 +1,153 @@
> > +/*
> > + * Performance test for IPI on SMP machines.
> > + *
> > + * Copyright (c) 2017 Cavium Networks.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of version 2 of the GNU General Public
> > + * License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * General Public License for more details.
> > + */
> 
> Would you mind using the new SPDX tags documented in Thomas patch set
> [1] rather than this fine but longer legalese? 

Of course. I'll collect more comments, if any, and send v3 soon.

> Each time long
> legalese is added as a comment to a kernel file, there is a whole star
> system that dies somewhere in the universe, which is not a good thing.

You can save all that stars and hours of your time if add
corresponding rule to checkpatch. ;)

> SPDX tags eschew this problem by using a simple one line comment and
> this has been proven to be mostly harmless. And if you could spread
> the word to others in your team this would be very nice. I recently
> nudged Aleksey who nicely updated his patches a short while ago.
> 
> > +MODULE_LICENSE("GPL");
> 
> There is a problem here: your MODULE_LICENSE tag means GPL-2.0 or
> later versions as documented in module.h. This is not consistent with
> your top level license notice. You should make this consistent IMHO
> .... and use SPDX tags for the top level notice of course!
> 
> Thank you!
> 
> [1] https://lkml.org/lkml/2017/12/4/934
> 
> CC: Aleksey Makarov <aleksey.makarov@cavium.com>
> -- 
> Cordially
> Philippe Ombredanne
