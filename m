From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 28 Jun 2011 15:10:56 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <m362nspvb6.fsf@intrepid.localdomain>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<m362nspvb6.fsf@intrepid.localdomain>
Message-ID: <20110628131056.GB12676@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2011 at 03:38:05PM +0200, Krzysztof Halasa wrote:
> > Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
> >
> >    clocksource: convert ARM 32-bit up counting clocksources
> >
> > broke the build for ixp4xx and made big endian operation impossible.
> > This commit restores the original behaviour.
> 
> So, what do we do with this?
> It would be nice to have the fix in the tree before 3.0.
> I guess I'll add this if nothing better shows up.

I'll say it once again:

If IXP is the only machine that needs this exception, then I think my
patch is okay. Otherwise, we would want a set of big-endian-friendly
clock reading methods.

But I really don't know whether IXP is all alone in this...

Just my 2 cents,

Richard
