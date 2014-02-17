From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 17 Feb 2014 16:47:08 +0000
Subject: [PATCH v2 1/5] drivers: of: add initialization code for reserved
 memory
In-Reply-To: <52FA8245.5050707@gmail.com>
References: <1391515773-6112-1-git-send-email-m.szyprowski@samsung.com>	 <
 1391515773-6112-2-git-send-email-m.szyprowski@samsung.com>	 <20140205110538 .
 99E47C40A89@trevor.secretlab.ca>	 <52FA0D6E.9090304@samsung.com>	 <
 20140211121316.24032C40C4D@trevor.secretlab.ca>	 <52FA33E2.4050004@samsung.
 com>	 <20140211190104.7E6C5C4140E@trevor.secretlab.ca> <1392148971.3835.15.
 camel@pasglop> <52FA8245.5050707@gmail.com>
Message-ID: <20140217164708.B332BC403B4@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014 21:04:21 +0100, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 
> 
> On 11.02.2014 21:02, Benjamin Herrenschmidt wrote:
> > On Tue, 2014-02-11 at 19:01 +0000, Grant Likely wrote:
> >
> >>> except that the former IMHO better suits the definition of memory
> >>> region, which I see as a single contiguous range of memory and can be
> >>> simplified to have a single reg entry per region.
> >>
> >> My point is rather if multiple reg tuples are found in a reserved memory
> >> node, the kernel must respect them and reserve the memory. I'm not
> >> arguing about whether or not that makes for a good binding.
> >
> > agreed.
> 
> My point is why, if the binding defines that just a single tuple should 
> be provided.

It's irrelevant because it gets processed at a different level. It's
important that the core early setup code can quickly parse all the
reserved regions without having any idea what the end-user binding is.
Multiple reg tuples is just fine in this regard.

Whether or not multiple tuples makes sense is defined for each
particular use case by the driver actually using it without impacting
core initialization code one iota.

g.
