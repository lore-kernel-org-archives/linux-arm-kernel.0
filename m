From: jbaron@redhat.com (Jason Baron)
Date: Wed, 29 Feb 2012 10:47:04 -0500
Subject: [PATCHv3] ARM: add jump label support
In-Reply-To: <20120229152320.GA6337@debian>
References: <1327757725-10114-7-git-send-email-rabin@rab.in>
 <1329325244-16289-1-git-send-email-rabin@rab.in>
 <20120229152320.GA6337@debian>
Message-ID: <20120229154704.GA2372@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 08:54:06PM +0530, Rabin Vincent wrote:
> On Wed, Feb 15, 2012 at 10:30:44PM +0530, Rabin Vincent wrote:
> > Add the arch-specific code to support jump labels for ARM and Thumb-2.
> > 
> > This code will only be activated on compilers that are capable of
> > building it.  It has been tested with GCC 4.6 patched with the patch
> > from GCC bug 48637.
> > 
> > Cc: Jason Baron <jbaron@redhat.com>
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
> > ---
> ...
> > +static __always_inline bool arch_static_branch(struct jump_label_key *key)
> 
> Hmm, there's now a patch in linux-next ("static keys: Introduce 'struct
> static_key', static_key_true()/false() and static_key_slow_[inc|dec]()")
> via the -tip tree which would cause this not to build anymore since
> struct jump_label_key was renamed to struct static_key.
> 
> I'm not sure how this could be handled to keep this compiling both in
> the arm tree separately and in linux-next.  I guess the easiest is to
> delay this until the next cycle, since it's not applied yet.

hmm...Maybe the rename patches could be pulled into the arm tree
somehow? Waiting a cycle works too...

Thanks,

-Jason
