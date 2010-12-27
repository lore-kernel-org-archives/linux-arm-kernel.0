From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Mon, 27 Dec 2010 11:29:36 +0100
Subject: [PATCH] dma_declare_coherent_memory: push ioremap() up to caller
In-Reply-To: <Pine.LNX.4.64.1012261837450.20458@axis700.grange>
References: <201012240020.37208.jkrzyszt@tis.icnet.pl>
	<201012250024.38576.jkrzyszt@tis.icnet.pl>
	<Pine.LNX.4.64.1012261837450.20458@axis700.grange>
Message-ID: <201012271129.44434.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sunday 26 December 2010 18:45:00 Guennadi Liakhovetski wrote:
> On Sat, 25 Dec 2010, Janusz Krzysztofik wrote:
>
> [snip]
>
> > > Passing the virtual address allows the API to become much more
> > > flexible. Not only that, it allows it to be used on ARM, rather
> > > than becoming (as it currently stands) prohibited on ARM.
> > >
> > > I believe that putting ioremap() inside this API was the wrong
> > > thing to do, and moving it outside makes the API much more
> > > flexible and usable. It's something I still fully support.
> >
> > Thanks, this is what I was missing, having my point of view rather
> > my machine centric, with not much wider experience. I'll quote your
> > argumentation in next iteration of this patch if required.
>
> AFAIU, this patch is similar to the previous two attempts:
>
> http://www.spinics.net/lists/linux-sh/msg05482.html
> and
> http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructur
>e/22271
>
> but is even more intrusive, because those two previous attempts added
> new functions, whereas this one is modifying an existing one. Both
> those two attempts have been NACKed by FUJITA Tomonori, btw, he is 
> not on the otherwise extensive CC list for this patch.

Hi Guennadi,
I composed that extensive CC list based on what I was able to find in 
MAINTAINERS for any files being modified, additionally adding Catalin 
Marinas as one of the idea promoters. FUJITA Tomonori's name was not 
specified there, nor was he mentioned as an author of any of those 
files. Adding him per your advice.

NB, the rationale quoted above is provided by courtesy of Russell King, 
and not of my authoriship, as it may look like at a first glance from 
your snip result.

Thanks,
Janusz
