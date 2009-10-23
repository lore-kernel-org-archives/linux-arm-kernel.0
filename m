From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 23 Oct 2009 07:20:52 +0200
Subject: spitz backlight: fix brightness limiting
In-Reply-To: <1256251399.23211.164.camel@dax.rpnet.com>
References: <20091019213751.GC1482@ucw.cz>
	<f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
	<1256251399.23211.164.camel@dax.rpnet.com>
Message-ID: <20091023052052.GA15499@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-10-22 23:43:19, Richard Purdie wrote:
> On Thu, 2009-10-22 at 04:20 +0800, Eric Miao wrote:
> > It's a little bit weird it's called 'limit_mask' when I first converted it
> > to a spi driver. There must be some reasons, Richard, you've got
> > any ideas?
> 
> Its a historical artifact that once worked through some bitfield magic
> but probably stopped working when we increased the range of values the
> backlight could accept and we didn't notice the limiting problem.
> 
> I'll happily take a patch to fix that.

Patch is available in the parent post. For now, I just fix it so that
it does not turn backlight off when it should not. I'll submit
limit_mask -> limit as separate patch, ok?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
