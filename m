From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Oct 2016 23:47:12 +0100
Subject: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
In-Reply-To: <20161027212727.leqg3gvwhd3u64er@lukather>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
 <20161027111419.GK25322@sirena.org.uk>
 <20161027212727.leqg3gvwhd3u64er@lukather>
Message-ID: <20161027224712.GY25322@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 11:27:27PM +0200, Maxime Ripard wrote:
> On Thu, Oct 27, 2016 at 12:14:19PM +0100, Mark Brown wrote:

> > but since I'm not turning up anything with this subject line I've no
> > idea what that might have been (and that's very concerning in itself
> > given that this is apparently v7...).

> v4 was here: https://patchwork.kernel.org/patch/3893371/
> v5: https://patchwork.kernel.org/patch/5455381/
> v6: https://patchwork.kernel.org/patch/6975871/

> So basically, I really have no idea why, but it really seems like it
> was just falling through the cracks, repeatedly (I'm not puting the
> blame on anyone though, it just happened). Maybe it was just because
> of the lack of comments :)

Oh, those subject lines were all starting ARM: rather than spi: -
there's a good chance I didn't look at the patches if I was busy
thinking they were changes for arch/arm rather than the SPI driver.

> > I'm also concerned that there isn't a version of this for sun6i,
> > it's going to make all the cut'n'pasting between the two drivers
> > harder if we make changes in one and not the other.

> I think I'll give reg_field a shot though, and try to merge the sun6i
> driver into this one and see the results. If it can help your
> decision.

It would definitely be nice given the level of duplication.

> > If the concern from the previous reviews to do with not using DMA is
> > there some reason it's hard to do DMA?

> I think just like Alexandru that it is orthogonal. But to really
> answer, no, it's not difficult. There's just been some fundamental
> disagreement on whether DMA was supposed to be optional or not that
> stalled everything I guess.

Oh, I seem to remember some patches adding DMA support that were doing
some strange special snowflake thing with ignoring errors now that I
think about it but that's not this one...  why did nobody ever follow up
on those?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/f8c15ff9/attachment.sig>
