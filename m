From: joe@perches.com (Joe Perches)
Date: Sun, 20 Oct 2013 08:22:46 -0700
Subject: [RFC PATCH] device: Add kernel standard devm_k.alloc functions
In-Reply-To: <20131020025713.GA22344@kroah.com>
References: <1381296747.2040.17.camel@joe-AO722>
 <20131011131138.3bc5b2acf60df3a5d79d0d24@linux-foundation.org>
 <CAGa+x864VYoGvOxoK0XnxXH9hKNq9WAZ16XHiFawZY7_2WJttw@mail.gmail.com>
 <CAGa+x86aS+C8iEb1P4ZYxPBix=Anjh4JZoAof=R-i9fGw=bq6w@mail.gmail.com>
 <20131018225702.GA13090@kroah.com> <8761stu7rl.fsf@linaro.org>
 <20131020025713.GA22344@kroah.com>
Message-ID: <1382282566.2041.39.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-10-19 at 19:57 -0700, Greg KH wrote:
> On Fri, Oct 18, 2013 at 10:52:46PM -0700, Kevin Hilman wrote:
> > Greg KH <gregkh@linuxfoundation.org> writes:
> > 
> > > On Fri, Oct 18, 2013 at 10:04:11AM -0700, Kevin Hilman wrote:
> > >> > A handful of boot panics on ARM platforms were bisected to point at
> > >> > the version of this commit that's in linux-next (commit
> > >> > 64c862a839a8db2c02bbaa88b923d13e1208919d).  Reverting this commit
> > >> > makes things happy again.
> > >> >
> > >> > Upon further digging, it seems that users of devres_alloc() are
> > >> > relying on the previous behavior of having the memory zero'd which is
> > >> > no longer the case after $SUBJECT patch.  The change below on top of
> > >> > -next makes these ARM boards happy again.
> > >> 
> > >> Oops, it should've fixed __devres_alloc() also.  Updated patch below.
> > >
> > > Can you send this in a format that I can apply it in?  It was whitespace
> > > damaged.
> > 
> > hmm, sorry about that.  This one should work, though I wonder if Andrew
> > should pick this up since I think the patch that causes the breakage
> > came through his tree.
> 
> No, the patch is in my tree, not Andrew's.
> 
> Joe, can I get a signed-off-by for this?

If you want.

Signed-off-by: Joe Perches <joe@perches.com>
