From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Nov 2013 15:47:52 +0100 (CET)
Subject: [Cocci] Warning masked by BUG() when CONFIG_BUG is enabled
In-Reply-To: <20131117140627.GA6744@katana>
References: <87a9h4559j.fsf@natisbad.org> <20131117140627.GA6744@katana>
Message-ID: <alpine.DEB.2.02.1311171547130.2013@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > As a side note, I noticed quite some instances of that pattern (switch
> > statement w/ a 'default' calling BUG()) while more carefully looking at
> > compilation output. I may get slapped for this, but just in case this
> > is indeed something which deserves to be fixed and can be fixed
> > automagically via some semantic patch, I have CC'ed Coccinelle people.
> 
> I don't think this can be fixed in a generic way. This driver, for
> example, should IMO return -EINVAL when hitting default in probe and
> simply get rid of the other BUG() calls. No need to halt the kernel
> because of a broken match->data.

One could nevertheless perhaps use Coccinelle to find them, if there is 
some possibility to fix them.

julia
