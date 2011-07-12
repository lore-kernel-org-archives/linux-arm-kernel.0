From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jul 2011 09:32:52 +0100
Subject: [PATCH] ARM: fix regression in IXP4xx clocksource
In-Reply-To: <20110712080513.GA2937@riccoc20.at.omicron.at>
References: <m3liwb15t2.fsf@intrepid.localdomain>
	<20110712080513.GA2937@riccoc20.at.omicron.at>
Message-ID: <20110712083252.GC23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 10:05:13AM +0200, Richard Cochran wrote:
> On Wed, Jul 06, 2011 at 11:02:17PM +0200, Krzysztof Halasa wrote:
> > From: Richard Cochran <richardcochran@gmail.com>
> > 
> > Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
> > 
> >    clocksource: convert ARM 32-bit up counting clocksources
> > 
> > broke the build for ixp4xx and made big endian operation impossible.
> > This commit restores the original behaviour.
> 
> I know I nag, but can we *please* have this patch in 3.0?
> Big endian IXP really, really does not work without it.

Thomas Glexnier said:
> Thinking more about it we should add BE accessor functions to the mmio
> clocksource as this might be useful for other architectures as well.

It seems that I can't rely on others, so I'm going to have to fit
this into my busy schedule at some point.
