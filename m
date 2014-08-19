From: hughd@google.com (Hugh Dickins)
Date: Tue, 19 Aug 2014 09:34:49 -0700 (PDT)
Subject: Lock Directory failure
In-Reply-To: <20140820012345.7c358fd7@canb.auug.org.au>
References: <20140818163209.GJ9662@saruman.home>
 <alpine.LSU.2.11.1408181350260.1127@eggly.anvils>
 <20140820012345.7c358fd7@canb.auug.org.au>
Message-ID: <alpine.LSU.2.11.1408190926090.1991@eggly.anvils>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Aug 2014, Stephen Rothwell wrote:
> On Mon, 18 Aug 2014 13:58:26 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> >
> > [PATCH next] vfs: initialize m_list to fix crash in mnt_set_mountpoint
> > 
> > Fix mnt_set_mountpoint() crash: new_mountpoint() must initialize m_list.
> > 
> > Reported-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> I assume that this is a fix for commit 89f7ca1af15b ("vfs: Keep a list
> of mounts on a mount point") that is currently i the vfs tree.  I will
> apply this patch as a fix up for the vfs tree in linux-next today.

Yes, that's it: thanks a lot, Stephen, that will help everybody.

I should acknowledge that Thierry Reding posted the same fix (a few
lines away) before mine, but I only came across his later in the day.

Hugh
