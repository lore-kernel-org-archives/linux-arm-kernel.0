From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 26 Apr 2011 20:07:19 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <201104262100.42670.pwaechtler@mac.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTimZZEr8fqXbuBjpYxF1quBFv7Oihg@mail.gmail.com>
	<BANLkTikNqO_xGgsUrZ2fid4ZmA8P6AoHLA@mail.gmail.com>
	<201104262100.42670.pwaechtler@mac.com>
Message-ID: <20110426190719.GA5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Waechtler wrote:
> Am Dienstag, 26. April 2011, 12:33:29 schrieb Per Forlin:
> > On 23 April 2011 11:23, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > 2011/4/22 Pavel Machek <pavel@ucw.cz>:
> > >> Plus, I was told new MMC standard has "write reliable" option...
> > > 
> > > I think Per F?rlin looked into reliable write. The latest eMMC cards
> > > has this, but OTOMH it was too darn slow to be used on current
> > > chips/"cards".
> > > 
> > > Per, Sebastian: any details?
> > 
> > I had plans to add reliable writes and do benchmarking but I never got
> > to it. Right now I have no plans to pick it up.
> > 
> > > Yours,
> > > Linus Walleij
> > 
> > Regards,
> > Per
> 
> As far as I understood the spec, reliable write only makes statements like
> either the old data is still intact - or the new data was written 
> (completely).

Hmm, if that's a correct understanding, it's not very useful for
fsync() or journal barriers (unless the spec implies something
barrier-like), and it would be nice if there were guarantees about the
_other_ data (that isn't being written at all) not getting corrupted
as a side effect.

-- Jamie
