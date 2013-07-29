From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 29 Jul 2013 11:54:00 -0600
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <20130727084825.GA4707@netboy>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
 <20130727084825.GA4707@netboy>
Message-ID: <20130729175400.GB15861@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 10:48:26AM +0200, Richard Cochran wrote:

> > Of course all this could have been done in C, but it wasn't/hasn't been..
> 
> You have identified the real issue: poor quality of the ARM board
> support process within the kernel. Churn is still churn, whether in DT
> or in platform devices, but the DT people promised to end the churn.

Actually my experience in this area was mainly from PPC, and granted
it spanned the PPC32/PPC64 merge.

> [ I disagree about the "more thought" part. The current discussion,
>   coming years too late after the introduction of DT to ARM Linux, is
>   contrary evidence enough. ]

The current discussion has little to do with the quality of the
bindings, look at the new kirkwood bindings - they have had much more
thought put into them than the old board.c stuff they are replacing.

> > I can't delay shipping while upstream sorts this out - so I know
> > *absolutely* that the DT schema will change. This has been planned for
> > and designed into the boot system and won't be a problem.
> > 
> > Why would anyone do embedded any other way?
> 
> Yep, that is the embedded way: ship it!
> 
> We can do better than that.

I think you missed the point.

There is no way I can possibly ship a product with a DT that is
finished. I can't tie my company's product release cycles to the whims
of the kernel community.

So embedded people are going to ship with unfinished DT and upgrade
later. They have to. There is no choice. Stable DT doesn't change
anything unless you can create perfect stable bindings for a new SOC
instantaneously.

This is where I see the whole disconnect in this
discussion. General-purpose and embedded are *DIFFERENT* users, and
they have different use-cases and different needs.

Jason
